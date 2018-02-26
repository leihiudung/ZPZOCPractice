//
//  ViewController.m
//  ZPZPhotoPractice
//
//  Created by zhoupengzu on 2018/2/26.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ViewController.h"
#import "ZPZAssetViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)gotoAssetViewController:(id)sender {
    ZPZAssetViewController * assetVC = [[ZPZAssetViewController alloc] init];
    [self.navigationController pushViewController:assetVC animated:YES];
}
/**
 * 一些概念
 * typedef NS_ENUM(NSInteger, PHAssetCollectionType) {
     PHAssetCollectionTypeAlbum      = 1,  相册
     PHAssetCollectionTypeSmartAlbum = 2,  智能相册
     PHAssetCollectionTypeMoment     = 3,  时刻，系统自动通过时间和地点生成的分组
     } PHOTOS_ENUM_AVAILABLE_IOS_TVOS(8_0, 10_0);
 *
 * typedef NS_ENUM(NSInteger, PHAssetCollectionSubtype) {
 
     // PHAssetCollectionTypeAlbum regular subtypes
     PHAssetCollectionSubtypeAlbumRegular         = 2, // 在iPhone中自己创建的相册
     PHAssetCollectionSubtypeAlbumSyncedEvent     = 3, // 从iPhoto（就是现在的图片app）中导入图片到设备
     PHAssetCollectionSubtypeAlbumSyncedFaces     = 4, // 从图片app中导入的人物照片
     PHAssetCollectionSubtypeAlbumSyncedAlbum     = 5, // 从图片app导入的相册
     PHAssetCollectionSubtypeAlbumImported        = 6, // 从其他的相机或者存储设备导入的相册
 
     // PHAssetCollectionTypeAlbum shared subtypes
     PHAssetCollectionSubtypeAlbumMyPhotoStream   = 100,  // 照片流，照片流和iCloud有关，如果在设置里关闭了iCloud开关，就获取不到了
     PHAssetCollectionSubtypeAlbumCloudShared     = 101,  // iCloud的共享相册，点击照片上的共享tab创建后就能拿到了，但是前提是你要在设置中打开iCloud的共享开关（打开后才能看见共享tab）
 
     // PHAssetCollectionTypeSmartAlbum subtypes
     PHAssetCollectionSubtypeSmartAlbumGeneric    = 200,
     PHAssetCollectionSubtypeSmartAlbumPanoramas  = 201,  // 全景图、全景照片
     PHAssetCollectionSubtypeSmartAlbumVideos     = 202,  // 视频
     PHAssetCollectionSubtypeSmartAlbumFavorites  = 203,  // 标记为喜欢、收藏
     PHAssetCollectionSubtypeSmartAlbumTimelapses = 204,  // 延时拍摄、定时拍摄
     PHAssetCollectionSubtypeSmartAlbumAllHidden  = 205,  // 隐藏的
     PHAssetCollectionSubtypeSmartAlbumRecentlyAdded = 206,  // 最近添加的、近期添加
     PHAssetCollectionSubtypeSmartAlbumBursts     = 207,  // 连拍
     PHAssetCollectionSubtypeSmartAlbumSlomoVideos = 208,  // Slow Motion,高速摄影慢动作（概念不懂）
     PHAssetCollectionSubtypeSmartAlbumUserLibrary = 209,  // 相机胶卷
     PHAssetCollectionSubtypeSmartAlbumSelfPortraits PHOTOS_AVAILABLE_IOS_TVOS(9_0, 10_0) = 210, // 使用前置摄像头拍摄的作品
     PHAssetCollectionSubtypeSmartAlbumScreenshots PHOTOS_AVAILABLE_IOS_TVOS(9_0, 10_0) = 211,  // 屏幕截图
     PHAssetCollectionSubtypeSmartAlbumDepthEffect PHOTOS_AVAILABLE_IOS_TVOS(10_2, 10_1) = 212,  // 在可兼容的设备上使用景深摄像模式拍的照片（概念不懂）
     PHAssetCollectionSubtypeSmartAlbumLivePhotos PHOTOS_AVAILABLE_IOS_TVOS(10_3, 10_2) = 213,  // Live Photo资源
     PHAssetCollectionSubtypeSmartAlbumAnimated PHOTOS_AVAILABLE_IOS_TVOS(11_0, 11_0) = 214,  // 没有解释
     PHAssetCollectionSubtypeSmartAlbumLongExposures PHOTOS_AVAILABLE_IOS_TVOS(11_0, 11_0) = 215,  // 没有解释
     // Used for fetching, if you don't care about the exact subtype
     PHAssetCollectionSubtypeAny = NSIntegerMax
     } PHOTOS_ENUM_AVAILABLE_IOS_TVOS(8_0, 10_0);
 */


@end
