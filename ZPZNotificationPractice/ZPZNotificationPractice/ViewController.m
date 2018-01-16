//
//  ViewController.m
//  ZPZNotificationPractice
//
//  Created by zhoupengzu on 2017/12/14.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ViewController.h"
#import "ZPZNotiSyncViewController.h"
#import "ZPZNotiThreadViewController.h"
#import "ZPZNotiQueueViewController.h"
#import "ZPZRegisteNotiViewController.h"

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
    self.title = @"NSNotification";
    
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
                                           @{titleKey:@"gotoSendNotiSync",selKey:NSStringFromSelector(@selector(gotoSendNotiSync))},
                                           @{titleKey:@"接收通知和线程的关系",selKey:NSStringFromSelector(@selector(gotoNotiAboutThread))},
                                           @{titleKey:@"通知队列",selKey:NSStringFromSelector(@selector(gotoNotiQueue))},
                                           @{titleKey:@"注册通知",selKey:NSStringFromSelector(@selector(gotoRegisteNoti))},
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

- (void)gotoSendNotiSync {
    ZPZNotiSyncViewController * syncVC = [[ZPZNotiSyncViewController alloc] init];
    [self.navigationController pushViewController:syncVC animated:YES];
}

- (void)gotoNotiAboutThread {
    ZPZNotiThreadViewController * threadVC = [[ZPZNotiThreadViewController alloc] init];
    [self.navigationController pushViewController:threadVC animated:YES];
}

- (void)gotoNotiQueue {
    ZPZNotiQueueViewController * queueVC = [[ZPZNotiQueueViewController alloc] init];
    [self.navigationController pushViewController:queueVC animated:YES];
}

- (void)gotoRegisteNoti {
    ZPZRegisteNotiViewController * registeVC = [[ZPZRegisteNotiViewController alloc] init];
    [self.navigationController pushViewController:registeVC animated:YES];
}

#pragma - mark common button
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
