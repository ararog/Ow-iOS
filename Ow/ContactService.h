//
//  ContactService.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 28/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EGODatabase/EGODatabase.h>
#import "Contact.h"

@interface ContactService : NSObject

-(instancetype)initWithDatabase:(EGODatabase *)database;
-(NSMutableArray *)findDeviceContacts;
-(NSMutableArray *)findAllContacts;
-(void)saveAll:(NSMutableArray *)contacts;

@end
