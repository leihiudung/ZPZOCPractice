//
//  ZPZTextView.m
//  ZPZCustomTextView
//
//  Created by zhoupengzu on 2017/12/6.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZTextView.h"
#import "ZPZTextView+delegate.h"

@interface ZPZTextView ()

@property (nonatomic, strong, readonly) ZPZLabel * placeHoldLabel;

@end

@implementation ZPZTextView

@synthesize placeHoldStr = _placeHoldStr;

- (instancetype)init {
    self = [super init];
    if (self) {
        _placeHoldLabel = [self createPlaceHoldLabel];
        self.delegate = self;
        [self addSubview:_placeHoldLabel];
        [self adjustPlaceLabelFrame];
        _placeHoldColor = [self getPlaceHoldDefaultColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _placeHoldLabel = [self createPlaceHoldLabel];
        self.delegate = self;
        [self addSubview:_placeHoldLabel];
        [self adjustPlaceLabelFrame];
        _placeHoldColor = [self getPlaceHoldDefaultColor];
    }
    return self;
}

- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset {
    [super setTextContainerInset:textContainerInset];
    [self adjustPlaceLabelFrame];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self adjustPlaceLabelFrame];
}

- (void)setPlaceHoldStr:(NSString *)placeHoldStr {
    if (_placeHoldLabel == nil) {
        return;
    }
    if (placeHoldStr == nil) {
        _placeHoldStr = @"";
    } else {
        _placeHoldStr = placeHoldStr;
    }
    _placeHoldLabel.text = _placeHoldStr;
}

-(NSString *)placeHoldStr {
    _placeHoldStr = _placeHoldLabel.attributedText.string;
    //这个判断也可以不要
    if (_placeHoldStr.length == 0) {
        _placeHoldStr = _placeHoldLabel.text;
    }
    return _placeHoldStr;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    _placeHoldLabel.font = self.font;
}

- (void)setPlaceHoldColor:(UIColor *)placeHoldColor {
    if (placeHoldColor == nil) {
        _placeHoldColor = [UIColor blackColor];
    } else {
        _placeHoldColor = placeHoldColor;
    }
    _placeHoldLabel.textColor = _placeHoldColor;
}

- (ZPZLabel *)createPlaceHoldLabel {
    ZPZLabel * label = [[ZPZLabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    label.textColor = [self getPlaceHoldDefaultColor];
    //UITextView默认font不存在
    self.font = label.font;
    return label;
}

- (UIColor *)getPlaceHoldDefaultColor {
    return [UIColor colorWithWhite:153 / 255.f alpha:1];
}

- (void)hidePlaceHolder {
    [UIView animateWithDuration:0.25 animations:^{
        self.placeHoldLabel.alpha = 1;
    } completion:^(BOOL finished) {
        self.placeHoldLabel.hidden = NO;
    }];
}

- (void)showPlaceHolder {
    [UIView animateWithDuration:0.25 animations:^{
        self.placeHoldLabel.alpha = 1;
    } completion:^(BOOL finished) {
        self.placeHoldLabel.hidden = NO;
    }];
}

- (void)adjustPlaceLabelFrame {
    UIEdgeInsets insets = self.textContainerInset;
//    NSLog(@"%@",NSStringFromUIEdgeInsets(insets));
    _placeHoldLabel.frame = CGRectMake(insets.left + self.textContainer.lineFragmentPadding, insets.top, self.frame.size.width - insets.left - insets.right - self.textContainer.lineFragmentPadding, self.frame.size.height - insets.top - insets.bottom);
    _placeHoldLabel.verticalAlignment = ZPZLabelVerticalTextAlignmentTop;
}

@end
