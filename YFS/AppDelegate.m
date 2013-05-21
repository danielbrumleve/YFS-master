//
//  AppDelegate.h
//  YFS
//
//  Created by Daniel Brumleve on 3/25/13.
//  Copyright (c) 2013 YFS Worldwide. All rights reserved.
//

#import <RestKit/RestKit.h>
#import "AppDelegate.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [self setupCoreData];

    // Override point for customization after application launch.
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_bar.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    //tabBar.selectedImageTintColor = [UIColor redColor];
    
    UIImage* tabBarBackground = [UIImage imageNamed:@"tab_bar.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    
    tabBarItem1.title = @"Scores";
    tabBarItem2.title = @"Bombs";
    
    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"beer.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"beer_unselected.png"]];
    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"bomb.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"bomb_unselected.png"]];
    

    return YES;
}

- (void)setupCoreData {
    [[YFSDataModel sharedDataModel] setup];
}

@end