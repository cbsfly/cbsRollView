//
//  ShowViewController.m
//  CbsRollView
//
//  Created by 陈秉慎 on 2/24/16.
//  Copyright © 2016 cbs. All rights reserved.
//

#import "ShowViewController.h"
#import "RollView.h"

@interface ShowViewController ()
@property (nonatomic, strong) RollView *rollView;
@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.rollView];
}

- (RollView *)rollView
{
    if (_rollView == nil) {
        _rollView = [[RollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    }
    return _rollView;
}

@end
