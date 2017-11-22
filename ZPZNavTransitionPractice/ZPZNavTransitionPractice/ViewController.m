//
//  ViewController.m
//  ZPZNavTransitionPractice
//
//  Created by zhoupengzu on 2017/11/22.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ViewController.h"
#import "ZPZFirstViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"主页";
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ZPZFirstViewController * firstVC = [[ZPZFirstViewController alloc] init];
    [self.navigationController pushViewController:firstVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
