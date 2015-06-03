//
//  ViewController.m
//  CCSplitViewControllerDemo
//
//  Created by Charles-Adrien Fournier on 10/04/15.
//  Copyright (c) 2015 Charles-Adrien Fournier. All rights reserved.
//

#import "ViewController.h"
#import "CCContentViewController.h"
#import "CCDetailsViewController.h"
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
    
    UINavigationController *navigationController = [UINavigationController new];
    
    CCSplitViewController *splitViewController = [CCSplitViewController new];
    
    CCContentViewController *vc1 = [CCContentViewController new];
    vc1.view.backgroundColor = [UIColor colorWithRed:0.20 green:0.59 blue:0.85 alpha:1.0];
    
    CCDetailsViewController *vc2 = [CCDetailsViewController new];
    vc2.view.backgroundColor = [UIColor colorWithRed:0.18 green:0.8 blue:0.44 alpha:1.0];

    splitViewController.viewControllers = [NSArray arrayWithObjects:vc1, vc2, nil];
    splitViewController.lateralViewController = vc2;
    splitViewController.lateralMinimumViewWidth = 100;
    
    [navigationController pushViewController:splitViewController animated:NO];
    
    vc1.navigationItem.title = @"vc1";
    vc2.navigationItem.title = @"vc2";
    
    [self presentViewController:navigationController animated:YES completion:^{
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            [NSThread sleepForTimeInterval:2.0];
            dispatch_async(dispatch_get_main_queue(), ^(void){
            });
        });
    }];
}


@end
