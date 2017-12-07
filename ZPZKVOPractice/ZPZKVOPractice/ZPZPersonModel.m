//
//  ZPZPersonModel.m
//  ZPZKVOPractice
//
//  Created by zhoupengzu on 2017/12/7.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZPersonModel.h"

@implementation ZPZPersonModel

+ (BOOL)automaticallyNotifiesObserversOfName {
    return NO;
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    if ([key isEqualToString:@"name"] || [key isEqualToString:@"ID"]) {
        return NO;
    }
    BOOL result = [super automaticallyNotifiesObserversForKey:key];
    return result;
}

- (void)addName:(NSString *)name andID:(NSString *)ID {
    
}

- (void)setName:(NSString *)name {
    [self willChangeValueForKey:@"name"];
    _name = name;
    [self didChangeValueForKey:@"name"];
}

@end
