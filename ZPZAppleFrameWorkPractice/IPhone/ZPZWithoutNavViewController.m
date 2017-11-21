//
//  ZPZWithoutNavViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/28.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZWithoutNavViewController.h"
#import "ZPZUINavgationBar.h"
#import "ZPZCommonMethod.h"

@interface ZPZWithoutNavViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    ZPZUINavgationBar * bar;
}

@property (nonatomic,strong) UITableView * tableView;

@end

@implementation ZPZWithoutNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.view.backgroundColor = [UIColor orangeColor];
//    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
//    view.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:view];
    
    bar = [[ZPZUINavgationBar alloc] init];
    [bar.leftButton addTarget:self action:@selector(backPrevious) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bar];
    [self configTableView_01];
}

- (void)backPrevious{
    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController popToViewController:nil animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
//下面这种写法不可取
//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//}

- (void)configTableView_01{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bar.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(bar.frame)) style:UITableViewStylePlain];
    //    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight] + 10) style:UITableViewStylePlain];
    //    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight] - 10) style:UITableViewStylePlain];
//    _tableView.contentInset = UIEdgeInsetsMake(2 * [ZPZCommonMethod getStatusHeight], 0, 0, 0);
    _tableView.backgroundColor = [UIColor lightGrayColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
//    [self.view addSubview:_tableView];
    [self.view insertSubview:_tableView belowSubview:bar];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * flag = @"flag";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:flag];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

@end
