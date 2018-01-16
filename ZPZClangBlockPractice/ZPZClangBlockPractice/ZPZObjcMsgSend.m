//
//  ZPZObjcMsgSend.m
//  ZPZClangBlockPractice
//
//  Created by zhoupengzu on 2017/11/28.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZObjcMsgSend.h"
#import <objc/message.h>

@implementation ZPZObjcMsgSend
/**
 * 这里需要复习一下函数指针的概念
 */
- (void)sendMessage {
    void (*msgSend)(id,SEL,NSString *) = (void (*)(id,SEL,NSString *))objc_msgSend;
    msgSend(self,@selector(receiveMessage:),@"Hello,prepare receive message!");
     ((void(*)(id,SEL,NSString *))objc_msgSend)(self,@selector(receiveMessage:),@"Hello,prepare receive message!");
}

- (void)receiveMessage:(NSString *)msg {
    NSLog(@"I received message:%@",msg);
}

@end
