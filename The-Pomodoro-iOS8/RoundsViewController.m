//
//  RoundsViewController.m
//  The-Pomodoro-iOS8
//
//  Created by Daniel Dayley on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "RoundsViewController.h"
#import "RoundsController.h"
#import "Timer.h"
#import "TimerViewController.h"

@interface RoundsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) UITableView *tableView;
@end

@implementation RoundsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"theID"];
    [self.view addSubview:self.tableView];
     self.tabBarController.tabBar.translucent = NO;

}
- (void)roundComplete {
    if ([RoundsController sharedInstance].currentRound < [RoundsController sharedInstance].roundTimes.count -1) {
        [RoundsController sharedInstance].currentRound ++;
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[RoundsController sharedInstance].currentRound inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        [[RoundsController sharedInstance] roundSelected];
    } else {
        [RoundsController sharedInstance].currentRound = 0;
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[RoundsController sharedInstance].currentRound inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        [[RoundsController sharedInstance] roundSelected];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [RoundsController sharedInstance].roundTimes.count ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"theID"];
    NSArray *roundsArray = [RoundsController sharedInstance].roundTimes;
    NSNumber *minutes = roundsArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%li minutes", (long)[minutes integerValue]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
////    UIImage *image = [UIImage imageNamed:roundsArray[0]];
//    NSLog(@"This the image: %@",image);
    
    cell.imageView.image = [UIImage imageNamed:[[RoundsController sharedInstance] imageNames][indexPath.row]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [RoundsController sharedInstance].currentRound = indexPath.row;
    [[RoundsController sharedInstance] roundSelected];
    [[Timer sharedInstance] cancelTimer];
    //display selecting time on roundsViewController. 
    [[Timer sharedInstance] updateMinutesAndSeconds];
    self.tabBarController.selectedViewController = self.tabBarController.viewControllers[0];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
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
