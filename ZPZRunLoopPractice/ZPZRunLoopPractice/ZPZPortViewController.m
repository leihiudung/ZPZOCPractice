//
//  ZPZPortViewController.m
//  ZPZRunLoopPractice
//
//  Created by zhoupengzu on 2017/12/27.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZPortViewController.h"
#import "ZPZWorkerClass.h"

@interface ZPZPortViewController ()<NSPortDelegate, NSMachPortDelegate>
{
    NSPort * mainPort;
}

@end

@implementation ZPZPortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self prepareData];
    [self sendMessage];
}

- (void)prepareData {
    mainPort = [NSMachPort port];
    mainPort.delegate = self;
    [[NSRunLoop currentRunLoop] addPort:mainPort forMode:NSDefaultRunLoopMode];
}

- (void)sendMessage {
    [NSThread detachNewThreadSelector:@selector(launchThreadWithPort:) toTarget:[ZPZWorkerClass class] withObject:mainPort];
}

- (void)handlePortMessage:(NSPortMessage *)message {
    NSLog(@"portVC_thread:%@", [NSThread currentThread]);
    NSLog(@"portVC:%@", message);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"release");
}

@end
