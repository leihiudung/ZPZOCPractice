//
//  ZPZClipPath_01_View.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/29.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZClipPath_01_View.h"

@implementation ZPZClipPath_01_View
/**
 * 先保存上下文，然后绘制裁剪区域，再绘制要在裁剪区域里的内容
 * 如果需要在裁剪区域外绘制，需要先将保存的上下文恢复，再做绘制
 */
- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 5);
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    
    CGContextMoveToPoint(context, 120, 70);
    CGContextAddArc(context, 70, 70, 50, 0, M_PI * 2, 0);
    //保存一下,用以绘制裁剪区域外的内容
    CGContextSaveGState(context);
    CGContextEOClip(context);
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextAddRect(context, CGRectMake(20, 20, 100, 100));
    CGContextDrawPath(context, kCGPathEOFillStroke);
    //恢复，可以试一下，如果不保存和恢复，则后面所有的操作都将被限制在这个区域里（圆心为（70，70），半径为50）
//    CGContextRestoreGState(context);
    CGContextMoveToPoint(context, 10, 10);
    CGContextAddLineToPoint(context, 140, 140);
    CGContextStrokePath(context);
    
    CFRelease(context);
}

@end
