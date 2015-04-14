//
//  ViewController.m
//  CCSplitViewControllerDemo
//
//  Created by Charles-Adrien Fournier on 10/04/15.
//  Copyright (c) 2015 Charles-Adrien Fournier. All rights reserved.
//

#import "ViewController.h"
#import "CCContentViewController.h"
#import "CCSplitViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)launchExample:(id)sender {
    
    CCSplitViewController *splitViewController = [CCSplitViewController new];
    
    CCContentViewController *vc1 = [CCContentViewController new];
    vc1.view.backgroundColor = [UIColor colorWithRed:0.20 green:0.59 blue:0.85 alpha:1.0];
    
    CCContentViewController *vc2 = [CCContentViewController new];
    vc2.view.backgroundColor = [UIColor colorWithRed:0.18 green:0.8 blue:0.44 alpha:1.0];

    splitViewController.viewControllers = [NSArray arrayWithObjects:vc1, vc2, nil];    
    splitViewController.insetsContentView = 32;
    
    [self presentViewController:splitViewController animated:YES completion:nil];
    
}


@end
