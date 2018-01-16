//
//  ZPZViewControllerDismissTransitioning.m
//  ZPZAlertViewController
//
//  Created by zhoupengzu on 2017/12/12.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZViewControllerDismissTransitioning.h"

@implementation ZPZViewControllerDismissTransitioning

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * containerView = transitionContext.containerView;
    toVC.view.frame = CGRectMake(0, 0, toVC.view.frame.size.width, toVC.view.frame.size.height);
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    NSTimeInterval time = [self transitionDuration:transitionContext];
    CGRect frame = [UIScreen mainScreen].bounds;
    [UIView animateWithDuration:time animations:^{
        fromVC.view.frame = CGRectMake(0, 0, 1, 1);
        fromVC.view.center = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    } completion:^(BOOL finished) {
        [fromVC.view removeFromSuperview];
        [transitionContext completeTransition:!(transitionContext.transitionWasCancelled)];
    }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

@end
