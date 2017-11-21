//
//  ZPZFillPath_02_View.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/29.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZFillPath_02_View.h"

@implementation ZPZFillPath_02_View

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 5);
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
//    CGContextMoveToPoint(context, 100, 100);
    //绘制方式一
//    CGContextAddArc(context, 100, 100, 100, 0, 2 * M_PI, 0);  //0 为顺时针，则1为逆时针，同时角度也应该为负值
//    CGContextAddArc(context, 100, 100, 50, 0, -2 * M_PI, 1);  //0 为顺时针，则1为逆时针
    //绘制方式二
    CGContextAddArc(context, 100, 100, 100, 0, 2 * M_PI, 0);  //0 为顺时针，则1为逆时针，同时角度也应该为负值
    CGContextAddArc(context, 100, 100, 50, 0, -2 * M_PI, 1);  //0 为顺时针，则1为逆时针
    
    //两种填充规则(线条没有颜色)
        CGContextFillPath(context);  //非零围绕填充，方式一此时全部被填充，方式二此时全部被填充
//    CGContextEOFillPath(context);  //奇偶填充，方式一此时中间有留白，方式二此时中间有留白
//        CGContextStrokePath(context); //即使是这样，也不会有描边即线条有颜色
    //两种填充规则(线条有颜色)
    //    CGContextDrawPath(context, kCGPathFillStroke);
//        CGContextDrawPath(context, kCGPathEOFillStroke);
    CFRelease(context);
}

@end
