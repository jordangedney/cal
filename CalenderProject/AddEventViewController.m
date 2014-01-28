//
//  AddEventViewController.m
//  CalenderProject
//
//  Created by Ben Frisbie on 1/23/14.
//  Copyright (c) 2014 Ben Frisbie. All rights reserved.
//

#import "AddEventViewController.h"

@implementation AddEventViewController

@synthesize titletext, locationtext, timepicker, datelabel, month, day;

-(void)viewDidLoad
{
    datelabel.text = [NSString stringWithFormat:@"%@ %d", month, day];
}

-(IBAction)KeyboardDismiss:(id)sender
{
    [sender resignFirstResponder];
}

-(IBAction)TapBackground:(id)sender
{
    [titletext resignFirstResponder];
    [locationtext resignFirstResponder];
}

- (IBAction)SaveEvent:(id)sender
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH:mm"]; //24hr time format
    NSString *timeString = [outputFormatter stringFromDate:timepicker.date];
    NSString *eventData = [NSString stringWithFormat:@"%@ %@ %@ %@",datelabel.text, titletext.text, timeString, locationtext.text];
    NSLog(eventData);
}

@end
