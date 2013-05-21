//
//  BombViewController.h
//  YFS
//
//  Created by Daniel Brumleve on 5/18/13.
//  Copyright (c) 2013 YFS Worldwide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface BombViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
