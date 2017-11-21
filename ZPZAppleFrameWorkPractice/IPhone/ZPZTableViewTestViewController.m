//
//  ZPZTableViewTestViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/10/11.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZTableViewTestViewController.h"
#import "ZPZCommonMethod.h"

//从以下实验可以看出：1、safeInset和frame距离vc上下左右有关，与导航栏是否隐藏无关，而adjustInset必定和contentInset有关，但是是否和safeInset相关要看contentInsetAdjustmentBehavior的设置

/**
 * 导航栏不透明的时候，tableView的高度需要减去状态栏和导航栏的高度
 * 导航栏透明的时候：
      如果不设置contentInsetAdjustmentBehavior，在iPhone X上会有自己调整的距离，有导航栏的时候是从导航栏下开始的
      如果设置了contentInsetAdjustmentBehavior为UIScrollViewContentInsetAdjustmentNever，则在iPhone X上会因为底部剪切掉一部分，有导航栏的时候是从屏幕左上角开始的
 */
@interface ZPZTableViewTestViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;

@end

@implementation ZPZTableViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //导航栏透明
    if (_isNavTranslent) {
        self.edgesForExtendedLayout = UIRectEdgeAll;
        self.view.backgroundColor = [UIColor orangeColor];
        [self configTableView_01_01];
//        [self configTableView_02_02];
//        [self configTableView_03_03];
//        [self configTableView_04_04];
    } else {
        //导航栏不透明
        [self configTableView_01];
//        [self configTableView_02];
//        [self configTableView_03];
//
//        [self configTableView_04];
//        [self configTableView_05];
//        [self configTableView_06];
    }
}
//NSLog(@"safeInset:%@,adjustInset:%@",NSStringFromUIEdgeInsets(_tableView.safeAreaInsets),NSStringFromUIEdgeInsets(_tableView.adjustedContentInset));
/**
 * 在iPhone X下，状态栏的高度为44，所以safeInset的上为44，导航栏没隐藏的情况下该高度会被忽略，而安全区域距离屏幕下边为34，所以safeInset的下为34
 * 在非iPhone X下，状态栏高度为20，所以safeInset的上为20，导航栏没隐藏的情况下该高度会被忽略，而安全区域是和屏幕下边重合的，所以safeInset的下为0
 */
//===========================================================================================================================
//方案一:contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentAtomic
/**
 * 在iPhone X之外，先打印：safeInset:{20, 0, 0, 0},adjustInset:{20, 0, 0, 0}，后打印：safeInset:{0, 0, 0, 0},adjustInset:{0, 0, 0, 0}
 * 在iPhone X上，先打印safeInset:{44, 0, 34, 0},adjustInset:{44, 0, 34, 0}，然后是safeInset:{0, 0, 34, 0},adjustInset:{0, 0, 34, 0}，可以看到其距离最下面都有34的安全区域（这个34会受frame的高度影响，如下面多减去10，可以再看看打印，都变成了24），但是无论怎样，这个高度最大为34
 */
- (void)configTableView_01{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight]) style:UITableViewStylePlain];
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight] + 10) style:UITableViewStylePlain];
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight] - 10) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor lightGrayColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}
/**
 * 导航栏透明的时候，无论怎么改，safeInset上为64或者88，下为34
 */
- (void)configTableView_01_01{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain]; //safeInset:{64, 0, 0, 0},adjustInset:{64, 0, 0, 0}或者safeInset:{88, 0, 34, 0},adjustInset:{88, 0, 34, 0}
    //    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight] + 10) style:UITableViewStylePlain];
//        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + 10) style:UITableViewStylePlain]; //safeInset:{64, 0, 0, 0},adjustInset:{64, 0, 0, 0}或safeInset:{88, 0, 34, 0},adjustInset:{88, 0, 34, 0}
    _tableView.backgroundColor = [UIColor lightGrayColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}
/**
 * 当有了contentInset时，safeInset不会改变，但是adjustInset会加上相应位置的inset
 * 在iPhone X下如果为contentInset = UIEdgeInsetsMake(10, 0, 10, 0)，则adjustInset={10, 0, 44, 0}，基本可以确定adjustInset=safeInset + contentInset
 * 在非iPhone X下，adjustInset={10, 0, 10, 0}
 */
- (void)configTableView_02{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight]) style:UITableViewStylePlain];
    //    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight] + 10) style:UITableViewStylePlain];
    //    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight] - 10) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor lightGrayColor];
    _tableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}
/**
 * 导航栏透明的时候，无论怎么改，safeInset上为64或者88，下为34
 * adjustInset=safeInset+contentInset
 */
- (void)configTableView_02_02{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    //    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight] + 10) style:UITableViewStylePlain];
    //    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight] - 10) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor lightGrayColor];
    _tableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}
/**
 * 当导航栏隐藏的时候，或者没有导航栏的时候，上下左右均会受frame的影响
 */
- (void)configTableView_03{
    self.navigationController.navigationBar.hidden = YES;
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];  //safeInset:{44, 0, 34, 0},adjustInset:{44, 0, 34, 0}
    //    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight] + 10) style:UITableViewStylePlain];
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 10) style:UITableViewStylePlain];  //safeInset:{44, 0, 24, 0},adjustInset:{44, 0, 24, 0}
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, self.view.frame.size.height - 20) style:UITableViewStylePlain];  //safeInset:{34, 0, 24, 0},adjustInset:{34, 0, 24, 0}
    _tableView.backgroundColor = [UIColor lightGrayColor];
//    _tableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}
/**
 * 当导航栏隐藏的时候，或者没有导航栏的时候，上下左右均会受frame的影响
 */
- (void)configTableView_03_03{
    self.navigationController.navigationBar.hidden = YES;
//        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];  //safeInset:{44, 0, 34, 0},adjustInset:{44, 0, 34, 0}
    //    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight] + 10) style:UITableViewStylePlain];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, self.view.frame.size.height - 10) style:UITableViewStylePlain];  //safeInset:{44, 0, 24, 0},adjustInset:{44, 0, 24, 0}
    _tableView.backgroundColor = [UIColor lightGrayColor];
    //    _tableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}
//============================================================================================================================
//方案二：contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//从下面可以看出，这个是的adjustInset不再受safeInset的影响，是的adjustInset=contentInset
//而safeInset始终是和距离最底部的距离相关
/**
 * 在iPhone X之外，打印：safeInset:{0, 0, 0, 0},adjustInset:{0, 0, 0, 0}
 * 在iPhone X上，打印safeInset:{0, 0, 34, 0},adjustInset:{0, 0, 0, 0}，可以看到其距离最下面都有34的安全区域（这个34会受frame的高度影响，如下面多减去10，可以再看看打印，safeInset变成了24），但是无论怎样，这个高度最大为34
 */
- (void)configTableView_04{
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight]) style:UITableViewStylePlain]; //safeInset:{0, 0, 34, 0},adjustInset:{0, 0, 0, 0}
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight] - 10) style:UITableViewStylePlain]; //safeInset:{0, 0, 24, 0},adjustInset:{0, 0, 0, 0}
    _tableView.backgroundColor = [UIColor lightGrayColor];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}
- (void)configTableView_04_04{
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain]; //safeInset:{0, 0, 34, 0},adjustInset:{0, 0, 0, 0}
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight] - 10) style:UITableViewStylePlain]; //safeInset:{0, 0, 24, 0},adjustInset:{0, 0, 0, 0}
    _tableView.backgroundColor = [UIColor lightGrayColor];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}
/**
 * 当有了contentInset时，safeInset不会改变，但是adjustInset会加上相应位置的inset
 * 在iPhone X下如果为contentInset = UIEdgeInsetsMake(10, 0, 10, 0)，则adjustInset={10, 0, 44, 0}，可以确定adjustInset= contentInset
 * 在非iPhone X下，adjustInset={10, 0, 10, 0}
 */
- (void)configTableView_05{
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [ZPZCommonMethod getNavAndStatusHeight]) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor lightGrayColor];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
//    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}
/**
 * 当导航栏隐藏的时候，或者没有导航栏的时候，safeInset的上始终为44或者20，下会受frame的影响，adjustInset上始终为0
 */
- (void)configTableView_06{
    self.navigationController.navigationBar.hidden = YES;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 10) style:UITableViewStylePlain];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    _tableView.backgroundColor = [UIColor lightGrayColor];
    //    _tableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (@available(iOS 11.0, *)) {
        NSLog(@"safeInset:%@,adjustInset:%@",NSStringFromUIEdgeInsets(_tableView.safeAreaInsets),NSStringFromUIEdgeInsets(_tableView.adjustedContentInset));
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
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
