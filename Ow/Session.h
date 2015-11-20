//
//  Session.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 12/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Session : NSObject

@property (nonatomic, strong) User* user;
@property (nonatomic, assign) BOOL muted;

- (void) loadData;
- (void) saveData;

@end
