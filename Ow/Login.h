//
//  Login.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 10/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Login : JSONModel

@property(nonatomic, strong) NSString* countryCode;
@property(nonatomic, strong) NSString* phoneNumber;

@end
