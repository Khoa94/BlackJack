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
@property (strong, nonatomic) NSString *dateOfMostMoney;
@property (strong, nonatomic) NSString *dateOfMostConsecutiveRounds;
- (IBAction)close;
@property (weak, nonatomic) IBOutlet UITextField *mostMoneyLabel;
@property (weak, nonatomic) IBOutlet UITextField *dateOfMostMoneyLabel;
@property (weak, nonatomic) IBOutlet UITextField *mostConsecutiveRoundsLabel;
@property (weak, nonatomic) IBOutlet UITextField *dateOfMostConsecutiveRoundsLabel;
@end
