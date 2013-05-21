//
//  BombCell.h
//  YFS
//
//  Created by Daniel Brumleve on 5/18/13.
//  Copyright (c) 2013 YFS Worldwide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BombCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *player;
@property (weak, nonatomic) IBOutlet UILabel *bombTotal;

@end
