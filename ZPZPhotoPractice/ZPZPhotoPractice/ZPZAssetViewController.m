//
//  ZPZAssetViewController.m
//  ZPZPhotoPractice
//
//  Created by zhoupengzu on 2018/2/26.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZAssetViewController.h"
#import <Photos/Photos.h>

@interface ZPZAssetViewController ()

@end

@implementation ZPZAssetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self useToFetchLibraryWithOptions];
}

- (void)useToFetchLibraryWithOptions {
    PHFetchOptions * options = [[PHFetchOptions alloc] init];
    options.includeHiddenAssets = YES;
    PHFetchResult<PHAsset *> * libraryResult = [PHAsset fetchAssetsWithOptions:options];
    NSLog(@"%@", libraryResult);
}

- (IBAction)useToFetchCollection:(id)sender {
    // 先获取到集合
    PHFetchResult<PHAssetCollection *> * collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumFavorites options:nil];
    if (collectionResult.count == 0) {
        return;
    }
    // 遍历集合，获取信息
    [collectionResult enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PHFetchResult<PHAsset *> * assetResult = [PHAsset fetchAssetsInAssetCollection:obj options:nil];
        NSLog(@"%@", assetResult);
    }];
}
- (IBAction)useToFetchIdentifier:(id)sender {
    PHFetchResult<PHAssetCollection *> * collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumAllHidden options:nil];
    if (collectionResult.count == 0) {
        return;
    }
    NSMutableArray * hiddenIdentifier = [NSMutableArray array];
    [collectionResult enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PHFetchResult<PHAsset *> * assetResult = [PHAsset fetchAssetsInAssetCollection:obj options:nil];
        [assetResult enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [hiddenIdentifier addObject:obj.localIdentifier];
        }];
    }];
    // 默认查找
    PHFetchResult<PHAsset *> * assetResult = [PHAsset fetchAssetsWithLocalIdentifiers:hiddenIdentifier options:nil];
    NSLog(@"%@", assetResult);
}

@end
