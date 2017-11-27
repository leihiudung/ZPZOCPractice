//
//  ViewController.m
//  ZPZBlockPractice
//
//  Created by zhoupengzu on 2017/11/22.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "ZPZIsaTestModel.h"

typedef void(^testBlock)();
typedef void(^testBlock1)(int a);

@interface ViewController ()

@property (nonatomic,strong) testBlock strongBlock;
@property (nonatomic,copy) testBlock copyBlock;
@property (nonatomic,weak) testBlock weakBlock;

@property (nonatomic,strong) testBlock1 strongBlock1;
@property (nonatomic,copy) testBlock1 copyBlock1;
@property (nonatomic,weak) testBlock1 weakBlock1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor orangeColor];
//    [self defineNormalLocalBlock];  //不引用外部变量
//    [self getObjectIsa];
    [self defineBlockWithOutLocalParams];
}

/**
 * 对象的isa
 */
- (void)getObjectIsa {
    ZPZIsaTestModel * model = [[ZPZIsaTestModel alloc] init];
    NSLog(@"%@",object_getClass(model));  //ZPZIsaTestModel
    Class cls = [ZPZIsaTestModel class];
    NSLog(@"%@",object_getClass(cls));  //ZPZIsaTestModel
}
/**
 * 不引用外部变量的时候，其类型为全局的block
 */
- (void)defineNormalLocalBlock {
    void(^localBlock)(void) = ^{
        NSLog(@"localBlock");
    };
    Class cls = object_getClass(localBlock);
    NSLog(@"%@",cls); //__NSGlobalBlock__
    NSLog(@"%@",class_getSuperclass(cls));  //__NSGlobalBlock
    NSLog(@"%@",object_getClass(cls)); //__NSGlobalBlock__ ，这是元类
    
}
/**
 * 引用外部变量的时候，变成了堆上的block
 */
- (void)defineBlockWithOutLocalParams{
    /*__block*/ int a = 10;
    void(^localBlock)(void) = ^{
        NSLog(@"%@",@(a));
    };
    Class cls = object_getClass(localBlock);
    NSLog(@"%@",cls); //__NSMallocBlock__
    NSLog(@"%@",class_getSuperclass(cls)); //__NSMallocBlock
    NSLog(@"%@",object_getClass(cls)); //__NSMallocBlock__
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
