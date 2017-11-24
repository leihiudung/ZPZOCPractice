//
//  ViewController.m
//  ZPZCoreTextPractice
//
//  Created by zhoupengzu on 2017/11/23.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>
#import "ZPZLayout01View.h"
#import "ZPZCommonMethod.h"
#import "ZPZDrawSingleLineView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    CTFramesetterRef
//    CTTypesetterRef
//    CTFrameRef
//    CTLineRef
//    CTRun
//    CTFontRef
    [self drawLineRef];
}

- (void)drawFrameRef{
    ZPZLayout01View * view = [[ZPZLayout01View alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - [ZPZCommonMethod getNavAndStatusHeight])];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}

- (void)drawLineRef{
    ZPZDrawSingleLineView * lineView = [[ZPZDrawSingleLineView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - [ZPZCommonMethod getNavAndStatusHeight])];
    lineView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
