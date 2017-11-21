//
//  ZPZUITableViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/10/23.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZUITableViewController.h"
#import "ZPZUITableView.h"
#import "ZPZUITableViewCell.h"
#import "ZPZCommonMethod.h"

@interface ZPZUITableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;

@end

@implementation ZPZUITableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
//    [self configSystemTableView];
}

- (void)configUI{
    ZPZUITableView * tableView = [[ZPZUITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight])];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.numberOfRows = ^NSInteger(ZPZUITableView *tableView, NSInteger section) {
        return 20;
    };
    tableView.heightForRowAtIndexPath = ^CGFloat(ZPZUITableView *tableView, NSIndexPath *indexPath) {
        return 50;
    };
    tableView.cellForRowAtIndexPath = ^ZPZUITableViewCell *(ZPZUITableView *tableView, NSIndexPath *indexPath) {
        static NSString * flag = @"zpz";
        ZPZUITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:flag];
        if (cell == nil) {
            NSLog(@"nil again");
            cell = [[ZPZUITableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50) andIdentifier:flag];
        }
        cell.textLabel.text = @(indexPath.row).stringValue;
        return cell;
    };
    [self.view addSubview:tableView];
    [tableView reloadData];
}

- (void)configSystemTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight]) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"flag"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"flag"];
    }
    NSLog(@"%s----%@",__FUNCTION__,@(indexPath.row));
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"flag"];  //cell为nil
    NSLog(@"%@",@([_tableView indexPathForCell:cell].row));
}

@end
