//
//  CountryService.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 24/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Country.h"

@interface CountryService : NSObject

-(Country *) findByCode:(NSString *)code;

-(NSString *) findTranslationByCode:(NSString *)code;

-(NSMutableArray *) findAllCountries;

-(NSMutableArray *) findByName:(NSString *)name;

@end
