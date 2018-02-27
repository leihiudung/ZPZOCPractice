//
//  ZPZCollectionListViewController.m
//  ZPZPhotoPractice
//
//  Created by zhoupengzu on 2018/2/26.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZCollectionListViewController.h"
#import <Photos/Photos.h>

/**
 * 一些概念
 * typedef NS_ENUM(NSInteger, PHCollectionListType) {
     PHCollectionListTypeMomentList    = 1,
     PHCollectionListTypeFolder        = 2,
     PHCollectionListTypeSmartFolder   = 3,
     } PHOTOS_ENUM_AVAILABLE_IOS_TVOS(8_0, 10_0);
 
 * typedef NS_ENUM(NSInteger, PHCollectionListSubtype) {
 
     // PHCollectionListTypeMomentList subtypes
     PHCollectionListSubtypeMomentListCluster    = 1,
     PHCollectionListSubtypeMomentListYear       = 2,
 
     // PHCollectionListTypeFolder subtypes
     PHCollectionListSubtypeRegularFolder        = 100,
 
     // PHCollectionListTypeSmartFolder subtypes
     PHCollectionListSubtypeSmartFolderEvents    = 200,
     PHCollectionListSubtypeSmartFolderFaces     = 201,
 
     // Used for fetching if you don't care about the exact subtype
     PHCollectionListSubtypeAny = NSIntegerMax
     } PHOTOS_ENUM_AVAILABLE_IOS_TVOS(8_0, 10_0);
 *
 */

@interface ZPZCollectionListViewController ()

@end

@implementation ZPZCollectionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test];
}

- (void)test {
//    PHFetchResult * result = [PHCollectionList fetchCollectionListsWithType:PHCollectionListTypeSmartFolder subtype:PHCollectionListSubtypeAny options:nil];
    PHFetchResult * result = [PHCollection fetchTopLevelUserCollectionsWithOptions:nil];
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@", obj);
    }];
//    [result enumerateObjectsUsingBlock:^(PHCollectionList *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        PHFetchResult * collectionResult = [PHAssetCollection fetchCollectionsInCollectionList:obj options:nil];
//        NSLog(@"%@", collectionResult);
//    }];
}

@end
