//
//  ZPZRunLoopSource.m
//  ZPZRunLoopPractice
//
//  Created by zhoupengzu on 2017/12/27.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZRunLoopSource.h"
#import "AppDelegate.h"
#import "ZPZRunLoopContext.h"
//该方法在调用CFRunLoopAddSource时触发
void RunLoopSourceScheduleRoutine(void * info,CFRunLoopRef rl,CFStringRef mode) {
    ZPZRunLoopSource * source = (__bridge_transfer ZPZRunLoopSource *)info;
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    ZPZRunLoopContext * context = [[ZPZRunLoopContext alloc] initWithSource:source andLoop:rl];
    [delegate performSelectorOnMainThread:@selector(registerSource:) withObject:context waitUntilDone:YES];
}
//事件源触发后调用
void RunLoopSourcePerformRoutine(void * info) {
    ZPZRunLoopSource * source = (__bridge_transfer ZPZRunLoopSource *)info;
    [source sourceFired];
}
//当source从runloop的当前mode移除的时候调用
void RunLoopSourceCancelroutine(void * info, CFRunLoopRef rl, CFStringRef mode) {
    ZPZRunLoopSource * source = (__bridge_transfer ZPZRunLoopSource *)info;
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    ZPZRunLoopContext * context = [[ZPZRunLoopContext alloc] initWithSource:source andLoop:rl];
    [delegate performSelectorOnMainThread:@selector(removeSource:) withObject:context waitUntilDone:YES];
}

@interface ZPZRunLoopSource ()

@property (nonatomic, assign) CFRunLoopSourceRef runLoopSource;

@end

@implementation ZPZRunLoopSource

- (instancetype)init {
    self = [super init];
    if (self) {
        CFRunLoopSourceContext context = {
            0,
            (__bridge void *)self,
            NULL, NULL, NULL, NULL, NULL,
            &RunLoopSourceScheduleRoutine,
            &RunLoopSourceCancelroutine,
            &RunLoopSourcePerformRoutine,
        };
        _runLoopSource = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
    }
    return self;
}

- (void)addToCurrentRunLoop {
    CFRunLoopAddSource(CFRunLoopGetCurrent(), _runLoopSource, kCFRunLoopDefaultMode);
}

- (void)sourceFired {
    NSLog(@"%s",__func__);
}

- (void)fireCommandsOnRunLoop:(CFRunLoopRef)runloop {
    CFRunLoopSourceSignal(_runLoopSource);
    CFRunLoopWakeUp(runloop);
}

- (void)invalidate {
    CFRunLoopRemoveSource(CFRunLoopGetCurrent(), _runLoopSource, kCFRunLoopDefaultMode);
}

@end
