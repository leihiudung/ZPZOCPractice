//
//  ZPZCollectionViewController.m
//  ZPZPhotoPractice
//
//  Created by zhoupengzu on 2018/2/27.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZCollectionViewController.h"
#import <Photos/Photos.h>

@interface ZPZCollectionViewController ()

@end

@implementation ZPZCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
// 得到自己创建的处于根目录下的相册，而且因为是自己创建的，所以是可以被删除的
- (IBAction)getTopLevelCollection:(id)sender {
    PHFetchResult * result = [PHCollection fetchTopLevelUserCollectionsWithOptions:nil];
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@", obj);
    }];
}
- (IBAction)canEditOperation:(id)sender {
//    [self operationWithAssetCollectionType:PHAssetCollectionTypeMoment];
    NSLog(@"===================================");
    [self operationWithAssetCollectionType:PHAssetCollectionTypeAlbum]; // 主要包括设备之间的同步资源和iCloud的照片流、iCloud的共享资源
    NSLog(@"===================================");
    [self operationWithAssetCollectionType:PHAssetCollectionTypeSmartAlbum];
}

/**
 typedef NS_ENUM(NSInteger, PHCollectionEditOperation) {
 PHCollectionEditOperationDeleteContent    = 1, // Delete things it contains
 PHCollectionEditOperationRemoveContent    = 2, // Remove things it contains, they're not deleted from the library
 PHCollectionEditOperationAddContent       = 3, // Add things from other collection
 PHCollectionEditOperationCreateContent    = 4, // Create new things, or duplicate them from others in the same container
 PHCollectionEditOperationRearrangeContent = 5, // Change the order of things
 PHCollectionEditOperationDelete           = 6, // Deleting of the container, not the content
 PHCollectionEditOperationRename           = 7, // Renaming of the container, not the content
 } PHOTOS_AVAILABLE_IOS_TVOS(8_0, 10_0);
 */

- (void)operationWithAssetCollectionType:(PHAssetCollectionType)type {
    PHFetchResult<PHAssetCollection *> * fetchResult = [PHAssetCollection fetchAssetCollectionsWithType:type subtype:PHAssetCollectionSubtypeAny options:nil];
    NSArray<NSDictionary *> * operationArray = @[
                                                 @{@"title": @"从相册删除资源，并永久删除", @"value": @(PHCollectionEditOperationDeleteContent)},
                                                 @{@"title": @"只从当前相册删除资源", @"value": @(PHCollectionEditOperationRemoveContent)},
                                                 @{@"title": @"从其他相册添加资源", @"value": @(PHCollectionEditOperationAddContent)},
                                                 @{@"title": @"创建新的内容，或者重复创建同一个相册里的相同资源", @"value": @(PHCollectionEditOperationCreateContent)},
                                                 @{@"title": @"重新排序", @"value": @(PHCollectionEditOperationRearrangeContent)},
                                                 // 一般来说，只有自己创建的相册才能被删除和重命名，对于系统的，你是没办法操作的
                                                 @{@"title": @"删除相册，但是不删除内容", @"value": @(PHCollectionEditOperationDelete)},
                                                 @{@"title": @"重命名相册，但是不对内容重命名", @"value": @(PHCollectionEditOperationRename)},
                                                 ];
    [fetchResult enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [operationArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull inObj, NSUInteger inIdx, BOOL * _Nonnull inStop) {
            NSString * title = inObj[@"title"];
            PHCollectionEditOperation operation = [inObj[@"value"] integerValue];
            NSLog(@"%@:%@:%@", obj.localizedTitle, title, ([obj canPerformEditOperation:operation] ? @"能" : @"不能"));
        }];
    }];
}



@end
