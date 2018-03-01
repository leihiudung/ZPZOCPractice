//
//  ZPZAssetCollectionRequestViewController.m
//  ZPZPhotoPractice
//
//  Created by zhoupengzu on 2018/3/1.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZAssetCollectionRequestViewController.h"
#import <Photos/Photos.h>

@interface ZPZAssetCollectionRequestViewController ()

@end

@implementation ZPZAssetCollectionRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)toCreateAssetCollection:(id)sender {
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetCollectionChangeRequest * request = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:@"相册"];
        NSLog(@"identifier:%@", request.placeholderForCreatedAssetCollection.localIdentifier);  //获取创建的相册的永久的唯一identifier
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            [self showDetailInfo:@"创建成功"];
        } else {
            [self showDetailInfo:@"创建失败"];
        }
    }];
}
- (IBAction)toDeleteAssetCollection:(id)sender {
    // 先获取需要删除的相册，其实能删除的也就只有自己创建的相册而已
    NSMutableArray<PHAssetCollection *> * delArr = [NSMutableArray array];
    PHFetchResult<PHAssetCollection *> * result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAny options:nil];
    [result enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj canPerformEditOperation:PHCollectionEditOperationDelete]) { // 判断是否有权限删除
            [delArr addObject:obj];
        }
    }];
    if (delArr.count == 0) {
        [self showDetailInfo:@"No thing to delete!"];
        return;
    }
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetCollectionChangeRequest deleteAssetCollections:delArr];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            [self showDetailInfo:@"删除成功"];
        } else {
            [self showDetailInfo:@"删除失败"];
        }
    }];
}
- (IBAction)toModifyTitle:(id)sender {
    // 重命名也是只能对自己创建的相册才会起作用，其他的系统的或者同步过来的相册都没办法修改
    NSMutableArray * modifyArr = [NSMutableArray array];
    PHFetchResult<PHAssetCollection *> * result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    [result enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj canPerformEditOperation:PHCollectionEditOperationRename]) {
            [modifyArr addObject:obj];
        }
    }];
    if (modifyArr.count == 0) {
        [self showDetailInfo:@"没有可以修改的相册"];
        return;
    }
    // 修改第一个
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetCollectionChangeRequest * request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:modifyArr.firstObject];
        request.title = @"修改了";
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            [self showDetailInfo:@"修改成功"];
        } else {
            [self showDetailInfo:@"修改失败"];
        }
    }];
}
- (IBAction)toModifyAssetCollectionWithoutIndexes:(id)sender {
}
- (IBAction)toModifyAssetCollectionWithIndexes:(id)sender {
}

#pragma mark - alert
- (void)showDetailInfo:(NSString *)info {
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:info preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:okAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
