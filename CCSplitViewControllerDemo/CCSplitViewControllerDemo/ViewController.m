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
    
    CCSplitViewController *splitViewController = [CCSplitViewController new];
    
    CCContentViewController *vc1 = [CCContentViewController new];
    
    CCDetailsViewController *vc2 = [CCDetailsViewController new];

    splitViewController.viewControllers = [NSArray arrayWithObjects:vc1, vc2, nil];
    splitViewController.lateralMinimumViewWidth = 100;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:splitViewController];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}


@end
