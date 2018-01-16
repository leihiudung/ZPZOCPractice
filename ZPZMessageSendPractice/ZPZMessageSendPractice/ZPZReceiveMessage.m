//
//  ZPZReceiveMessage.m
//  ZPZMessageSendPractice
//
//  Created by zhoupengzu on 2017/11/29.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZReceiveMessage.h"
#import <objc/runtime.h>
#import "ZPZPickMissMessage.h"

@interface ZPZReceiveMessage()
{
    ZPZPickMissMessage * pick;
}
@end

/**
 * IMP是函数指针
 */

@implementation ZPZReceiveMessage

- (instancetype)init{
    self = [super init];
    if (self) {
        pick = [[ZPZPickMissMessage alloc] init];
    }
    return self;
}

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
//        Method method = class_getInstanceMethod([ZPZReceiveMessage class], @selector(resolveInstanceMethodWithOC:age:));
//        IMP imp = method_getImplementation(method);
        //方式二：
//        IMP imp = class_getMethodImplementation([ZPZReceiveMessage class], @selector(resolveInstanceMethodWithOC:age:));
        //方式三：
//        IMP imp = class_getMethodImplementation([ZPZPickMissMessage class], @selector(resolveInstanceMethodWithOC:age:));
        //方式四：
        IMP imp = (IMP)resolveInstanceAddMethod;
        //方式二：
        return class_addMethod([self class], sel, imp, nil);
    }
    return [super resolveInstanceMethod:sel];
}

- (int)resolveInstanceMethodWithOC:(NSString *)name age:(NSInteger)age{
    NSLog(@"name:%@,age:%@",name,@(age));
    return 10;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * 接盘侠
 */
- (id)forwardingTargetForSelector:(SEL)aSelector{
    if (aSelector == @selector(testFindOtherReceiver)) {
        //也可以先检测替换的对象是否实现了该方法
        ZPZPickMissMessage * msg = [[ZPZPickMissMessage alloc] init];
        if ([msg respondsToSelector:aSelector]) {
            return msg;
        }
    }
    return [super forwardingTargetForSelector:aSelector];
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * 消息重定向，不能返回自己
 * 这里有个问题，为什么还需要methodSignatureForSelector？
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature * signature = [super methodSignatureForSelector:aSelector];
//    if (!signature && [pick respondsToSelector:aSelector]) {
//        signature = [pick methodSignatureForSelector:aSelector];
//    }
    //配合下面的做手脚二：
    if (!signature && [pick respondsToSelector:@selector(msgInvocationWithMessage:andScore:)]) {
        signature = [pick methodSignatureForSelector:@selector(msgInvocationWithMessage:andScore:)];
    }
    return signature;
}
/**
 * 如果没有对anInvocation做处理，则其中的target、selector、arguments等都是调用时候的
 */
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    //正常使用
//    [anInvocation invokeWithTarget:pick];
//    [anInvocation invoke];  //这样有问题
//    [anInvocation invokeWithTarget:[anInvocation target]];  //下面的是有问题的，因为[anInvocation target]是ZPZReceiveMessage对象
    
    NSMethodSignature * signature = anInvocation.methodSignature;
    NSInteger argumentsCount = [signature numberOfArguments];  //获取参数个数，这里有三个，因为前两个是self和SEL，第三个才是传递的参数
    for (NSInteger i = 0; i < argumentsCount; i++) {
        const char * type = [signature getArgumentTypeAtIndex:i];
        printf("%s\n",type);
    }
    //因为这里我们知道参数的类型，否则可以通过上面就可以看出参数类型
    //做手脚一：修改参数
//    NSString * changeWord = @"哈！I changed you!";
//    [anInvocation setArgument:&changeWord atIndex:(argumentsCount - 1)];
//    [anInvocation invokeWithTarget:pick];
    
    //做手脚二：添加传递参数，参数由原来的一个变成两个
    if (argumentsCount > 2) {
        anInvocation.selector = @selector(msgInvocationWithMessage:andScore:);
        NSString * changeWord = @"哈！I changed you!";
        [anInvocation setArgument:&changeWord atIndex:(argumentsCount - 2)];
        NSInteger score = 100;
        [anInvocation setArgument:&score atIndex:argumentsCount - 1];
        [anInvocation invokeWithTarget:pick];
    }
    //做手脚三：可以修改target，然后就可以直接使用[anInvocation invoke]和[anInvocation invokeWithTarget:[anInvocation target]]调用了
}


@end
