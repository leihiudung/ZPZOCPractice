//
//  ZPZAssetsUsingViewController.m
//  ZPZAVFoundationPractice
//
//  Created by zhoupengzu on 2018/2/22.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZAssetsUsingViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ZPZAssetsUsingViewController ()

@end

@implementation ZPZAssetsUsingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
/**
 * 一般直接使用其子类
 */
- (void)createAsset1 {
//    AVAsset
    // 初始化得到的是一个子类对象
//    AVAsset * asset = [AVAsset assetWithURL:[NSURL URLWithString:@""]];
//    AVURLAsset * urlAsset = [AVURLAsset ]
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
