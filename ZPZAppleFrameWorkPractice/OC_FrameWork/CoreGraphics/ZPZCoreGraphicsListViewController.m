//
//  ZPZCoreGraphicsListViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/27.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZCoreGraphicsListViewController.h"
#import "ZPZCommonMethod.h"
#import "ZPZCoreGraphicsDrawRectViewController.h"
#import "ZPZCoreGraphicsBitMapViewController.h"
#import "ZPZCoreGraphicsPathViewController.h"
#import "ZPZCoreGraphicsColorSpaceViewController.h"
#import "ZPZCoreGraphicsTransformViewController.h"

static NSString * title = @"title";
static NSString * type = @"type";

typedef NS_ENUM(NSInteger,ZPZCoreGraphicsListType) {
    ZPZCoreGraphicsListTypeDefault,
    ZPZCoreGraphicsListTypeDrawRect,
    ZPZCoreGraphicsListTypeBitMap,
    ZPZCoreGraphicsListTypePath,
    ZPZCoreGraphicsListTypeColor_ColorSpace,
    ZPZCoreGraphicsListTypeTransform,
};

@interface ZPZCoreGraphicsListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,copy) NSArray<NSDictionary *> * dataSource;

@end

@implementation ZPZCoreGraphicsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
    [self configUI];
}

- (void)prepareData{
    _dataSource = @[@{title:@"使用View的DrawRect",type:@(ZPZCoreGraphicsListTypeDrawRect)},
                    @{title:@"CGBitmapContextCreate",type:@(ZPZCoreGraphicsListTypeBitMap)},
                    @{title:@"绘制path",type:@(ZPZCoreGraphicsListTypePath)},
                    @{title:@"Color-Color Spaces",type:@(ZPZCoreGraphicsListTypeColor_ColorSpace)},
                    @{title:@"Transform",type:@(ZPZCoreGraphicsListTypeTransform)},
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
    ZPZCoreGraphicsListType listType = [_dataSource[indexPath.row][type] integerValue];
    switch (listType) {
        case ZPZCoreGraphicsListTypeDrawRect:
        {
            ZPZCoreGraphicsDrawRectViewController * drawRectVC = [[ZPZCoreGraphicsDrawRectViewController alloc] init];
            [self.navigationController pushViewController:drawRectVC animated:YES];
        }
            break;
        case ZPZCoreGraphicsListTypeBitMap:{
            ZPZCoreGraphicsBitMapViewController * bitMapVC = [[ZPZCoreGraphicsBitMapViewController alloc] init];
            [self.navigationController pushViewController:bitMapVC animated:YES];
        }
            break;
        case ZPZCoreGraphicsListTypePath:{
            ZPZCoreGraphicsPathViewController * pathVC = [[ZPZCoreGraphicsPathViewController alloc] init];
            [self.navigationController pushViewController:pathVC animated:YES];
        }
            break;
        case ZPZCoreGraphicsListTypeColor_ColorSpace:{
            ZPZCoreGraphicsColorSpaceViewController * colorVC = [[ZPZCoreGraphicsColorSpaceViewController alloc] init];
            [self.navigationController pushViewController:colorVC animated:YES];
        }
            break;
        case ZPZCoreGraphicsListTypeTransform:{
            ZPZCoreGraphicsTransformViewController * tranformVC = [[ZPZCoreGraphicsTransformViewController alloc] init];
            [self.navigationController pushViewController:tranformVC animated:YES];
        }
        default:
            break;
    }
}


@end
