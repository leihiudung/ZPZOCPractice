//
//  ZPZAssetCollectionViewController.m
//  ZPZPhotoPractice
//
//  Created by zhoupengzu on 2018/2/26.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZAssetCollectionViewController.h"
#import <Photos/Photos.h>

@interface ZPZAssetCollectionViewController ()

@end

@implementation ZPZAssetCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 * 单个图片和视频的集合
 * 比如时刻、用户自己创建的和智能相册等
 */
- (IBAction)useAssetCollection_01:(id)sender {
    //检查权限
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    switch (status) {
        case PHAuthorizationStatusNotDetermined:
        {
            //请求获取权限
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
               //因为是在异步线程，所以需要转到主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (status == PHAuthorizationStatusAuthorized) {
                        [self gotoReadPhotoForMoment];
                    }
                });
            }];
        }
            break;
        case PHAuthorizationStatusAuthorized:{
            [self gotoReadPhotoForMoment];
        }
            break;
            
        default:
            break;
    }
}
//Moment
- (void)gotoReadPhotoForMoment {
    //Moment:type类型为Moment的subtype只能是Any
    PHFetchResult * momentResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeMoment subtype:PHAssetCollectionSubtypeAny options:nil];
    NSLog(@"%@",momentResult);
    [momentResult enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@", obj);
    }];
}
- (IBAction)useCollectionForAlbum:(id)sender {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    switch (status) {
        case PHAuthorizationStatusNotDetermined:{
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (status == PHAuthorizationStatusAuthorized) {
                        [self gotoReadPhotoForAlbum];
                    }
                });
            }];
        }
            break;
        case PHAuthorizationStatusAuthorized:{
            [self gotoReadPhotoForAlbum];
        }
            break;
        default:
            break;
    }
}
// Album
- (void)gotoReadPhotoForAlbum {
    // Any：获取到所有的，包括自己创建的和照片流（相机胶卷和照片流什么区别）
    [self gotoReadPhotoForAlbumWithSubtype:PHAssetCollectionSubtypeAny];
    NSLog(@"==========================================");
    // Regular：只能获取到自己在app 上手动创建的，比如从iCloud或者Mac的图片app上同步过来的相簿都获取不到
    [self gotoReadPhotoForAlbumWithSubtype:PHAssetCollectionSubtypeAlbumRegular];
    NSLog(@"==========================================");
    // SyncedAlbum：获取从Mac的图片app上同步过来的相簿
    [self gotoReadPhotoForAlbumWithSubtype:PHAssetCollectionSubtypeAlbumSyncedAlbum];
    // MyPhotoStream：照片流
    [self gotoReadPhotoForAlbumWithSubtype:PHAssetCollectionSubtypeAlbumMyPhotoStream];
}

- (void)gotoReadPhotoForAlbumWithSubtype:(PHAssetCollectionSubtype)subType {
    //Album
    PHFetchResult<PHAssetCollection *> * albumResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:subType options:nil];
    NSLog(@"%@", albumResult);
    [albumResult enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@", obj);
    }];
}
/**
 * 通过上面的逐个分析，会发现，type为Album和Moment都没有办法获取到相机胶卷，即该机子上默认存储的所有照片，该怎么办呢？
 * 发现现在只剩SmartAlbum了，SmartAlbum是系统内置的智能相册，它对具有某些种类特性的资源做了归类
 * 而系统的这些SmartAlbum是不能删除的，都是系统自己处理好的，也就是说，我们见到的相册里的资源都是该类型下的
 * 而上面提到的两种情况都是基于该情况下的资源的
 * 其子类型除了Any之外多达16种，而这16种相册的绝大多数，无论其下面有没有内容，都是能获取到的
 * 但是这里有几个特殊情况：
        1、PHAssetCollectionSubtypeSmartAlbumAnimated和PHAssetCollectionSubtypeSmartAlbumLongExposures这两个枚举都是从iOS11开始才能用的，但是苹果文档并未给出说明，而且Animated的值定义的是214，但是通过获取你会发现变成了215
        2、PHAssetCollectionSubtypeSmartAlbumGeneric表示从iPhoto中同步过来的，但是iPhoto是老设备上的东西了，iPhoto是现在的图片或者照片app的前身，貌似从2015年开始就已经被放弃了，按照版本的更新，我们貌似也不用过多关注
 */
- (IBAction)useCollectionForSmartAlbum:(id)sender {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    switch (status) {
        case PHAuthorizationStatusNotDetermined:{
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self gotoReadPhotoForSmartAlbum];
                });
            }];
        }
            break;
        case PHAuthorizationStatusAuthorized:{
            [self gotoReadPhotoForSmartAlbum];
        }
            break;
        default:
            break;
    }
}
/**
 * 因为内容很多，所以只选取一些常见的
 */
- (void)gotoReadPhotoForSmartAlbum {
    // Any：全部的
    [self gotoReadPhotoForSmartAlbumWithSubtype:PHAssetCollectionSubtypeAny];
    NSLog(@"==========================================");
    // 全景
    [self gotoReadPhotoForSmartAlbumWithSubtype:PHAssetCollectionSubtypeSmartAlbumPanoramas]; //[,pænə'ræmə]
    NSLog(@"==========================================");
    // Videos 视频
    PHFetchResult * videoResult = [self gotoReadPhotoForSmartAlbumWithSubtype:PHAssetCollectionSubtypeSmartAlbumVideos];
    [videoResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PHAssetCollection * collection = obj;
        PHFetchResult<PHAsset *> * result = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
        NSLog(@"%@",@(result.count));
    }];
    NSLog(@"==========================================");
    // Favorites 最喜欢的，收藏了的
    PHFetchResult * favoriteResult = [self gotoReadPhotoForSmartAlbumWithSubtype:PHAssetCollectionSubtypeSmartAlbumFavorites];
    [favoriteResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PHAssetCollection * collection = obj;
        PHFetchResult<PHAsset *> * result = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
        NSLog(@"%@",@(result.count));
    }];
    NSLog(@"==========================================");
    // Hidden 隐藏
    PHFetchResult * hiddenResult = [self gotoReadPhotoForSmartAlbumWithSubtype:PHAssetCollectionSubtypeSmartAlbumAllHidden];
    [hiddenResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PHAssetCollection * collection = obj;
        PHFetchResult<PHAsset *> * result = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
        NSLog(@"%@",@(result.count));
    }];
    NSLog(@"==========================================");
    // Recently Added 最近添加
    PHFetchResult * recentlyAddResult = [self gotoReadPhotoForSmartAlbumWithSubtype:PHAssetCollectionSubtypeSmartAlbumRecentlyAdded];
    [recentlyAddResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PHAssetCollection * collection = obj;
        PHFetchResult<PHAsset *> * result = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
        NSLog(@"%@",@(result.count));
    }];
    NSLog(@"==========================================");
    // Photo Library 相机胶卷
    PHFetchResult * libraryResult = [self gotoReadPhotoForSmartAlbumWithSubtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary];
    [libraryResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PHAssetCollection * collection = obj;
        PHFetchResult<PHAsset *> * result = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
        NSLog(@"%@",@(result.count));
    }];
    NSLog(@"==========================================");
    // Animated
    PHFetchResult * animatedResult = [self gotoReadPhotoForSmartAlbumWithSubtype:PHAssetCollectionSubtypeSmartAlbumAnimated];
    [animatedResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PHAssetCollection * collection = obj;
        PHFetchResult<PHAsset *> * result = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
        NSLog(@"%@",@(result.count));
    }];
}

- (PHFetchResult *)gotoReadPhotoForSmartAlbumWithSubtype:(PHAssetCollectionSubtype)subType {
    PHFetchResult * smartAlbumResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:subType options:nil];
    NSLog(@"%@", smartAlbumResult);
    [smartAlbumResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@", obj);
    }];
    return smartAlbumResult;
}

@end
