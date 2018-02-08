//
//  ZPZEphemeralSessionViewController.m
//  ZPZNetWorkPractice
//
//  Created by zhoupengzu on 2018/1/31.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZEphemeralSessionViewController.h"

#define kRequest1 @"http://rap2api.taobao.org/app/mock/5106/GET/userInfoList"

@interface ZPZEphemeralSessionViewController ()<NSURLSessionDataDelegate>

@end

@implementation ZPZEphemeralSessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    self.title = @"Ephemeral Session";
    [self test];
}

- (void)test {
    NSURLSessionConfiguration * ephConfirguration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession * ephSession = [NSURLSession sessionWithConfiguration:ephConfirguration delegate:self delegateQueue:nil];
    NSURLSessionDataTask * dataTask = [ephSession dataTaskWithURL:[NSURL URLWithString:kRequest1]];
    [dataTask resume];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"finished");
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
