//
//  ZPZObserveInfoViewController.m
//  ZPZKVOPractice
//
//  Created by zhoupengzu on 2017/12/7.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZObserveInfoViewController.h"
#import "ZPZPersonModel.h"
#import <objc/runtime.h>

@interface ZPZObserveInfoViewController ()

@property (nonatomic, strong) ZPZPersonModel * personModel;
@property (nonatomic, strong) id obserInfo;

@end

@implementation ZPZObserveInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addKVOToPersonModelAndLogIt];
}

- (void)addKVOToPersonModelAndLogIt {
    _personModel = [[ZPZPersonModel alloc] init];
    [_personModel addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:NULL];
    [_personModel addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionOld context:NULL];
    [_personModel addObserver:self forKeyPath:@"ID" options:NSKeyValueObservingOptionInitial context:NULL];
    [_personModel addObserver:self forKeyPath:@"height" options:NSKeyValueObservingOptionPrior context:NULL];
    
    _obserInfo= _personModel.observationInfo;
    NSLog(@"%@---%@---%p",_obserInfo,[_obserInfo class],self);
    [self logObjectProperty];
    [self logObjectVar];
    [self logObjectMethod];
}

- (void)logObjectProperty {
    unsigned int outCount = 0;
    objc_property_t * propertyList = class_copyPropertyList([_obserInfo class], &outCount);
    printf("property count: %d\n", outCount);
    for (NSInteger i = 0; i < outCount; i++) {
        objc_property_t property = propertyList[i];
        const char * propertyName = property_getName(property);
        const char * propertyAttr = property_getAttributes(property);
        NSString * propertyNameStr = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSString * propertyAttrStr = [NSString stringWithCString:propertyAttr encoding:NSUTF8StringEncoding];
        NSLog(@"%@-----%@",propertyNameStr,propertyAttrStr);
    }
}

- (void)logObjectVar {
    unsigned int outCount = 0;
    Ivar * ivarList = class_copyIvarList([_obserInfo class], &outCount);
    printf("Ivar count: %d\n", outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivarList[i];
        const char * ivar_name = ivar_getName(ivar);
        const char * ivar_type = ivar_getTypeEncoding(ivar);
        NSString * ivarName = [NSString stringWithCString:ivar_name encoding:NSUTF8StringEncoding];
        NSString * ivarType = [NSString stringWithCString:ivar_type encoding:NSUTF8StringEncoding];
        
        if ([ivarType isEqualToString:@"@\"NSArray\""]) {
            NSArray * value = object_getIvar(_obserInfo, ivar);
            NSLog(@"%@-----%@---%@",ivarName,ivarType,value);
        } else {
            NSLog(@"%@-----%@",ivarName,ivarType);
        }
        
    }
    
}

- (void)logObjectMethod {
    unsigned int outCount = 0;
    Method * methodList = class_copyMethodList([_obserInfo class], &outCount);
    printf("Method count: %d\n", outCount);
    for (int i = 0; i < outCount; i++) {
        Method method = methodList[i];
        SEL sel = method_getName(method);
        NSString * methodName = NSStringFromSelector(sel);
        NSLog(@"MethodName:%@",methodName);
        char return_type[512] = {};
        method_getReturnType(method, return_type, sizeof(method));
        unsigned int argument_count = method_getNumberOfArguments(method);
        for (int j = 0; j < argument_count; j++) {
            char argument[512] = {};
            method_getArgumentType(method, j, argument, sizeof(argument));
            NSString * argumentStr = [NSString stringWithCString:argument encoding:NSUTF8StringEncoding];
            NSLog(@"argument:%@",argumentStr);
        }
        
        NSString * returnType = [NSString stringWithCString:return_type encoding:NSUTF8StringEncoding];
        NSLog(@"returnType:%@",returnType);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
