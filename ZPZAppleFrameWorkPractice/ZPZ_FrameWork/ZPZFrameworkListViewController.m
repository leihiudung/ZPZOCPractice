//
//  ZPZFrameworkListViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/10/19.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZFrameworkListViewController.h"
#import "ZPZCommonMethod.h"
#import "ZPZImageScrollViewController.h"
#import "ZPZUIScrollViewController.h"
#import "ZPZUITableViewController.h"

static NSString * title = @"title";
static NSString * type = @"type";

typedef NS_ENUM(NSInteger,ZPZFrameworkListType) {
    ZPZFrameworkListTypeDefault,
    ZPZFrameworkListTypeImageCycle_OC,
    ZPZFrameworkListTypeUIScrollView,
    ZPZFrameworkListTypeUITableView,
};

@interface ZPZFrameworkListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,copy) NSArray<NSDictionary *> * dataSourceArr;

@end

@implementation ZPZFrameworkListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
    [self configUI];
}

- (void)prepareData{
    _dataSourceArr = @[@{title:@"图片循环播放",type:@(ZPZFrameworkListTypeImageCycle_OC)},
                       @{title:@"自己实现UIScrollView效果",type:@(ZPZFrameworkListTypeUIScrollView)},
                       @{title:@"自己实现UITableView效果",type:@(ZPZFrameworkListTypeUITableView)},
                       ];
}

- (void)configUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight]) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString * flag = @"flag";
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

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row >= _dataSourceArr.count) {
        return;
    }
    ZPZFrameworkListType listType = [_dataSourceArr[indexPath.row][type] integerValue];
    switch (listType) {
        case ZPZFrameworkListTypeImageCycle_OC:
        {
            ZPZImageScrollViewController * imageScrollVC = [[ZPZImageScrollViewController alloc] init];
            [self.navigationController pushViewController:imageScrollVC animated:YES];
        }
            break;
        case ZPZFrameworkListTypeUIScrollView:{
            ZPZUIScrollViewController * scrollVC = [[ZPZUIScrollViewController alloc] init];
            [self.navigationController pushViewController:scrollVC animated:YES];
        }
            break;
        case ZPZFrameworkListTypeUITableView:{
            ZPZUITableViewController * tableViewVC = [[ZPZUITableViewController alloc] init];
            [self.navigationController pushViewController:tableViewVC animated:YES];
        }
        default:
            break;
    }
}

@end
