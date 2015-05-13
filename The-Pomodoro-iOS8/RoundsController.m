//
//  RoundsController.m
//  The-Pomodoro-iOS8
//
//  Created by Daniel Dayley on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "RoundsController.h"
#import "Timer.h"
@implementation RoundsController

+ (RoundsController *)sharedInstance {
    
    static RoundsController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [RoundsController new];
    });
    return sharedInstance;
}

- (NSArray *)roundTimes {
    return @[@1,@5,@10,@15,@25,@30,@45,@60];
}

-(NSArray *)imageNames {
    return @[@"jason", @"run",@"yoga",@"tv",@"bottle",@"football",@"beer",@"trek"];
}

- (void)roundSelected {
    [Timer sharedInstance].timeRemainingInSeconds = [[self roundTimes][self.currentRound] integerValue]*60;
    [[NSNotificationCenter defaultCenter] postNotificationName:newRoundNotification object:nil];
    [Timer sharedInstance].previousRoundTime = [Timer sharedInstance].timeRemainingInSeconds;
}


@end
