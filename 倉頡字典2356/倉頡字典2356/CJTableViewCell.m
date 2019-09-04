//
//  CJTableViewCell.m
//  倉頡字典2356
//
//  Created by Qwetional on 9/8/2019.
//  Copyright © 2019 Qwetional. All rights reserved.
//

#import "CJTableViewCell.h"

@implementation CJTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.heightOfCell = 80;
        self.characterLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.heightOfCell + 20, self.heightOfCell)];
        self.cjcodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.heightOfCell + 30, 0, 300, self.heightOfCell * 0.65)];
        self.characterUnicodeInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.heightOfCell + 30, self.heightOfCell * 0.65, 300, self.heightOfCell * 0.25)];
        [self.contentView addSubview:self.characterLabel];
        [self.contentView addSubview:self.cjcodeLabel];
        [self.contentView addSubview:self.characterUnicodeInfoLabel];
    }
    return self;
}

@end
