//
//  GameViewController.m
//  YFS
//
//  Created by Daniel Brumleve on 3/25/13.
//  Copyright (c) 2013 YFS Worldwide. All rights reserved.
//
#import "GameViewController.h"
#import "GameDetailViewController.h"
#import "Game.h"
#import "Team.h"
#import "GameCell.h"
#import "YFSDataModel.h"
#import "MappingProvider.h"

@interface GameViewController ()

@property (nonatomic, strong) Game *selectedGame;

@end

@implementation GameViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set debug logging level. Set to 'RKLogLevelTrace' to see JSON payload
    RKLogConfigureByName("RestKit/Network", RKLogLevelDefault);

    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self action:@selector(loadGames) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    [self loadGames];
    [self.refreshControl beginRefreshing];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"linen_bg.png"]];
}

- (void)loadGames {
    
    NSIndexSet *statusCodeSet = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    RKMapping *mapping = [MappingProvider gameMapping];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping                                                                                       pathPattern:nil                                                                                         keyPath:nil                                                                                      statusCodes:statusCodeSet];
    
    RKManagedObjectStore *store = [[YFSDataModel sharedDataModel] objectStore];
    
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"https://dl.dropboxusercontent.com"]];
    objectManager.managedObjectStore = store;
    [objectManager addResponseDescriptor:responseDescriptor];
    
    [objectManager getObjectsAtPath:@"/u/1494997/yfs.json" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        [self.refreshControl endRefreshing];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [self.refreshControl endRefreshing];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"An Error Has Occurred" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (GameCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameCell" forIndexPath:indexPath];
    Game *game = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    [self configureCell:cell forGame:game];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    GameDetailViewController *gameDetailViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        self.selectedGame = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        gameDetailViewController.game = self.selectedGame;
    }



#pragma mark - Configure Cell

- (void)configureCell:(GameCell *)cell forGame:(Game *)game
{
    
    //Set the game and date
    
    cell.gameName.text = game.name.description;
    cell.gameDate.text = game.date.description;
    
    //Set the Final label
    
    int extrasNumber = [game.innings count]/2;
    NSString *intString = [NSString stringWithFormat:@"Final/%i", extrasNumber];

    if (extrasNumber > 9) {
        cell.final.text = intString;
    } else {
        cell.final.text = @"Final";
    }
    
    //Set the team name and score labels
    
    NSSet *teamSet = game.teams;
    NSArray *teamArray = [teamSet allObjects];
    
    Team *teamOne = [teamArray objectAtIndex:0];
    Team *teamTwo = [teamArray objectAtIndex:1];
    
    if (teamOne.isHome.boolValue == NO){
        cell.visitor.text = teamOne.name.description;
        cell.home.text = teamTwo.name.description;
        cell.visitorFinalScore.text = teamOne.finalScore.description;
        cell.homeFinalScore.text = teamTwo.finalScore.description;
    } else {
        cell.visitor.text = teamTwo.name.description;
        cell.home.text = teamOne.name.description;
        cell.visitorFinalScore.text = teamTwo.finalScore.description;
        cell.homeFinalScore.text = teamOne.finalScore.description;
    }
    
    //Set the logos
    
    UIImage * redsLogo = [UIImage imageNamed:@"R.png"];
    UIImage * blacksLogo = [UIImage imageNamed:@"B.png"];
    
    if (cell.visitor.text.length <= 5)
    {
    	((UIImageView *)cell.visitorLogo).image = redsLogo;
        ((UIImageView *)cell.homeLogo).image = blacksLogo;
    } else {
        ((UIImageView *)cell.visitorLogo).image = blacksLogo;
        ((UIImageView *)cell.homeLogo).image = redsLogo;
    }
    
    //Set the background image of the cell

    UIImageView *cellBG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell_bg.png"]];
    cell.backgroundView = cellBG;
    
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    RKManagedObjectStore *store = [[YFSDataModel sharedDataModel] objectStore];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Game" inManagedObjectContext:store.mainQueueManagedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptorDate = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSSortDescriptor *sortDescriptorName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptorDate, sortDescriptorName];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:store.mainQueueManagedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    GameCell *cell = (GameCell*)[tableView cellForRowAtIndexPath:indexPath];
    Game *game = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:cell forGame:game];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
 {
 // In the simplest, most efficient, case, reload the table view.
 [self.tableView reloadData];
 }
 */

@end
