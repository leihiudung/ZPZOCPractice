//
//  ZPZViewControllerAnimatedTransitioning.m
//  ZPZAlertViewController
//
//  Created by zhoupengzu on 2017/12/12.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZViewControllerPresentTransitioning.h"

@implementation ZPZViewControllerPresentTransitioning

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //因为当toView出现时，fromView会被移除，所以这里做一个屏幕截图，作为一个假象
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    UIView * snapView = [window snapshotViewAfterScreenUpdates:NO];
    
    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView * containerView = [transitionContext containerView];
    CGRect frame = [UIScreen mainScreen].bounds;
    toView.frame = CGRectMake(0, 0, 1, 1);
    toView.center = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    CGFloat scaleX = ceilf(CGRectGetWidth(frame));
    CGFloat scaleY = ceilf(CGRectGetHeight(frame));
    NSTimeInterval time = [self transitionDuration:transitionContext];
    [containerView addSubview:snapView];
    [containerView addSubview:toView];  //这句必须有
    [UIView animateWithDuration:time animations:^{
        toView.frame = CGRectMake(0, 0, scaleX, scaleY);
    } completion:^(BOOL finished) {
        toView.frame = CGRectMake(0, 0, scaleX, scaleY);
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled]; //这句必须有
    }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

@end
