//
//  Player.h
//  YFS
//
//  Created by Daniel Brumleve on 3/30/13.
//  Copyright (c) 2013 YFS Worldwide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Team;

@interface Player : NSManagedObject

@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) Team *team;

@end
