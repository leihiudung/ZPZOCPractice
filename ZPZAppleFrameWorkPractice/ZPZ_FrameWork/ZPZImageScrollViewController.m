//
//  ZPZImageScrollViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/10/19.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZImageScrollViewController.h"
#import "ZPZImageCycleScrollView.h"
#import "ZPZImageScrollModel.h"

@interface ZPZImageScrollViewController ()

@property (nonatomic,strong) NSMutableArray<ZPZImageScrollModel * > * cycleImageArr;

@end

@implementation ZPZImageScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
    [self configUI];
}

- (void)prepareData{
    _cycleImageArr = [NSMutableArray array];
//    NSArray * imgArr = @[@"scene01.jpg",@"scene02.jpg",@"scene03.jpg",@"scene04.jpg",@"scene05.jpg",@"scene06.jpg"];
    NSArray * imgArr = @[@"scene01.jpg"];
//    NSArray * imgArr = @[@"scene01.jpg",@"scene02.jpg"];
    [imgArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZPZImageScrollModel *scrollModel = [[ZPZImageScrollModel alloc] init];
        scrollModel.imgUrl = obj;
        [_cycleImageArr addObject:scrollModel];
    }];
}

- (void)configUI{
    ZPZImageCycleScrollView * cycleView = [[ZPZImageCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    [cycleView setContentMargin:20 withContentSpace:20];
    cycleView.direction = ZPZImageCycleDirectionUpDown;
    [self.view addSubview:cycleView];
    [cycleView updateImageCycleScrollViewContent:_cycleImageArr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
