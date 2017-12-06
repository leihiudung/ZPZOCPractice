//
//  ViewController.m
//  ZPZCustomTextView
//
//  Created by zhoupengzu on 2017/12/6.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ViewController.h"
#import "ZPZTextViewHead.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
//    [self configDefaultLabel];
    [self configTextView];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
    [self.view addGestureRecognizer:tap];
}

- (void)configTextView {
    ZPZTextView * textView = [[ZPZTextView alloc] initWithFrame:CGRectMake(20, 20, [UIScreen mainScreen].bounds.size.width - 2 * 20, 100)];
//    NSLog(@"%@",NSStringFromUIEdgeInsets(textView.textContainerInset));
    textView.backgroundColor = [UIColor orangeColor];
    textView.placeHoldStr = @"I am the place hold textI am the place hold textI am the place hold textI am the place hold textI am the place hold textI am the place hold textI am the place hold text";
//    textView.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:textView];
    textView.shouldBeginEditing = ^BOOL(ZPZTextView * zT) {
        NSLog(@"begin");
        return YES;
    };
}

- (void)endEditing {
    [self.view endEditing:YES];
}

- (void)configDefaultLabel {
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 200, 50)];
    label.backgroundColor = [UIColor orangeColor];
    NSAttributedString * attr = [[NSAttributedString alloc] initWithString:@"attributed"];
//    label.text = @"hahahhah";
    label.attributedText = attr;
    [self.view addSubview:label];
    
    NSLog(@"attributedText:%@",label.attributedText.string);
    NSLog(@"text:%@",label.text);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
