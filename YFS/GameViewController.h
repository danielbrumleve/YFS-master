//
//  GameViewController.h
//  YFS
//
//  Created by Daniel Brumleve on 3/25/13.
//  Copyright (c) 2013 YFS Worldwide. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface GameViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
