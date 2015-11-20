//
//  MainPageViewController.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 12/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "MainPageViewController.h"

@implementation MainPageViewController

#pragma mark - UIView method

- (void)viewDidLoad {
    
    self.currentPage = 1;
    
    [super viewDidLoad];
}

#pragma mark - MSPageViewController methods

- (NSArray *)pageIdentifiers {
    
    return @[@"SettingsViewController", @"ContactsViewController", @"NotificationsViewController"];
}

#pragma mark - UIPageViewControllerDataSource

- (NSInteger)presentationCountForPageViewController:(BMPageViewController *)pageViewController {
    
    return 0;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

@end
