//
//  ObjectUtils.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 08/09/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "ObjectUtils.h"

@implementation ObjectUtils

+(NSObject *) nilIfNull:(NSObject *)value {
    
    if([value isEqual:NSNull.null])
        return nil;
    
    return value;
}

+(NSObject *) nullIfNil:(NSObject *)value {
    
    if(value == nil)
        return NSNull.null;
    
    return value;
}

@end
