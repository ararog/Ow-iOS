//
//  SettingsViewController.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 10/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import "BMPageViewController.h"
#import "OWViewController.h"
#import "HistoryService.h"

@interface SettingsViewController : OWViewController<BMPageViewControllerChild, MFMailComposeViewControllerDelegate,
    UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) HistoryService* historyService;

@end
