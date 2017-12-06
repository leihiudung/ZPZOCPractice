//
//  ZPZTextView.h
//  ZPZCustomTextView
//
//  Created by zhoupengzu on 2017/12/6.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPZLabel.h"

@interface ZPZTextView : UITextView

@property (nonatomic, strong, readonly) ZPZLabel * placeHoldLabel;
@property (nonatomic, copy) NSString * placeHoldStr;
@property (nonatomic, strong) NSAttributedString * placeHoldAttr;

- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;

@end
