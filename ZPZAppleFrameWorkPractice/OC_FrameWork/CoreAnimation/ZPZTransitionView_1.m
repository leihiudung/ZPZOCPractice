//
//  ZPZTransitionView_1.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/27.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZTransitionView_1.h"
//运行完的animation会自动被移除掉吗？
@interface ZPZTransitionView_1()<CAAnimationDelegate>

@property (nonatomic,strong) UIView * redView;
@property (nonatomic,strong) UIView * greenView;
@property (nonatomic,assign) NSInteger index;

@end

@implementation ZPZTransitionView_1

- (instancetype)initWithFrame:(CGRect)frame{
    frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    self = [super initWithFrame:frame];
    if (self) {
//        _transition = [CATransition animation];
//        _transition.type = kCATransitionMoveIn;
//        _transition.subtype = kCATransitionFromLeft;
//        _transition.startProgress = 0;
//        _transition.endProgress = 1;
//        _transition.delegate = self;
//        _transition.duration = 2;
        
        UIButton * toggleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        toggleButton.backgroundColor = [UIColor cyanColor];
        toggleButton.frame = CGRectMake(20, 20, self.frame.size.width - 2 * 20, 50);
        [toggleButton setTitle:@"Toggle red view" forState:UIControlStateNormal];
        [toggleButton addTarget:self action:@selector(toggleRedView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:toggleButton];
        
        _redView = [[UIView alloc] initWithFrame:CGRectMake(20, 80, self.frame.size.width - 2 * 20, 50)];
        _redView.backgroundColor = [UIColor redColor];
//        _redView.layer.speed = 10;   //这个也比较好玩儿，会影响duration
        [self addSubview:_redView];
        
        _greenView = [[UIView alloc] initWithFrame:CGRectMake(20, 140, self.frame.size.width - 2 * 20, 50)];
        _greenView.backgroundColor = [UIColor greenColor];
        [self addSubview:_greenView];
        
//        [_redView.layer addAnimation:_transition forKey:transitionKey];
//        [_greenView.layer addAnimation:_transition forKey:transitionKey];
        
        _redView.hidden = NO;
        _greenView.hidden = YES;
    }
    return self;
}

- (void)toggleRedView{
    //为什么可以一直添加
    CATransition * transition = [CATransition animation];
    transition.type = kCATransitionFade;
//    transition.subtype = kCATransitionFromLeft;
    transition.startProgress = 0;
    transition.endProgress = 1;
    transition.delegate = self;
    transition.duration = 1;
    
    [_redView.layer addAnimation:transition forKey:[NSString stringWithFormat:@"%@",@(_index)]];  //这个key貌似不起作用哎！
//    [_greenView.layer addAnimation:transition forKey:[NSString stringWithFormat:@"%@",@(_index)]];
    _redView.hidden = !_redView.hidden;
//    _greenView.hidden = !_redView.hidden;
    _index++;
}
//可以猜测一下下面的会打印出来几个结果，以及结果是什么
- (void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"%@",_redView.layer.animationKeys);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"%@",_redView.layer.animationKeys);
}

@end
