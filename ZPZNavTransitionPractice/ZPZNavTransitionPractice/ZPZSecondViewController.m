//
//  ZPZSecondViewController.m
//  ZPZNavTransitionPractice
//
//  Created by zhoupengzu on 2017/11/22.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZSecondViewController.h"

@interface ZPZSecondViewController ()

@end

@implementation ZPZSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor cyanColor];
    self.title = @"second";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.navigationController popViewControllerAnimated:YES];
    NSMutableArray * vcArr = [self.navigationController.viewControllers mutableCopy];
    [vcArr removeLastObject];
//    [vcArr removeLastObject];
    self.navigationController.viewControllers = vcArr;
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
