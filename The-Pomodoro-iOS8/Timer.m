//
//  Timer.m
//  The-Pomodoro-iOS8
//
//  Created by Daniel Dayley on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "Timer.h"

@interface Timer()
@property (nonatomic, assign) BOOL isOn;
@property (nonatomic)NSDate *expirationDate;

@end
@implementation Timer

+ (Timer *)sharedInstance {
    static Timer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Timer alloc] init];
        // sharedInstance.timeRemainingInSeconds = 3599;
        sharedInstance.hoursRemaining = sharedInstance.timeRemainingInSeconds/60/60;
        sharedInstance.minutesRemaining = sharedInstance.timeRemainingInSeconds/60;
        sharedInstance.secondsRemaining = sharedInstance.timeRemainingInSeconds - (60 * (sharedInstance.timeRemainingInSeconds/60));
    });
    return sharedInstance;
}

- (void)prepareForBackground {
    [[NSUserDefaults standardUserDefaults] setObject:self.expirationDate forKey:@"expirationDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)loadFromBackGround {
    self.expirationDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"expirationDate"];
    [Timer sharedInstance].timeRemainingInSeconds = self.expirationDate.timeIntervalSince1970 - [NSDate date].timeIntervalSince1970;
    [[Timer sharedInstance] startTimer];
}

- (void)updateMinutesAndSeconds {
    [Timer sharedInstance].hoursRemaining = [Timer sharedInstance].timeRemainingInSeconds/60/60;
    [Timer sharedInstance].minutesRemaining = [Timer sharedInstance].timeRemainingInSeconds/60 - [Timer sharedInstance].hoursRemaining * 60;
    [Timer sharedInstance].secondsRemaining = [Timer sharedInstance].timeRemainingInSeconds - (60 * ([Timer sharedInstance].timeRemainingInSeconds/60));
}

- (void)startTimer {
    //to prevent timer starting when timer is zero.
    if (self.timeRemainingInSeconds >0){
        self.expirationDate = [NSDate dateWithTimeIntervalSinceNow:self.timeRemainingInSeconds];
        NSLog(@"Starting timer: will end  in %ld seconds.",(long)self.timeRemainingInSeconds);
        self.isOn = YES;
        UILocalNotification *localNotification = [UILocalNotification new];
        localNotification.fireDate = self.expirationDate;
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.alertBody = @"Start another round?";
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    [self performSelector:@selector(checkActive) withObject:nil afterDelay:1];
    }
}

- (void)pauseTimer {
    self.isOn = NO;
}

- (void)endTimer {
    self.isOn = NO;
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"timerCompleteNotification" object:nil];
}

- (void)cancelTimer {
    self.isOn = NO;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)decreaseSecond {
    self.timeRemainingInSeconds --;
    [self updateMinutesAndSeconds];
    NSLog(@"%ld : %ld",(long)[Timer sharedInstance].minutesRemaining,(long)[Timer sharedInstance].secondsRemaining);
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:secondTickNotification object:nil];
    if (self.timeRemainingInSeconds == 0)
    {
        [self endTimer];
    }
}
- (void)timerCompleteNotification {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"timerCompleteNotification" object:self];
}

- (void)checkActive {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (self.isOn) {
        [self decreaseSecond];
        [self performSelector:@selector(checkActive) withObject:nil afterDelay:1];
    }
}


@end
