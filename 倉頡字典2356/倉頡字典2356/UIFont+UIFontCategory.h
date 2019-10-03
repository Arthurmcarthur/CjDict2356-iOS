//
//  UIFont+UIFontCategory.h
//  倉頡字典2356
//
//  Created by Qwetional on 21/9/2019.
//  Copyright © 2019 Qwetional. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (UIFontCategory)
+ (UIFont *)addHanaMinBFallbacktoFont:(UIFont*)font atHanaminFontSizeOf:(float)hanaminFontSize;
@end

NS_ASSUME_NONNULL_END
