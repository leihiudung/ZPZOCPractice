//
//  ZPZParagraphPractice.m
//  ZPZCoreTextPractice
//
//  Created by zhoupengzu on 2017/11/24.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZParagraphPractice.h"
#import <CoreText/CoreText.h>

@implementation ZPZParagraphPractice

NSAttributedString* applyParaStyle(CFStringRef fontName,CGFloat pointSize,NSString * plainText,CGFloat lineSpaceInc){
    CTFontRef fontRef = CTFontCreateWithName(fontName, pointSize, NULL);
    CGFloat lineSpacing = (CTFontGetLeading(fontRef) + lineSpaceInc) * 1;
    CTParagraphStyleSetting setting;
    setting.spec = kCTParagraphStyleSpecifierMinimumLineSpacing;
    setting.value = &lineSpacing;
    setting.valueSize = sizeof(CGFloat);
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(&setting, 1);
    NSDictionary * attributes = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)fontRef,(id)kCTFontNameAttribute,(__bridge id)paragraphStyle,kCTParagraphStyleAttributeName, nil];
    CFRelease(fontRef);
    CFRelease(paragraphStyle);
    NSAttributedString * attrString = [[NSAttributedString alloc] initWithString:plainText attributes:attributes];
    return attrString;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CFStringRef fontName = CFSTR("Didot Italic");
    CGFloat pointSize = 24.0;
    CFStringRef string = CFSTR("Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one,and I look at it, until it begins to shine.");
    NSAttributedString * attrString = applyParaStyle(fontName, pointSize, (__bridge_transfer NSString *)string, 20);
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrString);
    CGPathRef path = CGPathCreateWithRect(rect, NULL);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CTFrameDraw(frame, context);
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
}

@end
