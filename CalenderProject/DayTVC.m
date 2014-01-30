//
//  DayTVC.m
//  CalenderProject
//
//  Created by Ben Frisbie on 1/29/14.
//  Copyright (c) 2014 Ben Frisbie. All rights reserved.
//

#import "DayTVC.h"
#import "AddEventTVC.h"
#import "Event.h"

@interface DayTVC ()

@end

@implementation DayTVC

@synthesize month, day;

NSMutableArray *todaysEvents;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@ %d",month,day];
    [self update];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)update
{
    NSString *content = [NSString stringWithContentsOfFile:[self getDataPath] encoding:NSUTF8StringEncoding error:nil];
    todaysEvents = [self extractEvents:content];
}


-(NSString*)getDataPath
{
    NSString* filePath = @"data";
    NSString* fileRoot = [[NSBundle mainBundle] pathForResource:filePath ofType:@"txt"];
    return fileRoot;
}



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
        if ([scan scanString:[NSString stringWithFormat:@"%@%d",month,day] intoString:Nil]) {
            [today addObject:[all objectAtIndex:i]];
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



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"addEvent"]){
        
        AddEventTVC *controller = (AddEventTVC *)segue.destinationViewController;
        controller.month = month;
        controller.day = day;
        AddEventTVC *addEventTVC = segue.destinationViewController;
        addEventTVC.delegate = self;
    }
}


- (void)theSaveButtonOnTheAddEventTVCWasTapped:(AddEventTVC *)controller
{
    // close the delegated view
    [controller.navigationController popViewControllerAnimated:YES];
    [self update];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"Events"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Time: %@     Title: %@     Location: %@",((Event*)todaysEvents[indexPath.row]).time,
                        ((Event*)todaysEvents[indexPath.row]).title, ((Event*)todaysEvents[indexPath.row]).location];
    
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
