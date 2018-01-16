//
//  AppDelegate.h
//  ZPZRunLoopPractice
//
//  Created by zhoupengzu on 2017/12/22.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZPZRunLoopContext;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)registerSource:(ZPZRunLoopContext *)sourceInfo;
- (void)removeSource:(ZPZRunLoopContext *)sourceInfo;

@end

