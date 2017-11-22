//
//  ZPZPersonalNavViewController.m
//  ZPZNavTransitionPractice
//
//  Created by zhoupengzu on 2017/11/22.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZPersonalNavViewController.h"
#import "ZPZPopTransition.h"
#import "ZPZPushTransition.h"

@interface ZPZPersonalNavViewController ()<UINavigationControllerDelegate>

@end

@implementation ZPZPersonalNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        return [[ZPZPushTransition alloc] init];
    } else if (operation == UINavigationControllerOperationPop ) {
        return [[ZPZPopTransition alloc] init];
    }
    return nil;
}
//不会执行
- (void)addChildViewController:(UIViewController *)childController{
    [super addChildViewController:childController];
    NSLog(@"%@",childController);
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"%@",self.viewControllers);
    [super pushViewController:viewController animated:animated];
    NSLog(@"%@",viewController);
    NSLog(@"%sself.viewControllers%@",__func__,self.viewControllers);
    NSLog(@"self.childViewControllers:%@",self.childViewControllers);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
