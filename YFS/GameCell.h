//
//  GameCell.h
//  YFS
//
//  Created by Daniel Brumleve on 4/1/13.
//  Copyright (c) 2013 YFS Worldwide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *visitor;
@property (weak, nonatomic) IBOutlet UILabel *home;
@property (weak, nonatomic) IBOutlet UILabel *gameName;
@property (weak, nonatomic) IBOutlet UILabel *gameDate;
@property (weak, nonatomic) IBOutlet UILabel *visitorFinalScore;
@property (weak, nonatomic) IBOutlet UILabel *homeFinalScore;
@property (weak, nonatomic) IBOutlet UIImageView *visitorLogo;
@property (weak, nonatomic) IBOutlet UIImageView *homeLogo;
@property (weak, nonatomic) IBOutlet UILabel *final;




@end
