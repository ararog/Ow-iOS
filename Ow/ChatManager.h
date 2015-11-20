//
//  ChatManager.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 27/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestService.h"
#import "ContactService.h"
#import "HistoryService.h"
#import "AlertService.h"
#import "Session.h"

@interface ChatManager : NSObject

@property(nonatomic, strong) RestService* restService;
@property(nonatomic, strong) ContactService* contactService;
@property(nonatomic, strong) HistoryService* historyService;
@property(nonatomic, strong) AlertService* alertService;
@property(nonatomic, strong) Session* session;

-(instancetype)initWithServerURL:(NSURL *)serverUrl;
-(void) initialize;

@end
