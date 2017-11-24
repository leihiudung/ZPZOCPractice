//
//  ZPZDrawSingleLineView.m
//  ZPZCoreTextPractice
//
//  Created by zhoupengzu on 2017/11/23.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZDrawSingleLineView.h"
#import <CoreText/CoreText.h>

@implementation ZPZDrawSingleLineView

-(void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    //调换坐标
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    //创建区域
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathAddRect(pathRef, NULL, CGRectMake(10, 10, self.frame.size.width - 2 * 10, self.bounds.size.height - 2 * 10));
    //创建字符串
    CFStringRef strRef = CFSTR("Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine.");
    //创建富文本字典
    CTFontDescriptorRef descriptorRef = CTFontDescriptorCreateWithNameAndSize(CFSTR("PingFangSC-Light"), 18);
    CTFontRef fontRef = CTFontCreateWithFontDescriptor(descriptorRef, 18, NULL);
    CFStringRef keys[] = { kCTFontAttributeName };
    CTFontRef values[] = { fontRef };
    CFDictionaryRef dictionaryRef = CFDictionaryCreate(kCFAllocatorDefault, &keys, &values, <#CFIndex numValues#>, <#const CFDictionaryKeyCallBacks *keyCallBacks#>, <#const CFDictionaryValueCallBacks *valueCallBacks#>)
    //创建富文本
    CFAttributedStringRef attrRef = CFAttributedStringCreate(kCFAllocatorDefault, strRef, <#CFDictionaryRef attributes#>)
}

@end
