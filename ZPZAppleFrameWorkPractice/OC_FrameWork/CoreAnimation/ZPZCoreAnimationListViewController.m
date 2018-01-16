//
//  ZPZCoreAnimationListViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/26.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZCoreAnimationListViewController.h"
#import "ZPZChangeLayerViewController.h"
#import "ZPZTransitionViewController.h"
#import "ZPZPauseAndResumeViewController.h"

static NSString * title = @"title";
static NSString * type = @"type";

typedef NS_ENUM(NSInteger,ZPZCoreAnimationListType) {
    ZPZCoreAnimationListTypeDefault,
    ZPZCoreAnimationListTypeChangeDefaultLayer,
    ZPZCoreAnimationListTypeTransition,
    ZPZCoreAnimationListTypePauseAndResume,
};

@interface ZPZCoreAnimationListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,copy) NSArray<NSDictionary *> * dataSourceArr;

@end

@implementation ZPZCoreAnimationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
    [self configUI];
}

- (void)prepareData{
    _dataSourceArr = @[@{title:@"重写UIView的默认的layer",type:@(ZPZCoreAnimationListTypeChangeDefaultLayer)},
                       @{title:@"Transition",type:@(ZPZCoreAnimationListTypeTransition)},
                       @{title:@"Pause and Resume",type:@(ZPZCoreAnimationListTypePauseAndResume)},
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
    ZPZCoreAnimationListType listType = [_dataSourceArr[indexPath.row][type] integerValue];
    switch (listType) {
        case ZPZCoreAnimationListTypeChangeDefaultLayer:
            {
                ZPZChangeLayerViewController * changeVC = [[ZPZChangeLayerViewController alloc] init];
                [self.navigationController pushViewController:changeVC animated:YES];
            }
            break;
        case ZPZCoreAnimationListTypeTransition:{
            ZPZTransitionViewController * transitionVC = [[ZPZTransitionViewController alloc] init];
            [self.navigationController pushViewController:transitionVC animated:YES];
        }
            break;
        case ZPZCoreAnimationListTypePauseAndResume:{
            ZPZPauseAndResumeViewController * pauseAndResumeVC = [[ZPZPauseAndResumeViewController alloc] init];
            [self.navigationController pushViewController:pauseAndResumeVC animated:YES];
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
