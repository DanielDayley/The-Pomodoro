//
//  Timer.h
//  The-Pomodoro-iOS8
//
//  Created by Daniel Dayley on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *secondTickNotification;
static NSString *timerCompleteNotification;
static NSString *newRoundNotification;


@interface Timer : NSObject
@property (nonatomic, readonly) NSInteger minutesRemaining;
@property (nonatomic, assign) NSInteger secondsRemaining;
@property (nonatomic, readonly) NSInteger timeRemainingInSeconds;

- (void)startTimer;
- (void)cancelTimer;

@end
