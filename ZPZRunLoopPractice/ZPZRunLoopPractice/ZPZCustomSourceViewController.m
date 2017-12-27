//
//  ZPZCustomResouceViewController.m
//  ZPZRunLoopPractice
//
//  Created by zhoupengzu on 2017/12/26.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZCustomSourceViewController.h"
#import "AppDelegate.h"

@interface ZPZCustomSourceViewController ()
{
    NSThread * thread;
}

@end

@implementation ZPZCustomSourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(prepareToAdd)];
    [self testAddSource];
}
/*
typedef struct {
    CFIndex    version;
    void *    info;
    const void *(*retain)(const void *info);
    void    (*release)(const void *info);
    CFStringRef    (*copyDescription)(const void *info);
    Boolean    (*equal)(const void *info1, const void *info2);
    CFHashCode    (*hash)(const void *info);
    void    (*schedule)(void *info, CFRunLoopRef rl, CFRunLoopMode mode);
    void    (*cancel)(void *info, CFRunLoopRef rl, CFRunLoopMode mode);
    void    (*perform)(void *info);
} CFRunLoopSourceContext;
*/

CFStringRef copyDescription(const void * info) {
    return CFSTR("This is personal description!");
}

Boolean equal(const void *info1, const void *info2) {
    return (info1 == info2);
}

void schedule(void *info, CFRunLoopRef rl, CFRunLoopMode mode) {
    NSLog(@"schedule");
}

void cancel(void *info, CFRunLoopRef rl, CFRunLoopMode mode) {
    NSLog(@"cancel");
}

void perform(void *info) {
    NSLog(@"perform");
}

- (void)testAddSource {
    thread = [[NSThread alloc] initWithTarget:self selector:@selector(test) object:nil];
    [thread start];
}

- (void)test {
    [self addObserverToRunLoop];
    CFRunLoopSourceContext context = {0, (__bridge void *)self, NULL, NULL,
        &copyDescription,
        &equal,
        NULL,
        &schedule,
        &cancel,
        &perform
    };
    CFRunLoopSourceRef sourceRef = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
    CFRunLoopRef rl = CFRunLoopGetCurrent();
    Boolean isValid = CFRunLoopSourceIsValid(sourceRef);
    if (isValid) {
        NSLog(@"is valid");
    } else {
        NSLog(@"is not valid");
    }
    CFRunLoopAddSource(rl, sourceRef, kCFRunLoopDefaultMode);  //调用context的schedule回调函数
    
    CFRunLoopSourceSignal(sourceRef);
//    CFRunLoopWakeUp(rl);
//    CFRunLoopRun();  //运行很多次
//    CFRunLoopRunInMode(kCFRunLoopDefaultMode, kCFAbsoluteTimeIntervalSince1904, false); //在时间范围内运行很多次
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]; //这句话必须要有，只运行一次就退出runloop
    if (sourceRef) {
        CFRelease(sourceRef);
    }
    NSLog(@"runloop finished");
}

- (void)prepareToAdd {
    [self performSelector:@selector(addSourceToThread) onThread:thread withObject:nil waitUntilDone:NO];
}

- (void)addSourceToThread {
    NSTimer * runTimer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(logForCFRunLoopForFunWithMode) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:runTimer forMode:NSDefaultRunLoopMode];
//    [self performSelector:@selector(logForCFRunLoopForFunWithMode) withObject:nil];
//    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
}

- (void)logForCFRunLoopForFunWithMode{
    NSLog(@"%s",__func__);
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"release");
}

@end


