//
//  Login.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 10/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "Login.h"

@implementation Login

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"country_code": @"countryCode",
                                                       @"phone_number": @"phoneNumber"
                                                    }];
}

@end
