//
//  BLJRecordViewController.h
//  Black Jack 2
//
//  Created by Khoa Nguyen on 1/18/14.
//  Copyright (c) 2014 Khoa Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLJRecordViewController : UIViewController
@property (assign, nonatomic) int mostMoney;
@property (assign, nonatomic) int mostConsecutiveRounds;
@property (assign, nonatomic) int largestBet;
@property (strong, nonatomic) NSString *dateOfMostMoney;
@property (strong, nonatomic) NSString *dateOfMostConsecutiveRounds;
@property (strong, nonatomic) NSString *dateOfLargestBet;
- (IBAction)close;
@property (weak, nonatomic) IBOutlet UITextField *mostMoneyLabel;
@property (weak, nonatomic) IBOutlet UITextField *dateOfMostMoneyLabel;

@property (weak, nonatomic) IBOutlet UITextField *mostConsecutiveRoundsLabel;
@property (weak, nonatomic) IBOutlet UITextField *dateOfMostConsecutiveRoundsLabel;

@property (weak, nonatomic) IBOutlet UITextField *largestBetLabel;
@property (weak, nonatomic) IBOutlet UITextField *dateOfLargestBetLabel;

@end
