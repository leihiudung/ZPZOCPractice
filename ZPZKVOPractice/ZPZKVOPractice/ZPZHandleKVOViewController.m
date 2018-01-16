//
//  ZPZHandleKVOViewController.m
//  ZPZKVOPractice
//
//  Created by zhoupengzu on 2017/12/7.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZHandleKVOViewController.h"
#import "ZPZPersonModel.h"

@interface ZPZHandleKVOViewController ()

@property (nonatomic,assign) CGFloat btnWidth;
@property (nonatomic,assign) CGFloat btnHeight;
@property (nonatomic,assign) CGFloat btnBeginY;
@property (nonatomic,assign) CGFloat btnSpace;

@property (nonatomic, strong) ZPZPersonModel * personModel;

@end

@implementation ZPZHandleKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(changeArrayContent)];
    [self createUseButton];
}

#pragma - mark create button
- (void)createUseButton {
    _btnSpace = 15;
    NSInteger lineCount = 2;
    _btnWidth = ([UIScreen mainScreen].bounds.size.width - (lineCount + 1) * _btnSpace) / lineCount;
    if (_btnWidth < 0) {
        _btnWidth = 0;
    }
    _btnHeight = 50;
    NSString * titleKey = @"title";
    NSString * selKey = @"selKey";
    NSArray<NSDictionary *> * btnArray = @[
                                           @{titleKey:@"addKVOForModel",selKey:NSStringFromSelector(@selector(givePersonName))},
                                           ];
    for (NSInteger i = 0; i < btnArray.count; i++) {
        CGFloat beignX = (i % lineCount + 1) * _btnSpace + i % lineCount * _btnWidth;
        CGFloat beginY = (i / lineCount + 1) * _btnSpace + i / 2 * _btnHeight;
        CGRect frame = { { beignX, beginY },{ _btnWidth, _btnHeight } };
        NSString * title = btnArray[i][titleKey];
        NSString * selStr = btnArray[i][selKey];
        UIButton * button = [self createButtonWithFrame:frame andTitle:title andSelectorStr:selStr];
        [self.view addSubview:button];
    }
    [self addKVOForModel];
}

- (void)addKVOForModel {
    _personModel = [[ZPZPersonModel alloc] init];
    [_personModel addObserver:self forKeyPath:NSStringFromSelector(@selector(name)) options:NSKeyValueObservingOptionNew context:NULL];
    [_personModel addObserver:self forKeyPath:NSStringFromSelector(@selector(ID)) options:NSKeyValueObservingOptionNew context:NULL];
//    [_personModel addObserver:self forKeyPath:NSStringFromSelector(@selector(addName:andID:)) options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)givePersonName {
    _personModel.name = @"new name";
    [_personModel willChangeValueForKey:@"ID"];
    _personModel.ID = @"999";
    [_personModel didChangeValueForKey:@"ID"];
    [_personModel addName:@"zhou" andID:@"999"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@---%@",keyPath,change);
}

- (UIButton *)createButtonWithFrame:(CGRect)frame andTitle:(NSString *)title andSelectorStr:(NSString *)selStr {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:NSSelectorFromString(selStr) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor orangeColor];
    button.layer.cornerRadius = frame.size.height / 2;
    button.layer.masksToBounds = YES;
    return button;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_personModel removeObserver:self forKeyPath:NSStringFromSelector(@selector(name))];
    [_personModel removeObserver:self forKeyPath:NSStringFromSelector(@selector(ID))];
}

@end
