//
//  MappingProvider.h
//  YFS
//
//  Created by Daniel Brumleve on 5/18/13.
//  Copyright (c) 2013 YFS Worldwide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MappingProvider : NSObject

+ (RKMapping *)gameMapping;
+ (RKMapping *)inningMapping;
+ (RKMapping *)teamMapping;
+ (RKMapping *)playerMapping;
+ (RKMapping *)bombMapping;

@end
