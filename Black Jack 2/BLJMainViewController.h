//
//  ViewController.h
//  Black Jack
//
//  Created by Khoa Nguyen on 1/13/14.
//  Copyright (c) 2014 Khoa Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface BLJMainViewController : UIViewController <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextRoundBetLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentRoundBetLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerPointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *AIPointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *roundLabel;
@property (weak, nonatomic) IBOutlet UIImageView *playerCard1;
@property (weak, nonatomic) IBOutlet UIImageView *playerCard2;
@property (weak, nonatomic) IBOutlet UIImageView *playerCard3;
@property (weak, nonatomic) IBOutlet UIImageView *playerCard4;
@property (weak, nonatomic) IBOutlet UIImageView *playerCard5;
@property (weak, nonatomic) IBOutlet UIImageView *AICard1;
@property (weak, nonatomic) IBOutlet UIImageView *AICard2;
@property (weak, nonatomic) IBOutlet UIImageView *AICard3;
@property (weak, nonatomic) IBOutlet UIImageView *AICard4;
@property (weak, nonatomic) IBOutlet UIImageView *AICard5;
@property (assign, nonatomic) int money;
- (IBAction)stand;
- (IBAction)playerHit;
- (IBAction)startOver;
- (IBAction)doubleDown;
@end

