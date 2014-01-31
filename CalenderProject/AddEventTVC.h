//
//  AddEventTVC.h
//  CalenderProject
//

#import <UIKit/UIKit.h>

@class AddEventTVC;

@protocol AddEventTVCDelegate
- (void)theSaveButtonOnTheAddEventTVCWasTapped:(AddEventTVC *)controller;

@end

@interface AddEventTVC : UITableViewController

@property (nonatomic, weak) id <AddEventTVCDelegate> delegate;  //provides a way back to the last view

@property (strong,nonatomic) NSString *month;  //views current month
@property (nonatomic) int day; //views curretn day

@property (strong, nonatomic) IBOutlet UITextField *titletext;  //connection to title textbox
@property (strong, nonatomic) IBOutlet UITextField *locationtext;  //connection to location textbox
@property (strong, nonatomic) IBOutlet UIDatePicker *timepicker;  //connection to time textbox


-(IBAction)KeyboardDismiss:(id)sender;  //action linked to the "Done" button on the keyboard
- (IBAction)SaveEvent:(id)sender;  //action linked to the Save buttton in the navigation bar

@end
