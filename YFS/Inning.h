//
//  Inning.h
//  YFS
//
//  Created by Daniel Brumleve on 3/30/13.
//  Copyright (c) 2013 YFS Worldwide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Game;

@interface Inning : NSManagedObject

@property (nonatomic, retain) NSString * inningID;
@property (nonatomic, retain) NSNumber * inningNumber;
@property (nonatomic, retain) NSNumber * isTop;
@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) Game *game;

@end
