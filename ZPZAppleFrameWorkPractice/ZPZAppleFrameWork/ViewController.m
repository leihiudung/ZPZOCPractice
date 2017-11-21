//
//  ViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/19.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ViewController.h"
#import "ZPZAppleFrameWork-Swift.h"
#import "ZPZ_AB_CN_ViewController.h"
#import "ZPZRunTimeViewController.h"
#import "ZPZUIInitViewController.h"
#import "ZPZCoreAnimationListViewController.h"
#import "ZPZLayerListViewController.h"
#import "ZPZCoreGraphicsListViewController.h"
#import "ZPZIPhoneListViewController.h"
#import "ZPZDrawImageListViewController.h"
#import "ZPZFrameworkListViewController.h"
#import "ZPZSmallCaseViewController.h"

static NSString * title = @"title";
static NSString * type = @"type";

typedef NS_ENUM(NSInteger,ZPZListType) {
    ZPZListTypeDefult,
    ZPZListTypeAddressBook_Contact_Swift,
    ZPZListTypeAddressBook_Contact_OC,
    ZPZListTypeRunTime_OC,
    ZPZListTypeUIInit_OC,
    ZPZListTypeCoreAnimation_OC,
    ZPZListTypeLayer_OC,
    ZPZListTypeCoreGraphics_OC,
    ZPZListTypeIPhoneX_OC,
    ZPZListTypeDrawImage_OC,
    ZPZListTypeZPZFrameWork,
    ZPZListTypeSmallCase,
};

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,copy) NSArray<NSDictionary *> * dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"目录";
    [self prepareData];
    [self configTableView];
}

- (void)configTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor orangeColor];
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)prepareData{
    _dataSource = @[
                    @{title:@"通讯录-swift",type:@(ZPZListTypeAddressBook_Contact_Swift)},
                    @{title:@"通讯录-OC",type:@(ZPZListTypeAddressBook_Contact_OC)},
                    @{title:@"运行时-OC",type:@(ZPZListTypeRunTime_OC)},
                    @{title:@"UI初始化问题-OC",type:@(ZPZListTypeUIInit_OC)},
                    @{title:@"动画CoreAnimation-OC",type:@(ZPZListTypeCoreAnimation_OC)},
                    @{title:@"Layer-OC",type:@(ZPZListTypeLayer_OC)},
                    @{title:@"CoreGraphics-OC",type:@(ZPZListTypeCoreGraphics_OC)},
                    @{title:@"IPhone现象实验-OC",type:@(ZPZListTypeIPhoneX_OC)},
                    @{title:@"绘图-OC",type:@(ZPZListTypeDrawImage_OC)},
                    @{title:@"自定义工具",type:@(ZPZListTypeZPZFrameWork)},
                    @{title:@"小知识点",type:@(ZPZListTypeSmallCase)},
                    ];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * flag = @"category";
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
    ZPZListType listType = [[_dataSource[indexPath.row] objectForKey:type] integerValue];
    switch (listType) {
        case ZPZListTypeAddressBook_Contact_Swift:
        {
            ZPZAddressBookViewController * addressBookVC = [[ZPZAddressBookViewController alloc] init];
            [self.navigationController pushViewController:addressBookVC animated:YES];
        }
            break;
        case ZPZListTypeAddressBook_Contact_OC:{
            ZPZ_AB_CN_ViewController * ocVC = [[ZPZ_AB_CN_ViewController alloc] init];
            [self.navigationController pushViewController:ocVC animated:YES];
        }
            break;
        case ZPZListTypeRunTime_OC:{
            ZPZRunTimeViewController * runtimeVC = [[ZPZRunTimeViewController alloc] init];
            [self.navigationController pushViewController:runtimeVC animated:YES];
        }
            break;
        case ZPZListTypeUIInit_OC:{
            ZPZUIInitViewController * initVC = [[ZPZUIInitViewController alloc] init];
            [self.navigationController pushViewController:initVC animated:YES];
        }
            break;
        case ZPZListTypeCoreAnimation_OC:{
            ZPZCoreAnimationListViewController * animationVC = [[ZPZCoreAnimationListViewController alloc] init];
            [self.navigationController pushViewController:animationVC animated:YES];
        }
            break;
        case ZPZListTypeLayer_OC:{
            ZPZLayerListViewController * layerListVC = [[ZPZLayerListViewController alloc] init];
            [self.navigationController pushViewController:layerListVC animated:YES];
        }
            break;
        case ZPZListTypeCoreGraphics_OC:{
            ZPZCoreGraphicsListViewController * coreGraphicsVC = [[ZPZCoreGraphicsListViewController alloc] init];
            [self.navigationController pushViewController:coreGraphicsVC animated:YES];
        }
            break;
        case ZPZListTypeIPhoneX_OC:{
            ZPZIPhoneListViewController * iPhoneX = [[ZPZIPhoneListViewController alloc] init];
            [self.navigationController pushViewController:iPhoneX animated:YES];
        }
            break;
        case ZPZListTypeDrawImage_OC:{
            
            ZPZDrawImageListViewController * drawImageList = [[ZPZDrawImageListViewController alloc] init];
            [self.navigationController pushViewController:drawImageList animated:YES];
            
        }
            break;
        case ZPZListTypeZPZFrameWork:{
            ZPZFrameworkListViewController * frameVC = [[ZPZFrameworkListViewController alloc] init];
            [self.navigationController pushViewController:frameVC animated:YES];
        }
            break;
        case ZPZListTypeSmallCase:{
            ZPZSmallCaseViewController * smallCaseVC = [[ZPZSmallCaseViewController alloc] init];
            [self.navigationController pushViewController:smallCaseVC animated:YES];
        }
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
