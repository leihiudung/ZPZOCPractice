//
//  ZPZUITableView.h
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/10/23.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * 自定义tableView
 */

@class ZPZUITableViewCell;

@interface ZPZUITableView : UIScrollView

@property (nonatomic,copy) NSInteger(^numberOfRows)(ZPZUITableView * tableView,NSInteger section);
@property (nonatomic,copy) CGFloat(^heightForRowAtIndexPath)(ZPZUITableView * tableView,NSIndexPath * indexPath);
@property (nonatomic,copy) ZPZUITableViewCell *(^cellForRowAtIndexPath)(ZPZUITableView * tableView,NSIndexPath * indexPath);
- (void)reloadData;
- (ZPZUITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;

@end
