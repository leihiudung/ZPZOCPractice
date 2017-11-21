//
//  ZPZRunTimeMsgSendViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/25.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZRunTimeMsgSendViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface ZPZRunTimeMsgSendViewController ()

@property (nonatomic,strong) UIScrollView * scrollView;

@end

@implementation ZPZRunTimeMsgSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self configUI];
}

- (void)configUI{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:_scrollView];
    
    CGFloat beginX = 20;
    CGFloat buttonWidth = _scrollView.frame.size.width - 2 * beginX;
    CGFloat buttonHeight = 50;
    UIButton * msgSendButton = [self createButtonWithFrame:CGRectMake(beginX, 20, buttonWidth, buttonHeight) andTitle:@"objc_msgSend()"];
    [msgSendButton addTarget:self action:@selector(clickedObjc_MsgSend) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:msgSendButton];
}
/**
 * objc_msgSend的使用必须和下面一样，先强制类型转换，然后再使用
 * 程序中不建议直接使用objc_msgSend调用方法
 */
- (void)clickedObjc_MsgSend{
    NSDate *(*action)(id,SEL,NSString *) = (NSDate *(*)(id,SEL,NSString *))objc_msgSend;
    NSDate * useDate = action(self,@selector(receiveObjc_MsgSend:),@"clickedObjc_MsgSend()");
    NSLog(@"%@",useDate);
}

- (NSDate *)receiveObjc_MsgSend:(NSString *)from{
    NSLog(@"I am From :%@",from);
    return [NSDate date];
}

- (UIButton *)createButtonWithFrame:(CGRect)frame andTitle:(NSString *)title{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor orangeColor];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.layer.cornerRadius = frame.size.height / 2;
    button.layer.masksToBounds = YES;
    return button;
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
