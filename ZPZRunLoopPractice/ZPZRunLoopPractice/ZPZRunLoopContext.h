//
//  ZPZRunLoopContext.h
//  ZPZRunLoopPractice
//
//  Created by zhoupengzu on 2017/12/27.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZPZRunLoopSource;
/**
 * 用来管理
 */
@interface ZPZRunLoopContext : NSObject

@property (nonatomic, strong, readonly) ZPZRunLoopSource * source;
@property (nonatomic, assign, readonly) CFRunLoopRef loop;

- (instancetype)initWithSource:(ZPZRunLoopSource *)source andLoop:(CFRunLoopRef)loop;

@end
