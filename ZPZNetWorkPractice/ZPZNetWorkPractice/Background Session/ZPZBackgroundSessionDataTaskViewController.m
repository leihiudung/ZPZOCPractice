//
//  ZPZBackgroundSessionDataTaskViewController.m
//  ZPZNetWorkPractice
//
//  Created by zhoupengzu on 2018/2/1.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZBackgroundSessionDataTaskViewController.h"
#import "AppDelegate.h"

#define kRequest1 @"http://rap2api.taobao.org/app/mock/5106/GET/userInfoList"

@interface ZPZBackgroundSessionDataTaskViewController () <NSURLSessionTaskDelegate>

@property (nonatomic, strong) NSURLSessionDataTask * continueDelayTask;
@property (nonatomic, strong) NSURLSessionDataTask * cancelDelayTask;
@property (nonatomic, strong) NSURLSessionDataTask * delayNewTask;

@end

@implementation ZPZBackgroundSessionDataTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)gotoRequestWithURL:(UIButton *)sender {
    NSURLSessionDelayedRequestDisposition disposition = NSURLSessionDelayedRequestUseNewRequest;
    NSURLSessionConfiguration * backConfirguration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:NSStringFromClass([self class])];
    backConfirguration.discretionary = YES;
    NSURLSession * backSession = [NSURLSession sessionWithConfiguration:backConfirguration delegate:self delegateQueue:nil];
    switch (disposition) {
        case NSURLSessionDelayedRequestCancel:{
            _cancelDelayTask = [backSession dataTaskWithURL:[NSURL URLWithString:kRequest1]];
            [_cancelDelayTask resume];
        }
            break;
        case NSURLSessionDelayedRequestUseNewRequest:{
            _delayNewTask = [backSession dataTaskWithURL:[NSURL URLWithString:kRequest1]];
            [_delayNewTask resume];
        }
            break;
            
        default:
            _continueDelayTask = [backSession dataTaskWithURL:[NSURL URLWithString:kRequest1]];
            [_continueDelayTask resume];
            break;
    }
//    _delayTask.earliestBeginDate = [NSDate dateWithTimeIntervalSinceNow:3];  //该属性用来设置启动时间
}
- (IBAction)finishedWhenAppInBacground:(id)sender {
    NSURLSessionConfiguration * backConfirguration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:NSStringFromClass([self class])];
    NSURLSession * backSession = [NSURLSession sessionWithConfiguration:backConfirguration delegate:self delegateQueue:nil];
    NSURLSessionDataTask * dataTask = [backSession dataTaskWithURL:[NSURL URLWithString:kRequest1]];
    dataTask.earliestBeginDate = [NSDate dateWithTimeIntervalSinceNow:5];
    [dataTask resume];
}
/**
 * 调用是否成功的最终回调
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    } else {
        NSLog(@"success");
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willBeginDelayedRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLSessionDelayedRequestDisposition, NSURLRequest * _Nullable))completionHandler {
    if (task == _delayNewTask) {
        NSURLRequest * newRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:kRequest1]];
        completionHandler(NSURLSessionDelayedRequestUseNewRequest, newRequest);
    } else if (task == _cancelDelayTask){
        [task cancel];
        completionHandler(NSURLSessionDelayedRequestCancel, nil);
    } else {
        completionHandler(NSURLSessionDelayedRequestContinueLoading, nil);
    }
    
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    NSLog(@"finished");
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if(delegate.backgroundSessionCompletionHandler) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.view.backgroundColor = [UIColor greenColor];
        });
        void (^completionHandler)(void) = delegate.backgroundSessionCompletionHandler;
        delegate.backgroundSessionCompletionHandler = nil;
        completionHandler();
    }
}

- (void)dealloc {
    NSLog(@"release");
}


@end
