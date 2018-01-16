//
//  ZPZPersonModel.h
//  ZPZKVOPractice
//
//  Created by zhoupengzu on 2017/12/7.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZPZPersonModel : NSObject

@property (nonatomic, copy) NSString * name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) NSString * ID;
@property (nonatomic, assign) CGFloat height;

- (void)addName:(NSString *)name andID:(NSString *)ID;

@end
