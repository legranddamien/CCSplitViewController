//
//  CCDetailsViewController.m
//  CCSplitViewControllerDemo
//
//  Created by Charles-Adrien Fournier on 27/04/15.
//  Copyright (c) 2015 Charles-Adrien Fournier. All rights reserved.
//

#import <Masonry.h>
#import "CCDetailsViewController.h"

@interface CCDetailsViewController () 

@property UIScrollView *scrollView;

@property UIView *scrollViewContent;

@end

@implementation CCDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.scrollView = [UIScrollView new];
    self.scrollViewContent = [UIView new];
    
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithRed:0.18 green:0.8 blue:0.44 alpha:1.0];

    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.scrollViewContent];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.scrollViewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.scrollView);
        make.edges.mas_equalTo(self.scrollView);
    }];
    
    [self.navigationItem setTitle:@"detailsView"];
    
    self.scrollView.contentInset = UIEdgeInsetsMake([self.topLayoutGuide length], 0, [self.bottomLayoutGuide length], 0);
    
    UITextView *lastTextView = nil;
    
    for (int i = 0; i < 10; i++) {
        UITextView *textView = [UITextView new];
        
        textView.editable = NO;
        textView.text = @"Bonjour, bonjour";
        textView.backgroundColor = [UIColor clearColor];
        
        [self.scrollViewContent addSubview:textView];
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.scrollViewContent);
            make.right.mas_equalTo(self.scrollViewContent);
            make.height.mas_equalTo(100);
            
            if (lastTextView) {
                make.top.mas_equalTo(lastTextView.mas_bottom).with.offset(30);
            } else {
                make.top.mas_equalTo(self.scrollViewContent).with.offset(30);
            }
            
            if (i == 9) {
                make.bottom.mas_equalTo(self.scrollViewContent);
            }
        }];
        lastTextView = textView;
    }
    
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.scrollView.contentInset = UIEdgeInsetsMake([self.topLayoutGuide length], 0, [self.bottomLayoutGuide length], 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CCSplitViewLateralProtocol

- (void)didUpdateLateralViewInterafaceWithWidth:(CGFloat)width compact:(BOOL)compact {
    NSLog(@"Interafce Update with width : %f", width);
}

@end
