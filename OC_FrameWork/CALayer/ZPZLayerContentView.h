//
//  ZPZLayerContentView.h
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/26.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 为layer添加内容的三种方法：
 * 1、直接给contents属性设置一个图片，适合于内容不做改变的情况
 * 2、实现layer的代理，适用于可以通过外界获取到内容的情况(在ZPZLayerContentViewController中查看情况)
 * 3、子类，适用于想改变一些layer的固有操作行为或者想创建一个个性的layer（不推荐使用）
 */

@interface ZPZLayerContentView : UIView

@end
