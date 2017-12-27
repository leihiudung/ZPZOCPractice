//
//  ZPZRunLoopStartViewController.m
//  ZPZRunLoopPractice
//
//  Created by zhoupengzu on 2017/12/25.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZRunLoopStartViewController.h"

@interface ZPZRunLoopStartViewController ()
{
    NSPort * emptyPort;
    BOOL isContinue;
}

//@property (nonatomic, strong) NSTimer * onlyRunTimer;

@end

@implementation ZPZRunLoopStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Start Loop";
    [self addNotification];
    [self configUI];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:NSThreadWillExitNotification object:nil];
}

- (void)receiveNotification:(NSNotification *)noti {
    NSLog(@"Notification info:%@",noti.userInfo);
}

- (void)configUI {
    CGFloat margin = 15;
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 2 * margin;
    CGFloat height = 50;
    CGFloat beginY = 20;
    
    UIButton * onlyRunButton = [self createButtonWithFrame:CGRectMake(margin, beginY, width, height) andTitle:@"无条件启动" andSEL:@selector(onlyRun)];
    [self.view addSubview:onlyRunButton];
    beginY = CGRectGetMaxY(onlyRunButton.frame) + 20;
    UIButton * runDateButton = [self createButtonWithFrame:CGRectMake(margin, beginY, width, height) andTitle:@"限定时间" andSEL:@selector(runWithDate)];
    [self.view addSubview:runDateButton];
    beginY = CGRectGetMaxY(runDateButton.frame) + 20;
    UIButton * runDateWithModeButton = [self createButtonWithFrame:CGRectMake(margin, beginY, width, height) andTitle:@"限定时间和模式" andSEL:@selector(runWithDateAndMode)];
    [self.view addSubview:runDateWithModeButton];
    beginY = CGRectGetMaxY(runDateWithModeButton.frame) + 20;
    UIButton * dealRepeatButton = [self createButtonWithFrame:CGRectMake(margin, beginY, width, height) andTitle:@"重复执行" andSEL:@selector(dealWithTimerRepeat)];
    [self.view addSubview:dealRepeatButton];
    beginY = CGRectGetMaxY(dealRepeatButton.frame) + 20;
    UIButton * cfRunButton = [self createButtonWithFrame:CGRectMake(margin, beginY, width, height) andTitle:@"CFRunLoopRun()" andSEL:@selector(runwithCFRunLoopRun)];
    [self.view addSubview:cfRunButton];
    beginY = CGRectGetMaxY(cfRunButton.frame) + 20;
    UIButton * cfRunWithModeButton = [self createButtonWithFrame:CGRectMake(margin, beginY, width, height) andTitle:@"CFRunLoopRunInMode()" andSEL:@selector(runWithCFRunLoopRunWithMode)];
    [self.view addSubview:cfRunWithModeButton];
    beginY = CGRectGetMaxY(cfRunWithModeButton.frame) + 20;
    
}
///////////////////////////////////////////////////////////////////////
- (void)onlyRun {
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(testOnlyRun) object:nil];
    [thread start];
}

- (void)testOnlyRun {
    NSTimer * onlyRunTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(runPerformSelectorForOnlyRun) userInfo:nil repeats:YES];
//    [self performSelector:@selector(runPerformSelectorForOnlyRun) withObject:nil afterDelay:1];  //不会执行
//    [onlyRunTimer fire];  //该方法会导致立即执行
//    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(runPerformSelectorForOnlyRun) userInfo:nil repeats:YES];
    [self addObserverToRunLoop];
    NSRunLoop * onlyRunLoop = [NSRunLoop currentRunLoop];
    [onlyRunLoop addTimer:onlyRunTimer forMode:NSDefaultRunLoopMode];
    [onlyRunLoop run];
//    [self performSelector:@selector(runPerformSelectorForOnlyRun) withObject:nil withObject:nil]; //这样可以启动
}

- (void)runPerformSelectorForOnlyRun {
    NSLog(@"%@",[NSThread currentThread]);
    CFRunLoopStop(CFRunLoopGetCurrent());   //增加了这一行
}
///////////////////////////////////////////////////////////////////////
- (void)runWithDate {
    NSThread * dateThread = [[NSThread alloc] initWithTarget:self selector:@selector(testRunWithDate) object:nil];
    [dateThread start];
}

- (void)testRunWithDate {
    NSTimer * runDateTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(runPerformSelectorForRunWithDate) userInfo:nil repeats:YES];
    [self addObserverToRunLoop];
    [[NSRunLoop currentRunLoop] addTimer:runDateTimer forMode:NSDefaultRunLoopMode];
//    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:5]];
//    NSTimer * runDateTimer1 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runPerformSelectorForRunWithDate) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:runDateTimer1 forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:5]];
}

- (void)runPerformSelectorForRunWithDate {
    for (NSInteger i = 0; i < 10000000000; i++) {
        
    }
    NSLog(@"%@",[NSThread currentThread]);
}
///////////////////////////////////////////////////////////////////////
- (void)runWithDateAndMode {
    NSThread * dateThread = [[NSThread alloc] initWithTarget:self selector:@selector(testRunWithDate) object:nil];
    [dateThread start];
}

- (void)testRunWithDateAndMode {
    NSTimer * runDateTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(runPerformSelectorForRunWithDateAndMode) userInfo:nil repeats:YES];
    [self addObserverToRunLoop];
    [[NSRunLoop currentRunLoop] addTimer:runDateTimer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:5]];
}

- (void)runPerformSelectorForRunWithDateAndMode {
//    for (NSInteger i = 0; i < 10000000000; i++) {
//
//    }
    NSLog(@"%@",[NSThread currentThread]);
}

///////////////////////////////////////////////////////////////////////
- (void)dealWithTimerRepeat {
    isContinue = YES;
    NSThread * dateThread = [[NSThread alloc] initWithTarget:self selector:@selector(runToDealWithTimer) object:nil];
    [dateThread start];
}

- (void)runToDealWithTimer {
    [self addObserverToRunLoop];
    [self runToStartRunLoop];
}

- (void)runToStartRunLoop {
    NSTimer * runDateTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(cycleRepeat) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:runDateTimer forMode:NSDefaultRunLoopMode];
    while (isContinue && [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]) {
        NSTimer * runDateTimer1 = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(cycleRepeat) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:runDateTimer1 forMode:NSDefaultRunLoopMode];
    }
}

- (void)cycleRepeat {
    NSLog(@"%@",[NSThread currentThread]);
}

///////////////////////////////////////////////////////////////////////
- (void)runwithCFRunLoopRun {
    isContinue = YES;
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(addTimerToCFRunLoopForRun) object:nil];
    [thread start];
}

- (void)addTimerToCFRunLoopForRun {
    NSTimer * runTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(logForCFRunLoopForFun) userInfo:nil repeats:YES];
    [self addObserverToRunLoop];
    [[NSRunLoop currentRunLoop] addTimer:runTimer forMode:NSDefaultRunLoopMode];
    CFRunLoopRun();
    NSLog(@"addTimerToCFRunLoopForRun");
    CFRunLoopRun();  //第二次启动
}

- (void)logForCFRunLoopForFun {
    NSLog(@"%@",[NSThread currentThread]);
    if (!isContinue) {
        CFRunLoopStop(CFRunLoopGetCurrent());
    }
}
///////////////////////////////////////////////////////////////////////
- (void)runWithCFRunLoopRunWithMode {
    isContinue = YES;
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(addTimerToCFRunLoopRunWithMode) object:nil];
    [thread start];
}

- (void)addTimerToCFRunLoopRunWithMode {
    NSTimer * runTimer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(logForCFRunLoopForFunWithMode) userInfo:nil repeats:NO];
    [self addObserverToRunLoop];
    [[NSRunLoop currentRunLoop] addTimer:runTimer forMode:NSDefaultRunLoopMode];
    CFRunLoopRunResult result = CFRunLoopRunInMode(kCFRunLoopDefaultMode, 3, false);
    switch (result) {
        case kCFRunLoopRunStopped:{
            NSLog(@"stoped");
        }
            break;
        case kCFRunLoopRunFinished:{
            NSLog(@"finished");
        }
            break;
        case kCFRunLoopRunTimedOut:{
            NSLog(@"timeout");
        }
            break;
        case kCFRunLoopRunHandledSource:{
            NSLog(@"handle source");
        }
            break;
        default:
            break;
    }
}

- (void)logForCFRunLoopForFunWithMode {
    NSLog(@"%@",[NSThread currentThread]);
    if (!isContinue) {
        CFRunLoopStop(CFRunLoopGetCurrent());
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    isContinue = NO;
    NSLog(@"%s",__func__);
}

- (void)addObserverToRunLoop {
    CFRunLoopObserverRef observerRef = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:{
                NSLog(@"进入循环...");
            }
                break;
            case kCFRunLoopBeforeTimers:{
                NSLog(@"处理定时器之前。。。");
            }
                break;
            case kCFRunLoopBeforeSources:{
                NSLog(@"处理输入源之前。。。");
            }
                break;
            case kCFRunLoopBeforeWaiting:{
                NSLog(@"进入等待之前。。。");
            }
                break;
            case kCFRunLoopAfterWaiting:{
                NSLog(@"唤醒但是处理事件之前。。。");
            }
                break;
            case kCFRunLoopExit:{
                NSLog(@"runloop退出！");
            }
                break;
            default:
                break;
        }
    });
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observerRef, kCFRunLoopDefaultMode);
    if (observerRef) {
        CFRelease(observerRef);
    }
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

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"release");
}

@end
