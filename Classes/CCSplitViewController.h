//
//  CCSplitViewController.h
//  CCSplitViewControllerDemo
//
//  Created by Charles-Adrien Fournier on 10/04/15.
//  Copyright (c) 2015 Charles-Adrien Fournier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CCSplitViewController)
@end

@protocol CCSplitViewControllerDetails <NSObject>
@end

@interface CCSplitViewController : UIViewController

@property (nonatomic, copy) NSArray *viewControllers;

@property (nonatomic, assign) CGFloat lateralViewWidth;

// Specifies the insets between contentView and lateralView
@property (nonatomic) CGFloat insetsContentView;

- (void)setLateralViewWidth:(CGFloat)lateralViewWidth animated:(BOOL)animated;

@end
