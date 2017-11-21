//
//  ZPZDrawImage_UIImage_ViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/10/10.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZDrawImage_UIImage_ViewController.h"

@interface ZPZDrawImage_UIImage_ViewController ()

@end

@implementation ZPZDrawImage_UIImage_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self drawImage_PingYi];
//    [self drawImage_SuoFang];
    [self drawImage_CaiJian];
}
//平移
- (void)drawImage_PingYi{
    UIImage * oriImage = [UIImage imageNamed:@"Icon-60.png"];  //两倍图尺寸为120*120
    CGSize oriSize = oriImage.size;
//    UIGraphicsBeginImageContext(<#CGSize size#>) //该方法会调用下面方法作为返回，其中opaque=no，scale=1
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(oriSize.width * 2, oriSize.height), NO, 0); //scale如果为0，则其放大因子会根据设备自动调整
    //绘制
    [oriImage drawAtPoint:CGPointMake(0, 0)];
    [oriImage drawAtPoint:CGPointMake(oriSize.width, 0)];
    UIImage * finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView * imageView = [[UIImageView alloc] initWithImage:finalImage];
    [self.view addSubview:imageView];
    NSLog(@"oriSize:%@,finalSize:%@",NSStringFromCGSize(oriSize),NSStringFromCGSize(finalImage.size)); //(60,60),(120,60)
}
//缩放
- (void)drawImage_SuoFang{
    UIImage * oriImage = [UIImage imageNamed:@"Icon-60.png"];  //两倍图尺寸为120*120
    CGSize oriSize = oriImage.size;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(oriSize.width * 3, oriSize.height * 3), NO, 0);
    [oriImage drawInRect:CGRectMake(0, 0, oriSize.width * 3, oriSize.height * 3)];
    [oriImage drawInRect:CGRectMake(oriSize.width, oriSize.height, oriSize.width, oriSize.height)];
    UIImage * finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView * imageView = [[UIImageView alloc] initWithImage:finalImage];
    [self.view addSubview:imageView];
}
//裁剪
- (void)drawImage_CaiJian{
    UIImage * oriImage = [UIImage imageNamed:@"Icon-60.png"];  //两倍图尺寸为120*120
    CGSize oriSize = oriImage.size;
    UIGraphicsBeginImageContextWithOptions(oriSize, NO, 0);
    [oriImage drawAtPoint:CGPointMake(-oriSize.width / 2, 0)];
    UIImage * finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView * imageView = [[UIImageView alloc] initWithImage:finalImage];
    [self.view addSubview:imageView];
}

@end
