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


@end
@implementation Timer

+ (Timer *)sharedInstance {
    static Timer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Timer alloc] init];
        // sharedInstance.timeRemainingInSeconds = 3599;
        sharedInstance.minutesRemaining = sharedInstance.timeRemainingInSeconds/60;
        sharedInstance.secondsRemaining = sharedInstance.timeRemainingInSeconds - (60 * (sharedInstance.timeRemainingInSeconds/60));
    });
    return sharedInstance;
}

- (void)updateMinutesAndSeconds {
    [Timer sharedInstance].minutesRemaining = [Timer sharedInstance].timeRemainingInSeconds/60;
    [Timer sharedInstance].secondsRemaining = [Timer sharedInstance].timeRemainingInSeconds - (60 * ([Timer sharedInstance].timeRemainingInSeconds/60));
}

- (void)startTimer {
    self.isOn = YES;
    [self checkActive];
}

- (void)endTimer {
    self.isOn = NO;
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"timerCompleteNotification" object:nil];
}

- (void)cancelTimer {
    self.isOn = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)decreaseSecond {
    self.timeRemainingInSeconds --;
    NSLog(@"%ld : %ld",(long)[Timer sharedInstance].minutesRemaining,(long)[Timer sharedInstance].secondsRemaining);
    [self updateMinutesAndSeconds];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:secondTickNotification object:nil];
    if (self.timeRemainingInSeconds == 0)
    {
        [self endTimer];
    }
}
//- (void)decreaseSecond
//{
//    if (self.secondsRemaining > 0)
//    {
//        self.secondsRemaining--;
//        [[NSNotificationCenter defaultCenter] postNotificationName:secondTickNotification object:nil];
//    }
//    else if (self.secondsRemaining == 0 && self.minutesRemaining > 0)
//    {
//        self.minutesRemaining--;
//        self.secondsRemaining = 59;
//        [[NSNotificationCenter defaultCenter] postNotificationName:secondTickNotification object:nil];
//    }
//    else
//    {
//        [self endTimer];
//    }
//}

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
