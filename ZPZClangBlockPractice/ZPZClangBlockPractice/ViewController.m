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
/**
 * 下面的函数会转成这里的样子,由此可以看出，定义的block名是个函数指针，具体的调用为:
 * __ViewController__defineNormalLocalBlock_block_impl_0，在这里
 * void(*testBlock)(void) = ((void (*)())&__ViewController__defineNormalLocalBlock_block_impl_0((void *)__ViewController__defineNormalLocalBlock_block_func_0, &__ViewController__defineNormalLocalBlock_block_desc_0_DATA));
   ((void (*)(__block_impl *))((__block_impl *)testBlock)->FuncPtr)((__block_impl *)testBlock);
 */

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
