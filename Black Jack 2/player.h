//
//  player.h
//  Black Jack 2
//
//  Created by Khoa Nguyen on 1/14/14.
//  Copyright (c) 2014 Khoa Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface player : NSObject
@property (nonatomic, assign) int points;
@property (nonatomic, assign) int HitCounter;
@property (nonatomic, assign) int money;
@property (nonatomic, assign) int bet;
@end
