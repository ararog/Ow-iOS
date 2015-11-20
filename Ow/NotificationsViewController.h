//
//  NotificationsViewController.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 10/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMPageViewController.h"
#import "OWViewController.h"
#import "HistoryService.h"

@interface NotificationsViewController : OWViewController<BMPageViewControllerChild,
    UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) HistoryService* historyService;

@end
