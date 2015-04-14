//
//  CCContentViewController.m
//  CCSplitViewControllerDemo
//
//  Created by Charles-Adrien Fournier on 13/04/15.
//  Copyright (c) 2015 Charles-Adrien Fournier. All rights reserved.
//

#import <Masonry.h>
#import "CCContentViewController.h"

@interface CCContentViewController ()

@property UIScrollView *scrollView;

@property UIView *scrollViewContent;

@end

@implementation CCContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = [UIScrollView new];
    self.scrollViewContent = [UIView new];
    
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.scrollViewContent];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.scrollViewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.scrollView);
        make.edges.mas_equalTo(self.scrollView);
    }];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
