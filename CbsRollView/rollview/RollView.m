//
//  RollView.m
//  CbsRollView
//
//  Created by 陈秉慎 on 2/24/16.
//  Copyright © 2016 cbs. All rights reserved.
//

#import "RollView.h"
#define COUNT self.imageArray.count
#define SVIEWWIDTH self.frame.size.width
#define SVIEWHEIGHT self.frame.size.height

@implementation RollView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.rollScrollView];
        [self addSubview:self.pageControl];
        [self addNSTimer];
    }
    return self;
}
#pragma mark - delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == 0) {
        self.rollScrollView.contentOffset = CGPointMake(COUNT * SVIEWWIDTH, 0);
        self.pageControl.currentPage = (COUNT - 1);
    }else if (scrollView.contentOffset.x == (COUNT + 1) * SVIEWWIDTH){
        self.rollScrollView.contentOffset = CGPointMake(SVIEWWIDTH, 0);
        self.pageControl.currentPage = 0;
    }else{
        int pagenum = (round(scrollView.contentOffset.x/self.rollImgView.frame.size.width) - 1);
        [self.pageControl setCurrentPage:pagenum];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeNSTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addNSTimer];
}
#pragma mark - 定时器
- (void)addNSTimer
{
    if (self.timer == nil) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
        self.timer = timer;
    }
}

- (void)removeNSTimer
{
    [self.timer invalidate];
    self.timer =nil;
}

- (void)nextPage
{
    if (self.rollScrollView.contentOffset.x == ((COUNT) * self.rollImgView.frame.size.width)) {
        [self.rollScrollView scrollRectToVisible:CGRectMake(SVIEWWIDTH, 0, SVIEWWIDTH, SVIEWHEIGHT) animated:YES];
    }else{
        [self.rollScrollView scrollRectToVisible:CGRectMake(self.rollScrollView.contentOffset.x + self.rollImgView.frame.size.width, 0, SVIEWWIDTH, SVIEWHEIGHT) animated:YES];
    }
}
#pragma mark - getters
- (UIScrollView *)rollScrollView
{
    if (_rollScrollView == nil) {
        _rollScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SVIEWWIDTH, SVIEWHEIGHT)];
        _rollScrollView.delegate = self;
        _rollScrollView.contentSize = CGSizeMake((COUNT + 2) * SVIEWWIDTH, SVIEWHEIGHT);
        //使子视图imageview自动适配scrollview的大小
        [_rollScrollView setAutoresizesSubviews:YES];
        //将scrollview设成分页形式
        [_rollScrollView setPagingEnabled:YES];
        //隐藏scrollview两边的滚动条
        [_rollScrollView setShowsVerticalScrollIndicator:NO];
        [_rollScrollView setShowsHorizontalScrollIndicator:NO];
        //设置scrollview初始的位置为第二部分来显示第一张广告
        _rollScrollView.contentOffset = CGPointMake(SVIEWWIDTH, 0);
    }
    return _rollScrollView;
}

- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((SVIEWWIDTH - _pageControl.bounds.size.width)/2, SVIEWHEIGHT - 10, _pageControl.bounds.size.width, _pageControl.bounds.size.height)];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        [_pageControl setNumberOfPages:COUNT];
    }
    return _pageControl;
}

- (NSMutableArray *)imageArray
{
    if (_imageArray == nil) {
        _imageArray = [[NSMutableArray alloc] init];
        [_imageArray addObject:[UIImage imageNamed:@"pic1"]];
        [_imageArray addObject:[UIImage imageNamed:@"pic2"]];
        [_imageArray addObject:[UIImage imageNamed:@"pic3"]];
        [_imageArray addObject:[UIImage imageNamed:@"pic4"]];
        [_imageArray addObject:[UIImage imageNamed:@"pic5"]];
    }
    return _imageArray;
}

- (UIImageView *)rollImgView
{
    if (_rollImgView == nil) {
        //第一个放最后一个图片
        _rollImgView = [[UIImageView alloc] init];
        _rollImgView.frame = CGRectMake(0, 0, SVIEWWIDTH, SVIEWHEIGHT);
        [_rollImgView setImage:[_imageArray objectAtIndex:(COUNT - 1)]];
        [self.rollScrollView addSubview:_rollImgView];
        //最后一个放第一张图片
        _rollImgView = [[UIImageView alloc] init];
        _rollImgView.frame = CGRectMake(SVIEWWIDTH * (COUNT + 1), 0, SVIEWWIDTH, SVIEWHEIGHT);
        [_rollImgView setImage:[_imageArray objectAtIndex:0]];
        [self.rollScrollView addSubview:_rollImgView];
        
        for (int i = 0; i < COUNT; i++) {
            _rollImgView = [[UIImageView alloc] init];
            _rollImgView.frame = CGRectMake(SVIEWWIDTH * (i + 1), 0, SVIEWWIDTH, SVIEWHEIGHT);
            [_rollImgView setImage:[_imageArray objectAtIndex:i]];
            [self.rollScrollView addSubview:_rollImgView];
        }
    }
    return _rollImgView;
}
@end
