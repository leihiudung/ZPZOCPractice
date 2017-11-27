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

typedef void(^testBlock)(void);
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
    [self addButton];
//    [self defineNormalLocalBlock];  //不引用外部变量
//    [self getObjectIsa];
//    [self defineBlockWithOutLocalParams];
//    [self defineGlobalNormalBlock];
    [self defineGlobalNormalBlockWithLocalParams];
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

- (void)defineGlobalNormalBlock{
    _strongBlock = ^{
        NSLog(@"strong block");
    };
    _copyBlock = ^{
        NSLog(@"copy block");
    };
    _weakBlock = ^{
        NSLog(@"weak block");
    };
    //strong_block:__NSGlobalBlock__,copy_block:__NSGlobalBlock__,weak_block:__NSGlobalBlock__
    NSLog(@"strong_block:%@,copy_block:%@,weak_block:%@",object_getClass(_strongBlock),object_getClass(_copyBlock),object_getClass(_weakBlock));
    _strongBlock1 = ^(int a){
        NSLog(@"strong block1");
    };
    _copyBlock1 = ^(int a){
        NSLog(@"copy block1");
    };
    _weakBlock1 = ^(int a){
        NSLog(@"weak block1");
    };
    //strong_block1:__NSGlobalBlock__,copy_block1:__NSGlobalBlock__,weak_block1:__NSGlobalBlock__
    NSLog(@"strong_block1:%@,copy_block1:%@,weak_block1:%@",object_getClass(_strongBlock1),object_getClass(_copyBlock1),object_getClass(_weakBlock1));
}

- (void)defineGlobalNormalBlockWithLocalParams{
    /*__block*/ int k = 10;
    _strongBlock = ^{
        NSLog(@"strong block:%d",k);
    };
    _copyBlock = ^{
        NSLog(@"copy block:%d",k);
    };
    _weakBlock = ^{
        NSLog(@"weak block:%d",k);
    };
    //strong_block:__NSMallocBlock__,copy_block:__NSMallocBlock__,weak_block:__NSStackBlock__
    NSLog(@"strong_block:%@,copy_block:%@,weak_block:%@",object_getClass(_strongBlock),object_getClass(_copyBlock),object_getClass(_weakBlock));
    NSLog(@"%p",&_weakBlock);
    _strongBlock1 = ^(int a){
        NSLog(@"strong block1:%d",k);
    };
    _copyBlock1 = ^(int a){
        NSLog(@"copy block1:%d",k);
    };
    _weakBlock1 = ^(int a){
        NSLog(@"weak block1:%d",k);
    };
    //strong_block1:__NSMallocBlock__,copy_block1:__NSMallocBlock__,weak_block1:__NSStackBlock__
    NSLog(@"strong_block1:%@,copy_block1:%@,weak_block1:%@",object_getClass(_strongBlock1),object_getClass(_copyBlock1),object_getClass(_weakBlock1));
}

- (void)addButton{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor greenColor];
    btn.frame = CGRectMake(0, 0, self.view.frame.size.width, 50);
    [btn addTarget:self action:@selector(clickedToTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)clickedToTest{
    if (_weakBlock) {
        _weakBlock();
    }
    if (_weakBlock1) {
        _weakBlock1(10);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
