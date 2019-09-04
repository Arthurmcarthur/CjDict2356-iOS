//
//  AboutPageViewController.m
//  uitableview3
//
//  Created by Qwetional on 17/7/2019.
//  Copyright © 2019 Qwetional. All rights reserved.
//

#import "AboutPageViewController.h"
#import "AuthorInfoPageViewController.h"
#import "BullshitViewController.h"
#import "UserManualViewController.h"

@interface AboutPageViewController () <UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, weak)UITableView* tableView;
@end

@implementation AboutPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:UIColor.whiteColor];
    
    [[self navigationItem] setTitle:@"幫助&關于"];
    
    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height, [[self view] frame].size.width - ([[self view] safeAreaInsets].left + [[self view] safeAreaInsets].right), [[self view] frame].size.height - ([[self view] safeAreaInsets].top + [[self view] safeAreaInsets].bottom)-([[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height - 40)) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    [[self tableView] setDataSource:self];
    [[self tableView] setDelegate:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch(section){
        case 0:
            return 1;
        default:
            return 2;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch(indexPath.section){
        case 0:
            cell.textLabel.text = @"關于";
            return cell;
        default:
            switch(indexPath.row){
                case 0:
                    cell.textLabel.text = @"使用幫助";
                    return cell;
                default:
                    cell.textLabel.text = @"胡言亂語";
                    return cell;
            }
    }
    /*
    cell.textLabel.text = [NSString stringWithFormat:@"%@\t%@", self.allArr[indexPath.section][indexPath.row][@"KANJI"], ((NSString*)self.allArr[indexPath.section][indexPath.row][@"CJCODE"]).uppercaseString];
    // [[cell textLabel] setTextAlignment:NSTextAlignmentCenter];
    NSLog(@"%@", self.allArr[indexPath.section][indexPath.row][@"CJCODE"]);
    return cell;
     */
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        AuthorInfoPageViewController* authorinfoPageViewController = [[AuthorInfoPageViewController alloc] init];
        [self.navigationController pushViewController:authorinfoPageViewController animated:YES];
    }else{
        if(indexPath.row == 0){
            UserManualViewController* userManualViewController = [[UserManualViewController alloc] init];
            [self.navigationController pushViewController:userManualViewController animated:YES];
        }else{
            BullshitViewController* bullshitViewController = [[BullshitViewController alloc] init];
            [self.navigationController pushViewController:bullshitViewController animated:YES];
        }
    }
}
@end

