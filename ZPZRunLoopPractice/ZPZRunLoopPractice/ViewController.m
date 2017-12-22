//
//  ViewController.m
//  ZPZRunLoopPractice
//
//  Created by zhoupengzu on 2017/12/22.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Run Loop";
//    [self executePerfomSelectorOnMainThread];
    [self configUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self executePerfomSelectorOnCurrentThread];
//    [self executePerfomSelectorOnMainThread];
}

- (void)configUI {
    CGFloat margin = 15;
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 2 * margin;
    CGFloat height = 50;
    CGFloat beginY = 20;
    
    UIButton * getLoopButton = [self createButtonWithFrame:CGRectMake(margin, beginY, width, height) andTitle:@"获取RunLoop" andSEL:@selector(getCurrentRunLoop)];
    [self.view addSubview:getLoopButton];
    beginY = CGRectGetMaxY(getLoopButton.frame) + 20;
    UIButton * addLoopObserverButton = [self createButtonWithFrame:CGRectMake(margin, beginY, width, height) andTitle:@"添加RunLoop观察者" andSEL:@selector(addRunLoopObserver)];
    [self.view addSubview:addLoopObserverButton];
    beginY = CGRectGetMaxY(addLoopObserverButton.frame) + 20;
}

- (void)getCurrentRunLoop {
    //使用Cocoa框架
    NSRunLoop * currCocoaLoop = [NSRunLoop currentRunLoop];
    NSLog(@"Cocoa:%@",currCocoaLoop);
    //使用Core Foundation框架
    CFRunLoopRef loopRef = CFRunLoopGetCurrent();
    NSLog(@"Core Foundation:%@",loopRef);
}

void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    
    NSLog(@"%@", @(activity));
}

- (void)addRunLoopObserver {
    //获取CFRunLoopRef方法一：
//    NSRunLoop * nsRunLoop = [NSRunLoop currentRunLoop];
//    CFRunLoopRef loopRef = [nsRunLoop getCFRunLoop];
    //获取CFRunLoopRef方法二：
    CFRunLoopRef loopRef = CFRunLoopGetCurrent();
    //添加观察者方法一：
//    CFRunLoopObserverRef observerRef = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, true, 0, &runLoopObserverCallBack, NULL);
    //添加观察者方法二：
    CFRunLoopObserverRef observerRef = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopBeforeWaiting | kCFRunLoopAfterWaiting, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"%@", @(activity));
    });
    CFRunLoopAddObserver(loopRef, observerRef, kCFRunLoopCommonModes);
    if (observerRef) {
        CFRelease(observerRef);
    }
}

- (void)executePerfomSelectorOnCurrentThread {
    
    [self performSelector:@selector(logEventForPerfomSelectorOnCurrentThreadForSleep:) withObject:@"1-1" afterDelay:1];
    NSLog(@"after delay 1-1");
    
    [self performSelector:@selector(logEventForPerfomSelectorOnCurrentThread:) withObject:@"1" afterDelay:1];
    sleep(1);
    [self performSelector:@selector(logEventForPerfomSelectorOnCurrentThread:) withObject:@"0" afterDelay:0];

}
- (void)logEventForPerfomSelectorOnCurrentThread:(NSString *)infoStr {
    NSLog(@"%s--%@--info:%@",__func__,[NSThread currentThread],infoStr);
}
- (void)logEventForPerfomSelectorOnCurrentThreadForSleep:(NSString *)infoStr {
    NSLog(@"before:%s--%@--info:%@",__func__,[NSThread currentThread],infoStr);
    sleep(2);
    NSLog(@"after:%s--%@--info:%@",__func__,[NSThread currentThread],infoStr);
}
////////////////////////
- (void)executePerfomSelectorOnMainThread {
    [self performSelectorOnMainThreadWithWait];
    NSLog(@"after add wait");
    [self performSelectorOnMainThreadWithNoWait];
}

- (void)performSelectorOnMainThreadWithWait {
    [self performSelectorOnMainThread:@selector(logEventForWait:) withObject:@"wait" waitUntilDone:YES];
    NSLog(@"I am here for Wait");
}

- (void)performSelectorOnMainThreadWithNoWait {
    [self performSelectorOnMainThread:@selector(logEventForNoWait:) withObject:@"no wait" waitUntilDone:NO];
    NSLog(@"I am here for no Wait");
}

- (void)logEventForWait:(NSString *)infoStr {
    NSLog(@"%@", infoStr);
    sleep(2);
}

- (void)logEventForNoWait:(NSString *)infoStr {
    NSLog(@"%@", infoStr);
    sleep(2);
}
///////////////////////////
- (UIButton *)createButtonWithFrame:(CGRect)frame andTitle:(NSString *)title andSEL:(SEL)sel {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
