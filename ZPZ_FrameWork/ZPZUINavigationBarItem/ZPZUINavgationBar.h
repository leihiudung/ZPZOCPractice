//
//  ZPZUINavgationBar.h
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/28.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZPZUINavgationBar : UIView

@property (nonatomic,strong,readonly) UIButton * leftButton;
@property (nonatomic,strong,readonly) UIImageView * leftImageView;
@property (nonatomic,strong,readonly) UILabel * titleLabel;
@property (nonatomic,strong,readonly) UIButton * rightButton;
@property (nonatomic,strong,readonly) UILabel * rightLabel;
@property (nonatomic,strong,readonly) UIImageView * rightImageView;
@property (nonatomic,strong,readonly) UIView * bottomLineView;

@end
