//
//  ZPZColumnarView.m
//  ZPZCoreTextPractice
//
//  Created by zhoupengzu on 2017/11/24.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZColumnarView.h"
#import <CoreText/CoreText.h>

@implementation ZPZColumnarView

- (void)drawRect:(CGRect)rect {
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //反转
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    //CTFramesetter
    CFAttributedStringRef attrRef = [self getAttributedStr];
    CTFramesetterRef framesetterRef = CTFramesetterCreateWithAttributedString(attrRef);
    CFRelease(attrRef);
    CFArrayRef arrRef = [self createColumnsWithColumnCount:3];
    CFIndex pathCount = CFArrayGetCount(arrRef);
    CFIndex startIndex = 0;
    int column;
    for (column = 0; column < pathCount; column++) {
        CGPathRef path = CFArrayGetValueAtIndex(arrRef, column);
        CTFrameRef frmaeRef = CTFramesetterCreateFrame(framesetterRef, CFRangeMake(startIndex, 0), path, NULL);
        CTFrameDraw(frmaeRef, context);
        CFRange frameRange = CTFrameGetVisibleStringRange(frmaeRef);
        startIndex += frameRange.length;
        CFRelease(frmaeRef);
    }
    CFRelease(framesetterRef);
    CFRelease(arrRef);
}

- (CFAttributedStringRef)getAttributedStr{
    CFStringRef strRef = CFSTR("哈我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是我是啦");
    CGFloat fontSize = 20;
    CTFontDescriptorRef descriptorRef = CTFontDescriptorCreateWithNameAndSize(CFSTR("PingFangSC-Medium"), fontSize);
    CTFontRef fontRef = CTFontCreateWithFontDescriptor(descriptorRef, fontSize, NULL);
    CFRelease(descriptorRef);
    CGColorSpaceRef spaceRef = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {1,0,0,1};
    CGColorRef colorRef = CGColorCreate(spaceRef, components);
    CFRelease(spaceRef);
    CFTypeRef keys[] = { kCTFontAttributeName, kCTForegroundColorAttributeName };
    CFTypeRef values[] = { fontRef, colorRef };
    CFDictionaryRef dicRef = CFDictionaryCreate(kCFAllocatorDefault, (const void**)&keys, (const void**)&values, sizeof(keys) / sizeof(keys[0]), &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    CFRelease(fontRef);
    CFRelease(colorRef);
    CFAttributedStringRef attrRef = CFAttributedStringCreate(kCFAllocatorDefault, strRef, dicRef);
    CFRelease(strRef);
    return attrRef;
}

- (CFArrayRef)createColumnsWithColumnCount:(int)columnCount{
    int column;
    CGRect * columnRects;
    columnRects = (CGRect *)calloc(columnCount, sizeof(*columnRects)); //这里是重点，为什么写成*columnRects，而不是columnRects？
    columnRects[0] = self.bounds;
    CGFloat columnWidth = CGRectGetWidth(self.bounds) / columnCount;  //切割宽度
    //开始切割
    for (column = 0; column < columnCount - 1; column++) {
        CGRectDivide(columnRects[column], &columnRects[column], &columnRects[column + 1], columnWidth, CGRectMinXEdge);
    }
    for (column = 0;column < columnCount;column++){
        NSLog(@"%@",NSStringFromCGRect(columnRects[column])); //{{0, 0}, {125, 603}}
        columnRects[column] = CGRectInset(columnRects[column], 5, 10);
        NSLog(@"%@",NSStringFromCGRect(columnRects[column])); //{{5, 10}, {115, 583}}
    }
    CFMutableArrayRef arrRef = CFArrayCreateMutable(kCFAllocatorDefault, columnCount, &kCFTypeArrayCallBacks);
    for(column = 0; column < columnCount; column++) {
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, columnRects[column]);
        CFArrayInsertValueAtIndex(arrRef, column, path);
        CFRelease(path);
    }
    free(columnRects);
    return arrRef;
}

@end
