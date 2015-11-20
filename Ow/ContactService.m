//
//  ContactService.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 28/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "ContactService.h"
#import <RHAddressBook/AddressBook.h>
#import "ObjectUtils.h"
#import "Contact.h"

@interface ContactService ()

@property (nonatomic, strong) EGODatabase * database;
@property (nonatomic, strong) RHAddressBook *addressBook;

@end

@implementation ContactService

- (instancetype)initWithDatabase:(EGODatabase *)database {
    
    self = [super init];
    
    if(self) {
        
        _database = database;
        
        _addressBook = [RHAddressBook new];
        
        if ([RHAddressBook authorizationStatus] == RHAuthorizationStatusNotDetermined){
            [_addressBook requestAuthorizationWithCompletion:^(bool granted, NSError *error) {
                
            }];
        }
    }
    
    return self;
}

- (NSMutableArray *)findDeviceContacts {
    
    NSMutableArray* contactsFromAddressBook = [NSMutableArray new];
    
    NSArray *allPeople = [_addressBook people];
    
    for (RHPerson* person in allPeople) {
        
        RHMultiStringValue *phoneMultiValue = [person phoneNumbers];
        NSString* phoneNumber = nil;
        for (int i = 0; i <= [phoneMultiValue count]; i++) {
            
            NSString* label = [phoneMultiValue labelAtIndex:i];
            if([label isEqualToString: RHPersonPhoneMobileLabel])
                phoneNumber = [phoneMultiValue valueAtIndex:i];
        }
        
        if (phoneNumber != nil) {
            Contact* contact = [Contact new];
            
            contact.firstName = person.firstName;
            contact.lastName = person.lastName;
            contact.phoneNumber = phoneNumber;
            
            [contactsFromAddressBook addObject:contact];
        }
    }
    
    return contactsFromAddressBook;
}

- (NSMutableArray *)findAllContacts {
    
    NSMutableArray* contacts = [NSMutableArray new];

    [_database open];
    
    EGODatabaseResult* result = [_database executeQuery:@"SELECT * FROM `Contacts` "];
    
    for(EGODatabaseRow* row in result) {
        
        Contact* contact = [Contact new];
        contact.identifier = @([row intForColumn:@"Id"]);
        contact.firstName = [row stringForColumn:@"FirstName"];
        contact.lastName = [row stringForColumn:@"LastName"];
        contact.countryCode = [row stringForColumn:@"CountryCode"];
        contact.phoneNumber = [row stringForColumn:@"PhoneNumber"];
        [contacts addObject:contact];
    }
    
    [_database close];
    
    return contacts;
}

- (void)saveAll:(NSMutableArray *)contacts {

    [_database open];
    
    EGODatabaseResult* result = nil;
    
    for (Contact* contact in contacts) {
        
        result = [_database executeQueryWithParameters:@"SELECT exists(SELECT Id FROM `Contacts` WHERE Id = ?)",
                  contact.identifier, nil];
        
        EGODatabaseRow* row = [result firstRow];
        
        BOOL exists = [row boolForColumnAtIndex:0];
        
        if(! exists) {
            
            NSArray* parameters = @[[ObjectUtils nullIfNil:contact.identifier],
                                    [ObjectUtils nullIfNil:contact.firstName],
                                    [ObjectUtils nullIfNil:contact.lastName],
                                    [ObjectUtils nullIfNil:contact.countryCode],
                                    [ObjectUtils nullIfNil:contact.phoneNumber]];
            
            [_database executeUpdate:@"INSERT INTO Contacts(Id, FirstName, LastName, CountryCode, PhoneNumber)"
             "VALUES(?, ?, ?, ?, ?)" parameters: parameters];
        }
    }
    
    [_database close];
}

@end
