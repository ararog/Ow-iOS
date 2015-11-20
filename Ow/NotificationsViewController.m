//
//  NotificationsViewController.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 10/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "NotificationsViewController.h"
#import "MainPageViewController.h"
#import "NotificationCell.h"
#import "Notification.h"
#import "DateUtils.h"

@interface NotificationsViewController ()

@property (nonatomic, strong) NSMutableArray* notifications;

- (void)newNotification:(NSNotification *)aNotification;

@end

@implementation NotificationsViewController

@synthesize pageIndex;

#pragma mark - View methods

- (void)awakeFromNib {

}

- (void)viewDidLoad {

    self.title = NSLocalizedString(@"Notifications", nil);
    
    [super viewDidLoad];
    
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x147EBA)];
    
    self.view.backgroundColor = UIColorFromRGB(0xFDC101);
    
    self.tableView.backgroundColor = UIColorFromRGB(0xFDC101);
    
    UIButton* button;
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"contacts.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 32, 32)];
    [button addTarget:self
               action:@selector(gotoContacts:)
     forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationBar.topItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UINib *cellNib = [UINib nibWithNibName:@"NotificationCell" bundle:nil];
    [self.tableView registerNib:cellNib
         forCellReuseIdentifier:@"NotificationCell"];
    
    cellNib = [UINib nibWithNibName:@"MessageCell" bundle:nil];
    [self.tableView registerNib:cellNib
         forCellReuseIdentifier:@"MessageCell"];
    
    _notifications = [_historyService findAllNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(newNotification:)
                                                 name:ChatManagerNewNotification
                                               object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
}

#pragma mark Interaction methods

- (IBAction)gotoContacts:(id)sender {
    
    [(MainPageViewController *) self.parentViewController changePage:1];
}

#pragma mark ChatManager notification methods

- (void)newNotification:(NSNotification *)aNotification {
    
    Notification* notification = (Notification *) aNotification.object;
    
    if([_notifications count] > 0)
        [_notifications insertObject:notification atIndex:0];
    else
        [_notifications addObject:notification];
    
    [_tableView reloadData];
}

#pragma mark -
#pragma mark UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger count = [_notifications count];
    if(count == 0)
        count = 1;
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([_notifications count] > 0) {
        
        NSString *cellIdentifier = @"NotificationCell";
        NotificationCell *cell = (NotificationCell *)[_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
            cell = [[NotificationCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"NotificationCell"];
        
        Notification* notification = [_notifications objectAtIndex:indexPath.row];

        if(! notification.contact.lastName)
            cell.nameLabel.text = notification.contact.firstName;
        else
            cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@",
                                   notification.contact.firstName, notification.contact.lastName];
        
        cell.dateLabel.text = [DateUtils dateToString: notification.date];
        
        cell.descriptionLabel.text = [notification typeToString];
        
        return cell;
    }
    else {

        return [self messageCell:NSLocalizedString(@"No notifications found", nil)
                    forTableView:_tableView];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return nil;
}

#pragma mark -
#pragma mark UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

@end
