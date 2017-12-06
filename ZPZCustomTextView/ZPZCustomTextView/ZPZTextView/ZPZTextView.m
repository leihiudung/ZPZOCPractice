//
//  ZPZTextView.m
//  ZPZCustomTextView
//
//  Created by zhoupengzu on 2017/12/6.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZTextView.h"
#import "ZPZTextView+delegate.h"

@implementation ZPZTextView

@synthesize placeHoldStr = _placeHoldStr;
@synthesize placeHoldAttr = _placeHoldAttr;

- (instancetype)init {
    self = [super init];
    if (self) {
        _placeHoldLabel = [self createPlaceHoldLabel];
        self.delegate = self;
        [self addSubview:_placeHoldLabel];
        [self adjustPlaceLabelFrame];
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

- (void)setPlaceHoldAttr:(NSAttributedString *)placeHoldAttr {
    if (_placeHoldLabel == nil) {
        return;
    }
    if (placeHoldAttr == nil) {
        _placeHoldAttr = [[NSAttributedString alloc] init];
    } else {
        _placeHoldAttr = placeHoldAttr;
    }
    _placeHoldLabel.attributedText = placeHoldAttr;
}

- (NSAttributedString *)placeHoldAttr {
    _placeHoldAttr = _placeHoldLabel.attributedText;
    return _placeHoldAttr;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    _placeHoldLabel.font = self.font;
}

- (ZPZLabel *)createPlaceHoldLabel {
    ZPZLabel * label = [[ZPZLabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    return label;
}

- (void)adjustPlaceLabelFrame {
    UIEdgeInsets insets = self.textContainerInset;
//    NSLog(@"%@",NSStringFromUIEdgeInsets(insets));
    _placeHoldLabel.frame = CGRectMake(insets.left + self.textContainer.lineFragmentPadding, insets.top, self.frame.size.width - insets.left - insets.right - self.textContainer.lineFragmentPadding, self.frame.size.height - insets.top - insets.bottom);
    _placeHoldLabel.verticalAlignment = ZPZLabelVerticalTextAlignmentTop;
}

@end
