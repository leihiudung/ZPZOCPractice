//
//  ZPZUITableViewCell.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/10/23.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZUITableViewCell.h"

@implementation ZPZUITableViewCell

- (instancetype)initWithFrame:(CGRect)frame andIdentifier:(NSString *)identifier{
    self = [super initWithFrame:frame];
    if (self) {
        _identifier = identifier;
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textLabel];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 0.5, frame.size.width, 0.5)];
        lineView.backgroundColor = [UIColor colorWithWhite:153 / 255.f alpha:1];
        [self addSubview:lineView];
    }
    return self;
}

@end
