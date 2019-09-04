//
//  CodeChartsHandler.h
//  sqltest3
//
//  Created by Qwetional on 14/7/2019.
//  Copyright © 2019 Qwetional. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SQLiteManager;
@interface CodeChartsHandler : NSObject
@property(nonatomic, strong)SQLiteManager* dbManager;
@property(nonatomic, strong, nullable)NSError* dbOpenError;
- (instancetype)init;
- (NSMutableArray*)getRecordFrom:(NSString*)listName byRegularExpressionWithPattern:(NSString*)pattern;
- (NSMutableArray*)getRecordFrom:(NSString*)listName byGivenCharacter:(NSString*)givenCharacter;
- (NSMutableArray*)getRecordFromKanjiColomnOf:(NSString*)listName byGivenCharacter:(NSString*)givenCharacter;
- (NSMutableArray*)getRecordFromIDSListAndCjCodeChart:(NSString*)codeChart byGivenComponents:(NSString*)givenComponents;
+ (instancetype)codeChartsHandler;
@end

NS_ASSUME_NONNULL_END
