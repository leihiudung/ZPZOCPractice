//
//  ZPZUINavgationBar.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/28.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZUINavgationBar.h"
#import "ZPZCommonMethod.h"

#define leftButtonWidth [ZPZCommonMethod getNavHeight]
#define rightButtonWidth [ZPZCommonMethod getNavHeight]

@implementation ZPZUINavgationBar

- (instancetype)initWithFrame:(CGRect)frame{
    frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [ZPZCommonMethod getNavAndStatusHeight]);
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.backgroundColor = [UIColor clearColor];
        _leftButton.frame = CGRectMake(0, [ZPZCommonMethod getStatusHeight], leftButtonWidth, [ZPZCommonMethod getNavHeight]);
        [self addSubview:_leftButton];
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, [ZPZCommonMethod getStatusHeight], leftButtonWidth, [ZPZCommonMethod getNavHeight])];
        _leftImageView.backgroundColor = [UIColor orangeColor];
        [self addSubview:_leftImageView];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftButtonWidth, [ZPZCommonMethod getStatusHeight], frame.size.width - leftButtonWidth - rightButtonWidth, [ZPZCommonMethod getNavHeight])];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor colorWithWhite:51 / 255.f alpha:1];
        [self addSubview:_titleLabel];
        //其他
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, [ZPZCommonMethod getNavAndStatusHeight] - 0.5, frame.size.width, 0.5)];
        _bottomLineView.backgroundColor = [UIColor colorWithWhite:153 / 255.f alpha:1];
        [self addSubview:_bottomLineView];
    }
    return self;
}

@end
