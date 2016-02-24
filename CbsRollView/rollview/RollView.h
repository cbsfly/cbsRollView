//
//  RollView.h
//  CbsRollView
//
//  Created by 陈秉慎 on 2/24/16.
//  Copyright © 2016 cbs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RollView : UIView<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *rollScrollView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) UIImageView *rollImgView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@end
