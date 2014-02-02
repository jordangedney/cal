//
//  DetailEventTVC.h
//  CalenderProject
//

#import <UIKit/UIKit.h>

@class DetailEventTVC;

@protocol DetailEventTVCDelegate
- (void)theSaveButtonOnTheDetailEventTVCWasTapped:(DetailEventTVC *)controller;

@end

@interface DetailEventTVC : UITableViewController

@property (nonatomic, weak) id <DetailEventTVCDelegate> delegate;  //provides a way back to the last view

@property (strong,nonatomic) NSString *month;  //views current month
@property (nonatomic) int day; //views current day

@property (strong,nonatomic) NSString *eventtitle;  //views current title
@property (strong,nonatomic) NSString *eventlocation;  //views current title
@property (strong,nonatomic) NSString *eventtime;  //views current title

@property (strong, nonatomic) IBOutlet UITextField *titletext;  //connection to title textbox
@property (strong, nonatomic) IBOutlet UITextField *locationtext;  //connection to location textbox
@property (strong, nonatomic) IBOutlet UIDatePicker *timepicker;  //connection to time textbox


-(IBAction)KeyboardDismiss:(id)sender;  //action linked to the "Done" button on the keyboard
- (IBAction)SaveEvent:(id)sender;  //action linked to the Save buttton in the navigation bar

@end