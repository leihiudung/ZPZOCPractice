//
//  ZPZReceiveMessage.m
//  ZPZMessageSendPractice
//
//  Created by zhoupengzu on 2017/11/29.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZReceiveMessage.h"
#import <objc/runtime.h>

/**
 * IMP是函数指针
 */

@implementation ZPZReceiveMessage

//int resolveInstanceAddMethod(id obj,SEL sel, NSString * haha, int age, char * num){
//    NSLog(@"name:%@,age:%@",haha,@(age));
//    return 2;
//}
/**
 * 这里方法的参数最好和需要替换的相同（位置和类型），不然容易发生不可知的错误
 */
int resolveInstanceAddMethod(id obj,SEL sel, NSString * haha, int age){
    NSLog(@"name:%@,age:%@",haha,@(age));
    return 2;
}
/**
 * class_addMethod(<#Class  _Nullable __unsafe_unretained cls#>, <#SEL  _Nonnull name#>, <#IMP  _Nonnull imp#>, <#const char * _Nullable types#>)
 * imp是一个函数指针
 * types:返回值类型和形参类型数组，第一个是返回值类型,地址：https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100
 * types可以不传
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(testResolveInstanceMthod:age:)) {
        //方式一：
        Method method = class_getInstanceMethod([self class], @selector(resolveInstanceMethodWithOC:age:));
        IMP imp = method_getImplementation(method);
        //方式二：
//        IMP imp = class_getMethodImplementation([self class], @selector(resolveInstanceMethodWithOC:age:));
        //方式一：
//        return class_addMethod([self class], sel, (IMP)resolveInstanceAddMethod, nil);
        //方式二：
        return class_addMethod([self class], sel, imp, nil);
    }
    return [super resolveInstanceMethod:sel];
}

- (int)resolveInstanceMethodWithOC:(NSString *)name age:(NSInteger)age{
    NSLog(@"name:%@,age:%@",name,@(age));
    return 10;
}

@end
