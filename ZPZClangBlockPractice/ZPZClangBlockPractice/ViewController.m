//
//  ViewController.m
//  ZPZClangBlockPractice
//
//  Created by zhoupengzu on 2017/11/28.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "ZPZObjcMsgSend.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self defineNormalLocalBlock];
//    objc_getClass(<#const char * _Nonnull name#>)
//    object_getClass(<#id  _Nullable obj#>)
    [self sendMessage];
}

- (void)sendMessage{
    ZPZObjcMsgSend * send = [[ZPZObjcMsgSend alloc] init];
    [send sendMessage];
}

- (void)defineNormalLocalBlock {
    void(^testBlock)(void) = ^{
        NSLog(@"defineNormalLocalBlock");
    };
    testBlock();
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
