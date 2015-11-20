//
//  HistoryService.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 31/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "HistoryService.h"
#import "ObjectUtils.h"

@interface HistoryService ()

@property (nonatomic, strong) EGODatabase * database;

@end

@implementation HistoryService

-(instancetype)initWithDatabase:(EGODatabase *)database {
    
    self = [super init];
    if(self) {
        
        _database = database;
    }
    
    return self;
}

-(NSMutableArray *) findAllNotifications {
    
    NSMutableArray * notifications = [NSMutableArray new];
    
    [_database open];
    
    EGODatabaseResult* result = [_database executeQueryWithParameters:@"SELECT n.Id as NotificationId, n.Type, n.Content, n.Date, n.Read, "
                                 "c.Id as ContactId, c.FirstName, c.LastName, c.CountryCode, c.PhoneNumber "
                                 "FROM `Notifications` n INNER JOIN `Contacts` c ON n.ContactId = c.Id "
                                 "WHERE date(n.Date) >= date('now', '-' || ? || ' days') ORDER BY Date DESC", @(30), nil];
    
    for(EGODatabaseRow* row in result) {
        
        Notification* notification = [Notification new];
        notification.identifier = @([row intForColumn:@"NotificationId"]);
        notification.type = @([row intForColumn:@"Type"]);
        notification.content = [row stringForColumn:@"Content"];
        notification.date = [row dateForColumn:@"Date"];
        notification.read = [row boolForColumn:@"Read"];
        
        Contact* contact = [Contact new];
        contact.identifier = @([row intForColumn:@"ContactId"]);
        contact.firstName = [row stringForColumn:@"FirstName"];
        contact.lastName = [row stringForColumn:@"LastName"];
        contact.countryCode = [row stringForColumn:@"CountryCode"];
        contact.phoneNumber = [row stringForColumn:@"PhoneNumber"];

        notification.contact = contact;
        
        [notifications addObject:notification];
    }
    
    [_database close];
    
    return notifications;
}

- (NSInteger)countUnreadNotifications {
    
    NSInteger count = 0;
    
    [_database open];
    
    EGODatabaseResult* result = [_database executeQuery:@"SELECT COUNT(*) FROM `Notifications` WHERE Read = 0"];
    
    EGODatabaseRow* row = [result firstRow];
    if (row) {

        count = [row intForColumn:0];
    }
    
    [_database close];
    
    return count;
}

-(void) saveNotification:(Notification *)notification {
    
    [_database open];
    
    EGODatabaseResult* result = [_database executeQueryWithParameters:@"SELECT Id FROM `Contacts` WHERE PhoneNumber = ?",
              notification.contact.phoneNumber, nil];
    
    EGODatabaseRow* row = [result firstRow];
    if (row) {
        NSNumber* contactId = @([row intForColumn:@"Id"]);
        
        NSArray* parameters = @[
                                [ObjectUtils nullIfNil:notification.type],
                                [ObjectUtils nullIfNil:notification.content],
                                [ObjectUtils nullIfNil:notification.date],
                                @(notification.read),
                                contactId];
        
        [_database executeUpdate:@"INSERT INTO Notifications(Type, Content, Date, Read, ContactId) VALUES(?, ?, ?, ?, ?)"
                      parameters:parameters];
        
        NSInteger notificationId = [_database lastInsertRowId];
        
        notification.identifier = @(notificationId);
    }
    
    [_database close];
}

- (void)deleteAllNotifications {
    
    [_database open];
    
    [_database executeUpdate:@"DELETE FROM `Notifications`"];
    
    [_database close];
}

@end
