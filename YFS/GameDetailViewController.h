//
//  GameDetailViewController.h
//  YFS
//
//  Created by Daniel Brumleve on 3/25/13.
//  Copyright (c) 2013 YFS Worldwide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Game.h"

@interface GameDetailViewController : UIViewController 

@property (strong, nonatomic) Game *game;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIScrollView *visitorPlayers;
@property (nonatomic, strong) IBOutlet UIScrollView *homePlayers;


@property (weak, nonatomic) IBOutlet UILabel *gameName;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UIImageView *visitorLogo;
@property (strong, nonatomic) IBOutlet UIImageView *homeLogo;
@property (strong, nonatomic) IBOutlet UILabel *visitorScore;
@property (strong, nonatomic) IBOutlet UILabel *homeScore;
@property (strong, nonatomic) IBOutlet UIImageView *visitorTeamHeading;
@property (strong, nonatomic) IBOutlet UIImageView *homeTeamHeading;

-(void)setInningLabels;
-(void)setTeamLabels;
-(void)setPlayerlabels;


@end
