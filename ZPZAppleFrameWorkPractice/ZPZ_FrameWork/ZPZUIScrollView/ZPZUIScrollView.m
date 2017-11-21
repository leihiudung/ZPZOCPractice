//
//  ZPZUIScrollView.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/10/20.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZUIScrollView.h"

@implementation ZPZUIScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        UIPanGestureRecognizer * panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(scrollContentWithGesture:)];
        [self addGestureRecognizer:panGes];
    }
    return self;
}
/**
 * NSLog(@"%@",NSStringFromCGPoint([panGes translationInView:self]));
 * 打印上述可以发现，向右向下时都是正值，其他方向都是负值
 */
- (void)scrollContentWithGesture:(UIPanGestureRecognizer *)panGes{
    CGPoint changePoint = [panGes translationInView:self];
    CGRect bounds = self.bounds;
    switch (panGes.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:{
            if (_contentSize.width == 0 && _contentSize.height == 0) {
            } else if(_contentSize.width == 0 && _contentSize.height != 0) {
                bounds.origin.y = bounds.origin.y - changePoint.y;
            } else if(_contentSize.width != 0 && _contentSize.height == 0) {
                bounds.origin.x = bounds.origin.x - changePoint.x;
            } else {
                bounds.origin.x = bounds.origin.x - changePoint.x;
                bounds.origin.y = bounds.origin.y - changePoint.y;
            }
            self.bounds = bounds;
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:{
            /*
             * 计算出范围
             *
             */
            CGFloat minOffset = 0;
            CGFloat maxOffsetX = _contentSize.width - bounds.size.width;
            CGFloat maxOffsetY = _contentSize.height - bounds.size.height;
            CGFloat actualOffsetX = fmax(minOffset, fmin(maxOffsetX, bounds.origin.x - changePoint.x));
            CGFloat actualOffsetY = fmax(minOffset,fmin(maxOffsetY, bounds.origin.y - changePoint.y));
            if (_pageEnabled) {
                actualOffsetX = round(actualOffsetX / bounds.size.width) * bounds.size.width;
                actualOffsetY = round(actualOffsetY / bounds.size.height) * bounds.size.height;
            }
            if (_contentSize.width == 0 && _contentSize.height == 0) {
                bounds.origin.x = actualOffsetX;
                bounds.origin.y = actualOffsetY;
                self.bounds = bounds;
            } else if(_contentSize.width == 0 && _contentSize.height != 0) {
                bounds.origin.x = actualOffsetX;
                self.bounds = bounds;
                bounds.origin.y = actualOffsetY;
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.bounds = bounds;
                } completion:nil];
            } else if(_contentSize.width != 0 && _contentSize.height == 0) {
                bounds.origin.y = actualOffsetY;
                self.bounds = bounds;
                bounds.origin.x = actualOffsetX;
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.bounds = bounds;
                } completion:nil];
            } else {
                bounds.origin.x = actualOffsetX;
                bounds.origin.y = actualOffsetY;
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.bounds = bounds;
                } completion:nil];
            }
        }
            break;
        default:
            break;
    }
    [panGes setTranslation:CGPointZero inView:self];
}

@end
