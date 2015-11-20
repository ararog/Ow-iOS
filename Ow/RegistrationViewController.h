//
//  RegistrationViewController.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 10/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "OWViewController.h"
#import "RestService.h"
#import "Registration.h"

@interface RegistrationViewController : OWViewController<UITableViewDataSource, UITableViewDelegate> {
    
}

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) Registration* registration;
@property (nonatomic, strong) RestService* restService;
@property (nonatomic, strong) Session * session;

@end
