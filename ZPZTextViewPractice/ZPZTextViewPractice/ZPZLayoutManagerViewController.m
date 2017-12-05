//
//  ZPZLayoutManagerViewController.m
//  ZPZTextViewPractice
//
//  Created by zhoupengzu on 2017/12/4.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZLayoutManagerViewController.h"
/**
 * NSLayoutManager:用来协调NSTextStorage中的字符的展示
 */

@interface ZPZLayoutManagerViewController ()

@property (nonatomic, strong) UITextView * textView;
@property (nonatomic, strong) NSLayoutManager * layoutManager;
@property (nonatomic, strong) NSTextStorage * storeage;

@end

@implementation ZPZLayoutManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIBarButtonItem * endEditItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignTextViewFirstResponder)];
    self.navigationItem.rightBarButtonItems = @[endEditItem];
    [self configTextViewWithInvalidateGlyphs];
}

- (void)resignTextViewFirstResponder {
    [_textView resignFirstResponder];
}

- (CGFloat)getContentHeight {
    return [UIScreen mainScreen].bounds.size.height - self.navigationController.navigationBar.frame.size.height - [[UIApplication sharedApplication] statusBarFrame].size.height - 20;
}

- (void)configBasicUse {
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

- (void)configBasicTextViewWithShowsInvisibleCharacters {
    CGFloat height = [self getContentHeight];
    
    NSLayoutManager * layoutManager = [[NSLayoutManager alloc] init]; //这里必须要用这个方法初始化
    layoutManager.showsInvisibleCharacters = YES;
    layoutManager.showsControlCharacters = YES;
    
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

/************************** Invalidation **************************/
- (void)configTextViewWithInvalidateGlyphs {
    CGFloat height = [self getContentHeight];
    
    _layoutManager = [[NSLayoutManager alloc] init]; //这里必须要用这个方法初始化
    
    
    _storeage = [[NSTextStorage alloc] initWithString:[self contentStr]];
    [_storeage addLayoutManager:_layoutManager];
    
    NSTextContainer * textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, height / 2)];
    textContainer.widthTracksTextView = YES;
    [_layoutManager addTextContainer:textContainer];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 2 * 10, height) textContainer:textContainer];
    _textView.backgroundColor = [UIColor orangeColor];
    _textView.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:_textView];
    
    NSLog(@"%@",@(_layoutManager.numberOfGlyphs));
}

- (NSString *)contentStr {
    return @"周鹏祖";
    return @"A region where text is laid out.An NSLayoutManager uses NSTextContainer to determine where to break lines, lay out portions of text, and so on. An NSTextContainer object typically defines rectangular regions, but you can define exclusion paths inside the text container to create regions where text does not flow. You can also subclass to create text containers with nonrectangular regions, such as circular regions, regions with holes in them, or regions that flow alongside graphics.Instances of the NSTextContainer, NSLayoutManager, and NSTextStorage classes can be accessed from threads other than the main thread as long as the app guarantees access from only one thread at a time.";
}

@end
