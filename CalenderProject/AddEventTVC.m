//
//  AddEventTVC.m
//  CalenderProject
//

#import "AddEventTVC.h"

@interface AddEventTVC ()

@end

@implementation AddEventTVC

@synthesize delegate;
@synthesize month, day;
@synthesize titletext, locationtext, timepicker;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];

    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"Add Event to %@ %d",month,day];   //set the navigation bar's title
}

-(IBAction)KeyboardDismiss:(id)sender
{
    [sender resignFirstResponder];  //close the keyboard
}


- (IBAction)SaveEvent:(id)sender
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];  //used to format the time
    [outputFormatter setDateFormat:@"HH:mm"]; //24hr time format
    NSString *timeString = [outputFormatter stringFromDate:timepicker.date];  //formats the selected time in the datepicker object
    NSString *eventData;
    if (day == 1 || day == 2 || day == 3) {
        eventData = [NSString stringWithFormat:@"%@0%d;%@;%@;%@\n",month, day, timeString, titletext.text, locationtext.text]; //Saves event data into a string
    }
    else{
        eventData = [NSString stringWithFormat:@"%@%d;%@;%@;%@\n",month, day, timeString, titletext.text, locationtext.text]; //Saves event data into a string
    }
    NSLog(@"add: %@\n",eventData);
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:[self getDataPath]];  //used to travel to a specific spot in a file
    [fileHandle seekToEndOfFile];  //travel to the end of the file
    [fileHandle writeData:[eventData dataUsingEncoding:NSUTF8StringEncoding]];  //write the event out to the text file
    [self.delegate theSaveButtonOnTheAddEventTVCWasTapped:self];  //let the last view know we just clicked on the save button
}



/* Method to get the full path to a text file that will be written out to */
-(NSString*)getDataPath
{
    NSString* filePath = @"data";
    NSString* fileRoot = [[NSBundle mainBundle] pathForResource:filePath ofType:@"txt"];
    return fileRoot;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
