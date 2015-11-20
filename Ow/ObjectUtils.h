//
//  ObjectUtils.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 08/09/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectUtils : NSObject

+(NSObject *) nilIfNull:(NSObject *)value;
+(NSObject *) nullIfNil:(NSObject *)value;

@end
