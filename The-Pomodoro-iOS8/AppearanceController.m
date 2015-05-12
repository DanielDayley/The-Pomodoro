
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


-(void)initializeAppearanceDefaults

{
    self.themeColor = [UIColor redColor];
    
    if (self.themeColor){
        [[UINavigationBar appearance]setBackgroundColor:self.themeColor];
        [UISwitch appearance].onTintColor = self.themeColor;
        [UISegmentedControl appearance].tintColor = self.themeColor;
        [UIStepper appearance].tintColor = self.themeColor;
        [[UIButton appearance]setTitleColor:self.themeColor forState:UIControlStateNormal];
        [UITabBar appearance].barTintColor = self.themeColor;
        [UITabBar appearance].selectedImageTintColor = [UIColor whiteColor];
        [UITableView appearance].sectionIndexBackgroundColor = self.themeColor;
        
    }
    
}



@end
