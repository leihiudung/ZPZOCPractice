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

int globalVar = 20;
static NSString * globalStatic = @"全局静态对象";

@interface ViewController ()

@property (nonatomic,assign) NSInteger count;
@property (nonatomic,copy) NSString * str;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    [self defineNormalLocalBlock];
//    objc_getClass(<#const char * _Nonnull name#>)
//    object_getClass(<#id  _Nullable obj#>)
//    [self sendMessage];
//    [self defineNormalLocalWithLocalParamsBlock];
//    [self defineNormalLocalWithHasParamsBlock];
    [self defineNormalLocalVarLife];
}

- (void)sendMessage{
    ZPZObjcMsgSend * send = [[ZPZObjcMsgSend alloc] init];
    [send sendMessage];
}
/**
 * 下面的函数clang后看文件defineNormalLocalBlock解析
 */

- (void)defineNormalLocalBlock {
    void(^testBlock)(void) = ^{
        NSLog(@"defineNormalLocalBlock");
    };
    testBlock();
}
/**
 * 捕获局部外界值
 */
- (void)defineNormalLocalWithLocalParamsBlock{
//    NSInteger a = 10;
    NSString * a = @"";
    void(^testBlock)(void) = ^{
//        NSLog(@"defineNormalLocalBlock:%ld",a);
        NSLog(@"defineNormalLocalBlock:%@",a);
    };
    testBlock();
}

/**
 * 带参数的
 */
- (void)defineNormalLocalWithHasParamsBlock{
    void(^testBlock)(NSInteger i) = ^(NSInteger i){
        NSLog(@"defineNormalLocalBlock:%ld",i);
    };
    testBlock(10);
}
/**
 * 属性
 */
- (void)defineNormalLocalWithGlobalParamsBlock{
    void(^testBlock)(void) = ^{
        NSLog(@"defineNormalLocalBlock:%ld",_count);
    };
    testBlock();
}
/**
 * 全局变量
 * 全局变量和全局静态变量生命周期和程序是一样的，但是作用域不同
 */
- (void)defineNormalLocalWithAllGlobalParamsBlock{
    void(^testBlock)(void) = ^{
        NSLog(@"defineNormalLocalBlock:%d,%@",globalVar,globalStatic);
    };
    testBlock();
}

/**
 * 局部静态变量
 * 表现和局部变量一样，因为局部静态变量的作用域和局部变量的作用域相同
 * 但是这里传递的是变量的地址，所以结果和普通局部变量不一样
 * 作用域和生命周期不一样，静态局部变量的生命周期是程序运行期
 */
- (void)defineNormaLocalWithStaticBlock{
    static NSString * flag = @"";
    void(^testBlock)(void) = ^{
        NSLog(@"defineNormalLocalBlock:%@",flag);
    };
    testBlock();
}

/**
 * 因为a的作用域离开该函数就会释放，所以这里p很容易形成野指针，导致出现不可预见的错误
 - (void)test
 {
     int a = 0;
     // 利用指针p存储a的地址
     int *p = &a;
 
     ^{
     // 通过a的地址设置a的值
     *p = 10;
     };
 }
 */
- (void)defineNormalLocalVarLife{
    int a = 10;
    int *p = &a;
    void(^testBlock)(void) = ^{
        *p = 20;
    };
    NSLog(@"%@",@(a));
    testBlock();
}

- (void)defineBlockWithBlock{
    __block NSInteger a = 20;
    void(^testBlock)(void) = ^{
        NSLog(@"%@",@(a));
    };
    testBlock();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
