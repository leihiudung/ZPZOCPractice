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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor orangeColor];
//    [self defineNormalLocalBlock];
    [self getObjectIsa];
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

- (void)defineNormalLocalBlock {
    void(^localBlock)(void) = ^{
        NSLog(@"localBlock");
    };
    NSLog(@"%@",object_getClass(localBlock));
    Class cls = object_getClass(localBlock);
    NSLog(@"%@",class_getSuperclass(cls));
    NSLog(@"%@",object_getClass(cls));
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
