//
//  ZPZUITableViewCell.h
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/10/23.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZPZUITableViewCell : UIView

@property (nonatomic,copy,readonly) NSString * identifier;
@property (nonatomic,strong,readonly) UILabel * textLabel;

- (instancetype)initWithFrame:(CGRect)frame andIdentifier:(NSString *)identifier;

@end
