//
//  ZPZCoreGraphicsDrawRectViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/28.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZCoreGraphicsDrawRectViewController.h"
#import "ZPZDrawRect_01_View.h"
#import "ZPZCommonMethod.h"

@interface ZPZCoreGraphicsDrawRectViewController ()

@end

@implementation ZPZCoreGraphicsDrawRectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self drawRectInView01];
}

- (void)drawRectInView01{
    //这么写的view的背景色是透明的
//    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    [self.view addSubview:view];
    //同样的写法,不定义背景色时展示不同，因为手动修改了其中的drawRect方法，背景色变成了”黑色“
    ZPZDrawRect_01_View * view = [[ZPZDrawRect_01_View alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight])];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
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
