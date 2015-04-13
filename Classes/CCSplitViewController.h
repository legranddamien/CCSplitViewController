//
//  CCSplitViewController.h
//  CCSplitViewControllerDemo
//
//  Created by Charles-Adrien Fournier on 10/04/15.
//  Copyright (c) 2015 Charles-Adrien Fournier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCSplitViewController : UIViewController

@property (nonatomic, copy) NSArray *viewControllers;

@property (nonatomic, assign) CGFloat lateralViewWidth;

@property (nonatomic) CGFloat offsetContentView;

- (void)setLateralViewWidth:(CGFloat)lateralViewWidth animated:(BOOL)animated;

@end
