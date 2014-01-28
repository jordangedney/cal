//
//  DayViewController.m
//  CalenderProject
//
//  Created by Ben Frisbie on 1/16/14.
//  Copyright (c) 2014 Ben Frisbie. All rights reserved.
//

#import "DayViewController.h"
#import "AddEventViewController.h"

@implementation DayViewController

@synthesize datelabel, month, day;

- (void)viewDidLoad
{
   datelabel.text = [NSString stringWithFormat:@"%@ %d",month,day];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"prepareAddEventView"]){
        
        AddEventViewController *controller = (AddEventViewController *)segue.destinationViewController;
        controller.month = month;
        controller.day = day;
    }
}

@end
