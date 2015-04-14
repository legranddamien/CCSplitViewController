//
//  CCSplitViewController.m
//  CCSplitViewControllerDemo
//
//  Created by Charles-Adrien Fournier on 10/04/15.
//  Copyright (c) 2015 Charles-Adrien Fournier. All rights reserved.
//

#import <Masonry.h>
#import "CCSplitViewController.h"

@interface CCSplitViewController ()

@property (nonatomic) UIView *contentView;
@property (nonatomic) UIView *lateralView;

@property (nonatomic, strong) MASConstraint *lateralWidth;
@property (nonatomic, strong) MASConstraint *contentInsets;

@end

@implementation CCSplitViewController

@synthesize lateralViewWidth = _lateralViewWidth;

#pragma mark - Lifecycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.lateralViewWidth = 256;
        self.insetsContentView = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentView = [UIView new];
    self.lateralView = [UIView new];
        
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.lateralView];
    
    if ([self.viewControllers count] > 0) {
        [self.contentView addSubview:[self.viewControllers[0] view]];
        [self.contentView.subviews[0] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
    }
    
    if ([self.viewControllers count] > 1) {
        [self.lateralView addSubview:[self.viewControllers[1] view]];
        [self.lateralView.subviews[0] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.lateralView);
        }];
    }
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        self.contentInsets = make.right.mas_equalTo(self.lateralView.mas_left).with.insets(UIEdgeInsetsMake(0, 0, 0, self.insetsContentView));
        
    }];
    
    [self.lateralView mas_makeConstraints:^(MASConstraintMaker *make) {
        self.lateralWidth = make.width.equalTo(@(self.lateralViewWidth));
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
}

- (BOOL)shouldAutorotate {
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (UIDeviceOrientationIsLandscape(orientation)) {
        [self showLateralView];
    } else {
        [self hideLateralView];
    }
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return [self.viewControllers[0] supportedInterfaceOrientations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Accessors

- (void)setLateralViewWidth:(CGFloat)lateralViewWidth {
    [self setLateralViewWidth:lateralViewWidth animated:YES];
}

- (void)setLateralViewWidth:(CGFloat)lateralViewWidth animated:(BOOL)animated {
    if (_lateralViewWidth == lateralViewWidth)
        return;

    _lateralViewWidth = lateralViewWidth;
    
    if (!UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation]))
        return;

    if (!self.lateralWidth)
        return;
    
    self.lateralWidth.equalTo(@(self.lateralViewWidth));

    if (animated) {
        [UIView animateWithDuration:1.0 animations:^{
            [self.view layoutIfNeeded];
        }];
    } else {
        [self.view layoutIfNeeded];
    }
}

#pragma mark - private

- (void)hideLateralView {
    self.lateralWidth.mas_equalTo(@(0));
    self.contentInsets.with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    [UIView animateWithDuration:0.35 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)showLateralView {
    self.lateralWidth.mas_equalTo(@(self.lateralViewWidth));
    self.contentInsets.with.insets(UIEdgeInsetsMake(0, 0, 0, self.insetsContentView));
    [UIView animateWithDuration:0.35 animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
