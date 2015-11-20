//
//  User.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 11/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "JSONModel.h"

@interface User : JSONModel

@property(nonatomic, strong) NSNumber* identifier;
@property(nonatomic, strong) NSString<Optional>* firstName;
@property(nonatomic, strong) NSString<Optional>* lastName;
@property(nonatomic, strong) NSString* phoneNumber;
@property(nonatomic, strong) NSString* countryCode;

@end
