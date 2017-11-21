//
//  ZPZ_AB_CN_ViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/22.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZ_AB_CN_ViewController.h"
#import "ZPZ_AB_CN_UIViewController.h"
#import "ZPZ_AB_CN_DataViewController.h"

static NSString * title = @"title";
static NSString * type = @"type";

typedef NS_ENUM(NSInteger,ContactsEntryStatus) {
    ADDRESS_BOOK_CONTACT_UI,
    ADDRESS_BOOK_CONTACT_DATA
};

@interface ZPZ_AB_CN_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,copy) NSArray<NSDictionary *> * dataSource;

@end

@implementation ZPZ_AB_CN_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self prepareData];
    [self configUI];
}

- (void)prepareData{
    _dataSource = @[
                    @{title:@"AddressBook和Contacts--联系人UI",type:@(ADDRESS_BOOK_CONTACT_UI)},
                    @{title:@"AddressBook和Contacts--联系人数据",type:@(ADDRESS_BOOK_CONTACT_DATA)}
                    ];
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
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * flag = @"oc";
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
    ContactsEntryStatus status = [_dataSource[indexPath.row][type] integerValue];
    switch (status) {
        case ADDRESS_BOOK_CONTACT_UI:
            {
                ZPZ_AB_CN_UIViewController * uiVC = [[ZPZ_AB_CN_UIViewController alloc] init];
                [self.navigationController pushViewController:uiVC animated:YES];
            }
            break;
        case ADDRESS_BOOK_CONTACT_DATA:{
            ZPZ_AB_CN_DataViewController * dataVC = [[ZPZ_AB_CN_DataViewController alloc] init];
            [self.navigationController pushViewController:dataVC animated:YES];
        }
            break;
            
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
