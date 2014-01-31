//
//  ViewController.m
//  CalenderProject
//

#import "MonthViewController.h"
#import "DayTVC.h"

@interface MonthViewController ()

@end

@implementation MonthViewController

@synthesize monthlabel;

int m=0; //current month
int chosenday=0; //the day that is clicked
NSArray *monthnames; //array of the all the month's names
NSArray *buttons; //array of all the day buttons

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
	
    //sets up swipe to the left listener for the view
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedLeft)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    //sets up swipe to the right listener for the view
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedRight)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];

}



-(void)viewDidAppear:(BOOL)animated
{
    monthnames = [NSArray arrayWithObjects:@"January",@"February",@"March",@"April",@"May",@"June",
                  @"July",@"August",@"September",@"October",@"November",@"December",nil];
    
    buttons = [NSArray arrayWithObjects:_b0,_b1,_b2,_b3,_b4,_b5,_b6,_b7,_b8,_b9,_b10,_b11,_b12,_b13,_b14,_b15,_b16,_b17,_b18,_b19,_b20,_b21,_b22,_b23,_b24,_b25,_b26,_b27,_b28,_b29,_b30,_b31,_b32,_b33,_b34,_b35,_b36,_b37,_b38,_b39,_b40,_b41, nil]; //add all the day buttons to the button array
    
    
    [self updateMonth];
    
}



/* Method to update the views contents to the current month. Updates labels and buttons. */
-(void)updateMonth
{
    monthlabel.text = [monthnames objectAtIndex:m];  //sets the month label to the current month
    
    for (NSInteger i=0; i<42; i++) {
        [buttons[i] setTitle:[NSString stringWithFormat:@"%d",months[m][i]] forState:UIControlStateNormal];  //sets buttons text to the day in that month, 0 if not
        [buttons[i] setTag:months[m][i]];  //sets buttons tag to the day in that month, 0 if not
        if (months[m][i]==0) {
            ((UIButton*)buttons[i]).hidden = YES;  //if the day is not in the month make the button hidden
        }
        else{
            ((UIButton*)buttons[i]).hidden = NO;  //if the day is in the month make the button show
        }
    }
}



/* Method called when the view is swiped left. Moves to the next month */
-(void)swipedLeft
{
    m++;
    if (m>11) { //If the month was December go back to January
        m=0;
    }
    [self updateMonth];
}


/* Method called when the view is swiped right. Moves to the previous month */
-(void)swipedRight
{
    m--;
    if (m<0) { //If the month was January go to December
        m=11;
    }
    [self updateMonth];
}



/* Method called before transistioning to a new vew */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
        for (NSInteger i=0; i<42; i++) {
            if (((UIButton*)buttons[i]).isTouchInside == YES) {
                chosenday = ((UIButton*)buttons[i]).tag;  //Find out which day was pushed so it can be passed on to the next view
            }
        }
        DayTVC *controller = (DayTVC *)segue.destinationViewController; //get the next view
        controller.month = monthnames[m];  //set the next views month to the current month
        controller.day = chosenday;  //set the next views day to the pushed day
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
