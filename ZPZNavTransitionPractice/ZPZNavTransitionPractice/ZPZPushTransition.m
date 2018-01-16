//
//  ZPZPushTransition.m
//  ZPZNavTransitionPractice
//
//  Created by zhoupengzu on 2017/11/22.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZPushTransition.h"

@implementation ZPZPushTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}
/**
 * 1、设置rootViewController的时候，并不会调用这里，但是会调用pushViewController方法
 * 2、在执行该方法的时候，toVC已经被添加到了导航栈中
 * push动画执行完成后，会将fromVC的view移除
 * 问题：1、为什么到了这里fromVC.view的尺寸在不是想要的
        2、为什么在这里需要将原来缩放的内容改回来；
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * containerView = transitionContext.containerView;
    NSTimeInterval timeInterval = [self transitionDuration:transitionContext];
    [containerView addSubview:toVC.view];
    toVC.view.frame = CGRectMake(containerView.frame.size.width, toVC.view.frame.origin.y, toVC.view.frame.size.width, toVC.view.frame.size.height);
    NSLog(@"%@",fromVC.navigationController.viewControllers);
    [UIView animateWithDuration:timeInterval animations:^{
        toVC.view.frame = CGRectMake(0, toVC.view.frame.origin.y, toVC.view.frame.size.width, toVC.view.frame.size.height);
        fromVC.view.transform = CGAffineTransformScale(fromVC.view.transform, 0.5, 0.5);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        fromVC.view.transform = CGAffineTransformScale(fromVC.view.transform, 2, 2);
        NSLog(@"%@",fromVC.navigationController.viewControllers);
    }];
}

@end
