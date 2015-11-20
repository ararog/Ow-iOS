//
//  RegistrationViewController.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 10/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "AppDelegate.h"
#import "RegistrationViewController.h"
#import "Typhoon.h"
#import "TextFieldCell.h"
#import "RestService.h"
#import "ServiceMessage.h"
#import "Session.h"

@interface RegistrationViewController () {
    
}

@end

@implementation RegistrationViewController

#pragma mark - View methods

- (void)awakeFromNib {

}

- (void)viewDidLoad {

    self.title = NSLocalizedString(@"Register", nil);

    [super viewDidLoad];
    
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x147EBA)];
    
    self.view.backgroundColor = UIColorFromRGB(0xFDC101);
    
    self.tableView.backgroundColor = UIColorFromRGB(0xFDC101);
    
    UINib *cellNib = [UINib nibWithNibName:@"TextFieldCell" bundle:nil];
    [self.tableView registerNib:cellNib
         forCellReuseIdentifier:@"TextFieldCell"];
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(registrationSuccessful:)
                                                 name:RestServiceRegistrationSuccessful
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(registrationFailed:)
                                                 name:RestServiceRegistrationFailed
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark RestService notification methods

- (void)registrationSuccessful:(NSNotification *)aNotification {
    
    [self finishLoading];
    
    User* user = (User *) aNotification.object;
    
    _session.user = user;
    
    [_session saveData];
    
    AppDelegate *delegate = (AppDelegate *) [UIApplication sharedApplication].delegate;

    TyphoonStoryboard *sb = [TyphoonStoryboard storyboardWithName:@"Main"
                                                          factory:[TyphoonBlockComponentFactory defaultFactory]
                                                           bundle:nil];
    
    UIViewController* controller = [sb instantiateViewControllerWithIdentifier:@"MainPageViewController"];
    
    delegate.window.rootViewController =  controller;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ChatManagerStartChatSession
                                                        object:user];
}

- (void)registrationFailed:(NSNotification *)aNotification {
 
    [self finishLoading];

    ServiceMessage* message = (ServiceMessage *) aNotification.object;
    
    [self showMessage:@"Atenção!" title:NSLocalizedString(message.details, nil)];
}

#pragma mark UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0) {
        
        TextFieldCell *cell = (TextFieldCell *)[self.tableView dequeueReusableCellWithIdentifier:@"TextFieldCell"];
        if(cell == nil)
            cell = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TextFieldCell"];
        
        cell.textField.text = _registration.code;
        cell.textField.tag = 0;
        cell.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Code", nil)
                                                                               attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];

        [cell.textField addTarget:self
                           action:@selector(textFieldDidChange:)
                 forControlEvents:UIControlEventEditingChanged];
        
        return cell;
    }
    else {
    
        NSString *cellIdentifier = @"ButtonCell";
        UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ButtonCell"];
        
        cell.textLabel.text = NSLocalizedString(@"Confirm", nil);
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont fontWithName:@"MavenProBold" size:18];
        cell.textLabel.textColor = [UIColor whiteColor];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = UIColorFromRGB(0xFDC101);
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 1) {
        
        [self startLoadingWithMessage:NSLocalizedString(@"Wait", nil)];
        
        [_restService verify:_registration];
    }
}

#pragma mark - UITextField methods

- (void)textFieldDidChange:(UITextField *)textField {
    
    switch (textField.tag) {
        case 0:
            _registration.code = textField.text;
            break;
            
        default:
            break;
    }
}


@end
