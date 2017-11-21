//
//  ZPZCoreGraphicsBitMapViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/28.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZCoreGraphicsBitMapViewController.h"
#import "ZPZCommonMethod.h"

@interface ZPZCoreGraphicsBitMapViewController ()

@end

@implementation ZPZCoreGraphicsBitMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawBitMap];
}
//下面的尺寸有些问题，因为里面用的是像素单位
/**
 * width：宽度
 * height：高度
 * bytesPerRow: 每行的字节数，至少是width * 每个像素占用的字节数，而且是每个像素占用字节数的整数倍，
               一般每个像素都是由（r，g，b，a）、（r，g，b）等表示，每一个称为component，rgb的范围是0到255，因此一个字节就足够表示了（1bytes=8bits）
 * bitPerComponent：每个像素的各个component所占用的bits位数，每个像素所需要的字节数为(bitsPerComponent * number of components + 7)/8，（这里为什么要加7呢？难道预留的是为了alpha通道？）
 * space：The number of components for each pixel is specified by `space'
 * bitmapInfo：是否包含alpha通道
 * data：width * bytesPerRow * height
 */
- (void)drawBitMap{
//    CGBitmapContextCreate(<#void * _Nullable data#>, <#size_t width#>, <#size_t height#>, <#size_t bitsPerComponent#>, <#size_t bytesPerRow#>, <#CGColorSpaceRef  _Nullable space#>, <#uint32_t bitmapInfo#>)
    size_t width = self.view.frame.size.width;
    size_t height = self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight];
    void * data = NULL;
    size_t bitPerComponent = 8;
    size_t bytesPerRow = width * 4;  //为什么这里是4？(rgba?)
    data = calloc(bytesPerRow * height, sizeof(uint8_t));
    if (data == NULL) {
        return;
    }
    CGContextRef bitmapContext = CGBitmapContextCreate(data, width, height, bitPerComponent, bytesPerRow, CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB), kCGImageAlphaPremultipliedLast);  //32 bpp, 8 bpc,kCGImageAlphaPremultipliedLast，每个像素32位，每个component 8位（所以bitPerComponent为8）
    if (bitmapContext == NULL) {
        return;
    }
    CGContextSetFillColorWithColor(bitmapContext, [UIColor orangeColor].CGColor);
    CGContextFillRect(bitmapContext, CGRectMake(0, 0, self.view.frame.size.width, height / 2));
    CGContextSetFillColorWithColor(bitmapContext, [UIColor greenColor].CGColor);
    CGContextFillRect(bitmapContext, CGRectMake(0, height / 2, self.view.frame.size.width, height / 2));
    CGImageRef imageRef = CGBitmapContextCreateImage(bitmapContext);
//    CGContextDrawImage(bitmapContext, CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight]), imageRef);
    if (imageRef == NULL) {
        return;
    }
    UIImage * image = [UIImage imageWithCGImage:imageRef];
    CFRelease(imageRef);
    CFRelease(bitmapContext);
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight])];
    imageView.image = image;
    [self.view addSubview:imageView];
}

@end
