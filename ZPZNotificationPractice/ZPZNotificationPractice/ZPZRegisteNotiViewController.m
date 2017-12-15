//
//  ZPZRegisteNotiViewController.m
//  ZPZNotificationPractice
//
//  Created by zhoupengzu on 2017/12/15.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZRegisteNotiViewController.h"
#import "ZPZPostNotiViewController.h"

@interface ZPZRegisteNotiViewController ()

@property (nonatomic,assign) CGFloat btnWidth;
@property (nonatomic,assign) CGFloat btnHeight;
@property (nonatomic,assign) CGFloat btnBeginY;
@property (nonatomic,assign) CGFloat btnSpace;

@end

@implementation ZPZRegisteNotiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUseButton];
}

#pragma - mark create button
- (void)createUseButton {
    _btnSpace = 15;
    NSInteger lineCount = 2;
    _btnWidth = ([UIScreen mainScreen].bounds.size.width - (lineCount + 1) * _btnSpace) / lineCount;
    if (_btnWidth < 0) {
        _btnWidth = 0;
    }
    _btnHeight = 50;
    NSString * titleKey = @"title";
    NSString * selKey = @"selKey";
    NSArray<NSDictionary *> * btnArray = @[
                                           @{titleKey:@"Post Noti Obj",selKey:NSStringFromSelector(@selector(gotoPostNotiVCForObject))},
                                           @{titleKey:@"Post Noti Name",selKey:NSStringFromSelector(@selector(gotoPostNotiVXForName))}
                                           ];
    for (NSInteger i = 0; i < btnArray.count; i++) {
        CGFloat beignX = (i % lineCount + 1) * _btnSpace + i % lineCount * _btnWidth;
        CGFloat beginY = (i / lineCount + 1) * _btnSpace + i / 2 * _btnHeight;
        CGRect frame = { { beignX, beginY },{ _btnWidth, _btnHeight } };
        NSString * title = btnArray[i][titleKey];
        NSString * selStr = btnArray[i][selKey];
        UIButton * button = [self createButtonWithFrame:frame andTitle:title andSelectorStr:selStr];
        [self.view addSubview:button];
    }
}

- (void)gotoPostNotiVCForObject {
    [self removeNoti];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotiForObjectIsNil:) name:@"receiveNotiForObjectIsNil" object:nil];
    ZPZPostNotiViewController * postVC = [[ZPZPostNotiViewController alloc] init];
    postVC.addVC = self;
    [self.navigationController pushViewController:postVC animated:YES];
}

- (void)gotoPostNotiVXForName {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotiForObjectIsNil:) name:nil object:self];
    ZPZPostNotiViewController * postVC = [[ZPZPostNotiViewController alloc] init];
    postVC.addVC = self;
    [self.navigationController pushViewController:postVC animated:YES];
}

- (void)receiveNotiForObjectIsNil:(NSNotification *)noti {
    NSLog(@"%@",noti);
}

- (void)removeNoti {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma - mark common button
- (UIButton *)createButtonWithFrame:(CGRect)frame andTitle:(NSString *)title andSelectorStr:(NSString *)selStr {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:NSSelectorFromString(selStr) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor orangeColor];
    button.layer.cornerRadius = frame.size.height / 2;
    button.layer.masksToBounds = YES;
    return button;
}

@end
