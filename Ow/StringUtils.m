//
//  StringUtils.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 27/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "StringUtils.h"

@implementation StringUtils

+ (NSString *)normalizePhone:(NSString *)countryCode withNumber:(NSString *)number {
    
    NSCharacterSet *charset = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    NSString* identifier = [countryCode stringByAppendingString:number];
    
    NSString *pureNumbers = [[identifier componentsSeparatedByCharactersInSet:charset] componentsJoinedByString:@""];

    return pureNumbers;
}

@end
