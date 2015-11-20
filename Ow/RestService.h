//
//  RestService.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 10/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "AFNetworking.h"
#import "User.h"
#import "Login.h"
#import "Registration.h"

@interface RestService : AFHTTPRequestOperationManager

-(void) signin:(Login *)login;

-(void) verify:(Registration *)registration;

-(void) loadContacts:(User *)user;

-(void) syncContacts:(NSArray *)contacts ofUser:(User *)user;

@end
