//
//  ZPZScanViewController.m
//  ZPZScanCodePractice
//
//  Created by zhoupengzu on 2018/3/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZScanViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ZPZScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureSession * session;
    AVCaptureMetadataOutput * output;
}

@property (nonatomic, strong) UIView * topView;
@property (nonatomic, strong) UIView * leftView;
@property (nonatomic, strong) UIView * rightView;
@property (nonatomic, strong) UIView * bottomView;
@property (nonatomic, strong) UIView * middleView;
@property (nonatomic, strong) UIView * cameraView;
@property (nonatomic, assign) CGSize scanSize;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation ZPZScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"scan";
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self configUI];
}

- (void)configUI {
    
    AVMediaType mediaType = AVMediaTypeVideo;
    // 先检查权限，如果没有权限，就去申请获取
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    switch (status) {
        case AVAuthorizationStatusNotDetermined:{
            [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (granted) {
                        [self continueConfigUI:mediaType];
                    } else {
                        NSLog(@"denied");
                    }
                });
            }];
        }
            break;
        case AVAuthorizationStatusAuthorized:{
            [self continueConfigUI:mediaType];
        }
            break;
            
        default:
            NSLog(@"denied");
            break;
    }
}

- (void)continueConfigUI:(AVMediaType)mediaType {
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:mediaType];
    if (!device) {
        return;
    }

    CGRect cameraFrame = CGRectMake(10, 100, 300, 300);
    CGRect scanRect = CGRectMake(cameraFrame.size.width / 2 - 100, cameraFrame.size.height / 2 - 100, 200, 200);
    
    AVCaptureDeviceInput * deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
//    CGFloat top = scanRect.origin.y / CGRectGetHeight(cameraFrame);
//    CGFloat left = scanRect.origin.x / CGRectGetWidth(cameraFrame);
//    CGFloat width = scanRect.size.width / CGRectGetWidth(cameraFrame);
//    CGFloat height = scanRect.size.height / CGRectGetHeight(cameraFrame);
//    output.rectOfInterest = CGRectMake(top, left, height, width);
    
    session = [[AVCaptureSession alloc] init];
    if([session canAddInput:deviceInput]) {
        [session addInput:deviceInput];
    }
    if([session canAddOutput:output]) {
        [session addOutput:output];
    }
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode]; // 必须放在上面设置完session之后
    
    _cameraView = [[UIView alloc] initWithFrame:cameraFrame];
    _cameraView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_cameraView];
    
    // 添加扫描画面
    AVCaptureVideoPreviewLayer * layer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill; // 该值会影响展示
    layer.frame = _cameraView.bounds;
    [_cameraView.layer addSublayer:layer];
//     output.rectOfInterest = [layer metadataOutputRectOfInterestForRect:scanRect];
    [session startRunning];
    
    output.rectOfInterest = [layer metadataOutputRectOfInterestForRect:scanRect];  // 采用此方法必须放到startRunning之后
    
    [self.view bringSubviewToFront:_backButton];
    [self.view bringSubviewToFront:_startButton];
    
    _middleView = [[UIView alloc] initWithFrame:[layer rectForMetadataOutputRectOfInterest:output.rectOfInterest]];
    _middleView.backgroundColor = [UIColor clearColor];
    _middleView.layer.borderWidth = 5;
    _middleView.layer.borderColor = [UIColor orangeColor].CGColor;
    [_cameraView addSubview:_middleView];
   
//    UIView * recView = [[UIView alloc] initWithFrame:scanRect];
//    recView.backgroundColor = [UIColor clearColor];
//    recView.layer.borderWidth = 2;
//    recView.layer.borderColor = [UIColor greenColor].CGColor;
//    [_cameraView addSubview:recView];
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if(metadataObjects.count > 0) {
        [session stopRunning];
        AVMetadataMachineReadableCodeObject * readCode = metadataObjects.firstObject;
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"结果" message:readCode.stringValue preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * alertAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alertVC addAction:alertAction];
        [self presentViewController:alertVC animated:YES completion:nil];
        NSLog(@"%@", readCode.stringValue);
    }
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)start:(id)sender {
    [session startRunning];
}

- (void)dealloc {
    NSLog(@"release");
}

@end
