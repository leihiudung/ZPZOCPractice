//
//  ZPZRunTimeViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/25.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZRunTimeViewController.h"
#import "ZPZRunTimeMsgSendViewController.h"

static NSString * title = @"title";
static NSString * type = @"type";

typedef NS_ENUM(NSInteger,ZPZRunTimeListType) {
    ZPZRunTimeListTypeDefault,
    ZPZRunTimeListTypeMsgSend,
};

@interface ZPZRunTimeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,copy) NSArray<NSDictionary *> * dataSource;

@end

@implementation ZPZRunTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self prepareData];
    [self configUI];
}

- (void)prepareData{
    _dataSource = @[
                    @{title:@"Objc_MsgSend",type:@(ZPZRunTimeListTypeMsgSend)}
                    ];
}

- (void)configUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * flag = @"runtime_oc";
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
    
    ZPZRunTimeListType listType = [[_dataSource[indexPath.row] objectForKey:type] integerValue];
    switch (listType) {
        case ZPZRunTimeListTypeMsgSend:
        {
            ZPZRunTimeMsgSendViewController * msgSendVC = [[ZPZRunTimeMsgSendViewController alloc] init];
            [self.navigationController pushViewController:msgSendVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

@end
