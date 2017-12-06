//
//  ZPZTextView.h
//  ZPZCustomTextView
//
//  Created by zhoupengzu on 2017/12/6.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZPZTextView : UITextView

@property (nonatomic, strong, readonly) UILabel * placeHoldLabel;
@property (nonatomic, copy) NSString * placeHoldStr;
@property (nonatomic, strong) NSMutableAttributedString * placeHoldAttr;

- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;

@end
