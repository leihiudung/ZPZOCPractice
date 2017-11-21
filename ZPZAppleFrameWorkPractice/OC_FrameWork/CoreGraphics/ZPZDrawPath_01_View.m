//
//  ZPZDrawPath_01_View.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/29.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZDrawPath_01_View.h"

@implementation ZPZDrawPath_01_View

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 10); //设置画笔宽度
    /**
     * 只有在CGContextSetLineJoin(context, kCGLineJoinMiter)情况下才起作用
     */
    CGContextSetMiterLimit(context, 0);   //设置连接线的衔接限制
    CGContextSetLineJoin(context, kCGLineJoinMiter);  //定义两条线相连接出的形状
//    CGContextSetLineCap(context, kCGLineCapSquare);   //每条线结束时的形状
    
    /**
     * phase:先画phase，再开始不画
     * count:lengths的长度
     * lengths:绘制规则，依次表示绘制长度、不绘制长度、绘制长度、不绘制长度。。。。。。如此循环
     * 设置了CGContextSetLineCap，貌似就画不出来虚线了
     */
    CGFloat lengths[] = {2,3};
    CGContextSetLineDash(context, 5, lengths, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    
    //画线
    CGContextMoveToPoint(context, self.frame.size.width / 2, 10);
    CGContextAddLineToPoint(context, self.frame.size.width / 2 - 50, self.frame.size.height / 2);
    CGContextAddLineToPoint(context, self.frame.size.width / 2 + 50, self.frame.size.height / 2);
    //闭合
//    CGContextClosePath(context);
    //往上下文绘制(以下两个都是同样的效果)
    CGContextStrokePath(context);
//    CGContextDrawPath(context, kCGPathStroke);
    CFRelease(context);
}

@end
