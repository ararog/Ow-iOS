//
//  StringUtils.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 27/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtils : NSObject

+ (NSString *) normalizePhone:(NSString *)countryCode withNumber:(NSString *)number;

@end
