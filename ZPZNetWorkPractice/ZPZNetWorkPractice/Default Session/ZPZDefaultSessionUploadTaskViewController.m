//
//  ZPZDefaultSessionUploadTaskViewController.m
//  ZPZNetWorkPractice
//
//  Created by zhoupengzu on 2018/2/1.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZDefaultSessionUploadTaskViewController.h"

#define kRequest1 @"http://rap2api.taobao.org/app/mock/5106/POST/upload"

@interface ZPZDefaultSessionUploadTaskViewController ()<NSURLSessionTaskDelegate>

@end

@implementation ZPZDefaultSessionUploadTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)uploadWithRequest:(id)sender {
    NSURLSessionConfiguration * defaultConfirguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * defaultSession = [NSURLSession sessionWithConfiguration:defaultConfirguration delegate:self delegateQueue:nil];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kRequest1]];
    request.HTTPMethod = @"POST";
    
    NSURLSessionUploadTask * upload = [defaultSession uploadTaskWithStreamedRequest:request];
    [upload resume];
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
