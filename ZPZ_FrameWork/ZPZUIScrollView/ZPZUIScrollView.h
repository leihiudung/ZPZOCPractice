//
//  ZPZUIScrollView.h
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/10/20.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * 自定义实现和UIScrollView一样的效果，利用UIScrollView的原理实现
 */
@interface ZPZUIScrollView : UIView

@property (nonatomic,assign) CGSize contentSize;
@property (nonatomic,assign) BOOL pageEnabled;

@end
