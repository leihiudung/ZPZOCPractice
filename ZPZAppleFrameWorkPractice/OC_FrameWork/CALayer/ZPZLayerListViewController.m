//
//  ZPZLayerListViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/27.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZLayerListViewController.h"
#import "ZPZLayerContentViewController.h"
#import "ZPZChangeLayerViewController.h"

static NSString * title = @"title";
static NSString * type = @"type";

typedef NS_ENUM(NSInteger,ZPZLayerListType) {
    ZPZLayerListTypeDefault,
    ZPZLayerListTypeChangeLayer,
    ZPZLayerListTypeLayerContent,
};

@interface ZPZLayerListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,copy) NSArray<NSDictionary *> * dataSourceArr;

@end

@implementation ZPZLayerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
    [self configUI];
}

- (void)prepareData{
    _dataSourceArr = @[@{title:@"修改UIView的默认的layer",type:@(ZPZLayerListTypeChangeLayer)},
                       @{title:@"重写UIView的默认的layer的展示",type:@(ZPZLayerListTypeLayerContent)}];
}

- (void)configUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * flag = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:flag];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row >= _dataSourceArr.count) {
        return cell;
    }
    cell.textLabel.text = _dataSourceArr[indexPath.row][title];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row >= _dataSourceArr.count) {
        return;
    }
    ZPZLayerListType listType = [_dataSourceArr[indexPath.row][type] integerValue];
    switch (listType) {
        case ZPZLayerListTypeChangeLayer:
        {
            ZPZChangeLayerViewController * changeVC = [[ZPZChangeLayerViewController alloc] init];
            [self.navigationController pushViewController:changeVC animated:YES];
        }
            break;
        case ZPZLayerListTypeLayerContent:{
            ZPZLayerContentViewController * contentVC = [[ZPZLayerContentViewController alloc] init];
            [self.navigationController pushViewController:contentVC animated:YES];
        }
            
        default:
            break;
    }
}

@end
