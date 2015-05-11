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
@property (nonatomic) NSInteger timeRemainingInSeconds;

@end
@implementation Timer
+ (Timer *)sharedInstance {
    static Timer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Timer alloc] init];
    });
    return sharedInstance;
}
- (void)startTimer {
    self.isOn = YES;
    [self checkActive];
}
- (void)endTimer {
    self.isOn = NO;
    []
}
- (void)decreaseSecond {
    self.timeRemainingInSeconds --;
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"SecondTickNotification" object:self];
    if (self.timeRemainingInSeconds == 0)
    {
        [self endTimer];
    }
}
- (void)timerCompleteNotification {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"TimerCompleteNotification" object:self];
}


@end
