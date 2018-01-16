//
//  ZPZPickMissMessage.m
//  ZPZMessageSendPractice
//
//  Created by zhoupengzu on 2017/11/29.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZPickMissMessage.h"

@implementation ZPZPickMissMessage

- (int)resolveInstanceMethodWithOC:(NSString *)name age:(NSInteger)age{
    NSLog(@"name:%@,age:%@",name,@(age));
    return 10;
}

- (NSInteger)testFindOtherReceiver{
    NSLog(@"I am the receiver");
    return 20;
}

- (void)testMsgInvocationWithMessage:(NSString *)msg{
    NSLog(@"forwardInvocation:%@",msg);
}

- (void)msgInvocationWithMessage:(NSString *)msg andScore:(NSInteger)score{
    NSLog(@"msgInvocationWithMessage:%@,score:%@",msg,@(score));
}

@end
