//
//  CodeChartsHandler.m
//  sqltest3
//
//  Created by Qwetional on 14/7/2019.
//  Copyright © 2019 Qwetional. All rights reserved.
//

#import "CodeChartsHandler.h"
#import "SQLiteManager.h"

@implementation CodeChartsHandler
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString* dbPath = [[NSBundle mainBundle] pathForResource:@"cjdictdb" ofType:@"db"];
        NSString* documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString* documentDbPath = [documentDirectory stringByAppendingPathComponent:@"cjdictdb.db"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString* versionPlist = [documentDirectory stringByAppendingPathComponent:@"versionplist.plist"];
        if ([fileManager fileExistsAtPath:versionPlist]) {
            NSMutableDictionary* versionDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:versionPlist];
            if ([versionDictionary[@"version"] isEqualToString:[[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"]]) {
                NSLog(@"檢测OK，無需替换");
            } else {
                NSLog(@"需要替换");
                if ([fileManager fileExistsAtPath:documentDbPath]) {
                    NSLog(@"存在");
                    [fileManager removeItemAtPath:documentDbPath error:nil];
                    [fileManager copyItemAtPath:dbPath toPath:documentDbPath error:nil];
                } else {
                    NSLog(@"不存在");
                    [fileManager copyItemAtPath:dbPath toPath:documentDbPath error:nil];
                }
                [fileManager removeItemAtPath:versionPlist error:nil];
                NSMutableDictionary* newVersionDictionary = [NSMutableDictionary dictionaryWithDictionary:@{@"version":[[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"]}];
                [newVersionDictionary writeToFile:versionPlist atomically:YES];
                NSLog(@"替换OK");
            }
        } else {
            if ([fileManager fileExistsAtPath:documentDbPath]) {
                NSLog(@"存在");
                [fileManager removeItemAtPath:documentDbPath error:nil];
                [fileManager copyItemAtPath:dbPath toPath:documentDbPath error:nil];
            } else {
                NSLog(@"不存在");
                [fileManager copyItemAtPath:dbPath toPath:documentDbPath error:nil];
            }
            NSMutableDictionary* newVersionDictionary = [NSMutableDictionary dictionaryWithDictionary:@{@"version":[[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"]}];
            [newVersionDictionary writeToFile:versionPlist atomically:YES];
            NSLog(@"写入新plistOK");
        }
        
        if ([fileManager fileExistsAtPath:documentDbPath]) {
            NSLog(@"存在");
        } else {
            NSLog(@"不存在");
            [fileManager copyItemAtPath:dbPath toPath:documentDbPath error:nil];
        }
        
        self.dbManager = [[SQLiteManager alloc] initWithDatabaseNamed:documentDbPath];
        self.dbOpenError = nil;
        self.dbOpenError = [self.dbManager openDatabase];
    }
    return self;
}
- (NSMutableArray*)getRecordFrom:(NSString*)listName byRegularExpressionWithPattern:(NSString*)pattern{
    NSArray* tempArr = nil;
    NSMutableArray* resultArr = [[NSMutableArray alloc] init];
    if(!self.dbOpenError){
        // NSLog(@"开始");
        tempArr = [self.dbManager getRowsForQuery:[NSString stringWithFormat:@"SELECT * FROM %@", listName]];
        NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
        /*
         [tempArr enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(NSDictionary* columnDic, NSUInteger idx, BOOL* _Nonnull stop) {
         NSTextCheckingResult* match = [regex firstMatchInString:columnDic[@"CJCODE"] options:0 range:NSMakeRange(0, ((NSString*)columnDic[@"CJCODE"]).length)];
         if(match){
         [resultArr addObject:columnDic];
         }
         }];
         */
        for (NSDictionary* columnDic in tempArr){
            NSTextCheckingResult* match = [regex firstMatchInString:columnDic[@"CJCODE"] options:0 range:NSMakeRange(0, ((NSString*)columnDic[@"CJCODE"]).length)];
            if(match){
                [resultArr addObject:columnDic];
            }
        }
    }
    return resultArr;
}

- (NSMutableArray*)getRecordFrom:(NSString*)listName byGivenCharacter:(NSString*)givenCharacter{
    NSMutableArray* resultArr = nil;
    resultArr = [NSMutableArray arrayWithArray:[self.dbManager getRowsForQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE CJCODE = '%@' OR KANJI = '%@'", listName, givenCharacter, givenCharacter]]];
    return resultArr;
}

- (NSMutableArray*)getRecordFrom:(NSString*)listName byGivenCharacterArray:(NSArray <NSString*>*)givenCharacterArray{
    [self.dbManager doQuery:@"CREATE TABLE TargetCharactersTable ( \
     TARGETCHARACTERS TEXT NOT NULL \
     )"];
    NSMutableArray* givenCharacterArrayWithoutRepetition = [[NSMutableArray alloc] init];
    for (NSString* givenCharacter in givenCharacterArray) {
        if (![givenCharacterArrayWithoutRepetition containsObject:givenCharacter]){
            [givenCharacterArrayWithoutRepetition addObject:givenCharacter];
        }
    }
    givenCharacterArray = nil;
    for (NSString* givenCharacter in givenCharacterArrayWithoutRepetition) {
        //[self.dbManager doQuery:[NSString stringWithFormat:@"insert into TargetCharactersTable(TARGETCHARACTERS) values('%@')", givenCharacter]];
        [self.dbManager doQuery:[NSString stringWithFormat:@"INSERT INTO TargetCharactersTable (TARGETCHARACTERS) VALUES ('%@')", givenCharacter]];
    }
    // NSMutableArray* resultArr = [NSMutableArray arrayWithArray:[self.dbManager getRowsForQuery:[NSString stringWithFormat:@"SELECT * FROM TargetCharactersTable JOIN %@ ON TargetCharactersTable.TARGETCHARACTERS = %@.KANJI OR TargetCharactersTable.TARGETCHARACTERS = %@.CJCODE", listName, listName, listName]]];
    NSMutableArray* resultArr = [NSMutableArray arrayWithArray:[self.dbManager getRowsForQuery:[NSString stringWithFormat:@"With temp(SERIAL_NUMBER) AS (SELECT DISTINCT SERIAL_NUMBER FROM TargetCharactersTable JOIN %@ ON TargetCharactersTable.TARGETCHARACTERS = %@.KANJI OR TargetCharactersTable.TARGETCHARACTERS = %@.CJCODE) SELECT * FROM %@ A INNER JOIN temp B ON A.SERIAL_NUMBER = B.SERIAL_NUMBER", listName, listName, listName, listName]]];
    [self.dbManager doQuery:@"DROP TABLE TargetCharactersTable"];
    return resultArr;
}

- (NSMutableArray*)getRecordFromKanjiColomnOf:(NSString*)listName byGivenCharacter:(NSString*)givenCharacter{
    NSMutableArray* resultArr = nil;
    resultArr = [NSMutableArray arrayWithArray:[self.dbManager getRowsForQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE KANJI = '%@'", listName, givenCharacter]]];
    return resultArr;
}

- (NSMutableArray*)getRecordFromIDSListAndCjCodeChart:(NSString*)codeChart byGivenComponents:(NSString*)givenComponents{
    NSMutableArray* resultArr = [NSMutableArray arrayWithArray:[self.dbManager getRowsForQuery:[NSString stringWithFormat:@"WITH temp(KANJI) AS (SELECT KANJI FROM IDS WHERE IDS like '%%%@%%') SELECT * from %@ A INNER JOIN temp B ON A.KANJI = B.KANJI", givenComponents, codeChart]]];
    // NSLog(@"%@", resultArr);
    
    return resultArr;
}
+ (instancetype)codeChartsHandler{
    return [[CodeChartsHandler alloc] init];
}
@end
