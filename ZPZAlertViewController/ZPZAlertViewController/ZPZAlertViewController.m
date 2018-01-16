//
//  ZPZAlertViewController.m
//  ZPZAlertViewController
//
//  Created by zhoupengzu on 2017/12/12.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZAlertViewController.h"
#import "ZPZViewControllerTransitioningDelegate.h"

@interface ZPZAlertViewController ()
{
    ZPZViewControllerTransitioningDelegate * delegate;   //注意：这里必须定义为全局的变量或者属性，否则不起作用，因为被释放了
}

@property (nonatomic, strong) UIView * bacView;

@end

@implementation ZPZAlertViewController

@synthesize dimColor = _dimColor;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareInitData];
    [self configBacView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self configUI];
}

- (void)prepareInitData {
    self.view.backgroundColor = [UIColor clearColor];
    delegate = [[ZPZViewControllerTransitioningDelegate alloc] init];
    self.transitioningDelegate = delegate;
    self.view.clipsToBounds = YES;
}

- (void)configUI {
    UIButton * showAlertButton = [UIButton buttonWithType:UIButtonTypeCustom];
    showAlertButton.frame = CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width - 2 * 20, 50);
    showAlertButton.backgroundColor = [UIColor greenColor];
    [showAlertButton setTitle:@"show" forState:UIControlStateNormal];
    [showAlertButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showAlertButton];
}

- (void)configBacView {
    _bacView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    _bacView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_bacView];
    [self updateBacView];
}

#pragma mark - update
- (void)updateBacView {
    _bacView.backgroundColor = self.dimColor;
}

#pragma mark - setter & getter
- (void)setDimColor:(UIColor *)dimColor {
    if (dimColor == nil) {
        dimColor = [self getDefaultDimColor];
    }
    _dimColor = dimColor;
    [self updateBacView];
}

- (UIColor *)dimColor {
    if (_dimColor == nil) {
        _dimColor = [self getDefaultDimColor];
    }
    return _dimColor;
}
                    
- (UIColor *)getDefaultDimColor {
    return [UIColor colorWithWhite:0 alpha:0.4];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}
                                
                                

- (void)dealloc {
    NSLog(@"%s",__func__);
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
