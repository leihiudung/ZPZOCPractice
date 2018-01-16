//
//  ZPZCommonMethod.h
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/22.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZPZCommonMethod : NSObject
/**
 * 判断所给版本是否大于等于当前系统版本
 */
+ (BOOL)isCurrentVersionGreaterOrEqualVersion:(CGFloat)version;
/**
 * 是否需要新的通讯录框架
 */
+ (BOOL)isNeedNewContactFrameWork;
/**
 * 获取导航栏高度、状态栏高度
 */
+ (CGFloat)getStatusHeight;
+ (CGFloat)getNavHeight;
+ (CGFloat)getNavAndStatusHeight;

@end
