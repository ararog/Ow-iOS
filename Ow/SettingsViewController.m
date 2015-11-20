//
//  SettingsViewController.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 10/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import <Social/Social.h>
#import "SettingsViewController.h"
#import "MainPageViewController.h"
#import "SettingCell.h"
#import "SwitchFieldCell.h"

@implementation SettingsViewController

@synthesize pageIndex;

#pragma mark - View methods

- (void)awakeFromNib
{

}

- (void)viewDidLoad {

    self.title = NSLocalizedString(@"Settings", nil);

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
    
    self.navigationBar.topItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UINib *cellNib = [UINib nibWithNibName:@"SwitchFieldCell" bundle:nil];
    [self.tableView registerNib:cellNib
         forCellReuseIdentifier:@"SwitchFieldCell"];
    
    cellNib = [UINib nibWithNibName:@"SettingCell" bundle:nil];
    
    [self.tableView registerNib:cellNib
         forCellReuseIdentifier:@"GeneralSettingsCell"];

    [self.tableView registerNib:cellNib
         forCellReuseIdentifier:@"ManageNotificationsCell"];
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

- (void)changeSwitchValue:(id)sender {
    
}

#pragma mark -
#pragma mark UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSInteger rows = 0;
    
    switch (section) {
        case 0:
            rows = 2;
            break;

        case 1:
            rows = 1;
            break;

        case 2:
            rows = 1;
            break;
            
        default:
            break;
    }
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0) {
        
        NSString *cellIdentifier = @"GeneralSettingsCell";
        SettingCell *cell = (SettingCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
            cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        if(indexPath.row == 0)
            cell.textLabel.text = NSLocalizedString(@"About", nil);
        else
            cell.textLabel.text = NSLocalizedString(@"Tell to a friend", nil);
        
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"disclosure.png"]];
        
        return cell;
    }
    else if(indexPath.section == 1) {
        
        NSString *cellIdentifier = @"SwitchFieldCell";
        SwitchFieldCell *cell = (SwitchFieldCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
            cell = [[SwitchFieldCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        cell.fieldLabel.text = NSLocalizedString(@"Vibrate to notify", nil);
        cell.fieldSwitch.tag = 1;
        [cell.fieldSwitch addTarget:self
                             action:@selector(changeSwitchValue:)
                   forControlEvents:UIControlEventValueChanged];
        
        return cell;
    }
    else {
        
        NSString *cellIdentifier = @"ManageNotificationsCell";
        SettingCell *cell = (SettingCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
            cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        cell.textLabel.text = NSLocalizedString(@"Delete all notifications", nil);

        return cell;
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
    
    if(indexPath.section == 0) {
        
        if(indexPath.row == 0) {
            
            
        }
        else {
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                     delegate:self
                                                            cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:@"Email", @"Twitter", @"Facebook", nil];
            [actionSheet showInView:_tableView];
        }
    }
    else if(indexPath.section == 2){
        
        if(indexPath.row == 0) {
            
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Attention!", nil)
                                                              message:NSLocalizedString(@"Are you really want delete all notifications?", nil)
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                                    otherButtonTitles:NSLocalizedString(@"Yes", nil), NSLocalizedString(@"No", nil), nil];
            
            [message show];
        }
    }
}

#pragma mark -
#pragma mark UIActionSheetDelegate methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex == 0) {
        
        MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
        
        [mailComposer.navigationBar setTitleTextAttributes:@{UITextAttributeTextColor: [UIColor whiteColor],
                                                             UITextAttributeFont: [UIFont fontWithName:@"MavenProBold" size:18.0]}];
        
        [mailComposer setTitle:NSLocalizedString(@"Tell to a friend", nil)];
        [mailComposer setSubject:NSLocalizedString(@"Ow Notifier: iPhone, Android and Windows Phone", nil)];
        [mailComposer setMessageBody:NSLocalizedString(@"Your email message here", nil) isHTML:YES];
        mailComposer.mailComposeDelegate = self;
        
        [self presentViewController:mailComposer animated:YES completion:nil];
    }
    else if(buttonIndex == 1) {

        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
            
            SLComposeViewController *composerController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            
            [composerController setInitialText:NSLocalizedString(@"Try Ow today in your smartphone. Download at http://ow.com/download!", nil)];
            
            [self presentViewController:composerController animated:YES completion:nil];
        }
    }
    else if(buttonIndex == 2) {
        
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
            
            SLComposeViewController *composerController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            
            [composerController setInitialText:NSLocalizedString(@"Try Ow today in your smartphone. Download at http://ow.com/download!", nil)];
            
            [self presentViewController:composerController animated:YES completion:nil];
        }
    }
}

#pragma mark -
#pragma mark UIActionViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex == 0) {
        
        [_historyService deleteAllNotifications];
    }
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate methods

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

@end
