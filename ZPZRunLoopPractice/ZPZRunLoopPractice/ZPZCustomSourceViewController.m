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

@end

@implementation ZPZCustomSourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
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
    ZPZCustomSourceViewController * custom = (__bridge_transfer ZPZCustomSourceViewController *)info;
    [custom performSelectorOnMainThread:@selector(finished) withObject:nil waitUntilDone:NO];
}

void perform(void *info) {
    NSLog(@"perform");
}

- (void)finished {
    NSLog(@"%s",__func__);
}

- (void)testAddSource {
    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(test) object:nil];
    [thread start];
}

- (void)test {
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
    CFRunLoopWakeUp(rl);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


