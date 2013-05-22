//
//  Bomb.h
//  YFS
//
//  Created by Daniel Brumleve on 5/19/13.
//  Copyright (c) 2013 YFS Worldwide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Bomb : NSManagedObject

@property (nonatomic, copy) NSNumber * bombTotal;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString *bombID;

@end
