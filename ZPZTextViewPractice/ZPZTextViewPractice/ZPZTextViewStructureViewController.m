//
//  ZPZTextViewStructureViewController.m
//  ZPZTextViewPractice
//
//  Created by zhoupengzu on 2017/12/1.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZTextViewStructureViewController.h"
#import <objc/runtime.h>

@interface ZPZTextViewStructureViewController ()

@property (nonatomic, strong) UITextView * textView;

@end

@implementation ZPZTextViewStructureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"UITextView结构";
    [self configUI];
    [self printProperty];
}

- (void)configUI {
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 15, self.view.frame.size.width - 2 * 15, 200)];
    _textView.backgroundColor = [UIColor orangeColor];
//    _textView.textContainerInset = UIEdgeInsetsMake(20, 20, 20, 20);
    [self.view addSubview:_textView];
    NSLog(@"%@",NSStringFromUIEdgeInsets(_textView.textContainerInset));
}

- (void)printProperty {
    unsigned int count = 0;
    //这是一个数组，但是不包含继承来的
    objc_property_t * property = class_copyPropertyList([_textView class], &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t tempProperty = property[i];
        const char * propertyName = property_getName(tempProperty);
        NSString * propertyNameStr = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSLog(@"%@",propertyNameStr);
    }
    
    free(property);
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
