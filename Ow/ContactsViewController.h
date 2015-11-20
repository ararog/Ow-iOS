//
//  ContactsViewController.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 12/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMPageViewController.h"
#import "OWViewController.h"
#import "ContactService.h"
#import "HistoryService.h"

@interface ContactsViewController : OWViewController<BMPageViewControllerChild,
    UITableViewDataSource, UITableViewDelegate, UIBarPositioningDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIButton *notificationsButton;
@property (nonatomic, weak) IBOutlet UIButton *soundControllButton;

@property (nonatomic, strong) ContactService* contactService;
@property (nonatomic, strong) HistoryService* historyService;
@property (nonatomic, strong) Session * session;

@end
