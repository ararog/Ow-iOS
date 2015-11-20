//
//  HistoryService.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 31/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EGODatabase/EGODatabase.h>
#import "Notification.h"

@interface HistoryService : NSObject

-(instancetype)initWithDatabase:(EGODatabase *)database;
-(NSMutableArray *) findAllNotifications;
-(NSInteger) countUnreadNotifications;
-(void) saveNotification:(Notification *)notification;
-(void) deleteAllNotifications;

@end
