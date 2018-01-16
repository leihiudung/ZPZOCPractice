//
//  ZPZCoreGraphicsPathViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/28.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZCoreGraphicsPathViewController.h"
#import "ZPZDrawPath_01_View.h"
#import "ZPZFillPath_01_View.h"
#import "ZPZFillPath_02_View.h"
#import "ZPZClipPath_01_View.h"
#import "ZPZCommonMethod.h"

@interface ZPZCoreGraphicsPathViewController ()

@end

@implementation ZPZCoreGraphicsPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self drawingLines_01];
    [self clipPath_01];
}
- (void)drawingLines_01{
    
    ZPZDrawPath_01_View * view = [[ZPZDrawPath_01_View alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight])];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}

- (void)fillPath_01{
    ZPZFillPath_01_View * fillView = [[ZPZFillPath_01_View alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight])];
    fillView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:fillView];
}

- (void)fillPath_02{
    ZPZFillPath_02_View * fillView = [[ZPZFillPath_02_View alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight])];
    fillView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:fillView];
}

- (void)clipPath_01{
    ZPZClipPath_01_View * clipView = [[ZPZClipPath_01_View alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight])];
    clipView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:clipView];
}

@end
