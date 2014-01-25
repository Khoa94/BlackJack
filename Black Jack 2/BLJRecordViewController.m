//
//  BLJRecordViewController.m
//  Black Jack 2
//
//  Created by Khoa Nguyen on 1/18/14.
//  Copyright (c) 2014 Khoa Nguyen. All rights reserved.
//

#import "BLJRecordViewController.h"

@interface BLJRecordViewController ()

@end

@implementation BLJRecordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    self.mostMoneyLabel.text = [NSString stringWithFormat:@"$%d", self.mostMoney];
    self.dateOfMostMoneyLabel.text = self.dateOfMostMoney;
    
    self.mostConsecutiveRoundsLabel.text = [NSString stringWithFormat:@"%d", self.mostConsecutiveRounds];
    self.dateOfMostConsecutiveRoundsLabel.text = self.dateOfMostConsecutiveRounds;
    
    self.largestBetLabel.text = [NSString stringWithFormat:@"$%d", self.largestBet];
    self.dateOfLargestBetLabel.text = self.dateOfLargestBet;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)close {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
