//
//  Contact.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 10/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "Contact.h"

@implementation Contact

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"identifier",
                                                       @"first_name": @"firstName",
                                                       @"last_name": @"lastName",
                                                       @"country_code": @"countryCode",
                                                       @"phone_number": @"phoneNumber"
                                                    }];
}

@end
