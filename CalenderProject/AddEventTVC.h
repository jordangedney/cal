//
//  AddEventTVC.h
//  CalenderProject
//
//  Created by Ben Frisbie on 1/29/14.
//  Copyright (c) 2014 Ben Frisbie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddEventTVC;
@protocol AddEventTVCDelegate
- (void)theSaveButtonOnTheAddEventTVCWasTapped:(AddEventTVC *)controller;
@end

@interface AddEventTVC : UITableViewController

@property (nonatomic, weak) id <AddEventTVCDelegate> delegate;

@property (strong,nonatomic) NSString *month;
@property (nonatomic) int day;

@property (strong, nonatomic) IBOutlet UITextField *titletext;
@property (strong, nonatomic) IBOutlet UITextField *locationtext;
@property (strong, nonatomic) IBOutlet UIDatePicker *timepicker;


-(IBAction)KeyboardDismiss:(id)sender;
- (IBAction)SaveEvent:(id)sender;

@end
