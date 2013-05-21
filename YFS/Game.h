//
//  Game.h
//  YFS
//
//  Created by Daniel Brumleve on 3/30/13.
//  Copyright (c) 2013 YFS Worldwide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Inning, Team;

@interface Game : NSManagedObject

@property (nonatomic, copy) NSString * date;
@property (nonatomic, copy) NSString * gameID;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, strong) NSSet *innings;
@property (nonatomic, strong) NSSet *teams;


@end


