//
//  ZPZChangeLayerViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/26.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZChangeLayerViewController.h"
#import "ZPZChangeLayerView.h"

/*
 打印【changeView layer】得到：
 <CALayer:0x6040002246e0; position = CGPoint (333.5 70); bounds = CGRect (0 0; 627 100); delegate = <ZPZChangeLayerView: 0x7fa7b020f200; frame = (20 20; 627 100); layer = <CALayer: 0x6040002246e0>>; opaque = YES; allowsGroupOpacity = YES; >
 可以看出layer和view是通过设置代理联系在一起的
 */

@interface ZPZChangeLayerViewController ()

@end

@implementation ZPZChangeLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZPZChangeLayerView * changeView = [[ZPZChangeLayerView alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width - 2 * 20, 100)];
    //注意：这里没有设置背景色
    changeView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:changeView];
    NSLog(@"%@",changeView.layer);  //会打印 <CAGradientLayer: 0x60800023c620>，和下面使用默认的返回不一样，所以修改了
    UIView * defaultView = [[UIView alloc] initWithFrame:CGRectMake(20, 140, self.view.frame.size.width - 2 * 20, 100)];
    defaultView.backgroundColor = [UIColor redColor];
    [self.view addSubview:defaultView];
    NSLog(@"%@",defaultView.layer);  //会打印 <CALayer: 0x60800023c620>
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
