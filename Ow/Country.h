//
//  Country.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 24/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Country : JSONModel

@property (nonatomic, strong) NSString* code;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* dialCode;

@end
