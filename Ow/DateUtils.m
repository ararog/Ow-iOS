//
//  DateUtils.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 04/09/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils

+(NSString *) dateToString:(NSDate *)date {

    NSString* result = @"";
    
    if(date) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        result = [dateFormatter stringFromDate:date];
    }
    
    return result;
}


@end
