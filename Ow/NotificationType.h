//
//  NotificationType.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 14/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationType : NSObject

@property (nonatomic, strong) NSNumber* identifier;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* text;

@end
