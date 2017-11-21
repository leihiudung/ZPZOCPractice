//
//  ZPZCoreGraphicsColorSpaceViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/30.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZCoreGraphicsColorSpaceViewController.h"

@interface ZPZCoreGraphicsColorSpaceViewController ()

@end

@implementation ZPZCoreGraphicsColorSpaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawColor_ColorSpaces_Lab];
}
/**
 * CGColorSpaceCreateLab(<#const CGFloat * _Nonnull whitePoint#>, <#const CGFloat * _Nullable blackPoint#>, <#const CGFloat * _Nullable range#>)
 * CGColorSpaceCreateICCBased(<#size_t nComponents#>, <#const CGFloat * _Nullable range#>, <#CGDataProviderRef  _Nullable profile#>, <#CGColorSpaceRef  _Nullable alternate#>)
 * CGColorSpaceCreateCalibratedRGB(<#const CGFloat * _Nonnull whitePoint#>, <#const CGFloat * _Nullable blackPoint#>, <#const CGFloat * _Nullable gamma#>, <#const CGFloat * _Nullable matrix#>)
 * CGColorSpaceCreateCalibratedGray(<#const CGFloat * _Nonnull whitePoint#>, <#const CGFloat * _Nullable blackPoint#>, <#CGFloat gamma#>)
 */
- (void)drawColor_ColorSpaces_Lab{
    
}

- (void)drawColor_ICC{
    
}

- (void)drawColor_RGB{
    
}

- (void)drawColor_Gray{
    
}
/**
 * 使用通用方法创建
 * CGColorSpaceCreateWithName(<#CFStringRef  _Nullable name#>)，可选值为：kCGColorSpaceGenericGray、kCGColorSpaceGenericRGB、kCGColorSpaceGenericCMYK
 */
- (void)drawColor_Genic{
    
}

@end
