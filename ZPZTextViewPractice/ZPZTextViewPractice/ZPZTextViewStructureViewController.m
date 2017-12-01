//
//  ZPZTextViewStructureViewController.m
//  ZPZTextViewPractice
//
//  Created by zhoupengzu on 2017/12/1.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZTextViewStructureViewController.h"

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
}

- (void)configUI {
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 15, self.view.frame.size.width - 2 * 15, 200)];
    _textView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_textView];
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
