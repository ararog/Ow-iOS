//
//  RestService.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 10/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "RestService.h"
#import "ServiceMessage.h"
#import "Contact.h"

@implementation RestService

-(void) signin:(Login *)login {
 
    [self POST:@"/api/v1/users/login"
    parameters:[login toDictionary]
       success:^(AFHTTPRequestOperation *operation, id responseObject) {
          
           NSError* error;

           User *returnedUser = [[User alloc] initWithDictionary:responseObject error:&error];
           
           [[NSNotificationCenter defaultCenter] postNotificationName:RestServiceLoginSuccessful
                                                               object:returnedUser];
       }
       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           
           NSDictionary* info = (NSDictionary*) operation.responseObject;
           
           ServiceMessage *message = [[ServiceMessage alloc] init];
           
           message.details = [info valueForKey:@"message"];

           [[NSNotificationCenter defaultCenter] postNotificationName:RestServiceLoginFailed
                                                               object:message];
       }];
    
}

-(void) verify:(Registration *)registration {
    
    [self POST:@"/api/v1/users/verify"
    parameters:[registration toDictionary]
       success:^(AFHTTPRequestOperation *operation, id responseObject) {
           NSError* error;
           
           User *returnedUser = [[User alloc] initWithDictionary:responseObject error:&error];
           
           [[NSNotificationCenter defaultCenter] postNotificationName:RestServiceRegistrationSuccessful
                                                               object:returnedUser];
       }
       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           
           ServiceMessage *message = [[ServiceMessage alloc] init];
           
           message.details = error.description;
           
           [[NSNotificationCenter defaultCenter] postNotificationName:RestServiceRegistrationFailed
                                                               object:message];
       }];
    
}

- (void)loadContacts:(User *)user {
    
     [self GET:[NSString stringWithFormat:@"/api/v1/users/%d/contacts", user.identifier.intValue]
    parameters:nil
       success:^(AFHTTPRequestOperation *operation, id responseObject) {
           
           NSArray *contacts = [Contact arrayOfModelsFromDictionaries:responseObject];
           
           [[NSNotificationCenter defaultCenter] postNotificationName:RestServiceContactsLoaded
                                                               object:contacts];
       }
       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           
           ServiceMessage *message = [[ServiceMessage alloc] init];
           
           message.details = error.description;
           
           [[NSNotificationCenter defaultCenter] postNotificationName:RestServiceContactsNotLoaded
                                                               object:message];
       }];
}

- (void) syncContacts:(NSArray *)contacts ofUser:(User *)user {
   
   [self POST:[NSString stringWithFormat:@"/api/v1/users/%d/contacts/sync", user.identifier.intValue]
   parameters:[Contact arrayOfDictionariesFromModels:contacts]
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          
          NSArray *contacts = [Contact arrayOfModelsFromDictionaries:responseObject];
          
          [[NSNotificationCenter defaultCenter] postNotificationName:RestServiceContactsLoaded
                                                              object:contacts];
      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          
          ServiceMessage *message = [[ServiceMessage alloc] init];
          
          message.details = error.description;
          
          [[NSNotificationCenter defaultCenter] postNotificationName:RestServiceContactsNotLoaded
                                                              object:message];
      }];
}

@end
