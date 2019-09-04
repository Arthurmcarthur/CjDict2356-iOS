//
//  CJTableViewCell.h
//  倉頡字典2356
//
//  Created by Qwetional on 9/8/2019.
//  Copyright © 2019 Qwetional. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJTableViewCell : UITableViewCell
@property(nonatomic, strong)UILabel* characterLabel;
@property(nonatomic, strong)UILabel* cjcodeLabel;
@property(nonatomic, strong)UILabel* characterUnicodeInfoLabel;
@property(nonatomic, assign)int heightOfCell;
@end

NS_ASSUME_NONNULL_END
