//
//  BLJChangeBetViewController.h
//  Black Jack 2
//
//  Created by Khoa Nguyen on 1/17/14.
//  Copyright (c) 2014 Khoa Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BLJChangeBetViewController;
@protocol BLJChangeBetViewControllerDelegate
-(void) betViewController: (BLJChangeBetViewController *)betViewController didFinishEnterBetWithValue:(NSInteger) betValue;
@end

@interface BLJChangeBetViewController: UIViewController
@property (weak, nonatomic) IBOutlet UITextField *betValue;
@property (weak, nonatomic) IBOutlet UITextView *message;
@property (weak, nonatomic) id <BLJChangeBetViewControllerDelegate> delegate;
@property (assign, nonatomic) NSInteger money;
@property (assign, nonatomic) NSInteger currentRoundBetAmount;
- (IBAction)done:(id)sender;
- (IBAction)cancel;

@end
