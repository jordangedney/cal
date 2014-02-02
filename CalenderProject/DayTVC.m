//
//  DayTVC.m
//  CalenderProject
//
//  Created by Ben Frisbie on 1/29/14.
//  Copyright (c) 2014 Ben Frisbie. All rights reserved.
//

#import "DayTVC.h"
#import "AddEventTVC.h"
#import "DetailEventTVC.h"
#import "Event.h"

@interface DayTVC ()

@end

@implementation DayTVC

@synthesize month, day;

NSMutableArray *todaysEvents; //Array of today's Events

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@ %d",month,day];
    [self update];
    
}

/* Method to update the current days events from a text file */
-(void)update
{
    NSString *content = [NSString stringWithContentsOfFile:[self getDataPath] encoding:NSUTF8StringEncoding error:nil];  //Put all data from text file into string
    todaysEvents = [self extractEvents:content];
}


/* Method to get the full path to the text file that is read and written to */
-(NSString*)getDataPath
{
    NSString* filePath = @"data";
    NSString* fileRoot = [[NSBundle mainBundle] pathForResource:filePath ofType:@"txt"];
    return fileRoot;
}


/* Method to get todays events out of the string with all the years events */
-(NSMutableArray*)extractEvents:(NSString*)content
{
    NSMutableArray *all = [NSMutableArray arrayWithCapacity:1];
    NSScanner *scan = [NSScanner scannerWithString:content];
    
    while ([scan isAtEnd] == NO) {
        NSString *readin;
        NSCharacterSet* characters = [NSCharacterSet newlineCharacterSet];
        [scan scanUpToCharactersFromSet:characters intoString:&readin];
        [all addObject:readin];
    }
    
    NSMutableArray *today = [NSMutableArray arrayWithCapacity:1];
    
    for (int i=0; i<[all count]; i++) {
        scan = [NSScanner scannerWithString:[all objectAtIndex:i]];
        if (day == 1 || day == 2 || day == 3) {
            if ([scan scanString:[NSString stringWithFormat:@"%@0%d",month,day] intoString:Nil]) {
                [today addObject:[all objectAtIndex:i]];
            }
        }
        else{
            if ([scan scanString:[NSString stringWithFormat:@"%@%d",month,day] intoString:Nil]) {
                [today addObject:[all objectAtIndex:i]];
            }
        }
        
    }
    
    NSMutableArray *events = [NSMutableArray arrayWithCapacity:1];
    
    int j;
    Event *e;
    for (int i=0; i<[today count]; i++) {
        e = [[Event alloc]init];
        scan = [NSScanner scannerWithString:[today objectAtIndex:i]];

        j=0;
        while ([scan isAtEnd] == NO) {
            NSString *readin;
            NSCharacterSet* characters = [NSCharacterSet characterSetWithCharactersInString:@";"];
            [scan scanUpToCharactersFromSet:characters intoString:&readin];
            
            if ([scan isAtEnd] == NO) {
                [scan setScanLocation:[scan scanLocation]+1];
            }

            if (j==0) {
                e.date = readin;
            }
            if (j==1) {
                e.time = readin;
            }
            if (j==2) {
                e.title = readin;
            }
            if (j==3) {
                e.location = readin;
            }
            j++;
        }
        [events addObject:e];
    }
    
    return events;
}


/* Method called before going onto the next view */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"addEvent"]){
        
        AddEventTVC *acontroller = (AddEventTVC *)segue.destinationViewController; //get the next view controller
        acontroller.month = month; //set the next months view
        acontroller.day = day; //set the next view day
        acontroller.delegate = self; //allow the next view to get back to here
    }
    
    if([segue.identifier isEqualToString:@"detailEvent"]){
        
        DetailEventTVC *dcontroller = (DetailEventTVC *)segue.destinationViewController; //get the next view controller
        dcontroller.month = month; //set the next months view
        dcontroller.day = day; //set the next view day
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        dcontroller.eventtitle = ((Event*)todaysEvents[indexPath.row]).title;
        dcontroller.eventtime = ((Event*)todaysEvents[indexPath.row]).time;
        dcontroller.eventlocation = ((Event*)todaysEvents[indexPath.row]).location;
        
        dcontroller.delegate = self; //allow the next view to get back to here
    }

}


- (void)theSaveButtonOnTheAddEventTVCWasTapped:(AddEventTVC *)controller
{
    [controller.navigationController popViewControllerAnimated:YES]; // close the delegated view or the view that came back to this view
    [self update];
    [self.tableView reloadData];  //reload the view table
}

- (void)theSaveButtonOnTheDetailEventTVCWasTapped:(AddEventTVC *)controller
{
    [controller.navigationController popViewControllerAnimated:YES]; // close the delegated view or the view that came back to this view
    [self update];
    [self.tableView reloadData];  //reload the view table
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [todaysEvents count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Events";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Events"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Time: %@     Title: %@     Location: %@",((Event*)todaysEvents[indexPath.row]).time, ((Event*)todaysEvents[indexPath.row]).title, ((Event*)todaysEvents[indexPath.row]).location]; //set the table cell to the given events data
    
    return cell;
}



/* Method to allow deleting from the table */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tableView beginUpdates]; // Avoid  NSInternalInconsistencyException
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];  // Delete the row from the table
        NSString *content = [NSString stringWithContentsOfFile:[self getDataPath] encoding:NSUTF8StringEncoding error:nil];  //get the text files contents
        [self removeEvent:content :indexPath.row]; //remove event from the text file
        [self update];
        
        content = [NSString stringWithContentsOfFile:[self getDataPath] encoding:NSUTF8StringEncoding error:nil];
        [self.tableView reloadData];
        [self.tableView endUpdates];
    }   
}



/* Method to delete an event from the text file */
-(void)removeEvent:(NSString*)content :(NSInteger)eventnum
{
    NSString *remove = [NSString stringWithFormat:@"%@;%@;%@;%@",((Event*)todaysEvents[eventnum]).date, ((Event*)todaysEvents[eventnum]).time, ((Event*)todaysEvents[eventnum]).title, ((Event*)todaysEvents[eventnum]).location]; //get the string of the event that needs to be removed
    
    NSMutableArray *all = [NSMutableArray arrayWithCapacity:1];
    NSScanner *scan = [NSScanner scannerWithString:content];
    
    while ([scan isAtEnd] == NO) {
        NSString *readin;
        NSCharacterSet* characters = [NSCharacterSet newlineCharacterSet];
        [scan scanUpToCharactersFromSet:characters intoString:&readin];
        
        if ([readin isEqualToString:remove]==NO) {
            [all addObject:[NSString stringWithFormat:@"%@\n",readin]];
        }
        
    }
    
    if ([all count] == 0) {
        [[NSString stringWithFormat:@""] writeToFile:[self getDataPath] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    else if ([all count]>=1) {
        [all[0] writeToFile:[self getDataPath] atomically:YES encoding:NSUTF8StringEncoding error:nil];
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:[self getDataPath]];
    
        for (int i=1; i<[all count]; i++) {
            [fileHandle seekToEndOfFile];
            [fileHandle writeData:[all[i] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    
    }

}

@end
