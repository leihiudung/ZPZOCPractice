//
//  ZPZFirstViewController.m
//  ZPZNavTransitionPractice
//
//  Created by zhoupengzu on 2017/11/22.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZFirstViewController.h"
#import "ZPZSecondViewController.h"

@interface ZPZFirstViewController ()

@end

@implementation ZPZFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor orangeColor];
    self.title = @"first";
    UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width - 2 * 20, self.view.frame.size.width - 2 * 20)];
    contentView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:contentView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ZPZSecondViewController * secondVC = [[ZPZSecondViewController alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
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
