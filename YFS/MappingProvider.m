//
//  MappingProvider.m
//  YFS
//
//  Created by Daniel Brumleve on 5/18/13.
//  Copyright (c) 2013 YFS Worldwide. All rights reserved.
//

#import "MappingProvider.h"
#import "YFSDataModel.h"
#import "Inning.h"
#import "Game.h"
#import "Team.h"
#import "Player.h"

@implementation MappingProvider

+ (RKMapping *)gameMapping {
    RKEntityMapping *mapping = [RKEntityMapping mappingForEntityForName:@"Game"
                                                   inManagedObjectStore:[[YFSDataModel sharedDataModel] objectStore]];
    [mapping addAttributeMappingsFromDictionary:@{
     @"_id":             @"gameID",
     @"name":             @"name",
     @"date":            @"date"}];
    mapping.identificationAttributes = @[ @"gameID" ];
    
    [mapping addRelationshipMappingWithSourceKeyPath:@"innings"
                                             mapping:[MappingProvider inningMapping]];
    [mapping addRelationshipMappingWithSourceKeyPath:@"teams"
                                             mapping:[MappingProvider teamMapping]];
    
    return mapping;
}

+ (RKMapping *)inningMapping {
    RKEntityMapping *mapping = [RKEntityMapping mappingForEntityForName:@"Inning"
                                                   inManagedObjectStore:[[YFSDataModel sharedDataModel] objectStore]];
    [mapping addAttributeMappingsFromDictionary:@{
     @"_id":             @"inningID",
     @"inning":             @"inningNumber",
     @"score":             @"score",
     @"isTop":            @"isTop"}];
    
    return mapping;
}

+ (RKMapping *)teamMapping {
    RKEntityMapping *mapping = [RKEntityMapping mappingForEntityForName:@"Team"
                                                   inManagedObjectStore:[[YFSDataModel sharedDataModel] objectStore]];
    [mapping addAttributeMappingsFromDictionary:@{
     @"final":             @"finalScore",
     @"isHome":             @"isHome",
     @"name":            @"name"}];
    
    [mapping addRelationshipMappingWithSourceKeyPath:@"players"
                                             mapping:[MappingProvider playerMapping]];
    
    return mapping;
}

+ (RKMapping *)playerMapping {
    RKEntityMapping *mapping = [RKEntityMapping mappingForEntityForName:@"Player"
                                                   inManagedObjectStore:[[YFSDataModel sharedDataModel] objectStore]];
    [mapping addAttributeMappingsFromDictionary:@{
     @"name":            @"name"}];
    
    return mapping;
}

+ (RKMapping *)bombMapping {
    RKEntityMapping *mapping = [RKEntityMapping mappingForEntityForName:@"Bomb"
                                                   inManagedObjectStore:[[YFSDataModel sharedDataModel] objectStore]];
    [mapping addAttributeMappingsFromDictionary:@{
     @"bombs":            @"bombTotal",
     @"name":             @"name"}];
    mapping.identificationAttributes = @[ @"name" ];

    return mapping;
}

@end
