//
//  DayTVC.h
//  CalenderProject
//

#import <UIKit/UIKit.h>
#import "AddEventTVC.h"

@interface DayTVC : UITableViewController<AddEventTVCDelegate>

@property (strong,nonatomic) NSString *month; //The views month to display
@property (nonatomic) int day;  //The views numerical day to display

@end
