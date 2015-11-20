//
//  ChatManager.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 27/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "ChatManager.h"
#import <AVFoundation/AVFoundation.h>
#import <Reachability/Reachability.h>
#import "WebSocketRailsDispatcher.h"
#import "WebSocketRailsChannel.h"
#import "StringUtils.h"
#import "Notification.h"
#import "User.h"

@interface ChatManager () {
    
}

@property(nonatomic, strong) WebSocketRailsDispatcher* dispatcher;
@property(nonatomic, strong) NSMutableDictionary* connections;
@property(nonatomic, strong) NSURL* serverUrl;
@property(nonatomic, strong) User* user;
@property(nonatomic, strong) NSTimer* timer;
@property(nonatomic, strong) Reachability* reach;

-(void)startChat;
-(void)stopChat;
-(void)createRooms:(NSMutableArray*)contacts;
-(void)startSync;
-(void)performSync;
-(void)notify:(Notification *)notification;

- (void)startSession:(NSNotification *)aNotification;
- (void)sendNotification:(NSNotification *)aNotification;
- (void)contactsLoaded:(NSNotification *)aNotification;
- (void)reachabilityChanged:(NSNotification*)aNotification;

@end

@implementation ChatManager

-(instancetype)initWithServerURL:(NSURL *)serverUrl {
    
    self = [super init];
    
    if(self) {
        _serverUrl = serverUrl;
        _connections = [NSMutableDictionary new];
    }
    
    return self;
}

-(void)initialize {
    
    _reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    _user = _session.user;
    
    if(_user == nil) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(startSession:)
                                                     name:ChatManagerStartChatSession
                                                   object:nil];
    }
    else {
        
        [self startChat];
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sendNotification:)
                                                 name:ChatManagerSendNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contactsLoaded:)
                                                 name:RestServiceContactsLoaded
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    [_reach startNotifier];
}

#pragma mark - Chat management methods

-(void)startChat {
    
    _dispatcher = [[WebSocketRailsDispatcher alloc] initWithUrl:_serverUrl];
    
    [_dispatcher bind:@"connection_opened" callback:^(id data) {
        
        [self startSync];
    }];
    
    [_dispatcher bind:@"connection_closed" callback:^(id data) {
        
        [self stopSync];
    }];
    
    [_dispatcher bind:@"connection_error" callback:^(id data) {
        
        [self stopSync];
    }];

    [_dispatcher connect];
}

-(void)stopChat {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ChatManagerOfflineNotification
                                                        object:nil];
    
    for (NSString* channel in _connections.keyEnumerator) {
        
        [_dispatcher unsubscribe:channel];
    }
    
    [_dispatcher disconnect];
    
    _dispatcher = nil;
    
    [_connections removeAllObjects];
}

-(void)createRooms:(NSMutableArray *)contacts {
    
    _connections = [NSMutableDictionary new];
    
    NSString* phoneNumber;
    
    for (Contact* contact in contacts) {

        phoneNumber = [StringUtils normalizePhone:contact.countryCode
                                       withNumber:contact.phoneNumber];
        
        if([_connections valueForKey:phoneNumber] == nil) {
            
            
            WebSocketRailsChannel *channel = [_dispatcher subscribe:phoneNumber];
            
            [_connections setObject:channel
                             forKey:phoneNumber];
        }
    }
    
    phoneNumber = [StringUtils normalizePhone:_user.countryCode
                                   withNumber:_user.phoneNumber];
    
    WebSocketRailsChannel *channel  = [_dispatcher subscribe:phoneNumber];
    
    [channel bind:@"notification_event" callback:^(id data) {
        
        NSError* error;
        
        Notification* notification = [[Notification alloc] initWithDictionary:data error:&error];
        
        if(! error) {
            notification.date = [NSDate date];
            notification.read = NO;
            
            [self notify: notification];
        }
    }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ChatManagerOnlineNotification
                                                        object:nil];
}

#pragma mark ChatManager notification methods

- (void)startSession:(NSNotification *)aNotification {
    
    self.user = (User *) aNotification.object;
    
    [self startChat];
}

- (void)sendNotification:(NSNotification *)aNotification {
    
    Notification* outgoingNotification = aNotification.object;
    
    NSString* phoneNumber = [StringUtils normalizePhone:outgoingNotification.contact.countryCode
                                             withNumber:outgoingNotification.contact.phoneNumber];
    
    WebSocketRailsChannel* channel = [_connections objectForKey:phoneNumber];
    
    [channel trigger:@"notification_event" message:[outgoingNotification toDictionary]];
}

#pragma mark Connection status methods

- (void)reachabilityChanged:(NSNotification *)aNotification {
    
    Reachability * reach = [aNotification object];
    
    if([reach isReachable])
    {
        if(_user != nil && ! [@"connected" isEqualToString:_dispatcher.state])
            [self startChat];
    }
    else
    {
        [self stopChat];
    }
}

#pragma mark - Contacts sync methods

-(void)startSync {
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:300
                                              target:self
                                            selector:@selector(performSync)
                                            userInfo:nil
                                             repeats:YES];
    
    [_timer fire];
}

-(void)stopSync {
    
    [_timer invalidate];
    _timer = nil;
}

-(void)performSync {
    
    NSMutableArray* contacts = [_contactService findDeviceContacts];
    
    [_restService syncContacts:contacts ofUser:_user];
}

#pragma mark - RestService notification methods

- (void)contactsLoaded:(NSNotification *)aNotification {
    
    NSMutableArray* contacts = (NSMutableArray *) aNotification.object;
    if(contacts != nil) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:ChatManagerUpdateContactsList
                                                            object:contacts];
        
        [_contactService saveAll:contacts];
        
        [self createRooms:contacts];
    }
}

- (void)contactsNotLoaded:(NSNotification *)aNotification {
    
    
    //Handle any error related with contacts loading
    
}

#pragma mark - Income notification methods

- (void)notify:(Notification *)notification {
    
    [_historyService saveNotification:notification];

    [_alertService executeAlertForNotification:notification
                                     withSound:! _session.muted];

    [[NSNotificationCenter defaultCenter] postNotificationName:ChatManagerNewNotification
                                                        object:notification];
}


@end
