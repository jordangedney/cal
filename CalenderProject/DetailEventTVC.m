//
//  DetailEventTVC.m
//  CalenderProject
//

#import "DetailEventTVC.h"

@interface DetailEventTVC ()

@end

@implementation DetailEventTVC

@synthesize delegate;
@synthesize month, day, eventtitle, eventlocation, eventtime;
@synthesize titletext, locationtext, timepicker;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"Edit Event on %@ %d",month,day];   //set the navigation bar's title
    self.titletext.text = eventtitle;  //set the title textfield to the title of the event
    self.locationtext.text = eventlocation;  //set the location textfield to the location of the event
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH:mm"];
    [self.timepicker setDate:[outputFormatter dateFromString:eventtime]]; //set the time in the date picker to the time of the event
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(IBAction)KeyboardDismiss:(id)sender
{
    [sender resignFirstResponder];  //close the keyboard
}


- (IBAction)SaveEvent:(id)sender
{
    if ([titletext.text length] == 0) {
        titletext.text = [NSString stringWithFormat:@"(EMPTY)"];
    }
    if ([locationtext.text length] == 0) {
        locationtext.text = @"(EMPTY)";
    }
    
    NSString *content = [NSString stringWithContentsOfFile:[self getDataPath] encoding:NSUTF8StringEncoding error:nil];  //Put all data from text file into string
    [self editEvent:content];
    
    [self.delegate theSaveButtonOnTheDetailEventTVCWasTapped:self];  //let the last view know we just clicked on the save button
}


-(void)editEvent:(NSString*)content
{
    NSString *replace;
    if (day == 1 || day == 2 || day == 3) {
        replace = [NSString stringWithFormat:@"%@0%d;%@;%@;%@",month, day, eventtime, eventtitle, eventlocation];
    }
    else{
        replace = [NSString stringWithFormat:@"%@%d;%@;%@;%@",month, day, eventtime, eventtitle, eventlocation];
    }
    
    NSMutableArray *all = [NSMutableArray arrayWithCapacity:1];
    NSScanner *scan = [NSScanner scannerWithString:content];
    
    while ([scan isAtEnd] == NO) {
        NSString *readin;
        NSCharacterSet* characters = [NSCharacterSet newlineCharacterSet];
        [scan scanUpToCharactersFromSet:characters intoString:&readin];
        
        if ([readin isEqualToString:replace]==NO) {
            [all addObject:[NSString stringWithFormat:@"%@\n",readin]];
        }
        else{
            NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];  //used to format the time
            [outputFormatter setDateFormat:@"HH:mm"]; //24hr time format
            NSString *timeString = [outputFormatter stringFromDate:timepicker.date];  //formats the selected time in the datepicker object
            
            if (day == 1 || day == 2 || day == 3) {
                [all addObject:[NSString stringWithFormat:@"%@0%d;%@;%@;%@\n",month, day, timeString, titletext.text, locationtext.text]];
            }
            else{
                [all addObject:[NSString stringWithFormat:@"%@%d;%@;%@;%@\n",month, day, timeString, titletext.text, locationtext.text]];
            }
        }
        
    }
    
    [all[0] writeToFile:[self getDataPath] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:[self getDataPath]];
    
    for (int i=1; i<[all count]; i++) {
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:[all[i] dataUsingEncoding:NSUTF8StringEncoding]];
    }

    
}


/* Method to get the full path to a text file that will be written out to */
-(NSString*)getDataPath
{
    NSString* filePath = @"data";
    NSString* fileRoot = [[NSBundle mainBundle] pathForResource:filePath ofType:@"txt"];
    return fileRoot;
}

@end
