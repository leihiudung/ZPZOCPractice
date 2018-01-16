//
//  ZPZDrawRect_01_View.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/28.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZDrawRect_01_View.h"

@implementation ZPZDrawRect_01_View

//当需要展示在屏幕上且有内容需要更新的时候会调用
//在这里可以不用UIGraphicsBeginImageContext(<#CGSize size#>),而直接使用
- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, self.frame.size.width / 2, self.frame.size.height / 2));
    
    CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
    CGContextFillRect(context, CGRectMake(self.frame.size.width / 2, self.frame.size.height / 2, self.frame.size.width / 2, self.frame.size.height / 2));
}

@end
