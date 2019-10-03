//
//  UIFont+UIFontCategory.m
//  倉頡字典2356
//
//  Created by Qwetional on 21/9/2019.
//  Copyright © 2019 Qwetional. All rights reserved.
//

#import "UIFont+UIFontCategory.h"

@implementation UIFont (UIFontCategory)
+ (UIFont *)addHanaMinBFallbacktoFont:(UIFont*)font atHanaminFontSizeOf:(float)hanaminFontSize{
    UIFontDescriptor* originalDescriptor = [font fontDescriptor];
    
    UIFontDescriptor* fallbackDescriptor = [originalDescriptor fontDescriptorByAddingAttributes:@{UIFontDescriptorNameAttribute:@"HanaMinB"}];
    
    UIFontDescriptor* repaired = [originalDescriptor fontDescriptorByAddingAttributes:@{UIFontDescriptorCascadeListAttribute:@[fallbackDescriptor]}];
    
    font = [UIFont fontWithDescriptor:repaired size:hanaminFontSize];
    
    return font;
}
@end
