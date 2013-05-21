//
//  InningLine.m
//  YFS
//
//  Created by Daniel Brumleve on 5/20/13.
//  Copyright (c) 2013 YFS Worldwide. All rights reserved.
//

#import "InningLine.h"

@implementation InningLine

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [[UIColor whiteColor] setStroke];

    UIBezierPath *topPath = [[UIBezierPath alloc]init];
    [topPath moveToPoint:CGPointMake(0, 25)];
    [topPath addLineToPoint:CGPointMake(self.frame.size.width, 25)];
    topPath.lineWidth = 2;
    [topPath stroke];
    
    UIBezierPath *middlePath = [[UIBezierPath alloc]init];
    [middlePath moveToPoint:CGPointMake(0, 50)];
    [middlePath addLineToPoint:CGPointMake(self.frame.size.width, 50)];
    middlePath.lineWidth = 2;
    [middlePath stroke];
    
    UIBezierPath *verticalPath = [[UIBezierPath alloc]init];
    [verticalPath moveToPoint:CGPointMake(28, 0)];
    [verticalPath addLineToPoint:CGPointMake(28, self.frame.size.height)];
    verticalPath.lineWidth = 2;
    [verticalPath stroke];
    
    self.backgroundColor = [UIColor clearColor];
}


@end
