//
//  AlertService.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 01/09/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import "AlertService.h"

@interface AlertService ()

@property(nonatomic, strong) Notification* notification;
@property(nonatomic, strong) AVAudioPlayer* player;

-(void) postLocalNotification:(Notification*) notification;

@end

@implementation AlertService

-(instancetype)init {
    
    self = [super init];
    if(self) {
        
    }
    
    return self;
}

-(void) executeAlertForNotification:(Notification *)notification
                          withSound:(BOOL)sound{
    
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    
    if(sound) {
        
        if(_player != nil) {
            
            [_player stop];
            _player.delegate = nil;
            _player = nil;
        }
        
        NSString * path =[[NSBundle mainBundle] pathForResource:@"ow" ofType:@"mp3"];
        
        _notification = notification;
        
        NSURL * url = [NSURL fileURLWithPath:path];
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
        [_player setVolume:1.0];
        _player.delegate = self;
        [_player play];
    }
    else {
        
        [self postLocalNotification:notification];
    }
}

#pragma mark AVAudioPlayerDelegate methods

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    NSString* type = nil;
    
    switch (_notification.type.intValue) {
        case 1:
            type = @"vamo";
            break;

        case 2:
            type  = @"perai";
            break;

        case 3:
            type  = @"chegou";
            break;

        case 4:
            type  = @"maneiro";
            break;

        case 5:
            type  = @"tocomfome";
            break;
            
        case 6:
            type  = @"owkey";
            break;
            
        default:
            break;
    }
    
    NSString * path =[[NSBundle mainBundle] pathForResource:type ofType:@"mp3"];
    NSURL * url = [NSURL fileURLWithPath:path];
    
    [_player stop];
    _player.delegate = nil;
    _player = nil;
    
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
    [_player setVolume:1.0];
    [_player play];
    
    [self postLocalNotification:_notification];
}

- (void)postLocalNotification:(Notification *)notification {
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    localNotification.alertBody = [NSString stringWithFormat:NSLocalizedString(@"%@ warned: %@", nil),
                              _notification.contact.firstName, [_notification typeToString]];
    
    [UIApplication.sharedApplication presentLocalNotificationNow:localNotification];
}

@end
