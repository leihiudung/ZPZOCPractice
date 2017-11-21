//
//  ZPZImageCycleScrollView.h
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/10/18.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPZImageScrollManager.h"
/**
 * 循环滚动
 */

@class ZPZImageScrollModel;

@interface ZPZImageCycleScrollView : UIView
/**
 * contentImgWidth:图片宽度，默认和ZPZImageCycleScrollView宽度相等
 * contentImgSpace：图片之间的距离，默认为0
 * 注意⚠️：保证contentImgWidth+contentImgSpace不大于ZPZImageCycleScrollView的宽度width
 */
@property (nonatomic,copy) NSString * placeHolderImageStr;
- (void)setContentMargin:(CGFloat)margin withContentSpace:(CGFloat)contentSpace;
/**
 * 内容图片滑动方向，默认为横向滑动ZPZImageCycleDirectionLeftRight
 */
@property (nonatomic,assign) ZPZImageCycleDirection direction;
/**
 * 点击的当前图片
 * 返回图片的模型和点击的当前图片
 */
@property (nonatomic,copy) ClickedImage clickedImage;
/**
 * 建议使用该方法做初始化，目前暂不提供其他初始化方法的支持
 */
- (instancetype)initWithFrame:(CGRect)frame;
/**
 * cycleImageArr：滚动视图的内容
 */
- (void)updateImageCycleScrollViewContent:(NSArray<ZPZImageScrollModel *> *)cycleImageArr;

@end
