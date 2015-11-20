//
//  OwAssembly.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 18/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import <Typhoon/Typhoon.h>
#import <EGODatabase/EGODatabase.h>
#import "RestService.h"
#import "CountryService.h"
#import "ContactService.h"
#import "HistoryService.h"
#import "AlertService.h"
#import "ChatManager.h"
#import "Session.h"

@interface OwAssembly : TyphoonAssembly

- (ChatManager *)defaultChatManager;

- (RestService *)defaultRestService;

- (Session *)defaultSession;

- (EGODatabase *)defaulDatabase;

- (CountryService*)defaultCountryService;

- (ContactService*)defaultContactService;

- (HistoryService*)defaultHistoryService;

- (AlertService*)defaultAlertService;

- (id) loginViewController;

- (id) countryViewController;

- (id) registrationViewController;

- (id) contactsViewController;

- (id) notificationsViewController;

- (id) settingsViewController;

@end
