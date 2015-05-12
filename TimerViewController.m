//
//  TimerViewController.m
//  The-Pomodoro-iOS8
//
//  Created by Daniel Dayley on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "TimerViewController.h"
#import "Timer.h"

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

- (IBAction)trigger:(id)sender {
    if (self.timerButton.enabled)
        self.timerButton.enabled = NO;
   // if ([self.timerButton.titleLabel  isEqual: @"Start"]) {
        [[Timer sharedInstance] startTimer];
    self.timerLabel.text = [self timerStringWithMinutes:[Timer sharedInstance].minutesRemaining andSeconds:[Timer sharedInstance].secondsRemaining];

     //   self.timerButton.titleLabel.text = @"Stop";
        
  //  }
  //  if ([self.timerButton.titleLabel isEqual:@"Stop"]) {
        
  //  }
}


- (void)timerLabelUpdate {
    NSLog(@"Timer Label updated.");
    self.timerLabel.text = [self timerStringWithMinutes:[Timer sharedInstance].minutesRemaining andSeconds:[Timer sharedInstance].secondsRemaining];
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

- (NSString *)timerStringWithMinutes:(NSInteger)minutes andSeconds:(NSInteger)seconds {
    NSString *timerString;
    if (minutes < 10) {
        timerString = [NSString stringWithFormat:@"0%li:", (long)minutes]; }
    else {timerString = [NSString stringWithFormat:@"%li:", (long)minutes]; }
    
    if (seconds < 10) {
        timerString = [timerString stringByAppendingString:[NSString stringWithFormat:@"0%li", (long)seconds]]; }
    else { timerString = [timerString stringByAppendingString:[NSString stringWithFormat:@"%li", (long)seconds]]; }
    return timerString;
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
