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

@protocol CCSplitViewControllerLateral <NSObject>

- (void)didUpdateLateralViewInterafaceWithWidth:(CGFloat)width;

@end

@interface CCSplitViewController : UIViewController

/**
 *  Specifies the view controller to show
 */
@property (nonatomic, copy) NSArray *viewControllers;

/**
 *  Specifies the width of lateralView in landscape mode, by default 256
 */
@property (nonatomic, assign) CGFloat lateralViewWidth;

/**
 *  Specifies the minimal width of lateralView in portrait mode, by default 0
 */
@property (nonatomic, assign) CGFloat lateralMinimumViewWidth;

/**
 *  Specifies the insets between contentView and lateralView
 */
@property (nonatomic) CGFloat insetsContentView;

/**
 *  Prevent lateralView about interface update 
 */
@property (nonatomic, assign) id<CCSplitViewControllerLateral> lateralViewController;

/**
 *  Set new width for lateral view and change interface
 *
 *  @param lateralViewWidth Width of lateralView
 *  @param animated         Animation
 */
- (void)setLateralViewWidth:(CGFloat)lateralViewWidth animated:(BOOL)animated;

@end
