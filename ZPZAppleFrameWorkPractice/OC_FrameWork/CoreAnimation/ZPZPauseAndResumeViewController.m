//
//  ZPZPauseAndResumeViewController.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/9/27.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZPauseAndResumeViewController.h"

@interface ZPZPauseAndResumeViewController ()<CAAnimationDelegate>

@property (nonatomic,strong) UIView * animationView;
@property (nonatomic,assign) BOOL isAnimation;

@end

@implementation ZPZPauseAndResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建两个button，暂停和播放
    UIButton * resumeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    resumeButton.backgroundColor = [UIColor greenColor];
    resumeButton.frame = CGRectMake(20, 20, self.view.frame.size.width - 2 * 20, 50);
    [resumeButton setTitle:@"resume" forState:UIControlStateNormal];
    [resumeButton addTarget:self action:@selector(clickedToResume) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resumeButton];
    
    UIButton * pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pauseButton.backgroundColor = [UIColor redColor];
    pauseButton.frame = CGRectMake(20, 80, self.view.frame.size.width - 2 * 20, 50);
    [pauseButton setTitle:@"pause" forState:UIControlStateNormal];
    [pauseButton addTarget:self action:@selector(clickedToPause) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pauseButton];
    
    _animationView = [[UIView alloc] initWithFrame:CGRectMake(20, 140, self.view.frame.size.width - 2 * 20, 50)];
    _animationView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_animationView];
    
    CABasicAnimation * basicAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    basicAnimation.fromValue = @(CGRectGetMidY(_animationView.frame));
    basicAnimation.toValue = @(250);
    basicAnimation.repeatCount = HUGE_VALF;
    basicAnimation.autoreverses = YES;
    basicAnimation.duration = 1;
    basicAnimation.delegate = self;
    [_animationView.layer addAnimation:basicAnimation forKey:@"pause_resume"];
    _isAnimation = YES;
}

- (void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"%@",_animationView.layer.animationKeys);
}

- (void)clickedToResume{
    if (_isAnimation) {
        return;
    }
    _isAnimation = YES;
    _animationView.layer.speed = 1;
    CFTimeInterval offsetInterval = _animationView.layer.timeOffset;
    _animationView.layer.timeOffset = 0;
    _animationView.layer.beginTime = [_animationView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - offsetInterval;
}

- (void)clickedToPause{
    if (!_isAnimation) {
        return;
    }
    _isAnimation = NO;
    
    CFTimeInterval timeInterval = [_animationView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    _animationView.layer.speed = 0;
    _animationView.layer.timeOffset = timeInterval;
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
