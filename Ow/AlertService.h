//
//  AlertService.h
//  Ow
//
//  Created by Rogério Pereira Araújo on 01/09/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "Notification.h"

@interface AlertService : NSObject<AVAudioPlayerDelegate>

-(void) executeAlertForNotification:(Notification *)notification
                          withSound:(BOOL)sound;

@end
