//
//  ZPZUITableView.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/10/23.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZUITableView.h"
#import "ZPZUITableViewRowModel.h"
#import "ZPZUITableViewCell.h"

@interface ZPZUITableView ()

@property (nonatomic,copy) NSArray<ZPZUITableViewRowModel *> * rowsModelArr;
@property (nonatomic,strong) NSMutableDictionary<NSNumber *,ZPZUITableViewCell *> * visibleCellDic;
@property (nonatomic,strong) NSMutableArray<ZPZUITableViewCell *> * reusePoolArr;

@property (nonatomic,assign) BOOL isNeedCheckVisibleDic;
@property (nonatomic,strong) NSIndexPath * checkIndexPath;

@end

@implementation ZPZUITableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _visibleCellDic = [NSMutableDictionary dictionary];
        _reusePoolArr = [NSMutableArray array];
    }
    return self;
}

- (void)reloadData{
    [_visibleCellDic removeAllObjects];
    [_reusePoolArr removeAllObjects];
    _rowsModelArr = nil;
    [self prepareData];
    [self setNeedsLayout];
}
//异步执行
/**
 * 1.算出可视范围(二分法查找)
 * 2.获取可视范围内的cell
 * 3.将移出可视范围的cell添加到重用池中
 */
- (void)layoutSubviews{
    CGFloat beginY = self.contentOffset.y < 0 ? 0 : self.contentOffset.y;
    CGFloat endY = (self.contentOffset.y + self.frame.size.height) > self.contentSize.height ? self.contentSize.height : (self.contentOffset.y + self.frame.size.height);
    NSInteger beginIndex = [self findOutTheVisibleBeginIndexForLimit:beginY];
    NSInteger endIndex = [self findOutTheVisibleEndIndexForLimit:endY];
    //添加新的cell
    for (NSInteger i = beginIndex; i <= endIndex; i++) {
        if (_cellForRowAtIndexPath) {
            ZPZUITableViewRowModel * rowModel = _rowsModelArr[i];
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            //如何确定当前要加载的cell是已经在界面上还是从重用池里拿的还是创建的新的
            _isNeedCheckVisibleDic = YES;
            _checkIndexPath = indexPath;
            ZPZUITableViewCell * cell = _cellForRowAtIndexPath(self,indexPath);
            cell.frame = CGRectMake(0, rowModel.originY, self.frame.size.width, rowModel.rowHeight);
            //如果当前cell已经在可视范围内，则不需要添加
            if (!_visibleCellDic[@(i)]) {
                 [self addSubview:cell];
            }
            
            [_visibleCellDic setObject:cell forKey:@(i)];
            [_reusePoolArr removeObject:cell];  //该cell有可能是重用池中的，所以需要把重用池中的移出
        }
    }
    //移除原来的移出的cell到重用池中
    NSArray<NSNumber *> * allVisibleKeys = _visibleCellDic.allKeys;
    [allVisibleKeys enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.integerValue < beginIndex || obj.integerValue > endIndex) {
            ZPZUITableViewCell * cell = _visibleCellDic[obj];
            _visibleCellDic[obj] = nil;
            [_reusePoolArr addObject:cell];
//            [cell removeFromSuperview];
        }
    }];
}
/**
 * 二分法查找位置
 */
- (NSInteger)findOutTheVisibleBeginIndexForLimit:(CGFloat)limit{
    NSInteger minIndex = 0;
    NSInteger maxIndex = _rowsModelArr.count - 1;
    NSInteger mid = 0;
    while (minIndex < maxIndex) {
        mid = (minIndex + maxIndex) / 2;
        ZPZUITableViewRowModel * midRowModel = _rowsModelArr[mid];
        if (midRowModel.originY > limit) {
            maxIndex = mid;
            if (maxIndex - minIndex == 1) {
                return minIndex;
            }
        } else if (midRowModel.originY < limit) {
            minIndex = mid;
            if (maxIndex - minIndex == 1) {
                return maxIndex;
            }
            if ((midRowModel.originY + midRowModel.rowHeight) > limit) {
                return mid;
            }
        } else {
            return mid;
        }
    }
    
    return -1;
}
- (NSInteger)findOutTheVisibleEndIndexForLimit:(CGFloat)limit{
    NSInteger minIndex = 0;
    NSInteger maxIndex = _rowsModelArr.count - 1;
    NSInteger mid = 0;
    while (minIndex < maxIndex) {
        mid = (minIndex + maxIndex) / 2;
        ZPZUITableViewRowModel * midRowModel = _rowsModelArr[mid];
        if (midRowModel.originY > limit) {
            maxIndex = mid;
            if (maxIndex - minIndex == 1) {
                return minIndex;
            }
        } else if (midRowModel.originY < limit) {
            minIndex = mid;
            if (maxIndex - minIndex == 1) {
                return maxIndex;
            }
            if((midRowModel.originY + midRowModel.rowHeight) >= limit) {
                return mid;
            }
        } else if (midRowModel.originY == limit) {
            return mid;
        }
    }

    return -1;
}
/**
 * 1.获取行数
 * 2.获取行高，并转化成模型
 * 3.设置contentSize
 */
- (void)prepareData{
    NSInteger rows = 0;
    NSInteger section = 0;
    if (_numberOfRows) {
        rows = _numberOfRows(self,section);
    }
    NSMutableArray * rowsModelArr = [NSMutableArray array];
    CGFloat allHeight = 0;
    for (NSInteger i = 0; i < rows; i++) {
        CGFloat rowHeight = 0;
        if (_heightForRowAtIndexPath) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:section];
            rowHeight = _heightForRowAtIndexPath(self,indexPath);
        }
        ZPZUITableViewRowModel * rowModel = [[ZPZUITableViewRowModel alloc] init];
        rowModel.rowHeight = rowHeight;
        rowModel.originY = allHeight;
        [rowsModelArr addObject:rowModel];
        allHeight += rowHeight;
    }
    _rowsModelArr = rowsModelArr;
    self.contentSize = CGSizeMake(self.frame.size.width, allHeight);
}

- (ZPZUITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    //如何确定当前要加载的cell是已经在界面上还是从重用池里拿的还是创建的新的
    if (_isNeedCheckVisibleDic) {
        __block ZPZUITableViewCell * cell = nil;
        _isNeedCheckVisibleDic = NO;
        cell = _visibleCellDic[@(_checkIndexPath.row)];
        if (cell) {
            return cell;
        }
        [_reusePoolArr enumerateObjectsUsingBlock:^(ZPZUITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.identifier isEqualToString:identifier]) {
                cell = obj;
                *stop = YES;
            }
        }];
        return cell;
    }
    return nil;
}

@end
