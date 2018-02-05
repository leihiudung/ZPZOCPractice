//
//  ZPZDefaultSessionDataTaskViewController.m
//  ZPZNetWorkPractice
//
//  Created by zhoupengzu on 2018/2/1.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZDefaultSessionDataTaskViewController.h"

#define kRequest1 @"http://rap2api.taobao.org/app/mock/5106/GET/userInfoList"

@interface ZPZDefaultSessionDataTaskViewController ()<NSURLSessionDataDelegate, NSURLSessionDelegate>

@property (nonatomic, strong) NSMutableData * reponseData;

@end

@implementation ZPZDefaultSessionDataTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
}
- (IBAction)beginToRequestWithURL:(UIButton *)sender {
    NSURLSessionConfiguration * defaultConfirguration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    defaultConfirguration.waitsForConnectivity = YES;
    NSURLSession * defaultSession = [NSURLSession sessionWithConfiguration:defaultConfirguration delegate:self delegateQueue:nil];
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:[NSURL URLWithString:kRequest1]];
    dataTask.earliestBeginDate = [NSDate dateWithTimeIntervalSinceNow:3];
    [dataTask resume];
}
- (IBAction)beginToRequestWithRequest:(UIButton *)sender {
    NSURLSessionConfiguration * defaultConfirguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        defaultConfirguration.waitsForConnectivity = YES;
    defaultConfirguration.timeoutIntervalForResource = 3;
    NSURLSession * defaultSession = [NSURLSession sessionWithConfiguration:defaultConfirguration delegate:self delegateQueue:nil];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kRequest1]];
//    request.timeoutInterval = 3;
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:request];
    [dataTask resume];
}

- (IBAction)beginToRequestWithRequestForRedirect:(id)sender {
    NSURLSessionConfiguration * defaultConfirguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    defaultConfirguration.waitsForConnectivity = YES;
    defaultConfirguration.discretionary = NO;
    defaultConfirguration.timeoutIntervalForResource = 3;
    NSURLSession * defaultSession = [NSURLSession sessionWithConfiguration:defaultConfirguration delegate:self delegateQueue:nil];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.google.com"]];
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:request];
    [dataTask resume];
}
- (IBAction)begtinToRequestWithUrlForPost:(id)sender {
    NSURLSessionConfiguration * defaultConfirguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * form_dataSession = [NSURLSession sessionWithConfiguration:defaultConfirguration delegate:self delegateQueue:nil];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://0.0.0.0:8080/request.php?get_prarm=get"]];
    
    NSString * boundary = @"--WebKitFormBoundary7MA4YWxkTrZu0gW";
    NSString * imageName = @"image";
    NSString * fileName = @"1.jpeg";
    
    request.HTTPMethod = @"POST";
    [request setValue:[NSString stringWithFormat:@"multipart/form-data;boundary=%@",boundary] forHTTPHeaderField:@"content-type"];
    
    NSMutableData * bodyData = [NSMutableData data];
    //图片数据部分
    NSMutableString *imageBodyPre = [NSMutableString string];
    [imageBodyPre appendString:[NSString stringWithFormat:@"--%@\r\n", boundary]]; // 部分和全部的开始部分 必须以--boundary开始
    [imageBodyPre appendFormat:@"Content-Disposition:form-data; name=\"%@\";filename=\"%@\"", imageName, fileName];
    [imageBodyPre appendFormat:@"Content-Type:image/jpeg\r\n\r\n"];
    [bodyData appendData:[imageBodyPre dataUsingEncoding:NSUTF8StringEncoding]];
    NSData * imageData = UIImageJPEGRepresentation([UIImage imageNamed:fileName], 1);
    [bodyData appendData:imageData];
    // 参数部分
    NSMutableString * paramsStr = [NSMutableString string];
    NSMutableDictionary * postDic = [NSMutableDictionary dictionary];
    [postDic setObject:@"中国" forKey:@"contry"];
    [postDic setObject:@(12) forKey:@"age"];
    [postDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [paramsStr appendFormat:@"\r\n--%@\r\n", boundary];
        [paramsStr appendFormat:@"Content-Disposition:form-data;name=%@\r\n",key];
        [paramsStr appendFormat:@"Content-Type:text/plain\r\n\r\n"];  //这里必须要有两个\r\n，来使得value和前一行有一行空白
        [paramsStr appendFormat:@"%@\r\n",obj];
    }];
    [bodyData appendData:[paramsStr dataUsingEncoding:NSUTF8StringEncoding]];
    //全部的结束部分 结束部分必须以--boundary--形式结束
    [bodyData appendData:[[NSString stringWithFormat:@"--%@--", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSData * postData = bodyData;
    
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask * dataTask = [form_dataSession dataTaskWithRequest:request];
    [dataTask resume];
//    [self requestTypeIsX_www_form_urlencoded];
}
// Content-Type:application/x-www-form-urlencoded
- (void)requestTypeIsX_www_form_urlencoded {
    NSURLSessionConfiguration * defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * x_www_form_urlencodedSession = [NSURLSession sessionWithConfiguration:defaultConfiguration delegate:self delegateQueue:nil];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://0.0.0.0:8080/HelloPython.php?name=zhoupengzu"]];
    request.HTTPMethod = @"POST";
    NSMutableDictionary * postDic = [NSMutableDictionary dictionary];
    [postDic setObject:@"中国" forKey:@"contry"];
    [postDic setObject:@(12) forKey:@"age"];
    // application/x-www-form-urlencoded
    // 方法一：将Contnt-Type和参数分开
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSString * bodyStr = [self application_X_www_form_urlencoded:postDic];
    [request setHTTPBody:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
    // 方法二：不指定，默认就是
    NSString * requestStr = @"";
    requestStr = [requestStr stringByAppendingString:bodyStr];
    [request setHTTPBody:[requestStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask = [x_www_form_urlencodedSession dataTaskWithRequest:request];
    [dataTask resume];
}


- (NSString *)application_X_www_form_urlencoded:(NSDictionary *)postDic {
    NSMutableArray * formArr = [NSMutableArray array];
    [postDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [formArr addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
    }];
    
    return [formArr componentsJoinedByString:@"&"];
}
- (IBAction)beginToRequestForRequestDownload:(id)sender {
    NSURLSessionConfiguration * defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * defaultSession = [NSURLSession sessionWithConfiguration:defaultConfiguration delegate:self delegateQueue:nil];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://0.0.0.0:8080/for_down.JPG"]];
    NSURLSessionDataTask * task = [defaultSession dataTaskWithRequest:request];
    [task addObserver:self forKeyPath:NSStringFromSelector(@selector(progress)) options:NSKeyValueObservingOptionNew context:nil];
    [task resume];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@",change);
}

#pragma mark - NSURLSessionDelegate
/* The last message a session receives.  A session will only become
 * invalid because of a systemic error or when it has been
 * explicitly invalidated, in which case the error parameter will be nil.
 */
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error {
    NSLog(@"%@", error.description);
}

/* If an application has received an
 * -application:handleEventsForBackgroundURLSession:completionHandler:
 * message, the session delegate will receive this message to indicate
 * that all messages previously enqueued for this session have been
 * delivered.  At this time it is safe to invoke the previously stored
 * completion handler, or to begin any internal updates that will
 * result in invoking the completion handler.
 */
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    NSLog(@"%s",__func__);
}

/*
 * Sent when the system is ready to begin work for a task with a delayed start
 * time set (using the earliestBeginDate property). The completionHandler must
 * be invoked in order for loading to proceed. The disposition provided to the
 * completion handler continues the load with the original request provided to
 * the task, replaces the request with the specified task, or cancels the task.
 * If this delegate is not implemented, loading will proceed with the original
 * request.
 *
 * Recommendation: only implement this delegate if tasks that have the
 * earliestBeginDate property set may become stale and require alteration prior
 * to starting the network load.
 *
 * If a new request is specified, the allowsCellularAccess property from the
 * new request will not be used; the allowsCellularAccess property from the
 * original request will continue to be used.
 *
 * Canceling the task is equivalent to calling the task's cancel method; the
 * URLSession:task:didCompleteWithError: task delegate will be called with error
 * NSURLErrorCancelled.
 * 该方法只有后台任务才会调用
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
willBeginDelayedRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLSessionDelayedRequestDisposition disposition, NSURLRequest * _Nullable newRequest))completionHandler {
    NSLog(@"%s",__func__);
    completionHandler(NSURLSessionDelayedRequestContinueLoading, nil);
}

/* Sent as the last message related to a specific task.  Error may be
 * nil, which implies that no error occurred and this task is complete.
 * 最中接收数据完成后，会调用这里
 * 如果这里的error返回不为空，则表明请求失败了
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    NSLog(@"%s, %@", __func__, error == nil ? @"SUCCESS" : error.localizedDescription);
    if (error == nil && _reponseData.length > 0) {
        NSError * eror = nil;
        id objc = [NSJSONSerialization JSONObjectWithData:_reponseData options:NSJSONReadingMutableContainers error:&eror];
        NSLog(@"responseDataIs:%@", objc);
    } else {
        NSLog(@"failed");
    }
}

/*
 * Sent when a task cannot start the network loading process because the current
 * network connectivity is not available or sufficient for the task's request.
 *
 * This delegate will be called at most one time per task, and is only called if
 * the waitsForConnectivity property in the NSURLSessionConfiguration has been
 * set to YES.
 *
 * This delegate callback will never be called for background sessions, because
 * the waitForConnectivity property is ignored by those sessions.
 */
- (void)URLSession:(NSURLSession *)session taskIsWaitingForConnectivity:(NSURLSessionTask *)task {
    NSLog(@"%s",__func__);
//    [task cancel];
}
/* An HTTP request is attempting to perform a redirection to a different
 * URL. You must invoke the completion routine to allow the
 * redirection, allow the redirection with a modified request, or
 * pass nil to the completionHandler to cause the body of the redirection
 * response to be delivered as the payload of this request. The default
 * is to follow redirections.
 *
 * For tasks in background sessions, redirections will always be followed and this method will not be called.
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
        newRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler {
    NSLog(@"%s", __func__);
    NSDictionary * allFieldDic = response.allHeaderFields;
    NSLog(@"重定向的地址为：%@", allFieldDic[@"Location"]);
    completionHandler(request);
}
/* If implemented, when a connection level authentication challenge
 * has occurred, this delegate will be given the opportunity to
 * provide authentication credentials to the underlying
 * connection. Some types of authentication will apply to more than
 * one request on a given connection to a server (SSL Server Trust
 * challenges).  If this delegate message is not implemented, the
 * behavior will be to use the default handling, which may involve user
 * interaction.
 */
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    NSLog(@"%s",__func__);
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, challenge.proposedCredential);
}

/* The task has received a request specific authentication challenge.
 * If this delegate is not implemented, the session specific authentication challenge
 * will *NOT* be called and the behavior will be the same as using the default handling
 * disposition.
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    NSLog(@"%s", __func__);
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, challenge.proposedCredential);
}

/* Sent if a task requires a new, unopened body stream.  This may be
 * necessary when authentication has failed for any request that
 * involves a body stream.
 */
//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
// needNewBodyStream:(void (^)(NSInputStream * _Nullable bodyStream))completionHandler{
//
//}

/* Sent periodically to notify the delegate of upload progress.  This
 * information is also available as properties of the task.
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
   didSendBodyData:(int64_t)bytesSent
    totalBytesSent:(int64_t)totalBytesSent
totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    NSLog(@"%lld-%lld-%lld", bytesSent, totalBytesSent, totalBytesExpectedToSend);
}

/*
 * Sent when complete statistics information has been collected for the task.
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didFinishCollectingMetrics:(NSURLSessionTaskMetrics *)metrics {
    NSLog(@"%s", __func__);
}

#pragma mark - NSURLSessionDataDelegate
/* The task has received a response and no further messages will be
 * received until the completion block is called. The disposition
 * allows you to cancel a request or to turn a data task into a
 * download task. This delegate message is optional - if you do not
 * implement it, you can get the response as a property of the task.
 *
 * This method will not be called for background upload tasks (which cannot be converted to download tasks).
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    NSLog(@"%s",__func__);
    NSLog(@"MIME Type:%@", response.MIMEType);
    _reponseData = nil;
    NSHTTPURLResponse * urlResponse = (NSHTTPURLResponse *)response;
    if(urlResponse.statusCode == 200) {
        _reponseData = [NSMutableData data];
    }
    completionHandler(NSURLSessionResponseAllow);
}

/* Sent when data is available for the delegate to consume.  It is
 * assumed that the delegate will retain and not copy the data.  As
 * the data may be discontiguous, you should use
 * [NSData enumerateByteRangesUsingBlock:] to access it.
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    [_reponseData appendData:data];
}

- (void)dealloc {
    NSLog(@"released");
}


@end
