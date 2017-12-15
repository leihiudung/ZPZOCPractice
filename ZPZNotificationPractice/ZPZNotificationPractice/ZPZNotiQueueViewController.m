//
//  ZPZNotiQueueViewController.m
//  ZPZNotificationPractice
//
//  Created by zhoupengzu on 2017/12/14.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZNotiQueueViewController.h"

@interface ZPZNotiQueueViewController ()

@property (nonatomic,assign) CGFloat btnWidth;
@property (nonatomic,assign) CGFloat btnHeight;
@property (nonatomic,assign) CGFloat btnBeginY;
@property (nonatomic,assign) CGFloat btnSpace;

@end

@implementation ZPZNotiQueueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUseButton];
    [self addNotificationForThread];
}
//主线程添加
- (void)addNotificationForThread {
    [self addNotification1];
    [self addNotification2];
}

- (void)postNotificationInThreads {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        NSLog(@"发送receiveNotification1的thread:%@，queue：%@",[NSThread currentThread],[NSNotificationQueue defaultQueue]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveNotification1" object:nil];
    });
    dispatch_async(queue, ^{
        NSLog(@"发送receiveNotification2的thread:%@，queue：%@",[NSThread currentThread],[NSNotificationQueue defaultQueue]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveNotification2" object:nil];
    });
    dispatch_async(queue, ^{
        
        NSLog(@"发送receiveNotification1的thread:%@，queue：%@",[NSThread currentThread],[NSNotificationQueue defaultQueue]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveNotification1" object:nil];
    });
    dispatch_async(queue, ^{
        NSLog(@"发送receiveNotification2的thread:%@，queue：%@",[NSThread currentThread],[NSNotificationQueue defaultQueue]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveNotification2" object:nil];
    });
}

- (void)postNotificationInQueue {
    NSNotification * noti = [NSNotification notificationWithName:@"receiveNotification1" object:nil];
    NSNotificationQueue * queue = [[NSNotificationQueue alloc] initWithNotificationCenter:[NSNotificationCenter defaultCenter]];
    NSLog(@"发送receiveNotification1的thread:%@，queue：%@,mainQueue:%@",[NSThread currentThread],queue,[NSNotificationQueue defaultQueue]);
    [queue enqueueNotification:noti postingStyle:NSPostWhenIdle];
    NSLog(@"我先继续走了!!!");
}

- (void)postNotificationInQueueSpecial {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        NSNotification * noti = [NSNotification notificationWithName:@"receiveNotification1" object:nil];
        NSNotificationQueue * queue = [[NSNotificationQueue alloc] initWithNotificationCenter:[NSNotificationCenter defaultCenter]];
        [queue enqueueNotification:noti postingStyle:NSPostWhenIdle];
    });
}

- (void)coalescingNotification {
    NSNotification * noti1 = [NSNotification notificationWithName:@"receiveNotification2" object:nil];
    NSNotificationQueue * queue1 = [[NSNotificationQueue alloc] initWithNotificationCenter:[NSNotificationCenter defaultCenter]];
    [queue1 enqueueNotification:noti1 postingStyle:NSPostWhenIdle coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    [queue1 enqueueNotification:noti1 postingStyle:NSPostWhenIdle];
}

- (void)addNotification1 {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification1) name:@"receiveNotification1" object:nil];
}

- (void)addNotification2 {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification2) name:@"receiveNotification2" object:nil];
}

- (void)receiveNotification1 {
    NSLog(@"接收前%s,%@,queue:%@",__func__,[NSThread currentThread],[NSNotificationQueue defaultQueue]);
    sleep(2);
    NSLog(@"接收后%s,%@,queue:%@",__func__,[NSThread currentThread],[NSNotificationQueue defaultQueue]);
}

- (void)receiveNotification2 {
    NSLog(@"接收%s,%@,queue:%@",__func__,[NSThread currentThread],[NSNotificationQueue defaultQueue]);
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
                                           @{titleKey:@"post noti in thread",selKey:NSStringFromSelector(@selector(postNotificationInThreads))},
                                           @{titleKey:@"post noti in queue",selKey:NSStringFromSelector(@selector(postNotificationInQueue))},
                                           @{titleKey:@"post in special queue",selKey:NSStringFromSelector(@selector(postNotificationInQueueSpecial))},
                                           @{titleKey:@"coalescing notification",selKey:NSStringFromSelector(@selector(coalescingNotification))},
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

@end
