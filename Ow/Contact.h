//
//  Contact.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 10/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Contact : JSONModel

@property(nonatomic, strong) NSNumber* identifier;
@property(nonatomic, strong) NSString* firstName;
@property(nonatomic, strong) NSString<Optional>* lastName;
@property(nonatomic, strong) NSString<Optional>* countryCode;
@property(nonatomic, strong) NSString* phoneNumber;

@end
