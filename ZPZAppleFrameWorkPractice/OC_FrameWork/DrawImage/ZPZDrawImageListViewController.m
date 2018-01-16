//
//  ZPZDrawImageListViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/10/10.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZDrawImageListViewController.h"
#import "ZPZCommonMethod.h"
#import "ZPZDrawImage_UIImage_ViewController.h"
#import "ZPZDrawImage_CGImage_ViewController.h"
/**
 * 绘图的两种方式
 * 第一种方法就是创建一个图片类型的上下文。调用UIGraphicsBeginImageContextWithOptions函数就可获得用来处理图片的图形上下文。利用该上下文，你就可以在其上进行绘图，并生成图片。调用UIGraphicsGetImageFromCurrentImageContext函数可从当前上下文中获取一个UIImage对象。记住在你所有的绘图操作后别忘了调用UIGraphicsEndImageContext函数关闭图形上下文。
 
 * 第二种方法是利用cocoa为你生成的图形上下文。当你子类化了一个UIView并实现了自己的drawRect：方法后，一旦drawRect：方法被调用，Cocoa就会为你创建一个图形上下文，此时你对图形上下文的所有绘图操作都会显示在UIView上
 * 两大绘图框架（UIKit如UIImageView等和Core Graphics即QuartZ或QuartZ 2D）和三种获得图形上下文的方法（drawRect:、drawRect: inContext:、UIGraphicsBeginImageContextWithOptions）
 * 以上排列组合共六种方法
 */

/**
 * UIImage的CoreGraphics类型为CGImage
 * 一个CGImage对象可以让你获取原始图片中指定区域的图片（也可以获取指定区域外的图片，UIImage却办不到）
 */

static NSString * title = @"title";
static NSString * type = @"type";

typedef NS_ENUM(NSInteger,ZPZDrawImageListType) {
    ZPZDrawImageListTypeDefault,
    ZPZDrawImageListTypeUIImage,
    ZPZDrawImageListTypeCGImage,
};

@interface ZPZDrawImageListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,copy) NSArray<NSDictionary *> * dataSource;

@end

@implementation ZPZDrawImageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
    [self configUI];
}

- (void)prepareData{
    _dataSource = @[@{title:@"用UIImage绘制",type:@(ZPZDrawImageListTypeUIImage)},
                    @{title:@"用CGImage绘制",type:@(ZPZDrawImageListTypeCGImage)}
                    ];
}

- (void)configUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight]) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.tableFooterView = [UIView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * flag = @"draw_image";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:flag];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row >= _dataSource.count) {
        return cell;
    }
    cell.textLabel.text = _dataSource[indexPath.row][title];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row >= _dataSource.count) {
        return;
    }
    ZPZDrawImageListType listType = [_dataSource[indexPath.row][type] integerValue];
    switch (listType) {
        case ZPZDrawImageListTypeUIImage:
            {
                ZPZDrawImage_UIImage_ViewController * uiImageVC = [[ZPZDrawImage_UIImage_ViewController alloc] init];
                [self.navigationController pushViewController:uiImageVC animated:YES];
            }
            break;
        case ZPZDrawImageListTypeCGImage:{
            ZPZDrawImage_CGImage_ViewController * cgImageVC = [[ZPZDrawImage_CGImage_ViewController alloc] init];
            [self.navigationController pushViewController:cgImageVC animated:YES];
        }
        default:
            break;
    }
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
