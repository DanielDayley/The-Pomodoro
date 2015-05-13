//
//  Timer.h
//  The-Pomodoro-iOS8
//
//  Created by Daniel Dayley on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

static NSString *secondTickNotification = @"secondTickNotification";
static NSString *timerCompleteNotification = @"timerCompleteNotification";
static NSString *newRoundNotification = @"newRoundNotification";



@interface Timer : NSObject
@property (nonatomic) NSInteger hoursRemaining;
@property (nonatomic) NSInteger minutesRemaining;
@property (nonatomic) NSInteger secondsRemaining;
@property (nonatomic, assign) NSInteger timeRemainingInSeconds;

+ (Timer *)sharedInstance;
- (void)updateMinutesAndSeconds;
- (void)startTimer;
- (void)cancelTimer;
- (void)prepareForBackground;
- (void)loadFromBackGround;
@end
