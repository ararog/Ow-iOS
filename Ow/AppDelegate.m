//
//  AppDelegate.m
//  Ow
//
//  Created by Rogério Pereira Araújo on 10/08/14.
//  Copyright (c) 2014 Bmobile. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <Typhoon/Typhoon.h>
#import <TestFairy/TestFairy.h>
#import "OwAssembly.h"
#import "AppDelegate.h"
#import "Session.h"

@interface AppDelegate ()<AVAudioSessionDelegate>

@property (nonatomic) UIBackgroundTaskIdentifier backgroundTaskIdentifier;
@property(nonatomic, strong) TyphoonComponentFactory* factory;

@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    self.factory = [TyphoonBlockComponentFactory factoryWithAssembly:[OwAssembly assembly]];

    [_factory makeDefault];

    
    [TestFairy begin:@"da218bc49490918d08b9d8a149b5a2ad4e91bea7"];

    
    TyphoonStoryboard *sb = [TyphoonStoryboard storyboardWithName:@"Main"
                                                          factory:_factory bundle:nil];

    Session *session = [(OwAssembly *) _factory defaultSession];
    
    [session loadData];
    
    ChatManager* chatManager = [(OwAssembly *) _factory defaultChatManager];
    
    [chatManager initialize];
    
    UIViewController* controller = nil;
    if(session.user != nil)
        controller = [sb instantiateViewControllerWithIdentifier:@"MainPageViewController"];
    else
        controller = [sb instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
    
    _window.rootViewController = controller;
    
    [_window makeKeyAndVisible];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    _backgroundTaskIdentifier = [application beginBackgroundTaskWithExpirationHandler:^{
        UIBackgroundTaskIdentifier bgTask = UIBackgroundTaskInvalid;
        _backgroundTaskIdentifier = UIBackgroundTaskInvalid;
        [application endBackgroundTask:bgTask];
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    if (_backgroundTaskIdentifier != UIBackgroundTaskInvalid)
    {
        UIBackgroundTaskIdentifier identifier = _backgroundTaskIdentifier;
        _backgroundTaskIdentifier = UIBackgroundTaskInvalid;
        [application endBackgroundTask:identifier];
    }
    
    if(_factory == nil) {
        
        _factory = [TyphoonBlockComponentFactory factoryWithAssembly:[OwAssembly assembly]];
        
        Session *session = [(OwAssembly *) _factory defaultSession];
        
        [session loadData];
        
        ChatManager* chatManager = [(OwAssembly *) _factory defaultChatManager];
        
        [chatManager initialize];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
