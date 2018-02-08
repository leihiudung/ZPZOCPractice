//
//  ZPZBackgroundSessionDownloadTaskViewController.m
//  ZPZNetWorkPractice
//
//  Created by zhoupengzu on 2018/2/8.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZBackgroundSessionDownloadTaskViewController.h"
#import "AppDelegate.h"

@interface ZPZBackgroundSessionDownloadTaskViewController ()<NSURLSessionDownloadDelegate>

@end

@implementation ZPZBackgroundSessionDownloadTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)downloadWithUrl:(id)sender {
    NSURLSessionConfiguration * bacConfiguration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:NSStringFromClass([self class])];
    NSURLSession * bacSession = [NSURLSession sessionWithConfiguration:bacConfiguration delegate:self delegateQueue:nil];
    NSURLSessionDownloadTask * downloadTask = [bacSession downloadTaskWithURL:[NSURL URLWithString:@"http://img.pconline.com.cn/images/bbs4/20098/18/1250538257738.jpg"]];
    [downloadTask resume];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    NSLog(@"%s",__func__);
    NSFileManager * manager = [NSFileManager defaultManager];
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingString:@"/file.jpg"];
    [manager moveItemAtURL:location toURL:[NSURL fileURLWithPath:path] error:nil];
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    dispatch_async(dispatch_get_main_queue(), ^{
        AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        if (delegate.backgroundSessionCompletionHandler) {
            void (^completionHandler)(void) = delegate.backgroundSessionCompletionHandler;
            delegate.backgroundSessionCompletionHandler = nil;
            completionHandler();
        }
        self.view.backgroundColor = [UIColor orangeColor];
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    NSLog(@"%lld--%lld--%lld", bytesWritten, totalBytesWritten,totalBytesExpectedToWrite);
}

@end
