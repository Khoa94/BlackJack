//
//  ViewController.m
//  Black Jack
//
//  Created by Khoa Nguyen on 1/13/14.
//  Copyright (c) 2014 Khoa Nguyen. All rights reserved.

#import "BLJMainViewController.h"
#import "card.h"
#import "BLJChangeBetViewController.h"
#import "BLJRecordViewController.h"

@interface BLJMainViewController () <BLJChangeBetViewControllerDelegate>

@property (nonatomic, strong) NSTimer *aiHitTimer;

@end

@implementation BLJMainViewController {
    int currentRoundBetAmount, nextRoundBetAmount, playerPoints, AIPoints, HitButtonCounter, numberOfRemainingCards, AIHitCounter, round;
    //all integers are initialize to 0 as default
    
    NSMutableArray *remainingCards;
    AVAudioPlayer *dealCardSound;
    AVAudioPlayer *LoseSound;
    AVAudioPlayer *WinSound;
    int playerNumberOfAce;
    int AINumberOfAce;
    NSString *losingMessage;
    NSString *winningMessage;
    BOOL madeFirstBet;
    
}

- (void) saveMostMoney{
    if (self.money > [self getMostMoney]) {
        [[NSUserDefaults standardUserDefaults] setObject:@(self.money) forKey:@"mostMoney"];
        NSDate *currentTime = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd MMMM, YYYY' at 'hh:mm a"];
        NSString *resultString = [dateFormatter stringFromDate: currentTime];
        NSString *dateOfMostMoney = resultString;
        [[NSUserDefaults standardUserDefaults] setObject:dateOfMostMoney forKey:@"dateOfMostMoney"];
    }
}

-(int)getMostMoney
{
    int currentScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"mostMoney"];
    return currentScore;
}


- (void) saveMostConsecutiveRounds{
    if (round > [self getMostConsecutiveRounds]) {
        [[NSUserDefaults standardUserDefaults] setObject:@(round) forKey:@"mostConsecutiveRounds"];
        NSDate *currentTime = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd MMMM, YYYY' at 'hh:mm a"];
        NSString *resultString = [dateFormatter stringFromDate: currentTime];
        NSString *dateOfMostConsecutiveRounds = resultString;
        [[NSUserDefaults standardUserDefaults] setObject:dateOfMostConsecutiveRounds forKey:@"dateOfMostConsecutiveRounds"];
    }
}

-(int) getMostConsecutiveRounds
{
    int currentRoundNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"mostConsecutiveRounds"];
    return currentRoundNumber;
}


- (void) saveLargestBet {
    if (currentRoundBetAmount > [self getLargestBet]) {
        [[NSUserDefaults standardUserDefaults] setInteger:currentRoundBetAmount forKey:@"largestBet"];
        NSDate *currentTime = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd MMMM, YYYY' at 'hh:mm a"];
        NSString *resultString = [dateFormatter stringFromDate: currentTime];
        NSString *dateOfLargestBet = resultString;
        [[NSUserDefaults standardUserDefaults] setObject:dateOfLargestBet forKey:@"dateOfLargestBet"];
    }
}

-(int) getLargestBet
{
    int currentLargestBet = [[NSUserDefaults standardUserDefaults] integerForKey:@"largestBet"];
    return currentLargestBet;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //load saved progress
    round = [[NSUserDefaults standardUserDefaults] integerForKey:@"round"];
    if (round != 0){
        currentRoundBetAmount = [[NSUserDefaults standardUserDefaults] integerForKey:@"currentRoundBetAmount"];
        self.currentRoundBetLabel.text = [NSString stringWithFormat:@"Current round's bet: $%d", currentRoundBetAmount];
        self.nextRoundBetLabel.text = [NSString stringWithFormat:@"Next round's bet: $%d", currentRoundBetAmount];
        
        self.money = [[NSUserDefaults standardUserDefaults] integerForKey:@"money"];
        self.moneyLabel.text = [NSString stringWithFormat:@"Money: $%d", self.money];
        
        madeFirstBet =  YES;
    }
    
    else {
        round++;
        [self resetMoneyBet];
        madeFirstBet = NO;
    }
    
    self.roundLabel.text = [NSString stringWithFormat:@"Round %d", round];
    remainingCards = [[NSMutableArray alloc] initWithCapacity:51];
    [self resetCardDeck];
    [self playDealCardSound];
    [self drawCardAtBeginning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (madeFirstBet == NO && round==1) {
        [self performSegueWithIdentifier:@"changeBet" sender:nil];
    }
}

- (void) saveProgress{
    [[NSUserDefaults standardUserDefaults] setInteger:round forKey:@"round"];
    [[NSUserDefaults standardUserDefaults] setInteger:currentRoundBetAmount forKey:@"currentRoundBetAmount"];
    [[NSUserDefaults standardUserDefaults] setInteger:nextRoundBetAmount forKey:@"nextRoundBetAmount"];
    [[NSUserDefaults standardUserDefaults] setInteger:self.money forKey:@"money"];
}

-(void) resetCardDeck
{
    playerNumberOfAce = 0;
    AINumberOfAce = 0;
    numberOfRemainingCards = 52; //start counting at 0
    
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
            
            /*Fix the rank of the cards to match Black Jack rules. The default rank of an Ace is 11 */
            if (i==1){
                currentCard.rank = 11;
            }
            else if (i>=2 && i <= 10){
                currentCard.rank = i;}
            else {
                currentCard.rank = 10;
            }
            
            [remainingCards addObject:currentCard];
        }
    }
}


-(void)playDealCardSound
{
    NSURL* musicFile = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                               pathForResource:@"TurnCard"
                                               ofType:@"caf"]];
    dealCardSound = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile error:nil];
    dealCardSound.volume=1.0f;
    [dealCardSound play];
}

-(void)playLosingSound
{
    NSURL* musicFile = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                               pathForResource:@"Losing Sound"
                                               ofType:@"wav"]];
    LoseSound = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile error:nil];
    [LoseSound play];
    LoseSound.volume = 0.7f;
}

-(void)playWinningSound
{
    NSURL* musicFile = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                               pathForResource:@"Winning Sound"
                                               ofType:@"caf"]];
    WinSound = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile error:nil];
    [WinSound play];
}


- (void) resetMoneyBet {
    self.money = 3000;
    self.moneyLabel.text = [NSString stringWithFormat:@"Total money: $%d", self.money];
    currentRoundBetAmount = 0;
}

- (card*) drawCard{
    int cardIndex = arc4random()%(numberOfRemainingCards);
    card *drawedCard = [remainingCards objectAtIndex:cardIndex];
    
    [remainingCards removeObjectAtIndex:cardIndex];
    numberOfRemainingCards--;
    return drawedCard;
}

-(void)drawCardAtBeginning{
    [self AIHit];
    [self playerHit];
    [self playerHit];
}

- (void) newRound{
    round++;
    self.roundLabel.text = [NSString stringWithFormat:@"Round %d", round];
    
    [self saveMostConsecutiveRounds];
    [self saveLargestBet];
    
    if (nextRoundBetAmount != 0){
        currentRoundBetAmount = nextRoundBetAmount;
        self.currentRoundBetLabel.text = [NSString stringWithFormat:@"Current rounds's bet: $%d", currentRoundBetAmount];
    }
    
    playerPoints = 0;
    AIPoints = 0;
    self.AIPointsLabel.text = [NSString stringWithFormat:@"%d points",playerPoints];
    self.playerPointsLabel.text = [NSString stringWithFormat:@"%d points", playerPoints];
    
    HitButtonCounter = 0;
    AIHitCounter = 0;
    
    self.playerCard1.image = nil;
    self.playerCard2.image = nil;
    self.playerCard3.image = nil;
    self.playerCard4.image = nil;
    self.playerCard5.image = nil;
    self.AICard1.image = nil;
    self.AICard2.image = nil;
    self.AICard3.image = nil;
    self.AICard4.image = nil;
    self.AICard5.image = nil;
    
    [self resetCardDeck];
    [self drawCardAtBeginning];
    [self saveProgress];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)stand {
    [self AIDrawCard];
}

-(void)AIHit{
    [self playDealCardSound];
    AIHitCounter ++;
    card *drawedCard = [self drawCard];
    if (drawedCard.rank==11) {
        AINumberOfAce++;
    }
    if(AIHitCounter == 1){
        self.AICard1.image =drawedCard.image;
        AIPoints += drawedCard.rank;
        self.AIPointsLabel.text = [NSString stringWithFormat:@"%d Points", AIPoints];
    }
    else if(AIHitCounter == 2){
        self.AICard2.image =drawedCard.image;
        AIPoints += drawedCard.rank;
        self.AIPointsLabel.text = [NSString stringWithFormat:@"%d Points", AIPoints];
    }
    else if(AIHitCounter == 3){
        self.AICard3.image =drawedCard.image;
        AIPoints += drawedCard.rank;
        self.AIPointsLabel.text = [NSString stringWithFormat:@"%d Points", AIPoints];
    }
    else if(AIHitCounter == 4){
        self.AICard4.image =drawedCard.image;
        AIPoints += drawedCard.rank;
        self.AIPointsLabel.text = [NSString stringWithFormat:@"%d Points", AIPoints];
    }
    else if(AIHitCounter == 5){
        self.AICard5.image =drawedCard.image;
        AIPoints += drawedCard.rank;
        self.AIPointsLabel.text = [NSString stringWithFormat:@"%d Points", AIPoints];
    }
    
    if (AIPoints > 21 && AINumberOfAce > 0) {
        AIPoints -= 10; //An Ace could be 11 or 1. The difference between 11 and 1 is 10.
        self.AIPointsLabel.text = [NSString stringWithFormat:@"%d Points", AIPoints];
        AINumberOfAce--;
    }
}

- (void)AIDrawCard
{
    while (AIPoints<17) {
        [self AIHit];
    }
    [self determineWinner];
}

- (void)determineWinner{
    losingMessage = [NSString stringWithFormat:@"You've lost $%d", currentRoundBetAmount];
    winningMessage = [NSString stringWithFormat:@"You've won $%d", currentRoundBetAmount];
    
    if (AIHitCounter==5 && AIPoints<=21){
        [self playLosingSound];
        self.money = self.money - currentRoundBetAmount;
        self.moneyLabel.text = [NSString stringWithFormat:@"Total money: $%d", self.money];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:losingMessage message:@"The dealer draws 5 cards without getting over 21" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
    else if (AIPoints > 21) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:winningMessage message:@"The dealer is busted" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        [self playWinningSound];
        self.money = self.money + currentRoundBetAmount;
        self.moneyLabel.text = [NSString stringWithFormat:@"Total money: $%d", self.money];
    }
    else if (AIPoints > playerPoints){
        [self playLosingSound];
        self.money = self.money - currentRoundBetAmount;
        self.moneyLabel.text = [NSString stringWithFormat:@"Total money: $%d", self.money];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:losingMessage message:@"The dealer gets closer to 21 than you. Better luck next time!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
    
    else if (AIPoints < playerPoints){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:winningMessage message:@"You get closer to 21 than the dealer. Congratulations!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        if (self.money > 0){
            [alertView show];
        }
        [self playWinningSound];
        self.money = self.money + currentRoundBetAmount;
        self.moneyLabel.text = [NSString stringWithFormat:@"Total money: $%d", self.money];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"It's a draw" message:@"You can do better!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
    [self saveMostMoney];
}

- (IBAction)playerHit
{
    [self playDealCardSound];
    HitButtonCounter ++;
    card *drawedCard = [self drawCard];
    if (drawedCard.rank==11){
        playerNumberOfAce++;
    }
    
    if(HitButtonCounter == 1){
        self.playerCard1.image =drawedCard.image;
        playerPoints += drawedCard.rank;
        self.playerPointsLabel.text = [NSString stringWithFormat:@"%d Points", playerPoints];}
    else if(HitButtonCounter == 2){
        self.playerCard2.image =drawedCard.image;
        playerPoints += drawedCard.rank;
        self.playerPointsLabel.text = [NSString stringWithFormat:@"%d Points", playerPoints];}
    else if(HitButtonCounter == 3){
        self.playerCard3.image =drawedCard.image;
        playerPoints += drawedCard.rank;
        self.playerPointsLabel.text = [NSString stringWithFormat:@"%d Points", playerPoints];}
    else if(HitButtonCounter == 4){
        self.playerCard4.image =drawedCard.image;
        playerPoints += drawedCard.rank;
        self.playerPointsLabel.text = [NSString stringWithFormat:@"%d Points", playerPoints];}
    else if(HitButtonCounter == 5){
        self.playerCard5.image =drawedCard.image;
        playerPoints += drawedCard.rank;
        self.playerPointsLabel.text = [NSString stringWithFormat:@"%d Points", playerPoints];}
    
    //Automatically "stand" when the player's point is 21
    if (playerPoints == 21)
    {
        [self stand];
    }
    
    losingMessage = [NSString stringWithFormat:@"You've lost $%d", currentRoundBetAmount];
    winningMessage = [NSString stringWithFormat:@"You've won $%d", currentRoundBetAmount];
    
    /*Cases when the player automatically win or lose no matter what the dealer does*/
    if (playerPoints > 21 && playerNumberOfAce > 0){
        playerPoints -= 10; //An Ace could be 11 or 1. The difference between 11 and 1 is 10.
        self.playerPointsLabel.text = [NSString stringWithFormat:@"%d Points", playerPoints];
        playerNumberOfAce--;
    }
    
    if (playerPoints > 21) {
        [self playLosingSound];
        self.money = self.money - currentRoundBetAmount;
        self.moneyLabel.text = [NSString stringWithFormat:@"Total money: $%d", self.money];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:losingMessage message:@"You're busted. Better luck next time!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
    
    if (HitButtonCounter == 5 && playerPoints <=21)
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:winningMessage message:@"Your total points after drawing 5 cards don't go over 21" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        [self playWinningSound];
        self.money = self.money + currentRoundBetAmount;
        self.moneyLabel.text = [NSString stringWithFormat:@"Total money: $%d", self.money];
    }
    
    [self saveMostMoney];
}

- (IBAction)startOver {
    round = 0;
    madeFirstBet = NO;
    [self resetMoneyBet];
    [self performSegueWithIdentifier:@"changeBet" sender:nil];
    [self newRound];
}

- (IBAction)doubleDown {
    currentRoundBetAmount = currentRoundBetAmount*2;
    [self playerHit];
    
    if (playerPoints <=21){
        [self AIDrawCard];
    }
    currentRoundBetAmount = currentRoundBetAmount/2;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (self.money > 0){
        [self newRound];
    }
    else {
        [self startOver];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"You're out of money!" message:@"The game now restarts." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
}

-(void)betViewController:(BLJChangeBetViewController *)betViewController didFinishEnterBetWithValue:(NSInteger)betValue{
    if (madeFirstBet == NO){
        currentRoundBetAmount = betValue;
        self.currentRoundBetLabel.text = [NSString stringWithFormat:@"Current rounds's bet: $%d", currentRoundBetAmount];
        madeFirstBet =YES;
        self.nextRoundBetLabel.text = [NSString stringWithFormat:@"Next rounds's bet: $%d", currentRoundBetAmount];
    }
    else {
        nextRoundBetAmount = betValue;
        self.nextRoundBetLabel.text = [NSString stringWithFormat:@"Next rounds's bet: $%d", nextRoundBetAmount];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"changeBet"]) {
        BLJChangeBetViewController *betViewController = (BLJChangeBetViewController *)segue.destinationViewController;
        betViewController.delegate = self;
        betViewController.money = self.money;
        betViewController.currentRoundBetAmount = currentRoundBetAmount;
    }
    else if ([segue.identifier isEqualToString:@"record"]) {
        BLJRecordViewController *recordViewController = (BLJRecordViewController *)segue.destinationViewController;
        recordViewController.mostMoney = [self getMostMoney];
        recordViewController.dateOfMostMoney = [[NSUserDefaults standardUserDefaults] stringForKey:@"dateOfMostMoney"];
        recordViewController.mostConsecutiveRounds = [self getMostConsecutiveRounds];
        recordViewController.dateOfMostConsecutiveRounds = [[NSUserDefaults standardUserDefaults] stringForKey:@"dateOfMostConsecutiveRounds"];
        recordViewController.largestBet = [self getLargestBet];
        recordViewController.dateOfLargestBet = [[NSUserDefaults standardUserDefaults] stringForKey:@"dateOfLargestBet"];
    }
}



@end
