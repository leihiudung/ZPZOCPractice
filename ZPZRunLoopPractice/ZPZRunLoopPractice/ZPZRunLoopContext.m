//
//  ZPZRunLoopContext.m
//  ZPZRunLoopPractice
//
//  Created by zhoupengzu on 2017/12/27.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZRunLoopContext.h"

@implementation ZPZRunLoopContext

- (instancetype)initWithSource:(ZPZRunLoopSource *)source andLoop:(CFRunLoopRef)loop {
    self = [super init];
    if (self) {
        _source = source;
        _loop = loop;
    }
    return self;
}

@end
