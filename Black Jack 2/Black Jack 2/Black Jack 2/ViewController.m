//
//  ViewController.m
//  Black Jack
//
//  Created by Khoa Nguyen on 1/13/14.
//  Copyright (c) 2014 Khoa Nguyen. All rights reserved.
//

#import "ViewController.h"
#import "card.h"

@interface ViewController ()


@end

@implementation ViewController {
    int money, bet, playerPoints, AIPoints, HitButtonCounter, numberOfRemainingCards;
    NSMutableArray *remainingCards;
    NSMutableArray *removedCards;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    numberOfRemainingCards = 51;
    remainingCards = [[NSMutableArray alloc] initWithCapacity:numberOfRemainingCards];
    
    for (int i = 1; i<=13; i++)
    {
        for (int j=0 ; j<=3; j++)
        {
            card *currentCard = [[card alloc] init];
            currentCard.rank = i;
            
            if (j==0){
                currentCard.suite = [NSString stringWithFormat:@"S"];
            }
            else if (j==1){
                currentCard.suite = [NSString stringWithFormat:@"C"];
            }
            else if (j==2){
                currentCard.suite = [NSString stringWithFormat:@"D"];
            }
            else if (j==3){
                currentCard.suite = [NSString stringWithFormat:@"H"];
            }
            
            NSString *cardName = [NSString stringWithFormat:@"%d%@", currentCard.rank, currentCard.suite];
            currentCard.image = [UIImage imageNamed:cardName];
            
            [remainingCards addObject:currentCard];
        }
    }
    //draw 1 card for the AI player
    int AICardIndex = arc4random()%(numberOfRemainingCards) + 1;
    card *AICardDrawed = [remainingCards objectAtIndex:AICardIndex];
    
    [remainingCards removeObjectAtIndex:AICardIndex];
    [removedCards addObject:AICardDrawed];
    numberOfRemainingCards--;
    
    self.AICard1.image =AICardDrawed.image;
    
    if (AICardDrawed.rank > 10){
        AIPoints += 10;
    }
    else{
        AIPoints +=AICardDrawed.rank;
    }
        
    self.AIPointsLabel.text = [NSString stringWithFormat:@"%d Points", AIPoints];
    
    
    //draw 1 card for the player
    int playerCardIndex = arc4random()%(numberOfRemainingCards) + 1;
    card *playerCardDrawed = [remainingCards objectAtIndex:playerCardIndex];
    
    [remainingCards removeObjectAtIndex:playerCardIndex];
    [removedCards addObject:playerCardDrawed];
    numberOfRemainingCards--;
    
    self.playerCard1.image =playerCardDrawed.image;

    if (playerCardDrawed.rank > 10){
        playerPoints += 10;
    }
    else{
        playerPoints +=playerCardDrawed.rank;
    }
    
    self.playerPointsLabel.text = [NSString stringWithFormat:@"%d Points", playerPoints];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)stand {
}


- (IBAction)hit {
    HitButtonCounter ++;
    int cardIndex = arc4random()%(numberOfRemainingCards) + 1;
    card *cardDrawed = [remainingCards objectAtIndex:cardIndex];
    
    
    [remainingCards removeObjectAtIndex:cardIndex];
    [removedCards addObject:cardDrawed];
    numberOfRemainingCards--;

    if(HitButtonCounter == 1){
        self.playerCard2.image =cardDrawed.image;
        playerPoints += cardDrawed.rank;
        self.playerPointsLabel.text = [NSString stringWithFormat:@"%d Points", playerPoints];}
    
    else if(HitButtonCounter == 2){
        self.playerCard3.image =cardDrawed.image;
        playerPoints += cardDrawed.rank;
        self.playerPointsLabel.text = [NSString stringWithFormat:@"%d Points", playerPoints];}
    
    else if(HitButtonCounter == 3){
        self.playerCard4.image =cardDrawed.image;
        playerPoints += cardDrawed.rank;
        self.playerPointsLabel.text = [NSString stringWithFormat:@"%d Points", playerPoints];}
    
    else if(HitButtonCounter == 4){
        self.playerCard5.image =cardDrawed.image;
        playerPoints += cardDrawed.rank;
        self.playerPointsLabel.text = [NSString stringWithFormat:@"%d Points", playerPoints];
    }
    
    
}
@end
