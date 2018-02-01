//
//  AppDelegate.m
//  ZPZNetWorkPractice
//
//  Created by zhoupengzu on 2018/1/31.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler {
    self.backgroundSessionCompletionHandler = completionHandler;
}


@end
