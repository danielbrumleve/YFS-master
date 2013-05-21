//
//  GameDetailViewController.m
//  YFS
//
//  Created by Daniel Brumleve on 3/25/13.
//  Copyright (c) 2013 YFS Worldwide. All rights reserved.
//

#import "GameDetailViewController.h"
#import "Game.h"
#import "Team.h"
#import "Inning.h"
#import "Player.h"
#import "InningLine.h"

static const int inningLabelWidth=28;
static const int inningLabelHeight=25;
static const int playerLabelWidth=120;
static const int playerLabelHeight=25;



@interface GameDetailViewController ()
- (void)configureView;
@property (weak, nonatomic) IBOutlet InningLine *inningLine;

@end

@implementation GameDetailViewController


- (void)configureView
{
    // Set name of game and date

    self.date.text = self.game.date;
    self.gameName.text = self.game.name;
    
    // Sort innings and set labels
    
    [self setInningLabels];
    
    //Set the team logos & final scores
    
    [self setTeamLabels];
    
    //Set the player labels
    
    [self setPlayerlabels];
}


- (void)setInningLabels{
        
    NSSet *inningsSet = self.game.innings;
    NSArray * inningsArray = [inningsSet allObjects];
    NSPredicate *testForTrue =
    [NSPredicate predicateWithFormat:@"isTop == YES"];
    NSPredicate *testForFalse =
    [NSPredicate predicateWithFormat:@"isTop == NO"];
    
    NSArray *visitorArray = [inningsArray filteredArrayUsingPredicate:testForTrue];
    NSArray *homeArray = [inningsArray filteredArrayUsingPredicate:testForFalse];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"inningNumber" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    NSArray *visitorSortedScores = [visitorArray sortedArrayUsingDescriptors:sortDescriptors];
    NSArray *homeSortedScores = [homeArray sortedArrayUsingDescriptors:sortDescriptors];
    
    NSArray *visitorScores = [visitorSortedScores valueForKey:@"score"];
    NSArray *homeScores = [homeSortedScores valueForKey:@"score"];
    NSArray *inningFrames = [visitorSortedScores valueForKey:@"inningNumber"];
    
    for(int i=0, x=0;i<[inningFrames count];i++, x+=inningLabelWidth)
    {
        
        UILabel *inningFrame = [[UILabel alloc]initWithFrame:CGRectMake(x, 0, inningLabelWidth, inningLabelHeight)];
        UILabel *visitorInningsLabel=[[UILabel alloc]initWithFrame:CGRectMake(x, 25, inningLabelWidth, inningLabelHeight)];
        UILabel * homeInningsLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, 50, inningLabelWidth, inningLabelHeight)];
        inningFrame.text = [[inningFrames objectAtIndex:i]description];
        inningFrame.textAlignment = NSTextAlignmentCenter;
        inningFrame.textColor = [UIColor whiteColor];
        [inningFrame setBackgroundColor:[UIColor clearColor]];
        
        homeInningsLabel.text = [[homeScores objectAtIndex:i]description];
        homeInningsLabel.textAlignment = NSTextAlignmentCenter;
        homeInningsLabel.textColor = [UIColor whiteColor];
        [homeInningsLabel setBackgroundColor:[UIColor clearColor]];
        
        visitorInningsLabel.text = [[visitorScores objectAtIndex:i]description];
        visitorInningsLabel.textAlignment = NSTextAlignmentCenter;
        visitorInningsLabel.textColor = [UIColor whiteColor];
        [visitorInningsLabel setBackgroundColor:[UIColor clearColor]];
        
        [self.scrollView addSubview:inningFrame];
        [self.scrollView addSubview:homeInningsLabel];
        [self.scrollView addSubview:visitorInningsLabel];
        
        //Add vertical line using right border of label
        
        CALayer *rightHomeBorder = [CALayer layer];
        rightHomeBorder.borderColor = [UIColor whiteColor].CGColor;
        rightHomeBorder.borderWidth = 2;
        rightHomeBorder.frame = CGRectMake(-2, -2, 30, homeInningsLabel.frame.size.height+4);
        
        [homeInningsLabel.layer addSublayer:rightHomeBorder];
        
        CALayer *rightVisitorBorder = [CALayer layer];
        rightVisitorBorder.borderColor = [UIColor whiteColor].CGColor;
        rightVisitorBorder.borderWidth = 2;
        rightVisitorBorder.frame = CGRectMake(-2, -2, 30, visitorInningsLabel.frame.size.height+4);
        
        [visitorInningsLabel.layer addSublayer:rightVisitorBorder];
        
        CALayer *rightInningBorder = [CALayer layer];
        rightInningBorder.borderColor = [UIColor whiteColor].CGColor;
        rightInningBorder.borderWidth = 2;
        rightInningBorder.frame = CGRectMake(-2, -2, 30, inningFrame.frame.size.height+4);
        
        [inningFrame.layer addSublayer:rightInningBorder];
        
        }

}

- (void)setTeamLabels{
    
    NSArray *teams = [self.game.teams allObjects];
    Team *teamOne = [teams objectAtIndex:0];
    Team *teamTwo = [teams objectAtIndex:1];
    
    UIImage * redsLogo = [UIImage imageNamed:@"R.png"];
    UIImage * blacksLogo = [UIImage imageNamed:@"B.png"];
    UIImage * blacks = [UIImage imageNamed:@"blacks.png"];
    UIImage * reds = [UIImage imageNamed:@"reds.png"];
    
    if (teamOne.isHome.boolValue == NO && teamOne.name.length < 5)
    {
    	((UIImageView *)self.visitorLogo).image = redsLogo;
        ((UIImageView *)self.homeLogo).image = blacksLogo;
        ((UIImageView *)self.visitorTeamHeading).image = reds;
        ((UIImageView *)self.homeTeamHeading).image = blacks;
        self.visitorScore.text = teamOne.finalScore.description;
        self.homeScore.text = teamTwo.finalScore.description;
        
    } else if (teamOne.isHome.boolValue == NO && teamOne.name.length > 5){
        
        ((UIImageView *)self.visitorLogo).image = blacksLogo;
        ((UIImageView *)self.homeLogo).image = redsLogo;
        ((UIImageView *)self.visitorTeamHeading).image = blacks;
        ((UIImageView *)self.homeTeamHeading).image = reds;
        self.visitorScore.text = teamOne.finalScore.description;
        self.homeScore.text = teamTwo.finalScore.description;
        
    } else if (teamOne.isHome.boolValue == YES && teamOne.name.length > 5) {
        
        ((UIImageView *)self.visitorLogo).image = redsLogo;
        ((UIImageView *)self.homeLogo).image = blacksLogo;
        ((UIImageView *)self.visitorTeamHeading).image = reds;
        ((UIImageView *)self.homeTeamHeading).image = blacks;
        self.visitorScore.text = teamTwo.finalScore.description;
        self.homeScore.text = teamOne.finalScore.description;
        
    } else if (teamOne.isHome.boolValue == YES && teamOne.name.length < 5) {
        
        ((UIImageView *)self.visitorLogo).image = blacksLogo;
        ((UIImageView *)self.homeLogo).image = redsLogo;
        ((UIImageView *)self.visitorTeamHeading).image = blacks;
        ((UIImageView *)self.homeTeamHeading).image = reds;
        self.visitorScore.text = teamTwo.finalScore.description;
        self.homeScore.text = teamOne.finalScore.description;
    }

}

- (void)setPlayerlabels{
    
    NSArray *teams = [self.game.teams allObjects];
    Team *teamOne = [teams objectAtIndex:0];
    Team *teamTwo = [teams objectAtIndex:1];
    
    NSSet *teamOnePlayers = [teamOne.players valueForKey:@"name"];
    NSSet *teamTwoPlayers = [teamTwo.players valueForKey:@"name"];
    NSArray *arrTeamOnePlayers = [teamOnePlayers allObjects];
    NSArray *arrTeamTwoPlayers = [teamTwoPlayers allObjects];
    
    for(int i=0, y=0;i < [arrTeamOnePlayers count];i++, y+=playerLabelHeight){
        
        if (teamOne.isHome.boolValue == NO){
            
            UILabel *visitors = [[UILabel alloc]initWithFrame:CGRectMake(0, y, playerLabelWidth, playerLabelHeight)];
            visitors.text = [[arrTeamOnePlayers  objectAtIndex:i]description];
            visitors.textAlignment = NSTextAlignmentLeft;
            visitors.textColor = [UIColor whiteColor];
            [visitors setFont:[UIFont boldSystemFontOfSize:14]];
            visitors.numberOfLines = 1;
            visitors.adjustsFontSizeToFitWidth = YES;
            [visitors setBackgroundColor:[UIColor clearColor]];
            [self.visitorPlayers addSubview:visitors];
            
        } else if (teamOne.isHome.boolValue == YES){
            
            UILabel *home = [[UILabel alloc]initWithFrame:CGRectMake(0, y, playerLabelWidth, playerLabelHeight)];
            home.text = [[arrTeamOnePlayers objectAtIndex:i]description];
            home.textAlignment = NSTextAlignmentRight;
            home.textColor = [UIColor whiteColor];
            [home setFont:[UIFont boldSystemFontOfSize:14]];
            home.numberOfLines = 1;
            home.adjustsFontSizeToFitWidth = YES;
            [home setBackgroundColor:[UIColor clearColor]];
            [self.homePlayers addSubview:home];
        }
    }
    
    for(int i=0, y=0;i < [arrTeamTwoPlayers count];i++, y+=playerLabelHeight){
        
        if (teamTwo.isHome.boolValue == NO){
            
            UILabel *visitors = [[UILabel alloc]initWithFrame:CGRectMake(0, y, playerLabelWidth, playerLabelHeight)];
            visitors.text = [[arrTeamTwoPlayers  objectAtIndex:i]description];
            visitors.textAlignment = NSTextAlignmentLeft;
            visitors.textColor = [UIColor whiteColor];
            [visitors setFont:[UIFont boldSystemFontOfSize:14]];
            visitors.numberOfLines = 1;
            visitors.adjustsFontSizeToFitWidth = YES;
            [visitors setBackgroundColor:[UIColor clearColor]];
            [self.visitorPlayers addSubview:visitors];

            
            
        } else if (teamTwo.isHome.boolValue == YES){
            
            UILabel *home = [[UILabel alloc]initWithFrame:CGRectMake(0, y, playerLabelWidth, playerLabelHeight)];
            home.text = [[arrTeamTwoPlayers objectAtIndex:i]description];
            home.textAlignment = NSTextAlignmentRight;
            home.textColor = [UIColor whiteColor];
            [home setFont:[UIFont boldSystemFontOfSize:14]];
            home.numberOfLines = 1;
            home.adjustsFontSizeToFitWidth = YES;
            [home setBackgroundColor:[UIColor clearColor]];
            [self.homePlayers addSubview:home];
        }
    }

}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    
    //Set the background image
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"scores_bg.png"]];
    
    //Set the box score scrollview
    
    self.scrollView.contentSize = CGSizeMake(([self.game.innings count]/2)*inningLabelWidth, self.scrollView.frame.size.height);
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    [NSTimer scheduledTimerWithTimeInterval: 0.1 target:self.scrollView selector:@selector(flashScrollIndicators) userInfo:nil repeats:NO];
      
    //Set the player scrollviews
    
    NSArray *teams = [self.game.teams allObjects];
    Team *teamOne = [teams objectAtIndex:0];
    Team *teamTwo = [teams objectAtIndex:1];
    int teamOnePlayers = [teamOne.players count];
    int teamTwoPlayers = [teamTwo.players count];
    
    if (teamOne.isHome.boolValue == NO && teamTwo.isHome.boolValue == YES){
        self.visitorPlayers.contentSize = CGSizeMake(playerLabelWidth,  teamOnePlayers*playerLabelHeight);
        self.homePlayers.contentSize = CGSizeMake(playerLabelWidth, teamTwoPlayers*playerLabelHeight);
    } else if (teamOne.isHome.boolValue == YES && teamTwo.isHome.boolValue == NO){
        self.visitorPlayers.contentSize = CGSizeMake(playerLabelWidth, teamTwoPlayers*playerLabelHeight);
        self.homePlayers.contentSize = CGSizeMake(playerLabelWidth, teamOnePlayers*playerLabelHeight);
    }
    
    self.homePlayers.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 112);
    self.homePlayers.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.visitorPlayers.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    
    [NSTimer scheduledTimerWithTimeInterval: 0.1 target:self.homePlayers selector:@selector(flashScrollIndicators) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval: 0.1 target:self.visitorPlayers selector:@selector(flashScrollIndicators) userInfo:nil repeats:NO];
    
    //Swipe Gesture
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDetected:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
}

- (IBAction)swipeDetected:(UISwipeGestureRecognizer *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
