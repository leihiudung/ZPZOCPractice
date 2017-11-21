//
//  ZPZTransitionViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/27.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZTransitionViewController.h"
#import "ZPZTransitionView_1.h"

@interface ZPZTransitionViewController ()

@property (nonatomic,strong) UIScrollView * scrollView;

@end

@implementation ZPZTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTransitionView_1];
}

- (void)configTransitionView_1{
    ZPZTransitionView_1 * transitionView = [[ZPZTransitionView_1 alloc] init];
    transitionView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:transitionView];
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
