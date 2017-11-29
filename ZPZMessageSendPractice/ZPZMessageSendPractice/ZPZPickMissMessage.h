//
//  ZPZPickMissMessage.h
//  ZPZMessageSendPractice
//
//  Created by zhoupengzu on 2017/11/29.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZPZPickMissMessage : NSObject
//测试能否在第一步就修改为其他对象
- (int)resolveInstanceMethodWithOC:(NSString *)name age:(NSInteger)age;
- (NSInteger)testFindOtherReceiver;
- (void)testMsgInvocationWithMessage:(NSString *)msg;
- (void)msgInvocationWithMessage:(NSString *)msg andScore:(NSInteger)score;

@end
