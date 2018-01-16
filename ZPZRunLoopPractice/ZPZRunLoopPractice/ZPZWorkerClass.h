//
//  ZPZWorkerClass.h
//  ZPZRunLoopPractice
//
//  Created by zhoupengzu on 2017/12/27.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZPZWorkerClass : NSObject

@property (nonatomic, assign) BOOL shouldExit;

+ (void)launchThreadWithPort:(NSPort *)port;

@end
