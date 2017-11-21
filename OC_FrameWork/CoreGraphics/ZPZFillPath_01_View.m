//
//  ZPZFillPath_01_View.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/29.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZFillPath_01_View.h"

@implementation ZPZFillPath_01_View

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 5);
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    //绘制方式一
    CGContextAddRect(context, CGRectMake(10, 10, self.frame.size.width - 2 * 10, 100));
    CGContextAddRect(context, CGRectMake(20, 20, self.frame.size.width - 2 * 20, 80));
    
    //两种填充规则(线条没有颜色)
//    CGContextFillPath(context);  //非零围绕填充，此时全部被填充
    CGContextEOFillPath(context);  //奇偶填充，此时中间有留白
//    CGContextStrokePath(context); //即使是这样，也不会有描边即线条有颜色
    //两种填充规则(线条有颜色)
//    CGContextDrawPath(context, kCGPathFillStroke);
//    CGContextDrawPath(context, kCGPathEOFillStroke);
    CFRelease(context);
}

@end
