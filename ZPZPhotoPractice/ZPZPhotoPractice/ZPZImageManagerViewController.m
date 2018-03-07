//
//  ZPZImageManagerViewController.m
//  ZPZPhotoPractice
//
//  Created by zhoupengzu on 2018/3/6.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZImageManagerViewController.h"
#import <Photos/Photos.h>

@interface ZPZPhotoModel: NSObject

@property (nonatomic, strong) PHAsset * asset;

@end

@implementation ZPZPhotoModel

@end

//==============================================
@interface ZPZPhotoCell: UICollectionViewCell

@property (nonatomic, strong, readonly) UIImageView * imageView;
@property (nonatomic, copy) NSString * identifier;

@end

@implementation ZPZPhotoCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _imageView.backgroundColor = [UIColor whiteColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self.contentView addSubview:_imageView];
    }
    return self;
}

@end

//===============================================================================================
@interface ZPZImageManagerViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, PHPhotoLibraryChangeObserver>

@property (nonatomic, strong) UICollectionView * photoCollectionView;
@property (nonatomic, strong) NSMutableArray<ZPZPhotoModel *> * dataSourceArr;
@property (nonatomic, assign) CGSize thumbilImageSize;
@property (nonatomic, strong) PHFetchResult<PHAsset *> * assetFetchResult;

@end

@implementation ZPZImageManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
    [self getAssetsFromCameraRoll];
}

- (void)configUI {
    CGFloat space = 15;
    NSInteger columns = 3;
    CGFloat itemWidth = floor(([UIScreen mainScreen].bounds.size.width - 2 * space - (columns - 1) * space) / columns);
    CGFloat itemHeight = itemWidth;
    CGFloat scale = [UIScreen mainScreen].scale;
    _thumbilImageSize = CGSizeMake(itemWidth * scale, itemHeight * scale);
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
    flowLayout.sectionInset = UIEdgeInsetsMake(space, space, space, space);
    flowLayout.minimumLineSpacing = space;  // 行与行之间的距离，但是要注意滚动的方向，方向不同，代表的意义不同，它始终和滚动方向垂直
    flowLayout.minimumInteritemSpacing = space;  // 列与列之间的距离，意义同上
    
    _photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:flowLayout];
    _photoCollectionView.backgroundColor = [UIColor whiteColor];
    _photoCollectionView.delegate = self;
    _photoCollectionView.dataSource = self;
    [self.view addSubview:_photoCollectionView];
    
    [_photoCollectionView registerClass:[ZPZPhotoCell class] forCellWithReuseIdentifier:@"photo_cell"];
    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    NSLog(@"changed");
}

#pragma mark - 获取图片数据（相机胶卷中的）
- (void)getAssetsFromCameraRoll {
    _dataSourceArr = [NSMutableArray array];
    PHFetchResult<PHAssetCollection *> * collectionFetch = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    [collectionFetch enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PHFetchResult<PHAsset *> * assetFetch = [PHAsset fetchAssetsInAssetCollection:obj options:nil];
        _assetFetchResult = assetFetch;
        [assetFetch enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZPZPhotoModel * model = [[ZPZPhotoModel alloc] init];
            model.asset = obj;
            [_dataSourceArr addObject:model];
        }];
    }];
    [_photoCollectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSourceArr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZPZPhotoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo_cell" forIndexPath:indexPath];
    if (indexPath.item >= _dataSourceArr.count) {
        return cell;
    }
    // 给图片赋值
    ZPZPhotoModel * model = _dataSourceArr[indexPath.item];
    cell.identifier = model.asset.localIdentifier;
    // 这里可能有崩溃，但是没复现出来
    // 这里的返回的ID不是唯一的
    // PHImageManagerMaximumSize 用于获取原数据
    [[PHImageManager defaultManager] requestImageForAsset:model.asset targetSize:_thumbilImageSize contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if ([model.asset.localIdentifier isEqualToString:cell.identifier] && result != nil) {
            cell.imageView.image = result;
        }
    }];
    return cell;
}

- (void)dealloc {
    [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
    NSLog(@"release");
}

@end
