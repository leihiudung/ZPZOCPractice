//
//  ZPZLayerCover_01_Label.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/26.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZLayerCover_01_Label.h"

@implementation ZPZLayerCover_01_Label
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(20, 20, frame.size.width - 2 * 20, frame.size.height - 2 * 20)];
        view.backgroundColor = [UIColor blueColor];
        [self addSubview:view];
    }
    return self;
}

@end
