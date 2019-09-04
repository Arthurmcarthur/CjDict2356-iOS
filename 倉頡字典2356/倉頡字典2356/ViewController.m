//
//  ViewController.m
//  uitableview1
//
//  Created by Qwetional on 15/7/2019.
//  Copyright © 2019 Qwetional. All rights reserved.
//

#import "ViewController.h"
#import "CodeChartsHandler.h"
#import "AboutPageViewController.h"
#import "CJTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property(nonatomic, weak)UITableView* tableView;       // UITableView
@property(nonatomic, weak)UISearchBar* searchBar;       // 搜索欄
@property(nonatomic, weak)UIButton* infoButton;         // 关于按钮，即是左上角那个按钮
@property(nonatomic, strong)CodeChartsHandler* chartsHandler;       // 指向碼表處理器的指針
// @property(nonatomic, strong)UIFont* dictFont;                       // 黙認字体
@property(nonatomic, strong)NSDictionary* dictionaryWhenNoResult;   // 字典，用于存放没有結果時的情况。
@property(nonatomic, strong)NSArray* cj3Arr;                        // 数組，用於存放査詢結果
@property(nonatomic, strong)NSArray* cj5Arr;
@property(nonatomic, strong)NSArray* cj6Arr;
@property(nonatomic, strong)NSArray* mscjArr;
@property(nonatomic, strong)NSArray* yhcjArr;
@property(nonatomic, strong)NSArray* cj2Arr;
@property(nonatomic, strong)NSArray* allArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self view] setBackgroundColor:UIColor.whiteColor];
    
    #pragma mark - 導航欄
    // 設置導航欄
    [[self navigationItem] setTitle:@"倉頡字典2356"];
    UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [infoButton addTarget:self action:@selector(infoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.infoButton = infoButton;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.infoButton];
    [[[self navigationController] navigationBar] setBarTintColor:[UIColor whiteColor]];
    
    #pragma mark - 碼表處理器
    // 實例化碼表處理器并賦值
    [self setChartsHandler:[[CodeChartsHandler alloc] init]];
   
    #pragma mark - UITableView
    // 實例化UITableView并賦給self.tableView，設置Frame
    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height + 45, [[self view] frame].size.width - ([[self view] safeAreaInsets].left + [[self view] safeAreaInsets].right), [[self view] frame].size.height - ([[self view] safeAreaInsets].top + [[self view] safeAreaInsets].bottom)-([[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height + 45 - 40)) style:UITableViewStyleGrouped];
    tableView.rowHeight = 80;
    tableView.estimatedRowHeight = 0;
    [self setTableView:tableView];
    [[self view] addSubview:[self tableView]];
    
    // 設置self.tableView的代理和datasource
    [[self tableView] setDataSource:self];
    [[self tableView] setDelegate:self];
    
    #pragma mark - 搜索欄
    // 初始化搜索欄
    UISearchBar* searchBar = [[UISearchBar alloc] init];
    [self setSearchBar:searchBar];
    [[self searchBar] setDelegate:self];
    [[self searchBar] setPlaceholder:@"請輸入査詢字符"];
    [[self view] addSubview:[self searchBar]];
    
    // #pragma mark - P2字体初始化
    // 初始化P2字体
    // UIFont* dictFont = [UIFont fontWithName:@"HanaMinA" size:17];
    // self.dictFont = dictFont;

    #pragma mark - 没有結果時的字典初始化
    // 没有結果時的字典初始化
    self.dictionaryWhenNoResult = @{@"whenInitialize":@[@{@"KANJI":@"", @"CJCODE":@"", @"CJCODEINKANJI":@""}], @"whenNoResult":@[@{@"KANJI":@"(空)", @"CJCODE":@"無結果", @"CJCODEINKANJI":@""}]};
    #pragma mark - 查詢數組初始化
    // 初始化査詢結果的數組
    self.cj3Arr = self.dictionaryWhenNoResult[@"whenInitialize"];
    self.cj5Arr = self.dictionaryWhenNoResult[@"whenInitialize"];
    self.cj6Arr = self.dictionaryWhenNoResult[@"whenInitialize"];
    self.mscjArr = self.dictionaryWhenNoResult[@"whenInitialize"];
    self.yhcjArr = self.dictionaryWhenNoResult[@"whenInitialize"];
    self.cj2Arr = self.dictionaryWhenNoResult[@"whenInitialize"];
    self.allArr = @[self.cj3Arr, self.cj5Arr, self.cj6Arr, self.mscjArr, self.yhcjArr, self.cj2Arr];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[self searchBar] setFrame:CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height, [[self view] frame].size.width - ([[self view] safeAreaInsets].left + [[self view] safeAreaInsets].right), 45)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    #pragma mark - row數量
    // section里有幾個row，即每個碼表有幾個査詢結果
    switch(section){
        case 0:
            return self.cj3Arr.count;
        case 1:
            return self.cj5Arr.count;
        case 2:
            return self.cj6Arr.count;
        case 3:
            return self.mscjArr.count;
        case 4:
            return self.yhcjArr.count;
        default:
            return self.cj2Arr.count;
    }

}

#pragma mark - cell賦值
// 這方法是爲cell賦值，這樣便可顯示出査詢結果
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CJTableViewCell* cell = [[CJTableViewCell alloc] init];

    if([[self.dictionaryWhenNoResult allValues] containsObject:self.allArr[indexPath.section]]){
        // 如果没有值的狀况

        cell.characterLabel.text = self.allArr[indexPath.section][indexPath.row][@"KANJI"];
        cell.cjcodeLabel.text = ((NSString*)self.allArr[indexPath.section][indexPath.row][@"CJCODE"]).uppercaseString;
        cell.characterUnicodeInfoLabel.attributedText = [[NSAttributedString alloc] initWithString:@"" attributes:0];
    }else{
        // 有值的狀况
        cell.characterLabel.text = self.allArr[indexPath.section][indexPath.row][@"KANJI"];
        cell.cjcodeLabel.text = [NSString stringWithFormat:@"%@(%@)", self.allArr[indexPath.section][indexPath.row][@"CJCODEINKANJI"],  ((NSString*)self.allArr[indexPath.section][indexPath.row][@"CJCODE"]).uppercaseString];

        NSMutableAttributedString* characterUnicodeInfoLabelText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@:%@", @"● ",  self.allArr[indexPath.section][indexPath.row][@"UNICODECODEPOINT"], self.allArr[indexPath.section][indexPath.row][@"UNICODEBLOCK"]]];
        [self typeSettingWithUnicodeInfoLabelText:characterUnicodeInfoLabelText andUnicodeBlockInfo:self.allArr[indexPath.section][indexPath.row][@"UNICODEBLOCK"]];
        cell.characterUnicodeInfoLabel.attributedText = characterUnicodeInfoLabelText;
    }

    
    cell.characterLabel.font = [UIFont fontWithName:@"HanaMinA" size:40];
    // cell.characterUnicodeInfoLabel.font = [UIFont fontWithName:@"HanaMinA" size:10];
    cell.cjcodeLabel.font = [UIFont fontWithName:@"HanaMinA" size:21];
    // cell.characterUnicodeInfoLabel.textColor = [UIColor grayColor];
    return cell;
}

#pragma mark - section賦名
// 爲section賦名字
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch(section){
        case 0:
            if([[self.dictionaryWhenNoResult allValues] containsObject:((NSArray*)self.allArr[section])]){
                return @"倉頡三代";
            }else{
                return [NSString stringWithFormat:@"倉頡三代(%lu項結果)", ((NSArray*)self.allArr[section]).count];
            }
        case 1:
            if([[self.dictionaryWhenNoResult allValues] containsObject:((NSArray*)self.allArr[section])]){
                return @"倉頡五代";
            }else{
                return [NSString stringWithFormat:@"倉頡五代(%lu項結果)", ((NSArray*)self.allArr[section]).count];
            }
        case 2:
            if([[self.dictionaryWhenNoResult allValues] containsObject:((NSArray*)self.allArr[section])]){
                return @"倉頡六代";
            }else{
                return [NSString stringWithFormat:@"倉頡六代(%lu項結果)", ((NSArray*)self.allArr[section]).count];
            }
        case 3:
            if([[self.dictionaryWhenNoResult allValues] containsObject:((NSArray*)self.allArr[section])]){
                return @"微軟倉頡";
            }else{
                return [NSString stringWithFormat:@"微軟倉頡(%lu項結果)", ((NSArray*)self.allArr[section]).count];
            }
        case 4:
            if([[self.dictionaryWhenNoResult allValues] containsObject:((NSArray*)self.allArr[section])]){
                return @"雅虎倉頡";
            }else{
                return [NSString stringWithFormat:@"雅虎倉頡(%lu項結果)", ((NSArray*)self.allArr[section]).count];
            }
        default:
            if([[self.dictionaryWhenNoResult allValues] containsObject:((NSArray*)self.allArr[section])]){
                return @"倉頡二代";
            }else{
                return [NSString stringWithFormat:@"倉頡二代(%lu項結果)", ((NSArray*)self.allArr[section]).count];
            }
    }
}

#pragma mark - 索引條
// 右側的索引條
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return @[@"三", @"五", @"六", @"微", @"雅", @"二"];
}

#pragma mark - 複製按鈕
// 右滑得複製按鈕與更多選項按鈕
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([((CJTableViewCell*)[[self tableView] cellForRowAtIndexPath:indexPath]).characterLabel.text isEqualToString:@"(空)"] || [((CJTableViewCell*)[[self tableView] cellForRowAtIndexPath:indexPath]).characterLabel.text isEqualToString:@""]){
        return @[];
    }else{
        
        // 複製按鈕
        UITableViewRowAction* copyAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"複製" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
            // pasteboard.string = ((CJTableViewCell*)[[self tableView] cellForRowAtIndexPath:indexPath]).characterLabel.text;
            pasteboard.string = [NSString stringWithFormat:@"%@\t%@", ((CJTableViewCell*)[[self tableView] cellForRowAtIndexPath:indexPath]).characterLabel.text, ((CJTableViewCell*)[[self tableView] cellForRowAtIndexPath:indexPath]).cjcodeLabel.text];
        }];
        copyAction.backgroundColor = [UIColor colorWithRed:252.0 / 255.0 green:130.0 / 255.0 blue:7.0 / 255.0 alpha:1];
        
        // 更多選項按鈕與菜單
        UITableViewRowAction* moreOptions = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"•••" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            UIAlertController* moreOptionsAlert = [UIAlertController alertControllerWithTitle:@"更多選項..." message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            [moreOptionsAlert addAction:[UIAlertAction actionWithTitle:@"僅複製字符" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = ((CJTableViewCell*)[[self tableView] cellForRowAtIndexPath:indexPath]).characterLabel.text;
            }]];
            
            [moreOptionsAlert addAction:[UIAlertAction actionWithTitle:@"僅複製倉頡碼" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = ((CJTableViewCell*)[[self tableView] cellForRowAtIndexPath:indexPath]).cjcodeLabel.text;
            }]];
            
            [moreOptionsAlert addAction:[UIAlertAction actionWithTitle:@"繼續查找此字符" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self normalModeWithString:((CJTableViewCell*)[[self tableView] cellForRowAtIndexPath:indexPath]).characterLabel.text];
                [[self tableView] reloadData];
                [self.view endEditing:YES];
            }]];
            
            [moreOptionsAlert addAction:[UIAlertAction actionWithTitle:@"繼續查找此倉頡碼" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSString* targetCjcode = nil;
                @try {
                    targetCjcode = [[((CJTableViewCell*)[[self tableView] cellForRowAtIndexPath:indexPath]).cjcodeLabel.text componentsSeparatedByString:@"("][1] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@")"]];
                } @catch (NSException *exception) {
                    targetCjcode = @"";
                } @finally {
                    [self normalModeWithString:targetCjcode];
                    [[self tableView] reloadData];
                    [self.view endEditing:YES];
                }
            }]];
            
            [moreOptionsAlert addAction:[UIAlertAction actionWithTitle:@"複製Unicode編碼" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
                NSString* rawUnicodeInfoText = nil;
                NSString* targetUnicodeInfoText = nil;
                @try {
                    rawUnicodeInfoText = [[((CJTableViewCell*)[[self tableView] cellForRowAtIndexPath:indexPath]).characterUnicodeInfoLabel attributedText] string];
                    targetUnicodeInfoText = [rawUnicodeInfoText componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" :"]][1];
                } @catch (NSException *exception) {
                    targetUnicodeInfoText = @"";
                } @finally {
                    pasteboard.string = targetUnicodeInfoText;
                }
            }]];
            
            [moreOptionsAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [moreOptionsAlert dismissViewControllerAnimated:YES completion:nil];
            }]];
            
            // --------下面是適配iPad的代碼----------
            [[moreOptionsAlert popoverPresentationController] setSourceView:self.view];
            // 去掉多餘的popover箭頭
            [[moreOptionsAlert popoverPresentationController] setPermittedArrowDirections:0];
            [[moreOptionsAlert popoverPresentationController] setSourceView:self.view];
            [[moreOptionsAlert popoverPresentationController] setSourceRect:self.view.bounds];
            // --------上面是適配iPad的代碼----------
            
            [self presentViewController:moreOptionsAlert animated:YES completion:nil];
        }];
        moreOptions.backgroundColor = [UIColor colorWithRed:186.0 / 255.0 green:185.0 / 255.0 blue:192.0 / 255.0 alpha:1];
        return @[copyAction, moreOptions];
    }
}

#pragma mark - 搜索鍵
// 按下搜索鍵後做什麽
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    if([self.searchBar.text isEqualToString:@""]){
        UIAlertController* nullInputAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"請輸入漢字、倉頡碼或表達式" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okAlert = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }];
        [nullInputAlert addAction:okAlert];
        [self presentViewController:nullInputAlert animated:YES completion:nil];
    }
    NSRegularExpression* regexModePattern = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"^r\\|(.+)$"] options:0 error:nil];
    NSTextCheckingResult* regexModeMatch = [regexModePattern firstMatchInString:self.searchBar.text options:0 range:NSMakeRange(0, self.searchBar.text.length)];
    
    NSRegularExpression* idsModePattern = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"^i\\|(.+)$"] options:0 error:nil];
    NSTextCheckingResult* idsModeMatch = [idsModePattern firstMatchInString:self.searchBar.text options:0 range:NSMakeRange(0, self.searchBar.text.length)];
    
    if(regexModeMatch){
        // NSLog(@"%@", [self.searchBar.text substringWithRange:[regexModeMatch rangeAtIndex:1]]);
        [self regexModeWithRegexPattern:[self.searchBar.text substringWithRange:[regexModeMatch rangeAtIndex:1]]];
    }else if(idsModeMatch){
        // NSLog(@"%@", [self.searchBar.text substringWithRange:[idsModeMatch rangeAtIndex:1]]);
        [self idsModeWithPattern:[self.searchBar.text substringWithRange:[idsModeMatch rangeAtIndex:1]]];
    }else{
        [self normalMode];
    }

    [[self tableView] reloadData];
    [self.view endEditing:YES];
    
}

#pragma mark - 信息鍵
// 按下信息鍵後做什麽
- (void)infoButtonClick{
    // NSLog(@"点了一下");
    AboutPageViewController* aboutPageViewController = [[AboutPageViewController alloc] init];
    [self.navigationController pushViewController:aboutPageViewController animated:YES];
}

#pragma mark - 各種搜索模式
// 正則模式
- (void)regexModeWithRegexPattern:(NSString*)regex{
    NSArray* resultArr1 = [self.chartsHandler getRecordFrom:@"CJ3" byRegularExpressionWithPattern:regex];

    NSArray* resultArr2 = [self.chartsHandler getRecordFrom:@"CJ5" byRegularExpressionWithPattern:regex];

    NSArray* resultArr3 = [self.chartsHandler getRecordFrom:@"CJ6" byRegularExpressionWithPattern:regex];

    NSArray* resultArr4 = [self.chartsHandler getRecordFrom:@"MSCJ" byRegularExpressionWithPattern:regex];

    NSArray* resultArr5 = [self.chartsHandler getRecordFrom:@"YHCJ" byRegularExpressionWithPattern:regex];

    NSArray* resultArr6 = [self.chartsHandler getRecordFrom:@"CJ2" byRegularExpressionWithPattern:regex];

    NSArray<NSArray*>* resultArrCollection = @[resultArr1, resultArr2, resultArr3, resultArr4, resultArr5, resultArr6];
    
    [self isResultArrCollectionEmpty:resultArrCollection];
}

- (void)idsModeWithPattern:(NSString*)idsPattern{
    // NSLog(@"%@", [[self chartsHandler] getRecordFromIDSListByGivenComponents:idsPattern]);
    NSArray* resultArr1 = [[self chartsHandler] getRecordFromIDSListAndCjCodeChart:@"CJ3" byGivenComponents:idsPattern];
    
     NSArray* resultArr2 = [[self chartsHandler] getRecordFromIDSListAndCjCodeChart:@"CJ5" byGivenComponents:idsPattern];
    
    NSArray* resultArr3 = [[self chartsHandler] getRecordFromIDSListAndCjCodeChart:@"CJ6" byGivenComponents:idsPattern];

    NSArray* resultArr4 = [[self chartsHandler] getRecordFromIDSListAndCjCodeChart:@"MSCJ" byGivenComponents:idsPattern];

    NSArray* resultArr5 = [[self chartsHandler] getRecordFromIDSListAndCjCodeChart:@"YHCJ" byGivenComponents:idsPattern];

    NSArray* resultArr6 = [[self chartsHandler] getRecordFromIDSListAndCjCodeChart:@"CJ2" byGivenComponents:idsPattern];

    NSArray<NSArray*>* resultArrCollection = @[resultArr1, resultArr2, resultArr3, resultArr4, resultArr5, resultArr6];
    
    [self isResultArrCollectionEmpty:resultArrCollection];
}

- (void)normalMode{
    NSArray* resultArr1 = [[self chartsHandler] getRecordFrom:@"CJ3" byGivenCharacter:self.searchBar.text.lowercaseString];

    NSArray* resultArr2 = [[self chartsHandler] getRecordFrom:@"CJ5" byGivenCharacter:self.searchBar.text.lowercaseString];
    
    NSArray* resultArr3 = [[self chartsHandler] getRecordFrom:@"CJ6" byGivenCharacter:self.searchBar.text.lowercaseString];

    NSArray* resultArr4 = [[self chartsHandler] getRecordFrom:@"MSCJ" byGivenCharacter:self.searchBar.text.lowercaseString];
    
    NSArray* resultArr5 = [[self chartsHandler] getRecordFrom:@"YHCJ" byGivenCharacter:self.searchBar.text.lowercaseString];
    
    NSArray* resultArr6 = [[self chartsHandler] getRecordFrom:@"CJ2" byGivenCharacter:self.searchBar.text.lowercaseString];
    
    NSArray<NSArray*>* resultArrCollection = @[resultArr1, resultArr2, resultArr3, resultArr4, resultArr5, resultArr6];
    
    [self isResultArrCollectionEmpty:resultArrCollection];
    
}

- (void)normalModeWithString:(NSString*)targetString{
    self.searchBar.text = targetString.lowercaseString;
    
    NSArray* resultArr1 = [[self chartsHandler] getRecordFrom:@"CJ3" byGivenCharacter:targetString.lowercaseString];
    
    NSArray* resultArr2 = [[self chartsHandler] getRecordFrom:@"CJ5" byGivenCharacter:targetString.lowercaseString];
    
    NSArray* resultArr3 = [[self chartsHandler] getRecordFrom:@"CJ6" byGivenCharacter:targetString.lowercaseString];
    
    NSArray* resultArr4 = [[self chartsHandler] getRecordFrom:@"MSCJ" byGivenCharacter:targetString.lowercaseString];
    
    NSArray* resultArr5 = [[self chartsHandler] getRecordFrom:@"YHCJ" byGivenCharacter:targetString.lowercaseString];
    
    NSArray* resultArr6 = [[self chartsHandler] getRecordFrom:@"CJ2" byGivenCharacter:targetString.lowercaseString];
    
    NSArray<NSArray*>* resultArrCollection = @[resultArr1, resultArr2, resultArr3, resultArr4, resultArr5, resultArr6];
    
    [self isResultArrCollectionEmpty:resultArrCollection];
}

#pragma mark - 檢驗結果是否爲空
// 抽出來的方法，用于檢驗有没有結果爲空的表。 然後把它們裝在self.allArr裏。
- (void)isResultArrCollectionEmpty:(NSArray<NSArray*>*) resultArrCollection{
    if(resultArrCollection[0].count == 0){
        self.cj3Arr = self.dictionaryWhenNoResult[@"whenNoResult"];
    }else{
        self.cj3Arr = resultArrCollection[0];
    }
    if(resultArrCollection[1].count == 0){
        self.cj5Arr = self.dictionaryWhenNoResult[@"whenNoResult"];
    }else{
        self.cj5Arr = resultArrCollection[1];
    }
    if(resultArrCollection[2].count == 0){
        self.cj6Arr = self.dictionaryWhenNoResult[@"whenNoResult"];
    }else{
        self.cj6Arr = resultArrCollection[2];
    }
    if(resultArrCollection[3].count == 0){
        self.mscjArr = self.dictionaryWhenNoResult[@"whenNoResult"];
    }else{
        self.mscjArr = resultArrCollection[3];
    }
    if(resultArrCollection[4].count == 0){
        self.yhcjArr = self.dictionaryWhenNoResult[@"whenNoResult"];
    }else{
        self.yhcjArr = resultArrCollection[4];
    }
    if(resultArrCollection[5].count == 0){
        self.cj2Arr = self.dictionaryWhenNoResult[@"whenNoResult"];
    }else{
        self.cj2Arr = resultArrCollection[5];
    }
    self.allArr = @[self.cj3Arr, self.cj5Arr, self.cj6Arr, self.mscjArr, self.yhcjArr, self.cj2Arr];
}

#pragma mark - 根據所在Unicode Block不同設置顏色
// 抽出來的方法。根據所在Unicode Block不同設置Label中的小球顏色
- (void)typeSettingWithUnicodeInfoLabelText:(NSMutableAttributedString*)unicodeInfoLabelText andUnicodeBlockInfo:(NSString*)unicodeBlockInfo{
    NSRange characterUnicodeInfoLabelTextColorRange = NSMakeRange(0, 1);
    NSRange characterUnicodeInfoLabelTextPlainColor = NSMakeRange(1, unicodeInfoLabelText.length - 1);
    if([unicodeBlockInfo isEqualToString:@"Unicode 私人使用區"]){
        [unicodeInfoLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:characterUnicodeInfoLabelTextColorRange];
    }else if([unicodeBlockInfo isEqualToString:@"Unicode CJK基本區"]){
        [unicodeInfoLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:71.0 / 255.0 green:104.0 / 255.0 blue:81.0/255.0 alpha:1] range:characterUnicodeInfoLabelTextColorRange];
    }else if([unicodeBlockInfo isEqualToString:@"Unicode CJK擴展A區"]){
        [unicodeInfoLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:94.0 / 255.0 green:171.0 / 255.0 blue:91.0 / 255.0 alpha:1] range:characterUnicodeInfoLabelTextColorRange];
    }else if([unicodeBlockInfo isEqualToString:@"Unicode CJK擴展B區"]){
        [unicodeInfoLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:226.0 / 255.0 green:101.0 / 255.0 blue:141.0 / 255.0 alpha:1] range:characterUnicodeInfoLabelTextColorRange];
    }else if([unicodeBlockInfo isEqualToString:@"Unicode CJK擴展C區"]){
        [unicodeInfoLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:226.0 / 255.0 green:101.0 / 255.0 blue:141.0 / 255.0 alpha:1] range:characterUnicodeInfoLabelTextColorRange];
    }else if([unicodeBlockInfo isEqualToString:@"Unicode CJK擴展D區"]){
        [unicodeInfoLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:226.0 / 255.0 green:101.0 / 255.0 blue:141.0 / 255.0 alpha:1] range:characterUnicodeInfoLabelTextColorRange];
    }else if([unicodeBlockInfo isEqualToString:@"Unicode CJK擴展E區"]){
        [unicodeInfoLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:226.0 / 255.0 green:101.0 / 255.0 blue:141.0 / 255.0 alpha:1] range:characterUnicodeInfoLabelTextColorRange];
    }else if([unicodeBlockInfo isEqualToString:@"Unicode CJK擴展F區"]){
        [unicodeInfoLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:226.0 / 255.0 green:101.0 / 255.0 blue:141.0 / 255.0 alpha:1] range:characterUnicodeInfoLabelTextColorRange];
    }else if([unicodeBlockInfo isEqualToString:@"Unicode CJK兼容表意字符"]){
        [unicodeInfoLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:141.0 / 255.0 green:222.0 / 255.0 blue:140.0 / 255.0 alpha:1] range:characterUnicodeInfoLabelTextColorRange];
    }else if([unicodeBlockInfo isEqualToString:@"Unicode CJK兼容表意字符增補"]){
        [unicodeInfoLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:141.0 / 255.0 green:222.0 / 255.0 blue:140.0 / 255.0 alpha:1] range:characterUnicodeInfoLabelTextColorRange];
    }else if([unicodeBlockInfo isEqualToString:@"Unicode CJK漢字筆畫"]){
        [unicodeInfoLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:141.0 / 255.0 green:222.0 / 255.0 blue:140.0 / 255.0 alpha:1] range:characterUnicodeInfoLabelTextColorRange];
    }else if([unicodeBlockInfo isEqualToString:@"Unicode CJK漢字部首增補"]){
        [unicodeInfoLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:141.0 / 255.0 green:222.0 / 255.0 blue:140.0 / 255.0 alpha:1] range:characterUnicodeInfoLabelTextColorRange];
    }else if([unicodeBlockInfo isEqualToString:@"Unicode CJK康熙字典部首"]){
        [unicodeInfoLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:141.0 / 255.0 green:222.0 / 255.0 blue:140.0 / 255.0 alpha:1] range:characterUnicodeInfoLabelTextColorRange];
    }else if([unicodeBlockInfo isEqualToString:@"Unicode 日文平假名"]){
        [unicodeInfoLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:172.0 / 255.0 green:35.0 / 255.0 blue:51.0 / 255.0 alpha:1] range:characterUnicodeInfoLabelTextColorRange];
    }else if([unicodeBlockInfo isEqualToString:@"Unicode 日文片假名"]){
        [unicodeInfoLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:172.0 / 255.0 green:35.0 / 255.0 blue:51.0 / 255.0 alpha:1] range:characterUnicodeInfoLabelTextColorRange];
    }
    
    
    
    [unicodeInfoLabelText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:100.0 / 255.0 green:100.0 / 255.0 blue:100.0 / 255.0 alpha:1] range:characterUnicodeInfoLabelTextPlainColor];
    [unicodeInfoLabelText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HanaMinA" size:7] range:characterUnicodeInfoLabelTextColorRange];
    [unicodeInfoLabelText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HanaMinA" size:10] range:characterUnicodeInfoLabelTextPlainColor];
    [unicodeInfoLabelText addAttribute:NSBaselineOffsetAttributeName value:@4 range:NSMakeRange(0, 1)];
    [unicodeInfoLabelText addAttribute:NSBaselineOffsetAttributeName value:@3 range:NSMakeRange(1, unicodeInfoLabelText.length - 1)];
}

@end
