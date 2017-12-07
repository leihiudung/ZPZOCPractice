//
//  ZPZRuntimeKVOViewController.m
//  ZPZKVOPractice
//
//  Created by zhoupengzu on 2017/12/7.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZRuntimeKVOViewController.h"
#import "ZPZPersonModel.h"
#import <objc/runtime.h>

@interface ZPZRuntimeKVOViewController ()

@property (nonatomic, strong) ZPZPersonModel * personModel;

@end

@implementation ZPZRuntimeKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addPersonModelKVO];
}

- (void)addPersonModelKVO {
    _personModel = [[ZPZPersonModel alloc] init];
    NSLog(@"=========================add KVO before========================");
    [self logIsaBeforeKVO];
    [_personModel addObserver:self forKeyPath:@"ID" options:NSKeyValueObservingOptionNew context:NULL];
    [_personModel addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:NULL];
    NSLog(@"=========================add KVO after========================");
    [self logIsaAfterKVO];
    [self updateName];
    [self logIsaAfterKVO];
}

- (void)updateName {
    [_personModel willChangeValueForKey:@"ID"];
    _personModel.name = @"zhou";
    [_personModel didChangeValueForKey:@"ID"];
}

- (void)logIsaBeforeKVO {
    Class objectIsa = object_getClass(_personModel);
    Class classIsa = object_getClass(objectIsa);
    Class tempClassIsa = [ZPZPersonModel class];
    NSLog(@"%p----%p",objectIsa,tempClassIsa);  //这两个是同一个地址
    Class metaIsa = object_getClass(classIsa);
    NSLog(@"%@",classIsa);
//    Class superClass = class_getSuperclass(objectIsa);
    
}
- (void)logIsaAfterKVO {
    Class objectIsa = object_getClass(_personModel);
    Class classIsa = object_getClass(objectIsa);
    Class tempClassIsa = [ZPZPersonModel class];
    NSLog(@"%p----%p",objectIsa,tempClassIsa);
    Class metaIsa = object_getClass(classIsa);
    NSLog(@"%@",classIsa);
    //    Class superClass = class_getSuperclass(objectIsa);
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@----%@",keyPath,change);
}

@end
