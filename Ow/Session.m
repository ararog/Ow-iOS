//
//  Session.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 12/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "Session.h"

@interface Session () {
    
}

@property(nonatomic, strong) NSUserDefaults* preferences;

@end

@implementation Session

- (instancetype)init {
    
    self = [super init];
    if(self) {
        
        _preferences = [NSUserDefaults standardUserDefaults];
    }
    
    return self;
}

- (void) loadData {
    
    NSString* data = [_preferences stringForKey:@"user"];
    
    self.user = [[User alloc] initWithString:data
                                       error:nil];
    
    self.muted = [_preferences boolForKey:@"muted"];
}

- (void) saveData {
    
    NSString* data = [_user toJSONString];
    
    [_preferences setObject:data forKey:@"user"];
    
    [_preferences setBool:_muted forKey:@"muted"];
    
    [_preferences synchronize];
}

@end
