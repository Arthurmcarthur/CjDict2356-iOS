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
        self.dbManager = [[SQLiteManager alloc] initWithDatabaseNamed:dbPath];
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
