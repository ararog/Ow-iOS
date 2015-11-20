//
//  NotifyViewController.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 27/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "OWViewController.h"
#import "Contact.h"

@interface NotifyViewController : OWViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) Contact  *contact;

@end
