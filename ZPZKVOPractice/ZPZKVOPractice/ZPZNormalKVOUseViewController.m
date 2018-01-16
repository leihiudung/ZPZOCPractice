//
//  ZPZNormalKVOUseViewController.m
//  ZPZKVOPractice
//
//  Created by zhoupengzu on 2017/12/7.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZNormalKVOUseViewController.h"
#import "ZPZPersonModel.h"

const char * personContext = "person";

@interface ZPZNormalKVOUseViewController ()

@property (nonatomic,assign) CGFloat btnWidth;
@property (nonatomic,assign) CGFloat btnHeight;
@property (nonatomic,assign) CGFloat btnBeginY;
@property (nonatomic,assign) CGFloat btnSpace;

@property (nonatomic, strong) ZPZPersonModel * personModel;
@property (nonatomic, strong) NSMutableArray * array;

@end

@implementation ZPZNormalKVOUseViewController

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
                                           @{titleKey:@"addKVOForArray",selKey:NSStringFromSelector(@selector(changeArrayContent))},
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
    [self addKVOForArray];
}

- (void)normalKVOUse {
    ZPZNormalKVOUseViewController * normalVC = [[ZPZNormalKVOUseViewController alloc] init];
    [self.navigationController pushViewController:normalVC animated:YES];
}

- (void)addKVOForModel {
    _personModel = [[ZPZPersonModel alloc] init];
    
    [_personModel addObserver:self forKeyPath:NSStringFromSelector(@selector(name)) options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionPrior context:&personContext];
    [_personModel addObserver:self forKeyPath:NSStringFromSelector(@selector(age)) options:NSKeyValueObservingOptionOld context:&personContext];
    _personModel.ID = @"xxxxxxxxxxxxxxxxxxxxxxxx";
    [_personModel addObserver:self forKeyPath:NSStringFromSelector(@selector(ID)) options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:&personContext];
    [_personModel addObserver:self forKeyPath:NSStringFromSelector(@selector(ID)) options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:&personContext];
    [_personModel addObserver:self forKeyPath:NSStringFromSelector(@selector(height)) options:NSKeyValueObservingOptionPrior context:&personContext];
//    NSLog(@"before:%p",_personModel);
    id info = _personModel.observationInfo;
    NSLog(@"%@",info);
}

- (void)addKVOForArray {
    _array = [NSMutableArray array];
    [_array addObjectsFromArray:@[@"zhou",@"peng",@"zu"]];
    //效率更高
    [_array addObserver:self toObjectsAtIndexes:[NSIndexSet indexSetWithIndex:0] forKeyPath:NSStringFromSelector(@selector(stringByAppendingString:)) options:NSKeyValueObservingOptionNew context:NULL];
//    [_array addObserver:self forKeyPath:NSStringFromSelector(@selector(replaceObjectAtIndex:withObject:)) options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)givePersonName {
    _personModel.ID = @"new name";
}

- (void)changeArrayContent {
    NSString * str = _array[1];
    str = [str stringByAppendingString:@"KVO"];
    [_array replaceObjectAtIndex:1 withObject:str];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@--%@",keyPath,change);
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
