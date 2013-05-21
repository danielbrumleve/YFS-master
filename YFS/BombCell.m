//
//  BombCell.m
//  YFS
//
//  Created by Daniel Brumleve on 5/18/13.
//  Copyright (c) 2013 YFS Worldwide. All rights reserved.
//

#import "BombCell.h"

@implementation BombCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
