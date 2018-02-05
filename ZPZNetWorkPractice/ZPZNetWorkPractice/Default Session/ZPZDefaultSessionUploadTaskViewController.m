//
//  ZPZDefaultSessionUploadTaskViewController.m
//  ZPZNetWorkPractice
//
//  Created by zhoupengzu on 2018/2/1.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZDefaultSessionUploadTaskViewController.h"

#define kRequestUrl @"http://0.0.0.0:8080/request.php"
#define kStreamBoundary @"uploadTaskWithStreame"

@interface ZPZDefaultSessionUploadTaskViewController ()<NSURLSessionDataDelegate>

@property (nonatomic, strong) NSMutableData * responseData;

@end

@implementation ZPZDefaultSessionUploadTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)uploadWithRequest:(id)sender {
    NSURLSessionConfiguration * defaultConfirguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * defaultSession = [NSURLSession sessionWithConfiguration:defaultConfirguration delegate:self delegateQueue:nil];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@""]];
    request.HTTPMethod = @"POST";
    
    NSURLSessionUploadTask * upload = [defaultSession uploadTaskWithStreamedRequest:request];
    [upload resume];
}
- (IBAction)uploadWithRequestFromFile:(id)sender {
    NSURLSessionConfiguration * defaultConfirguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * defaultSession = [NSURLSession sessionWithConfiguration:defaultConfirguration delegate:self delegateQueue:nil];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kRequestUrl]];
    request.HTTPMethod = @"POST";
    /** 指定了请求体，会不起作用，会被忽略的
    NSMutableDictionary * postDic = [NSMutableDictionary dictionary];
    [postDic setObject:@"中国" forKey:@"contry"];
    [postDic setObject:@(12) forKey:@"age"];
    // application/x-www-form-urlencoded
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];  //不要指定冲突的请求头的类型
    NSString * bodyStr = [self application_X_www_form_urlencoded:postDic];
    [request setHTTPBody:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
     */
//    [request addValue:@"image/jpeg" forHTTPHeaderField:@"Content-Type"];
    NSURLSessionUploadTask * uploadMask = [defaultSession uploadTaskWithRequest:request fromFile:[[NSBundle mainBundle] URLForResource:@"1" withExtension:@"jpeg"]];
    [uploadMask resume];
}
- (IBAction)uploadWithRequestFromData:(id)sender {
    NSURLSessionConfiguration * defaultConfirguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * defaultSession = [NSURLSession sessionWithConfiguration:defaultConfirguration delegate:self delegateQueue:nil];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kRequestUrl]];
    request.HTTPMethod = @"POST";
    NSString * boundary = @"uploadWithRequestFromData";
    NSString * imageName = @"upload";
    NSString * fileName = @"1.jpeg";
    [request setValue:[NSString stringWithFormat:@"multipart/form-data;boundary=%@",boundary] forHTTPHeaderField:@"Content-Type"];
    NSMutableData * data = [NSMutableData data];
    //图片部分
    NSMutableString * imageStr = [NSMutableString string];
    [imageStr appendFormat:@"--%@\r\n",boundary];
    [imageStr appendFormat:@"Content-Disposition:form-data;name=\"%@\";filename=\"%@\"\r\n", imageName, fileName];
    [imageStr appendFormat:@"Content-Type:image/jpeg\r\n\r\n"];
    [data appendData:[imageStr dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:UIImageJPEGRepresentation([UIImage imageNamed:@"1.jpeg"], 1)];
    
    NSMutableString * postParams = [NSMutableString string];
    NSMutableDictionary * postDic = [NSMutableDictionary dictionary];
    [postDic setObject:@"中国" forKey:@"contry"];
    [postDic setObject:@(12) forKey:@"age"];
    [postDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [postParams appendFormat:@"\r\n--%@\r\n", boundary];
        [postParams appendFormat:@"Content-Disposition:form-data;name=%@\r\n",key];
        [postParams appendFormat:@"Content-Type:text/plain\r\n\r\n"];
        [postParams appendFormat:@"%@\r\n", obj];
    }];
    [data appendData:[postParams dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[[NSString stringWithFormat:@"--%@--",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSessionUploadTask * uploadTask = [defaultSession uploadTaskWithRequest:request fromData:data];
    [uploadTask resume];
}
//uploadTaskWithStreamedRequest
- (IBAction)uploadTaskWithStreame:(id)sender {
    NSURLSessionConfiguration * defaultConfirguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * defaultSession = [NSURLSession sessionWithConfiguration:defaultConfirguration delegate:self delegateQueue:nil];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kRequestUrl]];
    request.HTTPMethod = @"POST";
    [request setValue:[NSString stringWithFormat:@"multipart/form-data;boundary=%@",kStreamBoundary] forHTTPHeaderField:@"Content-Type"];
    NSURLSessionUploadTask * uploadTask = [defaultSession uploadTaskWithStreamedRequest:request];
    [uploadTask resume];
}

- (NSString *)application_X_www_form_urlencoded:(NSDictionary *)postDic {
    NSMutableArray * formArr = [NSMutableArray array];
    [postDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [formArr addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
    }];
    
    return [formArr componentsJoinedByString:@"&"];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    NSHTTPURLResponse * urlResponse = (NSHTTPURLResponse *)response;
    if (urlResponse.statusCode == 200) {
        NSLog(@"%s,success", __func__);
    }
    _responseData = [NSMutableData data];
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
   didSendBodyData:(int64_t)bytesSent
    totalBytesSent:(int64_t)totalBytesSent
totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    NSLog(@"send:%lld,totalSend:%lld,totalExpectedSend:%lld", bytesSent, totalBytesSent,totalBytesExpectedToSend);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    [_responseData appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    if (error == nil) {
        if (_responseData.length > 0) {
            id object = [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"result:%@", object);
        }
    }
    NSLog(@"%s", __func__);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
 needNewBodyStream:(void (^)(NSInputStream * _Nullable bodyStream))completionHandler {
    
    NSString * boundary = kStreamBoundary;
    NSString * imageName = @"upload";
    NSString * fileName = @"1.jpeg";
    NSMutableData * data = [NSMutableData data];
    //图片部分
    NSMutableString * imageStr = [NSMutableString string];
    [imageStr appendFormat:@"--%@\r\n",boundary];
    [imageStr appendFormat:@"Content-Disposition:form-data;name=\"%@\";filename=\"%@\"\r\n", imageName, fileName];
    [imageStr appendFormat:@"Content-Type:image/jpeg\r\n\r\n"];
    [data appendData:[imageStr dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:UIImageJPEGRepresentation([UIImage imageNamed:@"1.jpeg"], 1)];
    
    NSMutableString * postParams = [NSMutableString string];
    NSMutableDictionary * postDic = [NSMutableDictionary dictionary];
    [postDic setObject:@"中国" forKey:@"contry"];
    [postDic setObject:@(12) forKey:@"age"];
    [postDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [postParams appendFormat:@"\r\n--%@\r\n", boundary];
        [postParams appendFormat:@"Content-Disposition:form-data;name=%@\r\n",key];
        [postParams appendFormat:@"Content-Type:text/plain\r\n\r\n"];
        [postParams appendFormat:@"%@\r\n", obj];
    }];
    [data appendData:[postParams dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[[NSString stringWithFormat:@"--%@",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSInputStream * bodyStream = [[NSInputStream alloc] initWithData:data];
    completionHandler(bodyStream);
}

@end
