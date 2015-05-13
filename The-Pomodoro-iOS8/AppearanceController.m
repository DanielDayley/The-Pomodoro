
//
//  AppearanceController.m
//  The-Pomodoro-iOS8
//
//  Created by Warren Goh on 5/12/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "AppearanceController.h"
#import "RoundsViewController.h"


@implementation AppearanceController

+ (AppearanceController*)sharedInstance {
    
    static AppearanceController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AppearanceController alloc] init];
    });
    return sharedInstance;
}

-(void)initializeAppearanceDefaults

{
    self.themeColor = [UIColor blueColor];
    
    if (self.themeColor){
        [[UINavigationBar appearance]setBackgroundColor:self.themeColor];
        [[UINavigationBar appearance]setTranslucent:NO];
        [[UINavigationBar appearance]setTintColor:self.themeColor];
        [UISwitch appearance].onTintColor = self.themeColor;
        [UISegmentedControl appearance].tintColor = self.themeColor;
        [UIStepper appearance].tintColor = self.themeColor;
        [[UIButton appearance]setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [[UIButton appearance]setTitleColor:self.themeColor forState:UIControlStateDisabled];
        [UITabBar appearance].barTintColor = self.themeColor;
        [UITabBar appearance].selectedImageTintColor = [UIColor whiteColor];
        [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"white"]];
        [UITableView appearance].sectionIndexBackgroundColor = self.themeColor;
        [UITableView appearance].backgroundColor = self.themeColor;
    }
}



@end
