//
//  AuthorInfoPageViewController.m
//  倉頡字典2356
//
//  Created by Qwetional on 22/7/2019.
//  Copyright © 2019 Qwetional. All rights reserved.
//

#import "AuthorInfoPageViewController.h"

@interface AuthorInfoPageViewController ()
@property(nonatomic, weak)UIView* secondView;
@property(nonatomic, assign)int logoTapTime;
@property(nonatomic, weak)UIImageView* logoImageView;
@end

@implementation AuthorInfoPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    [[self navigationItem] setTitle:@"關于"];
    
    UIView* secondView = [[UIView alloc] initWithFrame:CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height, [[self view] frame].size.width - ([[self view] safeAreaInsets].left + [[self view] safeAreaInsets].right), [[self view] frame].size.height - ([[self view] safeAreaInsets].top + [[self view] safeAreaInsets].bottom)-([[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height - 40))];
    UIColor* secondViewBackgroundColor = nil;
    if (@available(iOS 13.0, *)) {
        secondViewBackgroundColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if ([traitCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                return [UIColor colorWithRed:238.0 / 255 green:238.0 / 255 blue:243.0 / 255 alpha:1];
            } else {
                return [UIColor colorWithRed:19.0 / 255 green:26.0 / 255 blue:39.0 / 255 alpha:1];
            }
        }];
        
    } else {
        secondViewBackgroundColor = [UIColor colorWithRed:238.0 / 255 green:238.0 / 255 blue:243.0 / 255 alpha:1];
    }
    [secondView setBackgroundColor:secondViewBackgroundColor];
    self.secondView = secondView;
    [self.view addSubview:self.secondView];
    self.logoTapTime = 0;
    
    NSString* logoPath = [[NSBundle mainBundle] pathForResource:@"2X 20PT-01" ofType:@"png"];
    UIImage* logoImage = [[UIImage alloc] initWithContentsOfFile:logoPath];
    UIImageView* logoImageView = [[UIImageView alloc] initWithImage:logoImage];
    self.logoImageView = logoImageView;
    self.logoImageView.userInteractionEnabled = YES;
    UIGestureRecognizer* logoTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logoBeingTapped)];
    [self.logoImageView addGestureRecognizer:logoTapRecognizer];
    [secondView addSubview:self.logoImageView];
    [self.logoImageView setCenter:CGPointMake(([[self view] frame].size.width - ([[self view] safeAreaInsets].left + [[self view] safeAreaInsets].right)) / 2, ([[self view] frame].size.height - ([[self view] safeAreaInsets].top + [[self view] safeAreaInsets].bottom)-([[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height - 40)) / 4)];
    
    UILabel* infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (([[self view] frame].size.height - ([[self view] safeAreaInsets].top + [[self view] safeAreaInsets].bottom)-([[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height - 40)) / 4) + 80, [[self view] frame].size.width - ([[self view] safeAreaInsets].left + [[self view] safeAreaInsets].right), 260)];

    
    
    // infoLabel.backgroundColor = [UIColor colorWithRed:238.0 / 255 green:238.0 / 255 blue:243.0 / 255 alpha:1];
    infoLabel.backgroundColor = secondViewBackgroundColor;
    infoLabel.numberOfLines = 15;
    infoLabel.textColor = UIColor.grayColor;
    infoLabel.font = [UIFont systemFontOfSize:12];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.text = [NSString stringWithFormat:@"倉頡字典2356 For iOS\n當前版本：%@\n\n主要開發者：\n好想食用巨大的方便@輕鬆輸入法\n\n其他貢獻者：\n八角雅成@輕鬆輸入法\nnameoverflow@輕鬆輸入法\nKit~@輕鬆輸入法\n\n本軟件使用如下開源項目：\nSQLiteManager4iOS by Ester Sanchez\nHanazono Mincho by GlyphWiki\nCJKVI-IDS by kawabata", [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]];
    [[self secondView] addSubview:infoLabel];
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)logoBeingTapped{
    if (self.logoTapTime < 4) {
        ++self.logoTapTime;
        NSLog(@"%d", self.logoTapTime);
    } else if (self.logoTapTime == 4) {
        ++self.logoTapTime;
        NSLog(@"%d", self.logoTapTime);
        // NSString* ezLogoPath = [[NSBundle mainBundle] pathForResource:@"Icon-App-83.5x83.5@2x" ofType:@"png"];
        // UIImage* ezLogoImage = [[UIImage alloc] initWithContentsOfFile:ezLogoPath];
        UIImage* ezLogoImage = [UIImage imageNamed:@"ezLogoImage"];
        self.logoImageView.image = ezLogoImage;
    }
}
@end
