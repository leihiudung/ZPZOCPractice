//
//  ZPZIPhoneXListViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/28.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZIPhoneListViewController.h"
#import "ZPZCommonMethod.h"
#import "ZPZWithoutNavViewController.h"
#import "ZPZTableViewTestViewController.h"

static NSString * title = @"title";
static NSString * type = @"type";

typedef NS_ENUM(NSInteger,ZPZIPhoneListType) {
    ZPZIPhoneListTypeDefault,
    ZPZIPhoneListTypeWithoutNav,
    ZPZIPhoneListTypeTableViewTest_NavTransulent,
    ZPZIPhoneListTypeTableViewTest_Nav,
};

@interface ZPZIPhoneListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,copy) NSArray<NSDictionary *> * dataSource;

@end

@implementation ZPZIPhoneListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
    [self configUI];
}

- (void)prepareData{
    _dataSource = @[@{title:@"隐藏导航栏",type:@(ZPZIPhoneListTypeWithoutNav)},
                    @{title:@"导航栏不透明时的UITableView",type:@(ZPZIPhoneListTypeTableViewTest_Nav)},
                    @{title:@"导航栏透明时的UITableView",type:@(ZPZIPhoneListTypeTableViewTest_NavTransulent)},
                    ];
}

- (void)configUI{
    CGFloat navAndStatusHeight = [ZPZCommonMethod getNavAndStatusHeight];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - navAndStatusHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * flag = @"iPhoneX";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:flag];
    if (cell == nil) {
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
    ZPZIPhoneListType listType = [_dataSource[indexPath.row][type] integerValue];
    switch (listType) {
        case ZPZIPhoneListTypeWithoutNav:
            {
                ZPZWithoutNavViewController * withOutVC = [[ZPZWithoutNavViewController alloc] init];
                [self.navigationController pushViewController:withOutVC animated:YES];
            }
            break;
        case ZPZIPhoneListTypeTableViewTest_Nav:{
            ZPZTableViewTestViewController * tableViewVC = [[ZPZTableViewTestViewController alloc] init];
            tableViewVC.isNavTranslent = NO;
            [self.navigationController pushViewController:tableViewVC animated:YES];
        }
            break;
        case ZPZIPhoneListTypeTableViewTest_NavTransulent:{
            ZPZTableViewTestViewController * tableViewVC = [[ZPZTableViewTestViewController alloc] init];
            tableViewVC.isNavTranslent = YES;
            [self.navigationController pushViewController:tableViewVC animated:YES];
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
