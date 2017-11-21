//
//  ZPZDrawImage_CGImage_ViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/10/10.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZDrawImage_CGImage_ViewController.h"

@interface ZPZDrawImage_CGImage_ViewController ()

@end

@implementation ZPZDrawImage_CGImage_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self drawImage01];
//    [self drawImage02];
    [self drawImage03];
}
//将图片拆分成两半，并分别绘制在上下文的左右两边
/**
 * 按照下面这种方法，做出来的有以下几个问题
 * 1、图片是倒的
 * 2、图片尺寸不对，尤其是在plus下（这里的图片有@2x和@3x，如果只是1x的呢？可以发现，如果只有1x的话这里不存在尺寸问题）
 */
- (void)drawImage01{
//    UIImage * oriImage = [UIImage imageNamed:@"Icon-60.png"];  //两倍图尺寸为120*120
    UIImage * oriImage = [UIImage imageNamed:@"Icon.png"];  //两倍图尺寸为120*120
    CGSize oriSize = oriImage.size;   //这个是不会受@2x和@3x的影响的，都只取的是1x图的长和宽
    CGImageRef leftImageRef = CGImageCreateWithImageInRect(oriImage.CGImage, CGRectMake(0, 0, oriSize.width / 2, oriSize.height));
    CGImageRef rightImageRef = CGImageCreateWithImageInRect(oriImage.CGImage, CGRectMake(oriSize.width / 2, 0, oriSize.width / 2, oriSize.height));
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(oriSize.width * 1.5, oriSize.height), NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, CGRectMake(0, 0, oriSize.width / 2, oriSize.height), leftImageRef);
    CGContextDrawImage(context, CGRectMake(oriSize.width, 0, oriSize.width / 2, oriSize.height), rightImageRef);
    UIImage * finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CFRelease(leftImageRef);
    CFRelease(rightImageRef);
    
    UIImageView * imageView = [[UIImageView alloc] initWithImage:finalImage];
    imageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageView];
}
//解决尺寸问题
- (void)drawImage02{
    UIImage * oriImage = [UIImage imageNamed:@"Icon-60.png"];  //两倍图尺寸为120*120
    CGImageRef oriImageRef = oriImage.CGImage;
    CGSize oriSize = oriImage.size;
    CGSize oriCGSize = CGSizeMake(CGImageGetWidth(oriImageRef), CGImageGetHeight(oriImageRef));//@3x时为180*180，@2x时为120*120
    CGImageRef leftImageRef = CGImageCreateWithImageInRect(oriImageRef, CGRectMake(0, 0, oriCGSize.width / 2, oriCGSize.height));
    CGImageRef rightImageRef = CGImageCreateWithImageInRect(oriImageRef, CGRectMake(oriCGSize.width / 2, 0, oriCGSize.width / 2, oriCGSize.height));
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(oriSize.width * 1.5, oriSize.height), NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, CGRectMake(0, 0, oriSize.width / 2, oriSize.height), leftImageRef);
    CGContextDrawImage(context, CGRectMake(oriSize.width, 0, oriSize.width / 2, oriSize.height), rightImageRef);
    UIImage * finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CFRelease(leftImageRef);
    CFRelease(rightImageRef);
    
    UIImageView * imageView = [[UIImageView alloc] initWithImage:finalImage];
    imageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageView];
}
//解决倒立问题
/**
 * 方法一、对得到的finalImage再做一次完全绘制，具体的如drawImage02方法
 * 方法二、在绘制CGImage之前，对上下文应用变换操作，将坐标反转
 * 方法三、在绘图之前将CGImage包装进UIImage中，见drawImage03，这样做有两大优点：
     1.当UIImage绘图时它会自动修复倒置问题
     2.当你从CGImage转化为Uimage时，可调用imageWithCGImage:scale:orientation:方法生成CGImage作为对缩放性的补偿。
 */
- (void)drawImage03{
    UIImage* mars = [UIImage imageNamed:@"Icon-60.png"];
    
    CGSize sz = [mars size];
    
    CGImageRef marsCG = [mars CGImage];
    
    CGSize szCG = CGSizeMake(CGImageGetWidth(marsCG), CGImageGetHeight(marsCG));
//    CGSize szCG = sz;  //这里不能写成这样
    
    CGImageRef marsLeft = CGImageCreateWithImageInRect(marsCG, CGRectMake(0,0,szCG.width/2.0,szCG.height));
    
    CGImageRef marsRight = CGImageCreateWithImageInRect(marsCG, CGRectMake(szCG.width/2.0,0,szCG.width/2.0,szCG.height));
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width*1.5, sz.height), NO, 0);
    //核心部分
    [[UIImage imageWithCGImage:marsLeft scale:[mars scale] orientation:UIImageOrientationUp] drawAtPoint:CGPointMake(0,0)];
    [[UIImage imageWithCGImage:marsRight scale:[mars scale] orientation:UIImageOrientationUp] drawAtPoint:CGPointMake(sz.width,0)];
    
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGImageRelease(marsLeft);
    CGImageRelease(marsRight);
    
    UIImageView * imageView = [[UIImageView alloc] initWithImage:im];
    imageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageView];
//    CGContextTranslateCTM(<#CGContextRef  _Nullable c#>, <#CGFloat tx#>, <#CGFloat ty#>)
//    self.view.contentScaleFactor
}

@end
