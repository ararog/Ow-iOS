//
//  Notification.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 10/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "Contact.h"

@interface Notification : JSONModel

@property(nonatomic, strong) NSNumber<Ignore>* identifier;
@property(nonatomic, strong) Contact* contact;
@property(nonatomic, strong) NSNumber* type;
@property(nonatomic, strong) NSString<Optional>* content;
@property(nonatomic, strong) NSDate<Optional>* date;
@property(nonatomic) BOOL read;

-(NSString *) typeToString;

@end
