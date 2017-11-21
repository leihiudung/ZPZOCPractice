//
//  ZPZImageScrollManager.h
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/10/18.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZPZImageScrollModel;

typedef void(^ClickedImage)(ZPZImageScrollModel * imageInfo,NSInteger currentIndex);

typedef NS_ENUM(NSInteger,ZPZImageCycleDirection) {
    ZPZImageCycleDirectionLeftRight,
    ZPZImageCycleDirectionUpDown,
};

@interface ZPZImageScrollManager : NSObject

@end
