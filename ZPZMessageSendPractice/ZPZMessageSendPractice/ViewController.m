//
//  ViewController.m
//  ZPZMessageSendPractice
//
//  Created by zhoupengzu on 2017/11/29.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>
#import "ZPZReceiveMessage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self firstSaveLife];
}
/**
 * 除正常调用外，可以试试下面的方法
 *  //先定义一个函数指针
     void(*funcPointer)(id,SEL,NSString *) = (void(*)(id,SEL,NSString *))objc_msgSend;
    //发送消息
     funcPointer(self,@selector(receiveObjSendMessage:),@"Hello!This is from msgSend");
 */
- (void)receiveObjSendMessage:(NSString *)msg {
    NSLog(@"%@",msg); // Hello!This is from msgSend
}

/**
 * 第一次补救机会
 */
- (void)firstSaveLife{
    ZPZReceiveMessage * msg = [[ZPZReceiveMessage alloc] init];
    int value = [msg testResolveInstanceMthod:@"resolveInstance" age:2];
    NSLog(@"%d",value);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
