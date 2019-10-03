//
//  bullshitViewController.m
//  倉頡字典2356
//
//  Created by Qwetional on 22/7/2019.
//  Copyright © 2019 Qwetional. All rights reserved.
//

#import "BullshitViewController.h"

@interface BullshitViewController ()

@end

@implementation BullshitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:UIColor.whiteColor];
    
    [[self navigationItem] setTitle:@"胡言亂語"];
    
    UITextView* textView = [[UITextView alloc] init];
    [textView setFrame:CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height, [[self view] frame].size.width - ([[self view] safeAreaInsets].left + [[self view] safeAreaInsets].right), [[self view] frame].size.height - ([[self view] safeAreaInsets].top + [[self view] safeAreaInsets].bottom)-([[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height - 40))];
    [textView setEditable:NO];
    [textView setTextContainerInset:UIEdgeInsetsMake(10, 15, 30, 15)];
    //[textView setFont:[UIFont systemFontOfSize:16]];
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;
    // NSDictionary* paragraphAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16], NSParagraphStyleAttributeName:paragraphStyle};
    NSDictionary* paragraphAttributes = nil;
    if (@available(iOS 13.0, *)) {
        paragraphAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor labelColor],  NSParagraphStyleAttributeName:paragraphStyle};
    } else {
        // Fallback on earlier versions
        paragraphAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16], NSParagraphStyleAttributeName:paragraphStyle};
    }
    textView.attributedText = [[NSAttributedString alloc] initWithString:@"    1982年，朱邦復登報放弃了倉頡輸入法的專利權。這個决定賦予了倉頡輸入法極大的生命力。倉頡輸入法從此不再屬於某個人，并在繁體中文地區被廣爲使用。就連使用簡體中文的大陸地區，也有人自行編製倉頡輸入法的碼表，供輸入用。可以説，倉頡輸入法産生了巨大的影響。\n    倉頡輸入法是公認的開放的輸入法。正因爲它開放，倉頡輸入法纔會被極爲廣泛地安裝到各大系統中。正因爲它開放，纔會有大新倉頡、快倉等各種魔改版本。然而，朱邦復先生當初開發倉頡輸入法并不衹爲輸入用，因此，倉頡輸入法的更新，也會順帶着倉頡系統内碼更新，官方倉頡輸入法的收字範圍，是由倉頡官方來决定的。又因爲倉頡内碼并未成爲事實上的標準，因此若不對應好倉頡内碼和Unicode，倉頡官方發佈的對照表就無法在常見的操作系統中使用。這種對應工作，通常需要人工完成，由于官方發展倉頡系統、倉頡内碼的立場，官方并不熱衷于去做這種對應。朱邦復先生曾言倉頡系統不兼容Unicode，正是此種原因。于是，這個任務常常由民間愛好者完成，而民間愛好者的水平又參差不齊。文本化的碼表往往會由于愛好者個人的喜好、倉頡的掌握水平，又或是倉頡系統中没有收入Unicode中的漢字而与官方的碼表産生出入。從這個角度看，我認爲倉頡輸入法又是封閉的。從倉頡系統到Unicode會有一道門檻，這阻止了官方對照表的傳播。\n    正因爲倉頡輸入法的開放性與(我認爲的)封閉性并存，官方在編碼取正中没有那麽高的話語權。這有好處也有壞處。如果民間有人認爲倉頡的官方編碼不好，他完全有權去做一張合他意的碼表，并將這碼表到處傳播，不須過問朱邦復先生或沈紅蓮女士的意見。如果民間有人認爲倉頡没有簡碼、不能打詞組的設定不好，他完全能爲它定簡碼、定詞組規則，甚至能將産品用于售賣，也不需要向朱邦復先生繳納費用，于是便有了快倉、大新倉頡和快趣詞組輸入規則。倉頡二代時，官方倉頡尚不能打簡，于是大陸便有人製作了簡體的倉頡碼表方便輸入。這就是説，倉頡用户有充分的自由權。但是，正因爲不須過問朱邦復團隊的意見，微軟便可以爲倉頡輸入法胡亂編碼，導致了微軟倉頡的非Big5部分亂象叢生。正因爲不須過問朱邦復團隊的意見，倉頡之友·馬來西亞碼表的C/D區混亂不堪，完全違背了倉頡輸入法的字首字身劃分準則，正因爲可以憑個人的喜好修改碼表，民間六代存在很多奇怪的編碼，例如「已」被編碼爲「尸卜山」，還誤導了不少人，以爲六代的「已」本就編「尸卜山」。\n    倉頡輸入法軟件的維護基本上都由民間團隊完成，例如曾受官方贊助的倉頡之友·馬來西亞有著名的《倉頡平臺2012》軟件。但是《倉頡平臺2012》已经有數年未有更新，其碼表的C/D區有許多錯誤。而且，《倉頡平臺2012》難以在Modern界面運行。我認爲，目前倉頡的生態很難令人滿意。\n    我從2015年暑假開始學習倉頡輸入法，使用過一年微軟倉頡，一年雅虎倉頡。我承認，目前流行的一些碼表都有其優點，但是碼表内都有規則不統一的問題。例如在三五代碼表中「冫」按二代規則取成「卜」的問題，我在數張碼表都有見到。爲了改善這種情况，我與骨折群内的數位成員都做過一些嘗試。例如我與Jackchows分别製作了倉頡三代補完計劃與倉頡五代補完計劃碼表，收字目前分别達E區與F區，理清了許多問題。nameoverflow大神則嘗試過用機器學習來給漢字取碼，mrhso找到了倉頡六代的完整輔助字形圖，無論是對于我們製作補完計劃還是民間六代查錯都頗有助益。\n    在試圖完善倉頡輸入法生態的過程中，我學習了很多東西。例如整理碼表中需要方便地處理碼表格式，于是我成功學會了正則表達式，再例如爲了方便地生成詞組需要寫程序，後來我學會了Python(當然專業需要也是原因之一)。倉頡輸入法在這個角度對我而言不再僅僅是一種輸入法，而是一種嘗試新技術的載體。\n    2017至2018年，我曾試用過日月遞照所製作的倉頡字典2356。重投iOS陣營後，倉頡字典2356仍給我留下了深刻的印象。相對于其他倉頡字典應用，倉頡字典2356具有碼表全、無廣告以及免費等許多優點，可以説它是我見過的最强大的字典應用。于是在换回iOS後，我就在考慮製作iOS版本的倉頡字典。總之，經過一段時間後，倉頡字典2356 For iOS正式面世了。我給它添加了一些我認爲有用的功能，例如正則表達式查字、部件查字等功能，相信它會在以後發揮許多用處。\n    以上便是我的一些感想，權作爲我第一個iOS應用的序。如果給它取個别名，我會將它命名成《倉頡輸入法：從入門到iOS開發》。若是閣下不同意本文的觀點，可當我在胡言亂語。不論如何，倉頡字典2356仍然會是非常强大的倉頡字典應用，請盡情使用吧。\n" attributes:paragraphAttributes];
    [self.view addSubview:textView];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
