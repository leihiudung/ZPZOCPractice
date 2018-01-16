//
//  ZPZPopTransition.m
//  ZPZNavTransitionPractice
//
//  Created by zhoupengzu on 2017/11/22.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZPopTransition.h"

@implementation ZPZPopTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * containerView = transitionContext.containerView;
    NSTimeInterval timeInterval = [self transitionDuration:transitionContext];
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    toVC.view.transform = CGAffineTransformScale(fromVC.view.transform, 0.5, 0.5);
    [UIView animateWithDuration:timeInterval animations:^{
        toVC.view.transform = CGAffineTransformIdentity;
        fromVC.view.frame = CGRectMake(containerView.frame.size.width, fromVC.view.frame.origin.y, fromVC.view.frame.size.width, fromVC.view.frame.size.height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
