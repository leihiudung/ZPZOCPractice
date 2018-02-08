//
//  AppDelegate.h
//  ZPZNetWorkPractice
//
//  Created by zhoupengzu on 2018/1/31.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (copy, nonatomic) void(^backgroundSessionCompletionHandler)(void);

@end

