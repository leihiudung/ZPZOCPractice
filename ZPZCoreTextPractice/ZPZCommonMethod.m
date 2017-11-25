//
//  ZPZCommonMethod.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/22.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZCommonMethod.h"
#import "AppDelegate.h"
//#import "Reachability.h"
//#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@implementation ZPZCommonMethod

+ (BOOL)isCurrentVersionGreaterOrEqualVersion:(CGFloat)version{
    BOOL result = NO;
    CGFloat currentVersion = [[UIDevice currentDevice].systemVersion floatValue];
    result = currentVersion >= version;
    return NO;
}

+ (BOOL)isNeedNewContactFrameWork{
    if ([ZPZCommonMethod isCurrentVersionGreaterOrEqualVersion:9.0]) {
        return YES;
    }else{
        return NO;
    }
}

+ (CGFloat)getStatusHeight{
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

+ (CGFloat)getNavHeight{
    id delegate = [UIApplication sharedApplication].delegate;
    if ([delegate isKindOfClass:[AppDelegate class]]) {
        AppDelegate * tempDelegate = (AppDelegate *)delegate;
        UIViewController * rootViewController = tempDelegate.window.rootViewController;
        if ([rootViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController * tempNav = (UINavigationController *)rootViewController;
            return tempNav.navigationBar.frame.size.height;
        }else if ([rootViewController isKindOfClass:[UITabBarController class]]){
            UIViewController * selectedVC = [(UITabBarController *)rootViewController selectedViewController];
            if ([selectedVC isKindOfClass:[UINavigationController class]]) {
                UINavigationController * tempNav = (UINavigationController *)selectedVC;
                return tempNav.navigationBar.frame.size.height;
            }else if(selectedVC.navigationController){
                return selectedVC.navigationController.navigationBar.frame.size.height;
            }
        }
    }
    return 0;
}

+ (CGFloat)getNavAndStatusHeight{
    return [ZPZCommonMethod getNavHeight] + [ZPZCommonMethod getStatusHeight];
}

//+ (NSString *)networkStatus {
//    NSString * status = @"";
//    NetworkStatus netStatus = [[Reachability reachabilityForInternetConnection]currentReachabilityStatus];
//    if (netStatus == ReachableViaWiFi) {
//        status = @"WiFi";
//
//    } else if(netStatus == NotReachable) {
//        status = @"无网络";
//    } else {
//        NSArray *typeStrings2G = @[CTRadioAccessTechnologyEdge, CTRadioAccessTechnologyGPRS, CTRadioAccessTechnologyCDMA1x];
//
//        NSArray *typeStrings3G = @[CTRadioAccessTechnologyHSDPA,
//                                   CTRadioAccessTechnologyWCDMA,
//                                   CTRadioAccessTechnologyHSUPA,
//                                   CTRadioAccessTechnologyCDMAEVDORev0,
//                                   CTRadioAccessTechnologyCDMAEVDORevA,
//                                   CTRadioAccessTechnologyCDMAEVDORevB,
//                                   CTRadioAccessTechnologyeHRPD];
//
//        NSArray *typeStrings4G = @[CTRadioAccessTechnologyLTE];
//
//        CTTelephonyNetworkInfo *teleInfo= [[CTTelephonyNetworkInfo alloc] init];
//        NSString *accessString = teleInfo.currentRadioAccessTechnology;
//        if ([typeStrings4G containsObject:accessString]) {
//            status = @"4G";
//        } else if ([typeStrings3G containsObject:accessString]) {
//            status = @"3G";
//        } else if ([typeStrings2G containsObject:accessString]) {
//            status = @"2G";
//        } else {
//            status = @"未知网络";
//        }
//    }
//    return status;
//}

@end
