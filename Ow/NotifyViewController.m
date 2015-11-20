//
//  NotifyViewController.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 27/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "NotifyViewController.h"
#import "StringUtils.h"
#import "NotificationType.h"
#import "Notification.h"
#import "Session.h"

@interface NotifyViewController ()

@property (nonatomic, strong) NSMutableArray* types;

-(void) goBack;

@end

@implementation NotifyViewController

#pragma mark - View methods

- (void)viewDidLoad {

    self.title = NSLocalizedString(@"Choose Notification", nil);

    [super viewDidLoad];
    
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x147EBA)];
    
    self.view.backgroundColor = UIColorFromRGB(0xFDC101);
    
    self.tableView.backgroundColor = UIColorFromRGB(0xFDC101);
    
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(0, 0, 32, 32)];
    [backButton addTarget:self
                   action:@selector(goBack)
         forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationBar.topItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.types = [NSMutableArray new];
    
    NotificationType *notificationType = [NotificationType new];
    notificationType.identifier = @(1);
    notificationType.name = @"vamo";
    notificationType.text = NSLocalizedString(notificationType.name, nil);
    
    [_types addObject:notificationType];
    
    notificationType = [NotificationType new];
    notificationType.identifier = @(2);
    notificationType.name = @"perai";
    notificationType.text = NSLocalizedString(notificationType.name, nil);
    
    [_types addObject:notificationType];
    
    notificationType = [NotificationType new];
    notificationType.identifier = @(3);
    notificationType.name = @"chegou";
    notificationType.text = NSLocalizedString(notificationType.name, nil);
    
    [_types addObject:notificationType];
    
    notificationType = [NotificationType new];
    notificationType.identifier = @(4);
    notificationType.name = @"maneiro";
    notificationType.text = NSLocalizedString(notificationType.name, nil);
    
    [_types addObject:notificationType];
    
    notificationType = [NotificationType new];
    notificationType.identifier = @(5);
    notificationType.name = @"tocomfome";
    notificationType.text = NSLocalizedString(notificationType.name, nil);
    
    [_types addObject:notificationType];

    notificationType = [NotificationType new];
    notificationType.identifier = @(6);
    notificationType.name = @"owkey";
    notificationType.text = NSLocalizedString(notificationType.name, nil);
    
    [_types addObject:notificationType];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Interaction methods

- (void)goBack {
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

#pragma mark -
#pragma mark UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger count = [_types count];
    if(count == 0)
        count = 1;
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = @"TypeCell";
    UITableViewCell *cell = (UITableViewCell *)[_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TypeCell"];
    
    NotificationType* type = [_types objectAtIndex:indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = type.text;
    cell.textLabel.font = [UIFont fontWithName:@"MavenProBold" size:18];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = UIColorFromRGB(0xFDC101);
    
    return cell;
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
    
    NotificationType* selectedType = [_types objectAtIndex:indexPath.row];
    
    Notification* notification = [Notification new];
    notification.contact = _contact;
    notification.type = selectedType.identifier;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ChatManagerSendNotification
                                                        object:notification];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
