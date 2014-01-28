//
//  DayViewController.m
//  CalenderProject
//
//  Created by Ben Frisbie on 1/16/14.
//  Copyright (c) 2014 Ben Frisbie. All rights reserved.
//

#import "DayViewController.h"

@implementation DayViewController

//@synthesize month,day;

- (void)viewDidLoad
{
    _monthlabel.text = _month;
    _daylabel.text = [NSString stringWithFormat:@"%d",_day];
}



@end
