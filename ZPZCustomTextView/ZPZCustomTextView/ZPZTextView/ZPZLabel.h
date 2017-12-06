//
//  ZPZLabel.h
//  ZPZPersonalLabel
//
//  Created by zhoupengzu on 2017/12/6.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ZPZLabelVerticalTextAlignment){
    ZPZLabelVerticalTextAlignmentMiddle,
    ZPZLabelVerticalTextAlignmentTop,
    ZPZLabelVerticalTextAlignmentBottom
};

@interface ZPZLabel : UILabel

@property (nonatomic, assign) ZPZLabelVerticalTextAlignment verticalAlignment;

@end
