//
//  ZPZRuntimeKVOViewController.m
//  ZPZKVOPractice
//
//  Created by zhoupengzu on 2017/12/7.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZRuntimeKVOViewController.h"
#import "ZPZPersonModel.h"
#import "ZPZStudentModel.h"
#import <objc/runtime.h>

@interface ZPZRuntimeKVOViewController ()

@property (nonatomic, strong) ZPZPersonModel * personModel;
@property (nonatomic, strong) ZPZPersonModel * secondPersonModel;
@property (nonatomic, strong) ZPZStudentModel * studentModel;

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
//    [self logIsaBeforeKVO];
//    [self logSuperClassOfObject:_personModel];
//    [self logPropertyOfObject:object_getClass(_personModel)];
    [self logMethodOfObject:object_getClass(_personModel)];
//    [_personModel addObserver:self forKeyPath:@"ID" options:NSKeyValueObservingOptionNew context:NULL];
    [_personModel addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:NULL];
//    [_personModel addObserver:self forKeyPath:@"height" options:NSKeyValueObservingOptionInitial context:NULL];
    NSLog(@"=========================add KVO after========================");
//    [self logIsaAfterKVO];
//    [self logSuperClassOfObject:_personModel];
//    [self logPropertyOfObject:object_getClass(_personModel)];
    [self logMethodOfObject:object_getClass(_personModel)];
//    [self updateName];
//    [self logIsaAfterKVO];
    
}

- (void)addPersonModelsKVO {
    _personModel = [[ZPZPersonModel alloc] init];
    _secondPersonModel = [[ZPZPersonModel alloc] init];
    NSLog(@"=========================add KVO before========================");
    //    [self logIsaBeforeKVO];
    //    [self logSuperClassOfObject:_personModel];
    //    [self logPropertyOfObject:object_getClass(_personModel)];
    [self logMethodOfObject:object_getClass(_personModel)];
    //    [_personModel addObserver:self forKeyPath:@"ID" options:NSKeyValueObservingOptionNew context:NULL];
    [_personModel addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:NULL];
    [_secondPersonModel addObserver:self forKeyPath:@"height" options:NSKeyValueObservingOptionInitial context:NULL];
    NSLog(@"=========================add KVO after========================");
    //    [self logIsaAfterKVO];
    //    [self logSuperClassOfObject:_personModel];
    //    [self logPropertyOfObject:object_getClass(_personModel)];
    [self logMethodOfObject:object_getClass(_personModel)];
}

//为了做对比，证明一些什么
- (void)testSomeThing {
    _studentModel = [[ZPZStudentModel alloc] init];
    [self logSuperClassOfObject:_studentModel];
    [self logPropertyOfObject:object_getClass(_studentModel)];
}

- (void)updateName {
    [_personModel willChangeValueForKey:@"ID"];
    _personModel.name = @"zhou";
    [_personModel didChangeValueForKey:@"ID"];
}
//isa
- (void)logIsaBeforeKVO {
    Class objectIsa = object_getClass(_personModel);
    Class classIsa = object_getClass(objectIsa);
    Class metaIsa = object_getClass(classIsa);
    NSLog(@"objectIsa:%@,classIsa:%@,metaIsa:%@",objectIsa, classIsa, metaIsa);
}
- (void)logIsaAfterKVO {
    Class objectIsa = object_getClass(_personModel);
    Class classIsa = object_getClass(objectIsa);
    Class metaIsa = object_getClass(classIsa);
    NSLog(@"objectIsa:%@,classIsa:%@,metaIsa:%@",objectIsa, classIsa, metaIsa);
}
//super class
- (void)logSuperClassOfObject:(id)obj {
    Class objectIsa = object_getClass(obj);
    Class superClass = class_getSuperclass(objectIsa);
    Class selfClass = [ZPZPersonModel class];
    NSLog(@"currentClass:%@,superClass:%@,superPointer:%p,selfPointer:%p",objectIsa,superClass,superClass, selfClass);
}
//property
- (void)logPropertyOfObject:(Class)cls {
    unsigned int count = 0;
    objc_property_t * property_list = class_copyPropertyList(cls, &count);
    for (unsigned int i = 0; i < count; i++) {
        objc_property_t property = property_list[i];
        const char * proper_name = property_getName(property);
        NSString * properName = [NSString stringWithCString:proper_name encoding:NSUTF8StringEncoding];
        NSLog(@"%@",properName);
    }
}
//method
- (void)logMethodOfObject:(Class)cls {
    unsigned int count = 0;
    Method * method_list = class_copyMethodList(cls, &count);
    for (unsigned int i = 0; i < count; i++) {
        Method method = method_list[i];
        SEL method_name = method_getName(method);
        NSString * methodName = NSStringFromSelector(method_name);
        NSLog(@"%@",methodName);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@----%@",keyPath,change);
}

@end
