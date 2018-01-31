//
//  ViewController.m
//  ZPZNetWorkPractice
//
//  Created by zhoupengzu on 2018/1/31.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ViewController.h"
#import "ZPZDefaultSessionViewController.h"
#import "ZPZEphemeralSessionViewController.h"
#import "ZPZBackgroundSessionViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
}

- (IBAction)gotoDefaultSessionVC:(UIButton *)sender {
    ZPZDefaultSessionViewController * defaultSessionVC = [[ZPZDefaultSessionViewController alloc] init];
    [self.navigationController pushViewController:defaultSessionVC animated:YES];
}
- (IBAction)gotoEphemeralSessionVC:(UIButton *)sender {
    ZPZEphemeralSessionViewController * ephemeralVC = [[ZPZEphemeralSessionViewController alloc] init];
    [self.navigationController pushViewController:ephemeralVC animated:YES];
}
- (IBAction)gotoBackgroundSessionVC:(UIButton *)sender {
    ZPZBackgroundSessionViewController * backVC = [[ZPZBackgroundSessionViewController alloc] init];
    [self.navigationController pushViewController:backVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
