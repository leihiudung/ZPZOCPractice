//
//  ZPZLayerContentViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/26.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZLayerContentViewController.h"
#import "ZPZLayerContentView.h"

@interface ZPZLayerContentViewController ()<CALayerDelegate>

@property (nonatomic,strong) UIScrollView * scrollView;

@end

@implementation ZPZLayerContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)configUI{
    CGFloat beginY = 0;
    CGFloat space = 20;
    CGFloat width = self.view.frame.size.width;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, beginY, width, self.view.frame.size.height - 64)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:_scrollView];
    
    ZPZLayerContentView * layerContentView = [[ZPZLayerContentView alloc] initWithFrame:CGRectMake(0, beginY, width, 100)];
    layerContentView.backgroundColor = [UIColor orangeColor];
    layerContentView.layer.delegate = self;
    [_scrollView addSubview:layerContentView];
    
    [layerContentView.layer setNeedsDisplay];
    
    beginY = CGRectGetMaxY(_scrollView.frame);
    
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, beginY);
}

/**
 * 以下两个代理回调，displayLayer：的优先级最高，即两个都存在的时候会优先调用displayLayer：忽略drawLayer:inContext:
 * displayLayer：更适合于设置contents属性，调用layer的方法setNeedsDisplay可以触发
 * drawLayer:inContext:更适合于动态绘制(CGContextRef)，调用layer的方法setNeedsDisplay可以触发
 * 测试：分别注释不想运行的方法即可
 */
//- (void)displayLayer:(CALayer *)layer{
//    layer.backgroundColor = [UIColor orangeColor].CGColor;
//    layer.cornerRadius = layer.bounds.size.height / 2;
//}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    //    layer.backgroundColor = [UIColor orangeColor].CGColor;  //设置颜色不顶用
    //    self.backgroundColor = [UIColor orangeColor];   //设置颜色不顶用
    
    //绘制一个三角形
    CGContextMoveToPoint(ctx, layer.bounds.size.width / 2 - 20, layer.bounds.size.height / 2);
    CGContextAddLineToPoint(ctx, layer.bounds.size.width / 2 + 20, layer.bounds.size.height / 2);
    CGContextAddLineToPoint(ctx, layer.bounds.size.width / 2, layer.bounds.size.height / 2 - 20);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextClosePath(ctx);
    CGContextStrokePath(ctx);
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
