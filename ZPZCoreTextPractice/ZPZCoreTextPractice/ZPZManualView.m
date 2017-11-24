//
//  ZPZManualView.m
//  ZPZCoreTextPractice
//
//  Created by zhoupengzu on 2017/11/24.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZManualView.h"
#import <CoreText/CoreText.h>

@implementation ZPZManualView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    //坐标转换
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    //富文本
    CFAttributedStringRef attrRef = [self getAttributedStr];
    //CFTypesetter
    CTTypesetterRef typesetterRef = CTTypesetterCreateWithAttributedString(attrRef);
    CFRelease(attrRef);
    CFIndex start = 0;
    double width = 150;
    CFIndex count = CTTypesetterSuggestLineBreak(typesetterRef, start, width);
    CTLineRef lineRef = CTTypesetterCreateLine(typesetterRef, CFRangeMake(start, count));
    float flush = 0.5;
    double penoffset = CTLineGetPenOffsetForFlush(lineRef, flush, width);
    CGPoint textPosition = CGPointMake(20, 20);
    CGContextSetTextPosition(context, textPosition.x + penoffset, textPosition.y);
    CTLineDraw(lineRef, context);
    CFRelease(typesetterRef);
    CFRelease(lineRef);
}

- (CFAttributedStringRef)getAttributedStr{
    CFStringRef strRef = CFSTR("哈我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是啦");
    CGFloat size = 20;
    CTFontDescriptorRef descriptorRef = CTFontDescriptorCreateWithNameAndSize(CFSTR("PingFangSC-Light"), size);
    CTFontRef fontRef = CTFontCreateWithFontDescriptor(descriptorRef, size, NULL);
    CFStringRef keys[] = { kCTFontAttributeName };
    CFTypeRef values[] = { fontRef };
    CFDictionaryRef dicRef = CFDictionaryCreate(kCFAllocatorDefault, (const void**)&keys, (const void**)&values, sizeof(keys) / sizeof(keys[0]), &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    CFAttributedStringRef attrRef = CFAttributedStringCreate(kCFAllocatorDefault, strRef, dicRef);
    CFRelease(dicRef);
    return attrRef;
}

@end
