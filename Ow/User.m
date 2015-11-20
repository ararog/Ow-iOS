//
//  User.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 11/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "User.h"

@implementation User

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"identifier",
                                                       @"phone_number": @"phoneNumber",
                                                       @"country_code": @"countryCode"
                                                    }];
}

@end
