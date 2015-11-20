//
//  OwAssembly.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 18/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "OwAssembly.h"
#import "MainPageViewController.h"
#import "LoginViewController.h"
#import "RegistrationViewController.h"
#import "CountryViewController.h"
#import "ContactsViewController.h"
#import "NotificationsViewController.h"
#import "SettingsViewController.h"

@implementation OwAssembly

- (ChatManager *)defaultChatManager {
    
    return [TyphoonDefinition withClass:[ChatManager class] configuration:^(TyphoonDefinition* definition)
            {
                definition.scope = TyphoonScopeSingleton;
                
                [definition useInitializer:@selector(initWithServerURL:) parameters:^(TyphoonMethod *initializer) {
                    [initializer injectParameterWith:[NSURL URLWithString:@"http://192.168.100.109:8080/websocket"]];
                }];
                
                [definition injectProperty:@selector(session)
                                      with:[self defaultSession]];
                
                [definition injectProperty:@selector(restService)
                                      with:[self defaultRestService]];
                
                [definition injectProperty:@selector(contactService)
                                      with:[self defaultContactService]];

                [definition injectProperty:@selector(historyService)
                                      with:[self defaultHistoryService]];

                [definition injectProperty:@selector(alertService)
                                      with:[self defaultAlertService]];
            }];
}

- (EGODatabase *)defaulDatabase {
    
    return [TyphoonDefinition withClass:[EGODatabase class] configuration:^(TyphoonDefinition* definition)
            {
                definition.scope = TyphoonScopeSingleton;
                
                NSFileManager *fileManager = [NSFileManager defaultManager];
                NSError *error;
                
                NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                NSString *dbPath = [documentsPath stringByAppendingPathComponent:@"ow.db"];

                BOOL exists = [fileManager fileExistsAtPath:dbPath];
                
                if(! exists) {
                    
                    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ow.db"];
                    [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
                }
                
                [definition useInitializer:@selector(initWithPath:) parameters:^(TyphoonMethod *initializer) {
                    [initializer injectParameterWith:dbPath];
                }];
            }];
}

- (RestService *)defaultRestService {
    
    return [TyphoonDefinition withClass:[RestService class] configuration:^(TyphoonDefinition* definition)
            {
                definition.scope = TyphoonScopeSingleton;
                
                [definition useInitializer:@selector(initWithBaseURL:) parameters:^(TyphoonMethod *initializer) {
                    [initializer injectParameterWith:[NSURL URLWithString:@"http://192.168.100.109:8080"]];
                }];
                
                [definition injectProperty:@selector(requestSerializer)
                                      with:[AFJSONRequestSerializer serializer]];
            }];
}

- (Session *)defaultSession {
    
    return [TyphoonDefinition withClass:[Session class] configuration:^(TyphoonDefinition* definition)
            {
                definition.scope = TyphoonScopeSingleton;
                
            }];
}

- (ContactService *)defaultContactService {
    
    return [TyphoonDefinition withClass:[ContactService class] configuration:^(TyphoonDefinition* definition)
            {
                definition.scope = TyphoonScopeSingleton;
                
                [definition useInitializer:@selector(initWithDatabase:) parameters:^(TyphoonMethod *initializer) {
                    [initializer injectParameterWith:[self defaulDatabase]];
                }];
            }];
}

- (HistoryService *)defaultHistoryService {
    
    return [TyphoonDefinition withClass:[HistoryService class] configuration:^(TyphoonDefinition* definition)
            {
                definition.scope = TyphoonScopeSingleton;
                
                [definition useInitializer:@selector(initWithDatabase:) parameters:^(TyphoonMethod *initializer) {
                    [initializer injectParameterWith:[self defaulDatabase]];
                }];                
            }];
}

- (CountryService *)defaultCountryService {
    
    return [TyphoonDefinition withClass:[CountryService class] configuration:^(TyphoonDefinition* definition)
            {
                definition.scope = TyphoonScopeSingleton;
                
            }];
}

- (AlertService *)defaultAlertService {
    
    return [TyphoonDefinition withClass:[AlertService class] configuration:^(TyphoonDefinition* definition)
            {
                definition.scope = TyphoonScopeSingleton;
                
            }];
}

- (id) countryViewController {
    
    return [TyphoonDefinition withClass:[CountryViewController class] configuration:^(TyphoonDefinition* definition)
            {
                [definition injectProperty:@selector(countryService)
                                      with:[self defaultCountryService]];
            }];
}

- (id) notificationsViewController {
    
    return [TyphoonDefinition withClass:[NotificationsViewController class] configuration:^(TyphoonDefinition* definition)
            {
                [definition injectProperty:@selector(historyService)
                                      with:[self defaultHistoryService]];
            }];
}

- (id) settingsViewController {
    
    return [TyphoonDefinition withClass:[NotificationsViewController class] configuration:^(TyphoonDefinition* definition)
            {
                [definition injectProperty:@selector(historyService)
                                      with:[self defaultHistoryService]];
            }];
}

- (id) registrationViewController {
    
    return [TyphoonDefinition withClass:[RegistrationViewController class] configuration:^(TyphoonDefinition* definition)
            {
                [definition injectProperty:@selector(session)
                                      with:[self defaultSession]];
                
                [definition injectProperty:@selector(restService)
                                      with:[self defaultRestService]];
            }];
}

- (id) loginViewController {
    
    return [TyphoonDefinition withClass:[LoginViewController class] configuration:^(TyphoonDefinition* definition)
            {
                [definition injectProperty:@selector(session)
                                      with:[self defaultSession]];
                
                [definition injectProperty:@selector(restService)
                                      with:[self defaultRestService]];
                
                [definition injectProperty:@selector(countryService)
                                      with:[self defaultCountryService]];
            }];
}

- (id) contactsViewController {
    
    return [TyphoonDefinition withClass:[ContactsViewController class] configuration:^(TyphoonDefinition* definition)
            {
                [definition injectProperty:@selector(session)
                                      with:[self defaultSession]];
                
                [definition injectProperty:@selector(contactService)
                                      with:[self defaultContactService]];
                
                [definition injectProperty:@selector(historyService)
                                      with:[self defaultHistoryService]];
            }];
}

@end
