//
//  CCSplitViewController.m
//  CCSplitViewControllerDemo
//
//  Created by Charles-Adrien Fournier on 10/04/15.
//  Copyright (c) 2015 Charles-Adrien Fournier. All rights reserved.
//

#import <objc/runtime.h>
#import <Masonry.h>
#import "CCSplitViewController.h"

@implementation UIViewController (CCSplitViewController)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
        [self convertSelector:@selector(navigationController) toSelector:@selector(cc_navigationController) forClass:class];
        [self convertSelector:@selector(navigationItem) toSelector:@selector(cc_navigationItem) forClass:class];
        [self convertSelector:@selector(setTitle:) toSelector:@selector(cc_setTitle:) forClass:class];
        [self convertSelector:@selector(setHidesBottomBarWhenPushed:) toSelector:@selector(cc_setHidesBottomBarWhenPushed:) forClass:class];
        [self convertSelector:@selector(setToolbarItems:) toSelector:@selector(cc_setToolbarItems:) forClass:class];
        [self convertSelector:@selector(setToolbarItems:animated:) toSelector:@selector(cc_setToolbarItems:animated:) forClass:class];
        
    });
    
}

+ (void)convertSelector:(SEL)originalSelector toSelector:(SEL)swizzledSelector forClass:(Class)class {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

#pragma mark - Swizzled Methods

#pragma message("Faire les verifications avant d'acceder aux viewControllers !!")
#pragma message("merge les conditions en une seule !")

- (UINavigationController *)cc_navigationController {
    if (self.parentViewController && [self.parentViewController isKindOfClass:[CCSplitViewController class]]) {
        if (((CCSplitViewController *)self.parentViewController).viewControllers[0] == self)
            return [self.parentViewController navigationController];
        else
            return [self cc_navigationController];
    }
    else {
        return [self cc_navigationController];
    }
}

- (UINavigationItem *)cc_navigationItem {
    if (self.parentViewController && [self.parentViewController isKindOfClass:[CCSplitViewController class]]) {
        if (((CCSplitViewController *)self.parentViewController).viewControllers[0] == self)
            return [self.parentViewController navigationItem];
        else
            return [self cc_navigationItem];
    } else {
        return [self cc_navigationItem];
    }
}

- (void)cc_setTitle:(NSString *)title {
    if (self.parentViewController && [self.parentViewController isKindOfClass:[CCSplitViewController class]]) {
        
        if (((CCSplitViewController *)self.parentViewController).viewControllers[0] == self)
            [self.parentViewController setTitle:title];
        else
            [self cc_setTitle:title];
        
    } else {
        [self cc_setTitle:title];
    }
}

- (void)cc_setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed {
    if (self.parentViewController && [self.parentViewController isKindOfClass:[CCSplitViewController class]]) {
        
        if (((CCSplitViewController *)self.parentViewController).viewControllers[0] == self)
            [self.parentViewController setHidesBottomBarWhenPushed:hidesBottomBarWhenPushed];
        else
            [self cc_setHidesBottomBarWhenPushed:hidesBottomBarWhenPushed];
    } else {
        [self cc_setHidesBottomBarWhenPushed:hidesBottomBarWhenPushed];
    }
}

- (void)cc_setToolbarItems:(NSArray *)toolbarItems {
    if (self.parentViewController && [self.parentViewController isKindOfClass:[CCSplitViewController class]]) {
        if (((CCSplitViewController *)self.parentViewController).viewControllers[0] == self)
            [self.parentViewController setToolbarItems:toolbarItems];
        else
            [self cc_setToolbarItems:toolbarItems];
    } else {
        [self cc_setToolbarItems:toolbarItems];
    }
}

- (void)cc_setToolbarItems:(NSArray *)toolbarItems animated:(BOOL)animated {
    if (self.parentViewController && [self.parentViewController isKindOfClass:[CCSplitViewController class]]) {
        if (((CCSplitViewController *)self.parentViewController).viewControllers[0] == self)
            [self.parentViewController setToolbarItems:toolbarItems animated:animated];
        else
            [self cc_setToolbarItems:toolbarItems animated:animated];
    } else {
        [self cc_setToolbarItems:toolbarItems animated:animated];
    }
}

@end


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
        [self addChildViewController:self.viewControllers[0]];
        [self.contentView.subviews[0] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
    }
    
    if ([self.viewControllers count] > 1) {
        [self.lateralView addSubview:[self.viewControllers[1] view]];
        [self addChildViewController:self.viewControllers[1]];
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
    
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (UIDeviceOrientationIsLandscape(orientation)) {
        [self showLateralView];
    } else {
        [self hideLateralView];
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {

    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (UIDeviceOrientationIsLandscape(orientation)) {
        [self showLateralView];
    } else {
        [self hideLateralView];
    }
    
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
