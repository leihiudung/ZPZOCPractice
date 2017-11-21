//
//  ZPZImageCycleScrollView.m
//  ZPZAppleFrameWork
//
//  Created by zhoupengzu on 2017/10/18.
//  Copyright © 2017年 zhoupengzu. All rights reserved.
//

#import "ZPZImageCycleScrollView.h"
#import "ZPZImageScrollModel.h"
#import <SDWebImage/SDWebImage.h>

@interface ZPZImageCycleScrollView()<UIScrollViewDelegate>

@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,assign) CGFloat contentMargin;
@property (nonatomic,assign) CGSize contentSize;
@property (nonatomic,assign) CGSize contentImgSize;
@property (nonatomic,assign) CGFloat contentImgSpace;
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) NSMutableArray<UIImageView *> * contentImageViewArr;
@property (nonatomic,copy) NSArray<ZPZImageScrollModel *> * cycleImageArr;

@end

@implementation ZPZImageCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _contentImageViewArr = [NSMutableArray array];
        _contentImgSize = frame.size;
        _contentImgSpace = 0;
        _direction = ZPZImageCycleDirectionLeftRight;
        [self configUIWithFrame:frame];
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)configUIWithFrame:(CGRect)frame{
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.clipsToBounds = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    [self updateFrame];
}

- (UIImageView *)createCommonImageView{
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapedImageToOperate)];
    [imageView addGestureRecognizer:imageTap];
    return imageView;
}

- (void)updateFrame{
    NSInteger needCount = [self countAllNeedContentImages];
    if (needCount != _contentImageViewArr.count) {  //如果需要的数目和已有的不匹配，则移除或者添加不匹配的个数
        if (needCount > _contentImageViewArr.count) {  //不够，需要添加
            for (NSInteger i = _contentImageViewArr.count; i < needCount; i++) {
                UIImageView * contentImageView = [self createCommonImageView];
                [_contentImageViewArr addObject:contentImageView];
                [_scrollView addSubview:contentImageView];
            }
        } else {  //多了，需要删除
            NSInteger moreCount = _contentImageViewArr.count - needCount;
            for (NSInteger i = 0; i < moreCount; i++) {
                UIImageView * contentImageView = _contentImageViewArr.lastObject;
                [_contentImageViewArr removeLastObject];
                [contentImageView removeFromSuperview];
                contentImageView = nil;
            }
        }
    }
    if (_direction == ZPZImageCycleDirectionUpDown) {
        _scrollView.frame = CGRectMake(0, [self getScrollViewBeginPosition], self.frame.size.width, _contentSize.height);
        CGFloat width = self.frame.size.width;
        CGFloat height = _contentImgSize.height;
        [_contentImageViewArr enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.frame = CGRectMake(0, idx * _contentSize.height, width, height);
        }];
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _scrollView.frame.size.height * needCount);
    } else {
        _scrollView.frame = CGRectMake([self getScrollViewBeginPosition], 0, _contentSize.width, self.frame.size.height);
        CGFloat width = _contentImgSize.width;
        CGFloat height = _scrollView.frame.size.height;
        [_contentImageViewArr enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.frame = CGRectMake(idx * _contentSize.width, 0, width, height);
        }];
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * needCount, _scrollView.frame.size.height);
    }
    [self resetScrollViewContentOffsetWithAnimation:NO];
}

- (NSInteger)countAllNeedContentImages{
    NSInteger count = 0;
    if (_contentMargin > 0) {
        count = 5;
    } else {
        count = 3;
    }
    return count;
}

- (CGFloat)getScrollViewBeginPosition{
    return _contentMargin + _contentImgSpace;
}

- (void)setDirection:(ZPZImageCycleDirection)direction{
    if (direction == _direction) {
        return;
    }
    _direction = direction;
    [self adjustContentImageSize];
    [self updateFrame];
}

- (void)adjustContentImageSize{
    if (_direction == ZPZImageCycleDirectionUpDown) {
        _contentSize.height = self.frame.size.height - 2 * _contentMargin - _contentImgSpace;
        if (_contentImgSize.width <= 0) {
            _contentMargin = 0;
            _contentImgSpace = 0;
            _contentImgSize.height = self.frame.size.height;
        }
        _contentSize.width = self.frame.size.width;
        _contentImgSize = CGSizeMake(_contentSize.width, _contentSize.height - _contentImgSpace);
    } else {
        _contentSize.width = self.frame.size.width - 2 * _contentMargin - _contentImgSpace;
        if (_contentImgSize.width <= 0) {
            _contentMargin = 0;
            _contentImgSpace = 0;
            _contentImgSize.width = self.frame.size.width;
        }
        _contentSize.height = self.frame.size.height;
        _contentImgSize = CGSizeMake(_contentSize.width - _contentImgSpace, _contentSize.height);
    }
}

- (void)setContentMargin:(CGFloat)margin withContentSpace:(CGFloat)contentSpace {
    _contentMargin = margin;
    _contentImgSpace = contentSpace;
    [self adjustContentImageSize];
    [self updateFrame];
}

- (void)resetScrollViewContentOffsetWithAnimation:(BOOL)isAnimate{
    if (_direction == ZPZImageCycleDirectionUpDown) {
        [_scrollView setContentOffset:CGPointMake(0, (_scrollView.contentSize.height / 2 - _scrollView.frame.size.height / 2)) animated:isAnimate];
    } else {
        [_scrollView setContentOffset:CGPointMake((_scrollView.contentSize.width / 2 - _scrollView.frame.size.width / 2), 0) animated:isAnimate];
    }
}

- (void)tapedImageToOperate{
    if (_clickedImage && _currentIndex >= 0 && _currentIndex < _cycleImageArr.count) {
        _clickedImage(_cycleImageArr[_currentIndex],_currentIndex);
    }
    NSLog(@"%f,%f",_scrollView.contentOffset.x,_scrollView.frame.origin.x);
}

- (void)updateImageCycleScrollViewContent:(NSArray<ZPZImageScrollModel *> *)cycleImageArr{
    if (cycleImageArr.count == 0) {
        return;
    }
    _cycleImageArr = cycleImageArr;
    _currentIndex = 0;
    [self updateContentImageView];
}

- (void)updateContentImageView{
    if (_cycleImageArr.count == 0) {
        return;
    }
    NSInteger middleIndex = floor(_contentImageViewArr.count / 2);
    for (NSInteger i = 0; i < _contentImageViewArr.count; i++) {
        UIImageView * imageView = _contentImageViewArr[i];
        ZPZImageScrollModel * model = nil;
        if (i < middleIndex) {
            model = _cycleImageArr[(_currentIndex + i - middleIndex + _cycleImageArr.count) % _cycleImageArr.count];
        } else if (i > middleIndex) {
            model = _cycleImageArr[(_currentIndex + i - middleIndex) % _cycleImageArr.count];
        } else {
            model = _cycleImageArr[_currentIndex];
        }
        imageView.image = [UIImage imageNamed:model.imgUrl];
    }
    [self resetScrollViewContentOffsetWithAnimation:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_cycleImageArr.count == 0) {
        return;
    }
    NSInteger tempCurrentIndex = _currentIndex;
    if (_direction == ZPZImageCycleDirectionUpDown) {
        if (scrollView.contentOffset.y <= (_scrollView.contentSize.height / 2 - _scrollView.frame.size.height * 3 / 2)) {
            tempCurrentIndex = (tempCurrentIndex - 1 + _cycleImageArr.count) % _cycleImageArr.count;
        } else if (scrollView.contentOffset.y >= (_scrollView.contentSize.height / 2 + _scrollView.frame.size.height / 2)) {
            tempCurrentIndex = (tempCurrentIndex + 1) % _cycleImageArr.count;
        }
    } else {
        if (scrollView.contentOffset.x <= (_scrollView.contentSize.width / 2 - _scrollView.frame.size.width * 3 / 2)) {
            tempCurrentIndex = (tempCurrentIndex - 1 + _cycleImageArr.count) % _cycleImageArr.count;
        } else if (scrollView.contentOffset.x >= (_scrollView.contentSize.width / 2 + _scrollView.frame.size.width / 2)) {
            tempCurrentIndex = (tempCurrentIndex + 1) % _cycleImageArr.count;
        }
    }
    if (_currentIndex != tempCurrentIndex) {
        _currentIndex = tempCurrentIndex;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView * tempView = [super hitTest:point withEvent:event];
    if (tempView) {
        tempView = _scrollView;
    }
    return tempView;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self updateContentImageView];
}

@end
