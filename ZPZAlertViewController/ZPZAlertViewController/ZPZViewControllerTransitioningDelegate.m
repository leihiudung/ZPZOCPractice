//
//  ZPZViewControllerTransitioningDelegate.m
//  ZPZAlertViewController
//
//  Created by zhoupengzu on 2017/12/12.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZViewControllerTransitioningDelegate.h"
#import "ZPZViewControllerPresentTransitioning.h"
#import "ZPZViewControllerDismissTransitioning.h"

@implementation ZPZViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[ZPZViewControllerPresentTransitioning alloc] init];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[ZPZViewControllerDismissTransitioning alloc] init];
}

@end
