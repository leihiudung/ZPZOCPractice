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
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHFetchResult<PHAsset *> * fetchResult = [PHAsset fetchAssetsWithLocalIdentifiers:identifierArr options:nil];
        if (fetchResult.count > 0) {
            PHAsset * firstAsset = fetchResult.firstObject;
            PHAssetChangeRequest * changeRequest = [PHAssetChangeRequest changeRequestForAsset:firstAsset];
            [firstAsset requestContentEditingInputWithOptions:nil completionHandler:^(PHContentEditingInput * _Nullable contentEditingInput, NSDictionary * _Nonnull info) {
                PHContentEditingOutput * output = [[PHContentEditingOutput alloc] initWithContentEditingInput:contentEditingInput];
                
            }];
        }
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            NSLog(@"编辑内容成功");
        } else {
            NSLog(@"编辑内容失败");
        }
    }];
}

@end
