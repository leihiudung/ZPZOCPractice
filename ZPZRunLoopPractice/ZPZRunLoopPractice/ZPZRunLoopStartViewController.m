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
    NSRunLoop * onlyRunLoop;
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
    UIButton * dealRepeatButton = [self createButtonWithFrame:CGRectMake(margin, beginY, width, height) andTitle:@"" andSEL:@selector(dealWithTimerRepeat)];
    [self.view addSubview:dealRepeatButton];
    beginY = CGRectGetMaxY(dealRepeatButton.frame) + 20;
    
}
///////////////////////////////////////////////////////////////////////
- (void)onlyRun {
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(testOnlyRun) object:nil];
    [thread start];
}

- (void)testOnlyRun {
    NSTimer * onlyRunTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(runPerformSelectorForOnlyRun) userInfo:nil repeats:YES];
    [self addObserverToRunLoop];
    onlyRunLoop = [NSRunLoop currentRunLoop];
    [onlyRunLoop addTimer:onlyRunTimer forMode:NSDefaultRunLoopMode];
    [onlyRunLoop run];
}

- (void)runPerformSelectorForOnlyRun {
    NSLog(@"%@",[NSThread currentThread]);
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
