//
//  AppDelegate.m
//  The-Pomodoro-iOS8
//
//  Created by Taylor Mott on 18.2.2015.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "AppDelegate.h"
#import "TimerViewController.h"
#import "RoundsViewController.h"
#import "AppearanceController.h"
#import "Timer.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    [AppearanceController sharedInstance].themeColor = [UIColor redColor];
    [[AppearanceController sharedInstance] initializeAppearanceDefaults];
    
    
    TimerViewController *timerVC = [TimerViewController new];
    timerVC.tabBarItem.title =  @"Timer";
    timerVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Timer" image:[UIImage imageNamed:@"timer"] tag:0];
    
    RoundsViewController *roundsVC = [RoundsViewController new];
    UINavigationController *roundsNavVC = [[UINavigationController alloc] initWithRootViewController:roundsVC];
    roundsNavVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Rounds" image:[UIImage imageNamed:@"rounds"] tag:1];
    
    UITabBarController *tabBarVC = [UITabBarController new];
    tabBarVC.viewControllers = @[timerVC,roundsNavVC];
    
    self.window.rootViewController = tabBarVC;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[Timer sharedInstance] prepareForBackground];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[Timer sharedInstance] loadFromBackGround];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        
    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert) categories:nil]];
        [application registerForRemoteNotifications];
    } else {
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationType)
         (UIRemoteNotificationTypeBadge |
          UIRemoteNotificationTypeSound |
          UIRemoteNotificationTypeAlert)];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    UIAlertController *notificationAlert = [UIAlertController alertControllerWithTitle:@"Timer Complete" message:notification.alertBody preferredStyle:UIAlertControllerStyleAlert];
    [notificationAlert addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:nil]];
    [notificationAlert addAction:[UIAlertAction actionWithTitle:@"Next Round" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[Timer sharedInstance] startTimer];
    }]];
    [self.window.rootViewController presentViewController:notificationAlert animated:YES completion:nil];
    application.applicationIconBadgeNumber = 0;
}
@end
