//
//  AppDelegate.m
//  ZPZRunLoopPractice
//
//  Created by zhoupengzu on 2017/12/22.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ZPZRunLoopContext.h"

@interface AppDelegate ()

@property (nonatomic, strong) NSMutableArray<ZPZRunLoopContext * > * source;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    ViewController * rootVC = [[ViewController alloc] init];
    UINavigationController * rootNav = [[UINavigationController alloc] initWithRootViewController:rootVC];
    _window.rootViewController = rootNav;
    [_window makeKeyAndVisible];
    _source = [NSMutableArray array];
    return YES;
}

- (void)registerSource:(ZPZRunLoopContext *)sourceInfo {
    if (sourceInfo) {
        [_source addObject:sourceInfo];
    }
}

- (void)removeSource:(ZPZRunLoopContext *)sourceInfo {
    __block ZPZRunLoopContext * contextToRemove = nil;
    [_source enumerateObjectsUsingBlock:^(ZPZRunLoopContext * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqual:sourceInfo]) {
            contextToRemove = obj;
            *stop = YES;
        }
    }];
    if (contextToRemove) {
        [_source removeObject:contextToRemove];
    }
}


@end
