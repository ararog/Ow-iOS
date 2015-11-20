//
//  LoginViewController.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 10/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "OWViewController.h"
#import "CountryViewController.h"
#import "RestService.h"
#import "CountryService.h"

@interface LoginViewController : OWViewController<CountryViewDelegate, UITableViewDataSource, UITableViewDelegate> {
    
}

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) RestService* restService;
@property (nonatomic, strong) CountryService* countryService;
@property (nonatomic, strong) Session * session;

@end
