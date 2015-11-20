//
//  ContactViewController.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 12/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import <AddressBook/AddressBook.h>
#import "Typhoon.h"
#import "ContactsViewController.h"
#import "MainPageViewController.h"
#import "NotifyViewController.h"
#import "Contact.h"

@interface ContactsViewController ()

@property (nonatomic, strong) NSMutableArray* contacts;

- (void)updateContacts:(NSNotification *)aNotification;
- (void)newNotification:(NSNotification *)aNotification;
- (void)onlineNotification:(NSNotification *)aNotification;
- (void)offlineNotification:(NSNotification *)aNotification;

- (IBAction)gotoSettings:(id)sender;
- (IBAction)gotoNotifications:(id)sender;
- (IBAction)addContact:(id)sender;
- (IBAction)changeSound:(id)sender;

@end

@implementation ContactsViewController

@synthesize pageIndex;

#pragma mark - View methods

- (void)viewDidLoad {

    self.title = NSLocalizedString(@"Contacts", nil);

    [super viewDidLoad];
    
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x147EBA)];
    
    self.view.backgroundColor = UIColorFromRGB(0xFDC101);
    
    self.tableView.backgroundColor = UIColorFromRGB(0xFDC101);
    
    UIButton* button;
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 32, 32)];
    [button addTarget:self
               action:@selector(gotoSettings:)
     forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationBar.topItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 32, 32)];
    [button addTarget:self
               action:@selector(addContact:)
     forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationBar.topItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UINib *cellNib = [UINib nibWithNibName:@"ContactCell" bundle:nil];
    [self.tableView registerNib:cellNib
         forCellReuseIdentifier:@"ContactCell"];
    
    cellNib = [UINib nibWithNibName:@"MessageCell" bundle:nil];
    [self.tableView registerNib:cellNib
         forCellReuseIdentifier:@"MessageCell"];
    
    _contacts = [_contactService findAllContacts];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateContacts:)
                                                 name:ChatManagerUpdateContactsList
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(newNotification:)
                                                 name:ChatManagerNewNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onlineNotification:)
                                                 name:ChatManagerOnlineNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(offlineNotification:)
                                                 name:ChatManagerOfflineNotification
                                               object:nil];
    if(_session.muted)
        [_soundControllButton setImage:[UIImage imageNamed:@"mute.png"]
                              forState:UIControlStateNormal];
    else
        [_soundControllButton setImage:[UIImage imageNamed:@"unmute.png"]
                              forState:UIControlStateNormal];
}

- (void)viewDidAppear:(BOOL)animated {
    

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Interaction methods

- (IBAction)gotoSettings:(id)sender {
    
    [(MainPageViewController *) self.parentViewController changePage:0];
}

- (IBAction)gotoNotifications:(id)sender {
    
    [(MainPageViewController *) self.parentViewController changePage:2];
}

- (IBAction)addContact:(id)sender {
    
}

- (IBAction)changeSound:(id)sender {
    
    if(_session.muted) {
        
        _session.muted = NO;
        [_soundControllButton setImage:[UIImage imageNamed:@"unmute.png"]
                              forState:UIControlStateNormal];
    }
    else {
        
        _session.muted = YES;
        [_soundControllButton setImage:[UIImage imageNamed:@"mute.png"]
                              forState:UIControlStateNormal];
    }
    
    [_session saveData];
}

#pragma mark RestService notification methods

- (void)updateContacts:(NSNotification *)aNotification {
    
    NSMutableArray* contacts = (NSMutableArray *) aNotification.object;
    
    self.contacts = contacts;
    
    [_tableView reloadData];
}

#pragma mark ChatManager notification methods

- (void)newNotification:(NSNotification *)aNotification {
    
    NSInteger count = [_historyService countUnreadNotifications];
    
    if(count == 0)
        [_notificationsButton setTitle:@""
                              forState:UIControlStateNormal];
    else
        [_notificationsButton setTitle:[NSString stringWithFormat:@"%d", count]
                              forState:UIControlStateNormal];
}

- (void)onlineNotification:(NSNotification *)aNotification {
    
    [self stopLoadingTitleView];
    
    _tableView.userInteractionEnabled = YES;
}

- (void)offlineNotification:(NSNotification *)aNotification {

    [self startLoadingTitleView];
    
    _tableView.userInteractionEnabled = NO;
}

#pragma mark -
#pragma mark UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger count = [_contacts count];
    if(count == 0)
        count = 1;
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([_contacts count] > 0) {
        
        NSString *cellIdentifier = @"ContactCell";
        UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ContactCell"];
        
        Contact* contact = [_contacts objectAtIndex:indexPath.row];
        
        if(! contact.lastName)
            cell.textLabel.text = contact.firstName;
        else
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", contact.firstName, contact.lastName];
        
        return cell;
    }
    else {
        
        return [self messageCell:NSLocalizedString(@"No contacts found", nil)
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
    
    Contact* selectedContact = [_contacts objectAtIndex:indexPath.row];
    
    if(selectedContact) {
        
        TyphoonStoryboard *sb = [TyphoonStoryboard storyboardWithName:@"Main"
                                                              factory:[TyphoonBlockComponentFactory defaultFactory] bundle:nil];
        
        NotifyViewController* controller = [sb instantiateViewControllerWithIdentifier:@"NotifyViewController"];
        controller.contact = selectedContact;
        controller.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:controller
                           animated:NO
                         completion:nil];
    }
}

@end
