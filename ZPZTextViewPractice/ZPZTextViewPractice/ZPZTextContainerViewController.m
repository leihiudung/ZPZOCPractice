//
//  ZPZTextContainerViewController.m
//  ZPZTextViewPractice
//
//  Created by zhoupengzu on 2017/12/1.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZTextContainerViewController.h"

@interface ZPZTextContainerViewController ()

@property (nonatomic, strong) UITextView * textView;

@end

@implementation ZPZTextContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * endEditItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignTextViewFirstResponder)];
    self.navigationItem.rightBarButtonItems = @[endEditItem];
    [self configTextViewWithContainerAndExclusionPaths];
}

- (void)resignTextViewFirstResponder {
    [_textView resignFirstResponder];
}

- (CGFloat)getContentHeight {
    return [UIScreen mainScreen].bounds.size.height - self.navigationController.navigationBar.frame.size.height - [[UIApplication sharedApplication] statusBarFrame].size.height - 20;
}

- (void)configUI {
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [self getContentHeight])];
    _textView.backgroundColor = [UIColor orangeColor];
//    _textView.delegate = self;
    [self.view addSubview:_textView];
}

- (void)configBasicTextView {
    CGFloat height = [self getContentHeight];
    
    NSLayoutManager * layoutManager = [[NSLayoutManager alloc] init]; //这里必须要用这个方法初始化
    
    NSTextStorage * storeage = [[NSTextStorage alloc] initWithString:[self contentStr]];
    [storeage addLayoutManager:layoutManager];
    
    NSTextContainer * textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, height / 2)];
    textContainer.widthTracksTextView = YES;
    [layoutManager addTextContainer:textContainer];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 2 * 10, height) textContainer:textContainer];
    _textView.backgroundColor = [UIColor orangeColor];
    _textView.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:_textView];
}

- (void)configTextViewWithTwoContainer {
    CGFloat height = [self getContentHeight];
    
    NSLayoutManager * layoutManager = [[NSLayoutManager alloc] init]; //这里必须要用这个方法初始化
    
    NSTextStorage * storeage = [[NSTextStorage alloc] initWithString:[self contentStr]];
    [storeage addLayoutManager:layoutManager];
    
    NSTextContainer * textContainer1 = [[NSTextContainer alloc] initWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, height / 2)];
    textContainer1.widthTracksTextView = YES;
    NSTextContainer * textContainer2 = [[NSTextContainer alloc] initWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, height / 2)];
    textContainer2.widthTracksTextView = YES;
    [layoutManager addTextContainer:textContainer1];
    [layoutManager addTextContainer:textContainer2];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 2 * 10, height) textContainer:textContainer2];
    _textView.backgroundColor = [UIColor orangeColor];
    _textView.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:_textView];
}

- (void)configTextViewWithContainerAndLineBreakMode {
    CGFloat height = [self getContentHeight];
    
    NSLayoutManager * layoutManager = [[NSLayoutManager alloc] init]; //这里必须要用这个方法初始化
    
    NSTextStorage * storeage = [[NSTextStorage alloc] initWithString:[self contentStr]];
    [storeage addLayoutManager:layoutManager];
    
    NSTextContainer * textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, height / 2)];
    textContainer.widthTracksTextView = YES;
    textContainer.lineBreakMode = NSLineBreakByTruncatingHead;
    [layoutManager addTextContainer:textContainer];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 2 * 10, height) textContainer:textContainer];
    _textView.backgroundColor = [UIColor orangeColor];
    _textView.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:_textView];
}

- (void)configTextViewWithContinerAndLineFragmentPadding {
    CGFloat height = [self getContentHeight];
    
    NSLayoutManager * layoutManager = [[NSLayoutManager alloc] init]; //这里必须要用这个方法初始化
    
    NSTextStorage * storeage = [[NSTextStorage alloc] initWithString:[self contentStr]];
    [storeage addLayoutManager:layoutManager];
    
    NSTextContainer * textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, height / 2)];
    textContainer.widthTracksTextView = YES;
    textContainer.lineFragmentPadding = 20;
    [layoutManager addTextContainer:textContainer];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 2 * 10, height) textContainer:textContainer];
    _textView.backgroundColor = [UIColor orangeColor];
    _textView.textContainerInset = UIEdgeInsetsMake(0, 20, 0, 20);
    _textView.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:_textView];
    NSLog(@"%@",NSStringFromUIEdgeInsets(_textView.textContainerInset));
}

- (void)configTextViewWithContainerAndExclusionPaths {
    CGFloat height = [self getContentHeight];
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 2 * 10;
    
    NSLayoutManager * layoutManager = [[NSLayoutManager alloc] init]; //这里必须要用这个方法初始化
    
    NSTextStorage * storeage = [[NSTextStorage alloc] initWithString:[self contentStr]];
    [storeage addLayoutManager:layoutManager];
    
    NSTextContainer * textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, height / 2)];
    textContainer.widthTracksTextView = YES;
    
    UIBezierPath * path1 = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, width / 2, textContainer.size.height / 2)];
    UIBezierPath * path2 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(width / 2, textContainer.size.height * 3 / 4, width / 2, textContainer.size.height / 4) byRoundingCorners:(UIRectCornerTopLeft) cornerRadii:CGSizeMake(20, 20)];
    textContainer.exclusionPaths = @[path1, path2];
    
    [layoutManager addTextContainer:textContainer];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, width, height) textContainer:textContainer];
    _textView.backgroundColor = [UIColor orangeColor];
    _textView.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:_textView];
}

- (NSString *)contentStr {
    return @"A region where text is laid out.An NSLayoutManager uses NSTextContainer to determine where to break lines, lay out portions of text, and so on. An NSTextContainer object typically defines rectangular regions, but you can define exclusion paths inside the text container to create regions where text does not flow. You can also subclass to create text containers with nonrectangular regions, such as circular regions, regions with holes in them, or regions that flow alongside graphics.Instances of the NSTextContainer, NSLayoutManager, and NSTextStorage classes can be accessed from threads other than the main thread as long as the app guarantees access from only one thread at a time.";
}

/**
 * NSTextStorage * textStorage;
 * 是NSMutableAttributedString类的半抽象的子类；
 * 可以在任意线程中操作，但是要保证其在同一时间只有一个线程在访问
 */
- (void)configTextContainer {
    NSTextContainer * textContainer;
    NSLayoutManager * layoutManager;
    NSTextStorage * textStorage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
