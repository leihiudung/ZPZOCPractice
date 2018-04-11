//
//  ZPZAssetAddVedioViewController.m
//  ZPZPhotoPractice
//
//  Created by zhoupengzu on 2018/4/11.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZAssetAddVedioViewController.h"
#import <Photos/Photos.h>

@interface ZPZAssetAddVedioViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ZPZAssetAddVedioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)toTakePhoto:(id)sender {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (status == PHAuthorizationStatusAuthorized) {
                    [self gotoMoveVedioToPersonalAssetCollection];
                }
            });
        }];
    } else if (status == PHAuthorizationStatusAuthorized) {
        [self gotoMoveVedioToPersonalAssetCollection];
    }
}
- (IBAction)moveVedioToPersonalAblum:(id)sender {
}

- (void)gotoMoveVedioToPersonalAssetCollection {
    // 获取相片交卷
    PHFetchResult<PHAssetCollection *> * collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    PHAssetCollection * cameraRollCollection = collectionResult.firstObject;
    // 获取到视频
    PHFetchResult<PHAsset *> * fetchResult = [PHAsset fetchAssetsInAssetCollection:cameraRollCollection options:nil];
    __block PHAsset * vedioAsset = nil;
    [fetchResult enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.mediaType == PHAssetMediaTypeVideo) {
            vedioAsset = obj;
            *stop = YES;
        }
    }];
    if (!vedioAsset) {
        NSLog(@"没有找到资源");
        return;
    }
    // 找到自定义相册
    PHFetchResult<PHAssetCollection *> * personalCollectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    __block PHAssetCollection * aimCollection = nil;
    [personalCollectionResult enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.localizedTitle isEqualToString:@"视频"]) {
            aimCollection = obj;
            *stop = YES;
        }
    }];
    if (!aimCollection) {
        NSLog(@"没有找到自定义相册");
        return;
    }
    if (![aimCollection canPerformEditOperation:PHCollectionEditOperationAddContent]) {
        NSLog(@"相册不能添加内容");
        return;
    }
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetCollectionChangeRequest * changeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:aimCollection];
        [changeRequest addAssets:@[vedioAsset]];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            NSLog(@"成功");
        } else {
            NSLog(@"失败");
        }
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
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
