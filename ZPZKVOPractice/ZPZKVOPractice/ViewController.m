//
//  ViewController.m
//  ZPZKVOPractice
//
//  Created by zhoupengzu on 2017/12/7.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ViewController.h"
#import "ZPZNormalKVOUseViewController.h"
#import "ZPZHandleKVOViewController.h"
#import "ZPZObserveInfoViewController.h"
#import "ZPZRuntimeKVOViewController.h"

@interface ViewController ()

@property (nonatomic,assign) CGFloat btnWidth;
@property (nonatomic,assign) CGFloat btnHeight;
@property (nonatomic,assign) CGFloat btnBeginY;
@property (nonatomic,assign) CGFloat btnSpace;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"KVO";
    
    [self createUseButton];
}
#pragma - mark create button
- (void)createUseButton {
    _btnSpace = 15;
    NSInteger lineCount = 2;
    _btnWidth = ([UIScreen mainScreen].bounds.size.width - (lineCount + 1) * _btnSpace) / lineCount;
    if (_btnWidth < 0) {
        _btnWidth = 0;
    }
    _btnHeight = 50;
    NSString * titleKey = @"title";
    NSString * selKey = @"selKey";
    NSArray<NSDictionary *> * btnArray = @[
                                           @{titleKey:@"KVO normal use",selKey:NSStringFromSelector(@selector(normalKVOUse))},
                                           @{titleKey:@"KVO handle use",selKey:NSStringFromSelector(@selector(handleKVOUse))},
                                           @{titleKey:@"KVO observe info",selKey:NSStringFromSelector(@selector(logObserveInfo))},
                                           @{titleKey:@"KVO runtime analyse",selKey:NSStringFromSelector(@selector(analyseKVO))},
                                           ];
    for (NSInteger i = 0; i < btnArray.count; i++) {
        CGFloat beignX = (i % lineCount + 1) * _btnSpace + i % lineCount * _btnWidth;
        CGFloat beginY = (i / lineCount + 1) * _btnSpace + i / 2 * _btnHeight;
        CGRect frame = { { beignX, beginY },{ _btnWidth, _btnHeight } };
        NSString * title = btnArray[i][titleKey];
        NSString * selStr = btnArray[i][selKey];
        UIButton * button = [self createButtonWithFrame:frame andTitle:title andSelectorStr:selStr];
        [self.view addSubview:button];
    }
}

- (void)normalKVOUse {
    ZPZNormalKVOUseViewController * normalVC = [[ZPZNormalKVOUseViewController alloc] init];
    [self.navigationController pushViewController:normalVC animated:YES];
}

- (void)handleKVOUse {
    ZPZHandleKVOViewController * handleVC = [[ZPZHandleKVOViewController alloc] init];
    [self.navigationController pushViewController:handleVC animated:YES];
}

- (void)logObserveInfo {
    ZPZObserveInfoViewController * observeVC = [[ZPZObserveInfoViewController alloc] init];
    [self.navigationController pushViewController:observeVC animated:YES];
}

- (void)analyseKVO {
    ZPZRuntimeKVOViewController * runtimeVC = [[ZPZRuntimeKVOViewController alloc] init];
    [self.navigationController pushViewController:runtimeVC animated:YES];
}

- (UIButton *)createButtonWithFrame:(CGRect)frame andTitle:(NSString *)title andSelectorStr:(NSString *)selStr {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:NSSelectorFromString(selStr) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor orangeColor];
    button.layer.cornerRadius = frame.size.height / 2;
    button.layer.masksToBounds = YES;
    return button;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
