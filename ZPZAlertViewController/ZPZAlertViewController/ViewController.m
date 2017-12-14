//
//  ViewController.m
//  ZPZAlertViewController
//
//  Created by zhoupengzu on 2017/12/12.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ViewController.h"
#import "ZPZAlertViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIButton * showAlertButton = [UIButton buttonWithType:UIButtonTypeCustom];
    showAlertButton.frame = CGRectMake(20, 20, [UIScreen mainScreen].bounds.size.width - 2 * 20, 50);
    showAlertButton.backgroundColor = [UIColor orangeColor];
    [showAlertButton setTitle:@"show" forState:UIControlStateNormal];
    [showAlertButton addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showAlertButton];
    
    UIButton * showSysAlertButton = [UIButton buttonWithType:UIButtonTypeCustom];
    showSysAlertButton.frame = CGRectMake(20, 80, [UIScreen mainScreen].bounds.size.width - 2 * 20, 50);
    showSysAlertButton.backgroundColor = [UIColor orangeColor];
    [showSysAlertButton setTitle:@"showSys" forState:UIControlStateNormal];
    [showSysAlertButton addTarget:self action:@selector(showSysAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showSysAlertButton];
//    CABasicAnimation * basicAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    basicAni.fromValue = @(1);
//    basicAni.toValue = @(0.2);
//    basicAni.autoreverses = YES;
//    basicAni.repeatCount = MAXFLOAT;
//    UILabel * animateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, [UIScreen mainScreen].bounds.size.width - 2 * 20, 50)];
//    animateLabel.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:animateLabel];
//    [animateLabel.layer addAnimation:basicAni forKey:@"hahhaha"];
    
    UIButton * showAlertViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    showAlertViewButton.frame = CGRectMake(20, 150, [UIScreen mainScreen].bounds.size.width - 2 * 20, 50);
    showAlertViewButton.backgroundColor = [UIColor orangeColor];
    [showAlertViewButton setTitle:@"showAlertView" forState:UIControlStateNormal];
    [showAlertViewButton addTarget:self action:@selector(showAlertView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showAlertViewButton];
}

- (void)showAlert {
    ZPZAlertViewController * alertVC = [[ZPZAlertViewController alloc] init];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)showSysAlert {
    UIAlertController * sysVC = [UIAlertController alertControllerWithTitle:@"title" message:@"messagemessagemessagemessagemessagemessagemessagemessage" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [sysVC addAction:action];
    [self presentViewController:sysVC animated:YES completion:nil];
}
- (void)showAlertView {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
