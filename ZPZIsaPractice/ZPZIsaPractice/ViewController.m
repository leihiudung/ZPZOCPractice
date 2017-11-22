//
//  ViewController.m
//  ZPZIsaPractice
//
//  Created by zhoupengzu on 2017/11/22.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ViewController.h"
#import "ZPZStudentModel.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    [self logIsaPointer];
    [self logIsaInstancePointer];
}
/**
 * 查看isa的指向
 */
- (void)logIsaPointer {
    Class cls = [ZPZStudentModel class];
    while (1) {
        cls = object_getClass(cls);
        NSLog(@"%@",cls);
        if (class_isMetaClass(cls)) {
            NSLog(@"meta class");
            break;
        }
    }
    //只打印了
    //ZPZStudentModel和meta class
}
/**
 * 对于对象变量，其isa指向其类，因为下面有两个地址是一样的
 * 类的isa又指向其自己的meta-class，基类的meta-class的isa指向root(这里是NSObject)的meta-class
 */
- (void)logIsaInstancePointer {
    ZPZStudentModel * stu = [[ZPZStudentModel alloc] init];
    Class cls = object_getClass(stu);
    NSLog(@"stu:%p",stu); //stu:0x60c00001cf60
    NSLog(@"1-cls:%p",cls); //1-cls:0x106259178
    NSLog(@"[ZPZStudentModel class]:%p",[ZPZStudentModel class]);  //[ZPZStudentModel class]:0x106259178
    NSLog(@"object_getClass(stu):%@",cls); // object_getClass(stu):ZPZStudentModel
    //下面的循环只会走一次
    while (1) {
        cls = object_getClass(cls);
        NSLog(@"2-cls:%p",cls);  //2-cls:0x106259150
        NSLog(@"2-cls:%@",cls);  //2-cls:ZPZStudentModel
        if (class_isMetaClass(cls)) {
            NSLog(@"meta class");
            break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
