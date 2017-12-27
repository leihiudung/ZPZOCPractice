//
//  ZPZTimerViewController.m
//  ZPZRunLoopPractice
//
//  Created by zhoupengzu on 2017/12/27.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZTimerViewController.h"

int i = 1;

void RunLoopTimerCallBack(CFRunLoopTimerRef timer, void *info) {
    NSLog(@"timer call back");
    if (i == 1) {
        CFRunLoopTimerSetNextFireDate(timer, CFAbsoluteTimeGetCurrent() + 5);  //该方法可以修改下次执行时间，但不会影响设置的重复执行时间
        i = i + 1;
    }
//    CFRunLoopStop(CFRunLoopGetCurrent());  //该方法可以终结重复
}

@interface ZPZTimerViewController ()
{
    CFRunLoopTimerRef mutipleTimer;
}

@end

@implementation ZPZTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"timer";
    [self configUI];
}

- (void)configUI {
    CGFloat margin = 15;
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 2 * margin;
    CGFloat height = 50;
    CGFloat beginY = 20;
    
    UIButton * timerContextButton = [self createButtonWithFrame:CGRectMake(margin, beginY, width, height) andTitle:@"context创建" andSEL:@selector(initThreadForContext)];
    [self.view addSubview:timerContextButton];
    beginY = CGRectGetMaxY(timerContextButton.frame) + 20;
    
    UIButton * timerHandleButton = [self createButtonWithFrame:CGRectMake(margin, beginY, width, height) andTitle:@"handle创建" andSEL:@selector(initThreadForHandle)];
    [self.view addSubview:timerHandleButton];
    beginY = CGRectGetMaxY(timerHandleButton.frame) + 20;
    
    UIButton * timerBetweenLoopsButton = [self createButtonWithFrame:CGRectMake(margin, beginY, width, height) andTitle:@"不同RunLoop使用" andSEL:@selector(initThreadForLoop1_2)];
    [self.view addSubview:timerBetweenLoopsButton];
    beginY = CGRectGetMaxY(timerBetweenLoopsButton.frame) + 20;
    
}

/**
 typedef struct {
 CFIndex    version;
 void *    info;
 const void *(*retain)(const void *info);
 void    (*release)(const void *info);
 CFStringRef    (*copyDescription)(const void *info);
 } CFRunLoopTimerContext;
 */
- (void)initThreadForContext {
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(createTimerWithContext) object:nil];
    [thread start];
}

- (void)createTimerWithContext {
    NSLog(@"%@",[NSThread currentThread]);
//    [NSTimer scheduledTimerWithTimeInterval:<#(NSTimeInterval)#> invocation:<#(nonnull NSInvocation *)#> repeats:<#(BOOL)#>]
    [self addObserverToRunLoop];
    CFRunLoopTimerRef timer = CFRunLoopTimerCreate(kCFAllocatorDefault, CFAbsoluteTimeGetCurrent(), 2, 0, 0, &RunLoopTimerCallBack, NULL);
    CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, kCFRunLoopDefaultMode);
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    CFRelease(timer);
}

- (void)initThreadForHandle {
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(createTimerWithHandle) object:nil];
    [thread start];
}

- (void)createTimerWithHandle {
    CFRunLoopTimerRef timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, CFAbsoluteTimeGetCurrent(), 2, 0, 0, ^(CFRunLoopTimerRef blockTimer) {
        NSLog(@"timer call back");
        if (i == 1) {
            CFRunLoopTimerSetNextFireDate(blockTimer, CFAbsoluteTimeGetCurrent() + 5);
            i++;
        }
    });
    CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, kCFRunLoopDefaultMode);
    CFRunLoopRun();
    CFRelease(timer);
}

- (void)createTimerForMutableRunLoops {
    mutipleTimer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, CFAbsoluteTimeGetCurrent(), 2, 0, 0, ^(CFRunLoopTimerRef blockTimer) {
        NSLog(@"timer call back:%@", [NSThread currentThread]);
    });
}

- (void)initThreadForLoop1_2 {
    [self createTimerForMutableRunLoops];
    NSThread * thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(addSameTimerToRunLoop1) object:nil];
    [thread1 start];
    NSThread * thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(addSameTimerToRunLoop2) object:nil];
    [thread2 start];
}

- (void)addSameTimerToRunLoop1 {
    CFRunLoopAddTimer(CFRunLoopGetCurrent(), mutipleTimer, kCFRunLoopDefaultMode);
    CFRunLoopRun();
    CFRelease(mutipleTimer);
}

- (void)addSameTimerToRunLoop2 {
    CFRunLoopAddTimer(CFRunLoopGetCurrent(), mutipleTimer, kCFRunLoopDefaultMode);
    CFRunLoopRun();
}

- (void)addObserverToRunLoop {
    CFRunLoopObserverRef observerRef = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:{
                NSLog(@"准备进入循环...");
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
    NSLog(@"release");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
