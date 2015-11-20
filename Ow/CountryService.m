//
//  CountryService.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 24/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "CountryService.h"

@interface CountryService ()

@property (nonatomic, strong) NSMutableArray* countries;

@end

@implementation CountryService

- (instancetype)init {
    
    self = [super init];
    
    if(self) {
        NSError* error;
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"countries" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        if (data) {
            _countries = [Country arrayOfModelsFromData:data
                                                  error:&error];
        }
    }
    
    return self;
}

- (Country *)findByCode:(NSString *)code {
    
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF.code like %@",
                                    code];
    
    NSArray* countriesFound = [_countries filteredArrayUsingPredicate:resultPredicate];
    
    if ([countriesFound count] == 1)
        return [countriesFound objectAtIndex:0];

    return nil;
}

- (NSString *)findTranslationByCode:(NSString *)code {

    NSLocale *locale = [NSLocale currentLocale];
    
    NSString *countryName = [locale displayNameForKey:NSLocaleCountryCode
                                                value:code];
    
    return countryName;
}

- (NSMutableArray *)findAllCountries {
    

    return _countries;
}

- (NSArray *)findByName:(NSString *)name {
    
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF.name contains[cd] %@",
                                    name];
    
    NSArray* countriesFound = [_countries filteredArrayUsingPredicate:resultPredicate];
    
    return countriesFound;
}

@end
