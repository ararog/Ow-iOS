//
//  LoginViewController.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 10/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "RegistrationViewController.h"
#import "Typhoon.h"
#import "CountryDetailsCell.h"
#import "PhoneDetailsCell.h"
#import "RestService.h"
#import "ServiceMessage.h"
#import "Session.h"
#import "Login.h"

@interface LoginViewController () {
    
}

@property(nonatomic, strong) Login* login;
@property(nonatomic, strong) Country* country;

@end

@implementation LoginViewController

#pragma mark - View methods

- (void)awakeFromNib {

}

- (void)viewDidLoad {

    self.title = NSLocalizedString(@"Login", nil);

    [super viewDidLoad];
    
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x147EBA)];
    
    self.view.backgroundColor = UIColorFromRGB(0xFDC101);
    
    self.tableView.backgroundColor = UIColorFromRGB(0xFDC101);
    
    UINib *cellNib = [UINib nibWithNibName:@"CountryDetailsCell" bundle:nil];
    [self.tableView registerNib:cellNib
         forCellReuseIdentifier:@"CountryDetailsCell"];
    
    cellNib = [UINib nibWithNibName:@"PhoneDetailsCell" bundle:nil];
    [self.tableView registerNib:cellNib
         forCellReuseIdentifier:@"PhoneDetailsCell"];
    
    NSLocale *currentLocale = [NSLocale currentLocale];
    
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    
    _country = [_countryService findByCode:countryCode];
    
    _login = [Login new];
    
    _login.countryCode = _country.dialCode;
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginSuccessful:)
                                                 name:RestServiceLoginSuccessful
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginFailed:)
                                                 name:RestServiceLoginFailed
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark RestService notification methods

- (void)loginSuccessful:(NSNotification *)aNotification {
    
    [self finishLoading];
    
    User* user = (User *) aNotification.object;
    
    _session.user = user;
    
    [_session saveData];
    
    AppDelegate *delegate = (AppDelegate *) [UIApplication sharedApplication].delegate;

    TyphoonStoryboard *sb = [TyphoonStoryboard storyboardWithName:@"Main"
                                                          factory:[TyphoonBlockComponentFactory defaultFactory]
                                                           bundle:nil];
    
    UIViewController* controller = [sb instantiateViewControllerWithIdentifier:@"MainPageViewController"];
    
    delegate.window.rootViewController = controller;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ChatManagerStartChatSession
                                                        object:user];
}

- (void)loginFailed:(NSNotification *)aNotification {
    
    [self finishLoading];
    
    [self performSegueWithIdentifier:@"startRegistration" sender:self];
}

#pragma mark UIStoryboard methods

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"startRegistration"]) {
        RegistrationViewController* controller = segue.destinationViewController;
        
        Registration *registration = [Registration new];
        registration.countryCode = _country.dialCode;
        registration.phoneNumber = _login.phoneNumber;
        
        controller.registration = registration;
    }
    
    if ([segue.identifier isEqualToString:@"chooseCountry"]) {

        CountryViewController* controller = segue.destinationViewController;

        controller.delegate = self;
    }
}

#pragma mark -
#pragma mark UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0) {

        CountryDetailsCell *cell = (CountryDetailsCell *)[self.tableView dequeueReusableCellWithIdentifier:@"CountryDetailsCell"];
        if(cell == nil)
            cell = [[CountryDetailsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CountryDetailsCell"];
        
        NSString* imageName = [NSString stringWithFormat:@"flag_%@.png",
                               _country.code.lowercaseString];

        cell.countryImageView.image = [UIImage imageNamed:imageName];
        cell.countryNameLabel.text = _country.name;

        return cell;
    }

    if(indexPath.row == 1) {

        PhoneDetailsCell *cell = (PhoneDetailsCell *)[self.tableView dequeueReusableCellWithIdentifier:@"PhoneDetailsCell"];
        if(cell == nil)
            cell = [[PhoneDetailsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PhoneDetailsCell"];

        cell.countryCodeField.text = _country.dialCode;
        cell.countryCodeField.tag = 0;
        [cell.countryCodeField addTarget:self
                                  action:@selector(textFieldDidChange:)
                        forControlEvents:UIControlEventEditingChanged];
        
        cell.phoneNumberField.text = _login.phoneNumber;
        cell.phoneNumberField.tag = 1;
        [cell.phoneNumberField addTarget:self
                                  action:@selector(textFieldDidChange:)
                        forControlEvents:UIControlEventEditingChanged];
        
        return cell;
    }

 
    NSString *cellIdentifier = @"ButtonCell";
    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ButtonCell"];
    
    cell.textLabel.text = NSLocalizedString(@"Login", nil);
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont fontWithName:@"MavenProBold" size:18];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = UIColorFromRGB(0xFDC101);
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0) {
     
        [self performSegueWithIdentifier:@"chooseCountry" sender:self];
    }
    
    if(indexPath.row == 2) {
        
        [self startLoadingWithMessage:NSLocalizedString(@"Wait", nil)];
        
        [_restService signin:_login];
    }
}

#pragma mark - UITextField methods

-(void)textFieldDidChange :(UITextField *)textField{
    
    switch (textField.tag) {
        case 0:
            _login.countryCode = textField.text;
            break;

        case 1:
            _login.phoneNumber = textField.text;
            break;
            
        default:
            break;
    }
}

#pragma mark - CountryView delegate methods

- (void)countryController:(id)sender didSelectCountry:(Country *)chosenCountry {
    
    if(chosenCountry != nil) {

        self.country = chosenCountry;
        
        _login.countryCode = _country.dialCode;
        
        [_tableView reloadData];
    }
}

@end
