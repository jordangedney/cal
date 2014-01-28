//
//  AddEventViewController.h
//  CalenderProject
//
//  Created by Ben Frisbie on 1/23/14.
//  Copyright (c) 2014 Ben Frisbie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddEventViewController : UIViewController

@property (strong,nonatomic) NSString *month;
@property (nonatomic) int day;

@property (strong, nonatomic) IBOutlet UITextField *titletext;
@property (strong, nonatomic) IBOutlet UITextField *locationtext;
@property (strong, nonatomic) IBOutlet UILabel *datelabel;

@property (strong, nonatomic) IBOutlet UIDatePicker *timepicker;


-(IBAction)KeyboardDismiss:(id)sender;
-(IBAction)TapBackground:(id)sender;
- (IBAction)SaveEvent:(id)sender;

@end
