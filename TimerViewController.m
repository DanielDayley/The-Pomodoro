//
//  TimerViewController.m
//  The-Pomodoro-iOS8
//
//  Created by Daniel Dayley on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "TimerViewController.h"
#import "Timer.h"
#import "AppearanceController.h"

@interface TimerViewController ()
@property (weak, nonatomic) IBOutlet UIButton *timerButton;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@end

@implementation TimerViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self registerForNotifications];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated {
    [self timerLabelUpdate];
    [[AppearanceController sharedInstance] initializeAppearanceDefaults];
    self.tabBarController.tabBar.translucent = NO;
    self.view.backgroundColor = [AppearanceController sharedInstance].themeColor;
    self.timerLabel.textColor = [UIColor whiteColor];
}

- (IBAction)trigger:(id)sender {
    if (self.timerButton.enabled)
        self.timerButton.enabled = NO;
        [[Timer sharedInstance] startTimer];
    self.timerLabel.text = [self timerStringWithHours:[Timer sharedInstance].hoursRemaining andMinutes:[Timer sharedInstance].minutesRemaining andSeconds:[Timer sharedInstance].secondsRemaining];

}


- (void)timerLabelUpdate {
    NSLog(@"Timer Label updated.");
    self.timerLabel.text = [self timerStringWithHours:[Timer sharedInstance].hoursRemaining andMinutes:[Timer sharedInstance].minutesRemaining andSeconds:[Timer sharedInstance].secondsRemaining];
}
- (void)registerForNotifications {
    NSNotificationCenter *nc= [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(timerLabelUpdate)
               name:secondTickNotification
               object:nil];
        [nc addObserver:self
               selector:@selector(newRound)
               name:newRoundNotification
                 object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)newRound
{
    [self timerLabelUpdate];
    self.timerButton.enabled = YES;
}

-(void)dealloc {
    [self unregisterForNotifications];
}

- (void)unregisterForNotifications {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

- (NSString *)timerStringWithHours:(NSInteger)hours andMinutes:(NSInteger)minutes andSeconds:(NSInteger)seconds {
    NSString *secondString;
    NSString *minuteString;
    NSString *hourString = @"";
    if (hours < 10) {
        hourString = [hourString stringByAppendingString:[NSString stringWithFormat:@"0%li:", (long)hours]]; }
    else {minuteString = [hourString stringByAppendingString:[NSString stringWithFormat:@"%li:", (long)minutes]]; }
    if (hours == 0) {
        hourString = @"";
    }
    if (minutes < 10) {
        minuteString = [hourString stringByAppendingString:[NSString stringWithFormat:@"0%li:", (long)minutes]]; }
    else {minuteString = [hourString stringByAppendingString:[NSString stringWithFormat:@"%li:", (long)minutes]]; }
    
    if (seconds < 10) {
        secondString = [minuteString stringByAppendingString:[NSString stringWithFormat:@"0%li", (long)seconds]]; }
    else { secondString = [minuteString stringByAppendingString:[NSString stringWithFormat:@"%li", (long)seconds]]; }
    return secondString;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
