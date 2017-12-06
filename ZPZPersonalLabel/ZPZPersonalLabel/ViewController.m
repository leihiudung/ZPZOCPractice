//
//  ViewController.m
//  ZPZPersonalLabel
//
//  Created by zhoupengzu on 2017/12/6.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ViewController.h"
#import "ZPZLabel.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
//    [self configtableView];
    [self configLableView];
}

- (void)configLableView {
    ZPZLabel * tempLabel = [[ZPZLabel alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 100)];
    tempLabel.text = @"I am a label";
//    tempLabel.verticalAlignment = ZPZLabelVerticalTextAlignmentMiddle;
    tempLabel.font = [UIFont systemFontOfSize:20];
    tempLabel.backgroundColor = [UIColor orangeColor];
    tempLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:tempLabel];
}

- (void)configtableView {
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 88) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * flag = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:flag];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
        ZPZLabel * tempLabel = [[ZPZLabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        tempLabel.text = @"I am a label";
            tempLabel.verticalAlignment = ZPZLabelVerticalTextAlignmentTop;
        tempLabel.font = [UIFont systemFontOfSize:20];
        tempLabel.backgroundColor = [UIColor orangeColor];
        tempLabel.textAlignment = NSTextAlignmentCenter;
        
        [cell.contentView addSubview:tempLabel];
    }
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
