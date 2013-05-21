//
//  YFSDataModel.h
//  YFS
//
//  Created by Daniel Brumleve on 5/18/13.
//  Copyright (c) 2013 YFS Worldwide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFSDataModel : NSObject

@property (nonatomic, strong) RKManagedObjectStore *objectStore;

+ (id)sharedDataModel;
- (void)setup;

@end
