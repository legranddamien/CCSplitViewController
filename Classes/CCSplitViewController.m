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

- (CCSplitViewController *)ccSplitViewController
{
    UIViewController *ctrl = self.parentViewController;
    while (![ctrl isKindOfClass:[CCSplitViewController class]] && ctrl.parentViewController != nil)
    {
        ctrl = self.parentViewController;
    }
    
    return ([ctrl isKindOfClass:[CCSplitViewController class]]) ? (CCSplitViewController *)ctrl : nil;
}

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

- (UINavigationController *)cc_navigationController {
    
    UIViewController *tmpViewController;
    CCSplitViewController *tmpSplitViewController = nil;
    
    if ([self.parentViewController isKindOfClass:[CCSplitViewController class]])
        tmpSplitViewController = ((CCSplitViewController *)self.parentViewController);
    
    if (tmpSplitViewController) {
        if ([tmpSplitViewController.viewControllers[0] conformsToProtocol:@protocol(CCSplitViewControllerLateral)])
            tmpViewController = tmpSplitViewController.viewControllers[1];
        else
            tmpViewController = tmpSplitViewController.viewControllers[0];
    }
    
    if (self.parentViewController && [self.parentViewController isKindOfClass:[CCSplitViewController class]] &&
        tmpViewController == self)
        return [self.parentViewController navigationController];
    else
        return [self cc_navigationController];
}

- (UINavigationItem *)cc_navigationItem {
    UIViewController *tmpViewController;
    CCSplitViewController *tmpSplitViewController = nil;
    
    if(self.parentViewController && [self.parentViewController isKindOfClass:[CCSplitViewController class]])
    {
        return [self.parentViewController navigationItem];
    }
    else
    {
        return [self cc_navigationItem];
    }
}

- (void)cc_setTitle:(NSString *)title {
    
    UIViewController *tmpViewController;
    CCSplitViewController *tmpSplitViewController = nil;
    
    if ([self.parentViewController isKindOfClass:[CCSplitViewController class]])
        tmpSplitViewController = ((CCSplitViewController *)self.parentViewController);
    
    if (tmpSplitViewController) {
        if ([tmpSplitViewController.viewControllers[0] conformsToProtocol:@protocol(CCSplitViewControllerLateral)])
            tmpViewController = tmpSplitViewController.viewControllers[1];
        else
            tmpViewController = tmpSplitViewController.viewControllers[0];
    }
    
    
    if (self.parentViewController && [self.parentViewController isKindOfClass:[CCSplitViewController class]] &&
        tmpViewController == self)
        [self.parentViewController setTitle:title];
    else
        [self cc_setTitle:title];
}

- (void)cc_setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed {
    UIViewController *tmpViewController;
    CCSplitViewController *tmpSplitViewController = nil;
    
    if ([self.parentViewController isKindOfClass:[CCSplitViewController class]])
        tmpSplitViewController = ((CCSplitViewController *)self.parentViewController);
    
    if (tmpSplitViewController) {
        if ([tmpSplitViewController.viewControllers[0] conformsToProtocol:@protocol(CCSplitViewControllerLateral)])
            tmpViewController = tmpSplitViewController.viewControllers[1];
        else
            tmpViewController = tmpSplitViewController.viewControllers[0];
    }
    
    if (self.parentViewController && [self.parentViewController isKindOfClass:[CCSplitViewController class]] &&
        tmpViewController == self)
        [self.parentViewController setHidesBottomBarWhenPushed:hidesBottomBarWhenPushed];
    else
        [self cc_setHidesBottomBarWhenPushed:hidesBottomBarWhenPushed];
}

- (void)cc_setToolbarItems:(NSArray *)toolbarItems {
    UIViewController *tmpViewController;
    CCSplitViewController *tmpSplitViewController = nil;
    
    if ([self.parentViewController isKindOfClass:[CCSplitViewController class]])
        tmpSplitViewController = ((CCSplitViewController *)self.parentViewController);
    
    if (tmpSplitViewController) {
        if ([tmpSplitViewController.viewControllers[0] conformsToProtocol:@protocol(CCSplitViewControllerLateral)])
            tmpViewController = tmpSplitViewController.viewControllers[1];
        else
            tmpViewController = tmpSplitViewController.viewControllers[0];
    }
    
    if (self.parentViewController && [self.parentViewController isKindOfClass:[CCSplitViewController class]] &&
        tmpViewController == self)
        [self.parentViewController setToolbarItems:toolbarItems];
    else
        [self cc_setToolbarItems:toolbarItems];
}

- (void)cc_setToolbarItems:(NSArray *)toolbarItems animated:(BOOL)animated {
    UIViewController *tmpViewController;
    CCSplitViewController *tmpSplitViewController = nil;
    
    if ([self.parentViewController isKindOfClass:[CCSplitViewController class]])
        tmpSplitViewController = ((CCSplitViewController *)self.parentViewController);
    
    if (tmpSplitViewController) {
        if ([tmpSplitViewController.viewControllers[0] conformsToProtocol:@protocol(CCSplitViewControllerLateral)])
            tmpViewController = tmpSplitViewController.viewControllers[1];
        else
            tmpViewController = tmpSplitViewController.viewControllers[0];
    }
    
    if (self.parentViewController && [self.parentViewController isKindOfClass:[CCSplitViewController class]] &&
        tmpViewController == self)
        [self.parentViewController setToolbarItems:toolbarItems animated:animated];
    else
        [self cc_setToolbarItems:toolbarItems animated:animated];
}

@end

@interface CCSplitViewController ()

@property (nonatomic) UIView *firstView;
@property (nonatomic) UIView *separatorView;
@property (nonatomic) UIView *secondView;

@property (nonatomic, strong) MASConstraint *lateralWidth;
@property (nonatomic, strong) MASConstraint *contentInsets;

@end

@implementation CCSplitViewController

@synthesize lateralViewWidth = _lateralViewWidth;

#pragma mark - Lifecycle

- (instancetype)init {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.lateralMinimumViewWidth = 0;
        self.lateralViewWidth = 256;
        self.insetsContentView = 0;
        self.separatorColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        self.lateralMinimumViewWidth = 0;
        self.lateralViewWidth = 256;
        self.insetsContentView = 0;
        self.separatorColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithViewControllers:(NSArray *)viewControllers
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.lateralMinimumViewWidth = 0;
        self.lateralViewWidth = 256;
        self.insetsContentView = 0;
        self.separatorColor = [UIColor clearColor];
        self.viewControllers = viewControllers;
    }
    return self;
}

- (void)setViewControllers:(NSArray *)viewControllers
{
    [self removeCurrentControllersFromViews];
    _viewControllers = viewControllers;
    [self addControllersToViews];
}

- (void)addControllersToViews
{
    if(!self.firstView) return;
    
    if ([self.viewControllers count] > 0) {
        [self addChildViewController:self.viewControllers[0]];
        [self.firstView addSubview:[self.viewControllers[0] view]];
        [self.viewControllers[0] didMoveToParentViewController:self];
        [self.firstView.subviews[0] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.firstView);
        }];
    }
    
    if ([self.viewControllers count] > 1) {
        [self showDetailViewController:self.viewControllers[1] sender:self];
    }
}

- (void)removeCurrentControllersFromViews
{
    if(!self.firstView) return;
    
    for (UIViewController *ctrl in self.viewControllers)
    {
        [ctrl.view removeFromSuperview];
        [ctrl removeFromParentViewController];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.firstView = [UIView new];
    self.separatorView = [UIView new];
    self.separatorView.backgroundColor = self.separatorColor;
    self.secondView = [UIView new];
    
    [self.view addSubview:self.firstView];
    [self.view addSubview:self.separatorView];
    [self.view addSubview:self.secondView];
    
    [self addControllersToViews];
    
    [self createView];
    
    BOOL portrait = NO;
    
    if(floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1)
    {
        portrait = (self.view.frame.size.height > self.view.frame.size.width);
    }
    else
    {
        portrait = UIInterfaceOrientationIsPortrait(self.interfaceOrientation);
    }
    
    if (!portrait)
    {
        [self showLateralViewAnimated:NO];
    }
    else
    {
        if (self.lateralMinimumViewWidth == 0)
            [self hideLateralViewAnimated:NO];
        else
            [self updateLateralViewForPortrait];
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    if(floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) return;
    
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    BOOL portrait = UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
    
    //    if (self.view.frame.size.width > self.view.frame.size.height) //size did not changed yet ! and it better to use UIInterfaceOrientation returned by the method
    //        portrait = NO;
    //    else
    //        portrait = YES;
    
    if (portrait && self.lateralMinimumViewWidth == 0) {
        [self hideLateralViewAnimated:YES];
    } else if (portrait && self.lateralMinimumViewWidth != 0) {
        [self updateLateralViewForPortrait];
    } else if (!portrait && self.lateralMinimumViewWidth == 0) {
        [self showLateralViewAnimated:YES];
    } else if (!portrait && self.lateralMinimumViewWidth != 0) {
        [self updateLateralViewForLandscape];
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    BOOL portrait;
    
    if (size.width > size.height)
        portrait = NO;
    else
        portrait = YES;
    
    
    if (portrait && self.lateralMinimumViewWidth == 0) {
        [self hideLateralViewAnimated:YES];
    } else if (portrait && self.lateralMinimumViewWidth != 0) {
        [self updateLateralViewForPortrait];
    } else if (!portrait && self.lateralMinimumViewWidth == 0) {
        [self showLateralViewAnimated:YES];
    } else if (!portrait && self.lateralMinimumViewWidth != 0) {
        [self updateLateralViewForLandscape];
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.viewControllers[0] supportedInterfaceOrientations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

- (void)showDetailViewController:(UIViewController *)vc sender:(id)sender
{
    if(self.secondView.subviews.count > 0)
    {
        [(UIViewController *)self.viewControllers[1] removeFromParentViewController];
        [self.secondView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    if(self.viewControllers.count <= 1 || self.viewControllers[1] != vc)
    {
        NSArray *array = @[self.viewControllers[0], vc];
        self.viewControllers = array;
    }
    
    [self addChildViewController:self.viewControllers[1]];
    
    self.navigationItem.titleView = nil;
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
    
    UIView *view = [self.viewControllers[1] view];
    
    [self.secondView addSubview:view];
    [self.viewControllers[1] didMoveToParentViewController:self];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.secondView);
    }];
    
    [self.view layoutIfNeeded];
}

#pragma mark - private

- (void)createView {
    if ([self.viewControllers[0] conformsToProtocol:@protocol(CCSplitViewControllerLateral)])
    {
        [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
            self.lateralWidth = make.width.equalTo(@(self.lateralViewWidth));
            make.left.mas_equalTo(self.view);
            make.top.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view);
        }];
        
        [self.separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.firstView.mas_right);
            make.top.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view);
            make.width.mas_equalTo(@(1 / [UIScreen mainScreen].scale));
        }];
        
        [self.secondView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.view);
            make.top.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view);
            self.contentInsets = make.left.mas_equalTo(self.separatorView.mas_right).with.insets(UIEdgeInsetsMake(0, self.insetsContentView, 0, 0));
        }];
    }
    else
    {
        [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view);
            make.top.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view);
            self.contentInsets = make.right.mas_equalTo(self.separatorView.mas_left).with.insets(UIEdgeInsetsMake(0, 0, 0, self.insetsContentView));
            
        }];
        
        [self.separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view);
            make.width.mas_equalTo(@(1 / [UIScreen mainScreen].scale));
            make.right.mas_equalTo(self.secondView.mas_left);
        }];
        
        [self.secondView mas_makeConstraints:^(MASConstraintMaker *make) {
            self.lateralWidth = make.width.equalTo(@(self.lateralViewWidth));
            make.right.mas_equalTo(self.view);
            make.top.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view);
        }];
    }
}

- (void)hideLateralViewAnimated:(BOOL)animated {
    _isCompact = YES;
    self.lateralWidth.mas_equalTo(@(0));
    self.contentInsets.with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    if (animated)
        [UIView animateWithDuration:0.35 animations:^{
            [self.view layoutIfNeeded];
        }];
    else
        [self.view layoutIfNeeded];
}

- (void)showLateralViewAnimated:(BOOL)animated {
    _isCompact = NO;
    self.lateralWidth.mas_equalTo(@(self.lateralViewWidth));
    self.contentInsets.with.insets(UIEdgeInsetsMake(0, 0, 0, self.insetsContentView));
    if (animated)
        [UIView animateWithDuration:0.35 animations:^{
            [self.view layoutIfNeeded];
        }];
    else
        [self.view layoutIfNeeded];
}

- (void)updateLateralViewForPortrait {
    _isCompact = YES;
    self.lateralWidth.mas_equalTo(@(self.lateralMinimumViewWidth));
    self.contentInsets.with.insets(UIEdgeInsetsMake(0, 0, 0, self.insetsContentView));
    
    if (self.lateralViewController && [self.lateralViewController respondsToSelector:@selector(didUpdateLateralViewInterafaceWithWidth:compact:)])
        [self.lateralViewController didUpdateLateralViewInterafaceWithWidth:self.lateralMinimumViewWidth compact:YES];
}

- (void)updateLateralViewForLandscape {
    _isCompact = NO;
    self.lateralWidth.mas_equalTo(@(self.lateralViewWidth));
    self.contentInsets.with.insets(UIEdgeInsetsMake(0, 0, 0, self.insetsContentView));
    
    if (self.lateralViewController && [self.lateralViewController respondsToSelector:@selector(didUpdateLateralViewInterafaceWithWidth:compact:)])
        [self.lateralViewController didUpdateLateralViewInterafaceWithWidth:self.lateralViewWidth compact:NO];
}

- (UIViewController<CCSplitViewControllerLateral> *)lateralViewController
{
    if(self.viewControllers.count > 0)
    {
        if([self.viewControllers[0] conformsToProtocol:@protocol(CCSplitViewControllerLateral)])
        {
            return self.viewControllers[0];
        }
        
        else if (self.viewControllers.count > 1 && [self.viewControllers[1] conformsToProtocol:@protocol(CCSplitViewControllerLateral)])
        {
            return self.viewControllers[1];
        }
    }
    
    return nil;
}

@end
