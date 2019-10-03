//
//  UserManualViewController.m
//  倉頡字典2356
//
//  Created by Qwetional on 22/7/2019.
//  Copyright © 2019 Qwetional. All rights reserved.
//

#import "UserManualViewController.h"
#import <string>

@interface UserManualViewController ()

@end

@implementation UserManualViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:UIColor.whiteColor];
    
    [[self navigationItem] setTitle:@"使用幫助"];
    
    UITextView* textView = [[UITextView alloc] init];
    [textView setFrame:CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height, [[self view] frame].size.width - ([[self view] safeAreaInsets].left + [[self view] safeAreaInsets].right), [[self view] frame].size.height - ([[self view] safeAreaInsets].top + [[self view] safeAreaInsets].bottom)-([[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height - 40))];
    [textView setEditable:NO];
    [textView setTextContainerInset:UIEdgeInsetsMake(10, 15, 30, 15)];
    //[textView setFont:[UIFont systemFontOfSize:16]];
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;
    NSDictionary* paragraphAttributes = nil;
    if (@available(iOS 13.0, *)) {
        paragraphAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor labelColor],  NSParagraphStyleAttributeName:paragraphStyle};
    } else {
        // Fallback on earlier versions
        paragraphAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16], NSParagraphStyleAttributeName:paragraphStyle};
    }
    std::string manualStr = R"(    歡迎來到倉頡字典2356的世界。爲了讓您能够掌握該字典的使用與特性，我將在下方進行簡單的介紹。
    本倉頡字典支持直接搜索編碼的漢字，衹需在搜索框内輸入想查找的漢字或編碼并按下搜索鍵即可。
    如果您想要同時查找多個漢字或是編碼，請以空格分隔它們。例如説，想要同時查找「米塞斯」三个字，您需要在搜索框内鍵入「米 塞 斯」（不含直角引號）。或者，您也可以以前導字符m|來實現查找。例如説，「m|米塞斯」（不含直角引號）可以與剛剛提到的「米 塞 斯」具有同樣的作用。
    也許您會問，在同時查找多個字符或編碼時爲什麽要手動用空格將不同字符分隔開，或者使用前導字符m|呢？因爲，我們無法保證編碼對應的字符長度一定是1，即使現在所有編碼對應的字符長度都是1，隨着碼表更新，以後也不一定會是如此。出于這種考慮，我們讓用户手動分隔字符，或是在確信要查找的字符長度都爲1時，使用m|模式讓應用自動去分開這些字符。
    有時候，我們需要匹配符合某個條件的編碼。這時候，我們可以運用正則表達式對編碼進行匹配。首先，我介紹一些常用的正則符號。
    在正則表達式中，\w可以匹配到一個字母，或是一個數字，又或是一個下劃綫，又或者是一個漢字。例如说，通过L\w這個正則表達式可以匹配到Li。相同的，sk\w這個正則表達式可以匹配到skr。正則表達式ye.可以匹配到yes，yep，ye!等字符串。這是因爲在正則表達式中，.可以匹配一個任意字符。正則表達式00\d可以匹配到字符串007。這是因爲在正則表達式中，\d可以匹配一個數字。如果你不是使用像Python中的match方法從頭匹配的話，你會發現，la既能匹配到laundry，又能匹配到mainland中的la，這顯然是因爲這兩個字符串中都包含了la。那怎麽樣才能使用la去匹配laundry呢？仔細分析這兩個la會發現如下的不同，laundry中的la位于字符串的最前方，而mainland中的la位于字符串的中間部分。所以，我們就想，是不是存在那麽一個表達式，可以匹配到字符串的頭部位置呢？很幸運，我們的確有這麽一個表達式，它就是^。^并不匹配任何字符，它衹匹配一個位置，就是字符串起始的位置。所以我們衹需寫^la就匹配到了laundry中的la，而避免匹配到mainland中的la。同樣的，一般而言，我們使用se可以匹配到second中的se和Chinese中的se。怎樣纔能使se衹匹配到Chinese中的se？容易發現，Chinese中的se位于字符串的最後方，因此我們可以使用表達式se$。同樣，$不匹配任何字符，它只匹配字符串終結的位置。
    剛剛我們説，\w匹配到一個字母，或是一個數字，又或是一個下劃綫，又或是一個漢字。顯而易見，可以寫\w\w\w来匹配yes字符串。但是如果要匹配有10個字符的understand，難道要寫\w\w\w\w\w\w\w\w\w\w吗？爲了解决這個問題，我們可以簡单地寫\w{10}。{}中的10表示前方的那個表達式出現了10次。更强地，我們甚至可以寫\w{1,10}。{1,10}意味着前面的那個字符出現了1至10次。總之，{m}表示這前面的那個字符出現了m次，{n,m}表示這前面的那個字符出現了n至m次　請注意，{m}的範圍僅限于它前面的那个字符，例如説，l\w{5}表示的是l後面跟着五個漢字/字母/下劃綫/數字，而不是説，一個l後面跟着一個漢字/字母/下劃綫/數字的序列出現了五次。
    就我剛才所説，\w{3}可以匹配yes是毫無疑問的了。但是，\w{3}又會匹配到understand中的und。爲了避免這種狀况，我們回想一下剛剛提到的^和$符號。通過寫^\w{3}$就可在匹配yes的同時避免匹配到understand。這是因爲^代表字符串的開頭，\w{3}代表有三個字母/漢字/数字/下劃綫出現。$代表字符串的結束。就yes這個字符串而言，它完全符全這個正則表達式的描述。而understand這個字符串，在頭三个字母被\w{3}匹配到以後，第四個字符是e。e顯然不是字符串的終結處，所以這正則表達式不會匹配到understand。
    不過，假使我們有一個連續的字符串Ah, yes, I understand.，我們剛剛的方法就不管用了。因为這個字符串是連續的，所以若是寫^\w{3}$，^會去匹配字符串的開頭位置，而\w{3}會去匹配緊接着的Ah,。在\w{3}匹配完Ah,后，第四位就是y了，y顯然不是字符串的終結處。那怎麽办呢？我們還有辦法。在正則表達式中，\b可以匹配單詞的開頭和結束處。所以，我們只要寫\b\w{3}\b就能匹配到yes。
    上面，我曾説過{m}代表前面的字符出現了m次。那如果我不知道前面的字符出現了幾次呢？例如説，我想寫一個正則表達式，它能匹配所有以tory結尾的單詞。但tory前面出現了幾個字母？没人能確定這一點。例如history，tory前面有3個字母，repository中，tory前出現了6個字母。怎麽辦？難道我們要寫^\w{1,+∞}tory$這樣的表達式嗎？當然不是。在正則表達式中，我們使用+來表示一個字符出現了至少一次。所以，我們可以寫^\w+tory$，這就能準確匹配到history、repository等單詞。
    就上方的例子而言，它能匹配到history、repository等詞。但它不能匹配到tory這個詞本身。因爲，\w+意味着tory前方的單詞至少要出現一次。那如何做到既能匹配history、repository單詞，又能匹配到tory這個詞本身呢？可以寫^\w*tory$。*表示，它前面的那個字符出現了任意次(包括0次)。
    在正則表達式中，?代表一個字符可能出現一次，也可能不出現。例如^\w?tory$可以匹配story，也可以匹配tory。
    在我們剛剛介紹的例子中，\w、.、\d等字符被賦予了特殊含義。如果我們真的就想找\w、\d或.這些字符串怎麽辦？這時就不能直接匹配\w、\d或.，而是應在它們的前面增加一個\，即寫成\\w、\\d及\.。這種操作被稱爲「轉義」。
    講了上面这一些規則之後，我們再來看倉頡字典2356的正則。在倉頡字典2356中，可以使用正則表達式去匹配符合正則表達式的編碼，從而找出相應的漢字。爲了在倉頡字典2356中觸發正則模式，您必須在正則表達式前面加上r|。（請忽略後面的那個句號）于是，我們嘗試在倉頡字典2356的搜索框中輸入r|^\w{2}$。（也請忽略這個句號）我們會發現，所有兩碼的字都被找了出來。再例如，我想尋找以編碼haf結尾的漢字，只需要輸入r|haf$即可。如果我想找一個以n開頭，以b結尾的字呢？很簡單，只需要搜r|^n\w*b$即可。
    正則表達式是十分複雜的東西，我在上面介紹的僅是其中一角。如果您需要繼續深入，不妨上網尋找更加詳細的教程。
    
    有時候，我們會想要尋找所有包含某部件的字。對于倉頡字典2356而言，要做到這一點是很簡單的。我在倉頡字典2356中提供了部件查找模式，爲了觸發這個模式，您需要使用i|作爲前導。例如，「i|華」這個表達式就能找到所有含有「華」部件的漢字。
    通過這個模式，我們甚至可以再實現稍微，稍微複雜一點點的東西。利用表意文字描述字符(IDC)，我們可以對一些漢字的結構作出相應的描述。例如説，我不知道某個字怎麽打，但我知道這個字左邊是「有」，右邊是「或」。我們就可以在搜索框寫i|⿰有或，代表有這麽一個字，它的左邊是「有」，右邊是「或」。點擊搜索鍵後，我們就能容易地得到我們心中想的漢字「戫」。
    總之，利用這個模式我們能做很多事。「i|⿺瓦十」可以找到「瓧」，「i|⿱⿰未成肉」可以找到「膥」字。IDC目前有⿰⿱⿲⿳⿴⿵⿶⿷⿸⿹⿺⿻等十二個字符，還請您多多利用。
    
)";
    
    textView.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithUTF8String:manualStr.c_str()] attributes:paragraphAttributes];
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
