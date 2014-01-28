//
//  ViewController.m
//  CalenderProject
//
//  Created by Ben Frisbie on 1/15/14.
//  Copyright (c) 2014 Ben Frisbie. All rights reserved.
//

#import "ViewController.h"
#import "DayViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize monthlabel;

int m=0;
int chosenday=0;
NSArray *monthnames;
NSArray *buttons;
NSInteger months[12][42] = {
    {0,0,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31},          //January
    {0,0,0,0,0,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28},             //February
    {0,0,0,0,0,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31},    //March
    {0,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30},               //April
    {0,0,0,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31},        //May
    {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30},                   //June
    {0,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31},            //July
    {0,0,0,0,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31},      //August
    {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30},                 //September
    {0,0,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31},          //October
    {0,0,0,0,0,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30},       //November
    {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31}};             //December

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedLeft)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedRight)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];

}

-(void)viewDidAppear:(BOOL)animated
{
    monthnames = [NSArray arrayWithObjects:@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December",nil];
    
    monthlabel.text = [monthnames objectAtIndex:m];
    
    buttons = [NSArray arrayWithObjects:_b0,_b1,_b2,_b3,_b4,_b5,_b6,_b7,_b8,_b9,_b10,_b11,_b12,_b13,_b14,_b15,_b16,_b17,_b18,_b19,_b20,_b21,_b22,_b23,_b24,_b25,_b26,_b27,_b28,_b29,_b30,_b31,_b32,_b33,_b34,_b35,_b36,_b37,_b38,_b39,_b40,_b41, nil];
    
    [self updateMonth];
    
}

-(void)updateMonth
{
    monthlabel.text = [monthnames objectAtIndex:m];
    
    for (NSInteger i=0; i<42; i++) {
        [buttons[i] setTitle:[NSString stringWithFormat:@"%d",months[m][i]] forState:UIControlStateNormal];
        [buttons[i] setTag:months[m][i]];
        if (months[m][i]==0) {
            ((UIButton*)buttons[i]).hidden = YES;
        }
        else{
            ((UIButton*)buttons[i]).hidden = NO;
        }
    }
}

-(void)swipedLeft
{
    m++;
    if (m>11) {
        m=0;
    }
    [self updateMonth];
}

-(void)swipedRight
{
    m--;
    if (m<0) {
        m=11;
    }
    [self updateMonth];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"prepareDayView"]){
        for (NSInteger i=0; i<42; i++) {
            if (((UIButton*)buttons[i]).isTouchInside == YES) {
                chosenday = ((UIButton*)buttons[i]).tag;
            }
        }
        DayViewController *controller = (DayViewController *)segue.destinationViewController;
        controller.month = monthnames[m];
        controller.day = chosenday;
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
