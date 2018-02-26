//
//  ZPZAssetsUsingViewController.m
//  ZPZAVFoundationPractice
//
//  Created by zhoupengzu on 2018/2/22.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZAssetsUsingViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

@interface ZPZAssetsUsingViewController ()

@end

@implementation ZPZAssetsUsingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self createAsset1];
    [self createAssetWithLibrary];
}
/**
 * 一般直接使用其子类
 */
- (void)createAsset1 {
//    AVAsset
    // 初始化得到的是一个子类对象
//    AVAsset * asset = [AVAsset assetWithURL:[NSURL URLWithString:@""]];
    NSURL * url = [NSURL URLWithString:@""];
    NSDictionary * options = @{AVURLAssetPreferPreciseDurationAndTimingKey:@(YES)};
    AVURLAsset * urlAsset = [[AVURLAsset alloc] initWithURL:url options:options];
    NSLog(@"%@", urlAsset);
}
/**
 * 访问资源库
 */
- (void)createAssetWithLibrary {
    // 检查权限
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    switch (status) {
        case PHAuthorizationStatusNotDetermined:
        {
            //首次询问获取权限
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                //注意这里不一定是在主线程的
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (status == PHAuthorizationStatusAuthorized) {
                        [self gotoReadMediaAsset];
                    }
                });
            }];
        }
            break;
        case PHAuthorizationStatusAuthorized: {
            [self gotoReadMediaAsset];
        }
            break;
        default:
            break;
    }
}

- (void)gotoReadMediaAsset {
    //获取相册里的资源
    [PHAsset]
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
