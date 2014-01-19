//
//  ViewController.h
//  Black Jack
//
//  Created by Khoa Nguyen on 1/13/14.
//  Copyright (c) 2014 Khoa Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *betLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerPointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *AIPointsLabel;
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
- (IBAction)stand;
- (IBAction)hit;
@end
