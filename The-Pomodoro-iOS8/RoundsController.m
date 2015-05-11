//
//  RoundsController.m
//  The-Pomodoro-iOS8
//
//  Created by Daniel Dayley on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "RoundsController.h"

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
    return @[@25,@5,@25,@5,@25,@5,@25,@15];
}
@end
