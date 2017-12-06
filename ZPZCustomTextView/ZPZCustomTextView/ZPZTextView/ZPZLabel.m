//
//  ZPZLabel.m
//  ZPZPersonalLabel
//
//  Created by zhoupengzu on 2017/12/6.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZLabel.h"

@implementation ZPZLabel

- (void)setVerticalAlignment:(ZPZLabelVerticalTextAlignment)verticalAlignment {
    _verticalAlignment = verticalAlignment;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect actualRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (_verticalAlignment) {
        case ZPZLabelVerticalTextAlignmentTop:{
            actualRect.origin.y = bounds.origin.y;
        }
            break;
        case ZPZLabelVerticalTextAlignmentMiddle:{
            actualRect.origin.y = bounds.origin.y + bounds.size.height / 2 - actualRect.size.height / 2;
        }
            break;
        case ZPZLabelVerticalTextAlignmentBottom:{
            actualRect.origin.y = bounds.origin.y + bounds.size.height - actualRect.size.height;
        }
            break;
            
        default:
            break;
    }
    return actualRect;
}
//这里小心写错
- (void)drawTextInRect:(CGRect)rect {
//    NSLog(@"%s",__func__);
    CGRect actualRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
//    NSLog(@"%s",__func__);
}
//先调用父类的这个方法，然后是上面的方法，最后是该方法剩下的
- (void)drawRect:(CGRect)rect {
//     NSLog(@"%s",__func__);
    [super drawRect:rect];
   
}

@end
