//
//  ZPZUIInitLayerCover_Q_ViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/26.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZUIInitLayerCover_Q_ViewController.h"
#import "ZPZLayerCover_01_Label.h"

@interface ZPZUIInitLayerCover_Q_ViewController ()

@end

@implementation ZPZUIInitLayerCover_Q_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    ZPZLayerCover_01_Label * label = [[ZPZLayerCover_01_Label alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width - 2 * 20, self.view.frame.size.height - 2 * 20 - 64)];
    label.backgroundColor = [UIColor redColor];
    [self.view addSubview:label];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
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
