//
//  Team.h
//  YFS
//
//  Created by Daniel Brumleve on 3/30/13.
//  Copyright (c) 2013 YFS Worldwide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Game, Player;

@interface Team : NSManagedObject

@property (nonatomic, retain) NSNumber * finalScore;
@property (nonatomic, retain) NSNumber * isHome;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Game *game;
@property (nonatomic, strong) NSSet *players;



@end


