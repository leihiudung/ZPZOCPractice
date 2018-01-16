//
//  ZPZWorkerClass.m
//  ZPZRunLoopPractice
//
//  Created by zhoupengzu on 2017/12/27.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZWorkerClass.h"
@interface ZPZWorkerClass()<NSPortDelegate>
@property(nonatomic, strong) NSPort * remotePort;
@property(nonatomic, strong) NSPort * selfPort;
@end

@implementation ZPZWorkerClass

+ (void)launchThreadWithPort:(NSPort *)port {
    ZPZWorkerClass * worker = [[self alloc] init];
    [worker addObserverToRunLoop];
    worker.remotePort = port;
    [worker sendPortMessage];
    do {
        BOOL result = [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]; //为了保活
        if (result) {
            NSLog(@"processed");
        } else {
            NSLog(@"processed failed");
        }
    } while (!worker.shouldExit);
}

- (void)sendPortMessage {
    NSMutableArray * array = [NSMutableArray array];
    [array addObject:@"pengzu"];
    [array addObject:@"zhou"];
    _selfPort = [NSMachPort port];
    _selfPort.delegate = self;
    [[NSRunLoop currentRunLoop] addPort:_selfPort forMode:NSDefaultRunLoopMode];
    [_remotePort sendBeforeDate:[NSDate date] components:array from:_selfPort reserved:0];

    //    remotePort sendBeforeDate:<#(nonnull NSDate *)#> msgid:<#(NSUInteger)#> components:<#(nullable NSMutableArray *)#> from:<#(nullable NSPort *)#> reserved:<#(NSUInteger)#>
}

- (void)handlePortMessage:(NSPortMessage *)message {
    NSLog(@"worker:%@",message);
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

- (void)dealloc {
    NSLog(@"worker release");
}

@end
