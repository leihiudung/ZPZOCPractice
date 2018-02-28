//
//  ZPZAssetChangeRequestViewController.m
//  ZPZPhotoPractice
//
//  Created by zhoupengzu on 2018/2/27.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZAssetChangeRequestViewController.h"
#import <Photos/Photos.h>

@interface ZPZAssetChangeRequestViewController ()
{
    NSMutableArray * identifierArr;
}
@property (weak, nonatomic) IBOutlet UIImageView *finalImageView;

@end

@implementation ZPZAssetChangeRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    identifierArr = [NSMutableArray array];
    // Do any additional setup after loading the view.
}
- (IBAction)toCreateAndAndAsset:(id)sender {
//    [identifierArr removeAllObjects];
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        NSLog(@"ggggggggg");
        PHAssetChangeRequest * request = [PHAssetChangeRequest creationRequestForAssetFromImage:[UIImage imageNamed:@"girl.jpg"]];
        if (request.placeholderForCreatedAsset.localIdentifier) {
            [identifierArr addObject:request.placeholderForCreatedAsset.localIdentifier];
        }
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        NSLog(@"ffffffff");
        if (success) {
            NSLog(@"添加成功！");
        } else {
            NSLog(@"添加失败！");
        }
    }];
//    NSLog(@"hhhhhhh");
//    BOOL isSuccess = [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
//        [PHAssetChangeRequest creationRequestForAssetFromImage:[UIImage imageNamed:@"girl.jpg"]];
//    } error:nil];
//    if (isSuccess) {
//        NSLog(@"添加成功！");
//    } else {
//        NSLog(@"添加失败！");
//    }
//    NSLog(@"iiiiiiii");
}
- (IBAction)toDeleteAsset:(id)sender {
    if (identifierArr.count == 0) {
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有要删除的目标，请先添加资源！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertVC addAction:okAction];
        [self presentViewController:alertVC animated:YES completion:nil];
        return;
    }
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        // 查找set
        PHFetchResult<PHAsset *> * result = [PHAsset fetchAssetsWithLocalIdentifiers:identifierArr options:nil];
        [PHAssetChangeRequest deleteAssets:result];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            NSLog(@"删除成功！");
        } else {
            NSLog(@"删除失败：%@", error);
        }
    }];
}
- (IBAction)toModifyAsset:(id)sender {
    if (identifierArr.count == 0) {
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有要更新的目标，请先添加资源！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertVC addAction:okAction];
        [self presentViewController:alertVC animated:YES completion:nil];
        return;
    }
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHFetchResult<PHAsset *> * fetchResult = [PHAsset fetchAssetsWithLocalIdentifiers:identifierArr options:nil];
        if (fetchResult.count > 0) {
            PHAsset * firstAsset = fetchResult.firstObject;
            PHAssetChangeRequest * changeRequest = [PHAssetChangeRequest changeRequestForAsset:firstAsset];
            changeRequest.favorite = YES;
        }
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            NSLog(@"修改成功");
        } else {
            NSLog(@"修改失败");
        }
    }];
}

- (IBAction)toEditAssetContent:(id)sender {
    // 1、根据identifier查找到asset
    PHFetchResult<PHAsset *> * fetchResult = [PHAsset fetchAssetsWithLocalIdentifiers:@[@"421C93B7-E05A-41FF-9983-02C1B8B41902/L0/001"] options:nil];
    if (fetchResult.count > 0) {
        PHAsset * firstAsset = fetchResult.firstObject;
        if ([firstAsset canPerformEditOperation:PHAssetEditOperationContent]) {
            NSLog(@"可以被修改");
        }
        // 2、获取PHContentEditingInput对象
        PHContentEditingInputRequestOptions * requestOptions = [[PHContentEditingInputRequestOptions alloc] init];
        // 该方法只有在已经存在PHAdjustmentData的情况下才会被调用
        requestOptions.canHandleAdjustmentData = ^BOOL(PHAdjustmentData * _Nonnull adjustmentData) {
            NSLog(@"formatIdentifier:%@,formatVersion:%@", adjustmentData.formatIdentifier, adjustmentData.formatVersion);
            if ([adjustmentData.formatVersion isEqualToString:@"2.0"]) {
                return NO;
            }
            return YES;
        };
//        PHContentEditingInputRequestID requestId =
        [firstAsset requestContentEditingInputWithOptions:requestOptions completionHandler:^(PHContentEditingInput * _Nullable contentEditingInput, NSDictionary * _Nonnull info) {
            // 3、创建PHAdjustmentdata，可以在data参数里设置要做的操作，比如过滤等，可以是一个序列串，但是这里的长度是有限制的
            PHAdjustmentData * adjustData = [[PHAdjustmentData alloc] initWithFormatIdentifier:firstAsset.localIdentifier formatVersion:@"2.0" data:[@"ceshi" dataUsingEncoding:NSUTF8StringEncoding]];
            // 4、初始化PHContentEditingOutput对象
            PHContentEditingOutput * output = [[PHContentEditingOutput alloc] initWithContentEditingInput:contentEditingInput];
            output.adjustmentData = adjustData;
            // 通过PHContentEditingInput可以获取到想要的信息，处理图片:修改图片整体颜色
            NSURL * imageUrl = [contentEditingInput fullSizeImageURL];  // 包含图片数据的文件
            NSData * originalImageData = [NSData dataWithContentsOfURL:imageUrl];
            UIImage * originalImage = [UIImage imageWithData:originalImageData];
            CGImageRef imageRef = originalImage.CGImage;
            size_t width = CGImageGetWidth(imageRef);
            size_t height = CGImageGetHeight(imageRef);
            size_t bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
            size_t bytesPerRow = CGImageGetBytesPerRow(imageRef);
            uint32_t bitmapInfo = CGImageGetBitmapInfo(imageRef);
            CGColorSpaceRef space = CGImageGetColorSpace(imageRef);
            //获取每个像素的字节数据集合
            CGDataProviderRef dataProviderRef = CGImageGetDataProvider(imageRef);
            CFDataRef dataRef = CGDataProviderCopyData(dataProviderRef);
            CFMutableDataRef mutableDataRef = CFDataCreateMutableCopy(kCFAllocatorDefault, 0, dataRef);
            //                const UInt8 * constBytesPtr = CFDataGetBytePtr(dataRef);
            UInt8 * bytesPtr = CFDataGetMutableBytePtr(mutableDataRef);
            NSUInteger length = CFDataGetLength(mutableDataRef);
            // 一个像素由四个字节byte组成
            for (int i = 0; i < length; i += 4) {
                UInt8 red = bytesPtr[i];
                UInt8 green = bytesPtr[i + 1];
                UInt8 blue = bytesPtr[i + 2];
                UInt8 average = (red + green + blue) / 3;
                bytesPtr[i] = average;
                bytesPtr[i + 1] = average;
                bytesPtr[i + 2] = average;
            }
            CGContextRef imageContextRef = CGBitmapContextCreate(bytesPtr, width, height, bitsPerComponent, bytesPerRow, space, bitmapInfo);
            CGImageRef finalImageRef = CGBitmapContextCreateImage(imageContextRef);
            UIImage * finalImage = [UIImage imageWithCGImage:finalImageRef];
            _finalImageView.image = finalImage;
            // ⚠️这里为什么一定要用UIImageJPEGRepresentation才能成功，而UIImagePNGRepresentation会失败，生成的数据是正确的，但是相册相应的资源无法更新???
            // 因为这个和renderedContentURL有关，图片的输出只能是JPEG格式，video只能是.mov格式输出
            // 对于Live Photo，调用saveLivePhotoToOutput:options:completionHandler:方法保存和更新
            BOOL isSuccess = [UIImageJPEGRepresentation(finalImage, 1) writeToURL:output.renderedContentURL atomically:NO];
            if (isSuccess) {
                NSLog(@"写入成功");
            } else {
                NSLog(@"写入失败");
            }
            CGImageRelease(finalImageRef);
            CGContextRelease(imageContextRef);
            CFRelease(mutableDataRef);
            CFRelease(dataRef);
            
            // 5、赋值更新
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                // 使用PHAssetChangeRequest
                PHAssetChangeRequest * changeRequest = [PHAssetChangeRequest changeRequestForAsset:firstAsset];
                changeRequest.contentEditingOutput = output;
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                if (success) {
                    NSLog(@"编辑内容成功");
                } else {
                    NSLog(@"编辑内容失败:%@", error);
                }
            }];
        }];
    }
}
- (IBAction)toResetAsset:(id)sender {
    PHFetchResult<PHAsset *> * result = [PHAsset fetchAssetsWithLocalIdentifiers:@[@"421C93B7-E05A-41FF-9983-02C1B8B41902/L0/001"] options:nil];
    if (result.count == 0) {
        return;
    }
    PHAsset * firstAsset = result.firstObject;
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetChangeRequest * request = [PHAssetChangeRequest changeRequestForAsset:firstAsset];
        [request revertAssetContentToOriginal];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            NSLog(@"还原成功");
        } else {
            NSLog(@"还原失败");
        }
    }];
}
- (IBAction)toUseAssetCreationRequestAdd:(id)sender {
    [self support];
    return;
    NSURL * url1 = [[NSBundle mainBundle] URLForResource:@"girl" withExtension:@"jpg"];
//    NSURL * url2 = [[NSBundle mainBundle] URLForResource:@"code" withExtension:@"png"];
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetCreationRequest * request = [PHAssetCreationRequest creationRequestForAsset];
        request.favorite = YES;
        [request addResourceWithType:PHAssetResourceTypePhoto fileURL:url1 options:nil];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            NSLog(@"添加成功");
        } else {
            NSLog(@"添加失败");
        }
    }];
}

- (void)support {
    NSArray<NSDictionary *> * array = @[
                                        @{@"title":@"PHAssetResourceTypePhoto", @"value":@(PHAssetResourceTypePhoto)},
                                        @{@"title":@"PHAssetResourceTypeVideo", @"value":@(PHAssetResourceTypeVideo)},
                                        @{@"title":@"PHAssetResourceTypeAudio", @"value":@(PHAssetResourceTypeAudio)},
                                        @{@"title":@"PHAssetResourceTypeAlternatePhoto", @"value":@(PHAssetResourceTypeAlternatePhoto)},
                                        @{@"title":@"PHAssetResourceTypeFullSizePhoto", @"value":@(PHAssetResourceTypeFullSizePhoto)},
                                        @{@"title":@"PHAssetResourceTypeFullSizeVideo", @"value":@(PHAssetResourceTypeFullSizeVideo)},
                                        @{@"title":@"PHAssetResourceTypeAdjustmentData", @"value":@(PHAssetResourceTypeAdjustmentData)},
                                        @{@"title":@"PHAssetResourceTypeAdjustmentBasePhoto", @"value":@(PHAssetResourceTypeAdjustmentBasePhoto)},
                                        @{@"title":@"PHAssetResourceTypePairedVideo", @"value":@(PHAssetResourceTypePairedVideo)},
                                        @{@"title":@"PHAssetResourceTypeFullSizePairedVideo", @"value":@(PHAssetResourceTypeFullSizePairedVideo)},
                                        @{@"title":@"PHAssetResourceTypeAdjustmentBasePairedVideo", @"value":@(PHAssetResourceTypeAdjustmentBasePairedVideo)},
                                        ];
    [array enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@:%@", obj[@"title"], ([PHAssetCreationRequest supportsAssetResourceTypes:@[obj[@"value"]]] ? @"支持" : @"不支持"));
    }];
}

@end
