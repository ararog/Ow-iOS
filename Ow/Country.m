//
//  Country.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 24/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "Country.h"

@implementation Country

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"code": @"code",
                                                       @"dial_code": @"dialCode",
                                                       @"name": @"name",
                                                       }];
}

@end
