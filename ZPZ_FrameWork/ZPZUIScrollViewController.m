//
//  ZPZUIScrollViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/10/20.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZUIScrollViewController.h"
#import "ZPZUIScrollView.h"

@interface ZPZUIScrollViewController ()

@end

@implementation ZPZUIScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZPZUIScrollView * scrollView = [[ZPZUIScrollView alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width - 2 * 20, 200)];
    scrollView.backgroundColor = [UIColor redColor];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 3, 0);
    [self.view addSubview:scrollView];
    scrollView.pageEnabled = YES;
    
    UIView * personalView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scrollView.frame.size.width, 50)];
    personalView.backgroundColor = [UIColor orangeColor];
    [scrollView addSubview:personalView];
    UIView * blueView = [[UIView alloc] initWithFrame:CGRectMake(scrollView.frame.size.width, 0, scrollView.frame.size.width, 50)];
    blueView.backgroundColor = [UIColor blueColor];
    [scrollView addSubview:blueView];
    UIView * greenView = [[UIView alloc] initWithFrame:CGRectMake(scrollView.frame.size.width * 2, 0, scrollView.frame.size.width, 50)];
    greenView.backgroundColor = [UIColor greenColor];
    [scrollView addSubview:greenView];
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
