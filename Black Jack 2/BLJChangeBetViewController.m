//
//  BLJChangeBetViewController.m
//  Black Jack 2
//
//  Created by Khoa Nguyen on 1/17/14.
//  Copyright (c) 2014 Khoa Nguyen. All rights reserved.
//

#import "BLJChangeBetViewController.h"

@interface BLJChangeBetViewController ()

@end

@implementation BLJChangeBetViewController

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
    self.message.text = [NSString stringWithFormat:@"You currently have $%d. Enter the amount you want to bet for the next round.", self.money];
    [self.message setFont:[UIFont systemFontOfSize:17]];
}

- (void) viewDidAppear:(BOOL)animated{
    [self.betValue becomeFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    int maxBet = self.money-self.currentRoundBetAmount;
    if  (self.betValue==nil || [self.betValue.text integerValue]==0 || [self.betValue.text intValue] > maxBet)
    {
        NSString *message = [NSString stringWithFormat:@"Please enter a non-zero number that is smaller than %d", maxBet];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Invalid input" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
    else{
    [self.delegate betViewController:self didFinishEnterBetWithValue: [self.betValue.text integerValue]];
    }
}

- (IBAction)cancel {
    
    //the condition prevent player to hit the "Cancel" button to peek at the card.
    if (self.currentRoundBetAmount > 0) {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}



@end
