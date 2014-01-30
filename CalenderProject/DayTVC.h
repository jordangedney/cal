//
//  DayTVC.h
//  CalenderProject
//
//  Created by Ben Frisbie on 1/29/14.
//  Copyright (c) 2014 Ben Frisbie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddEventTVC.h"

@interface DayTVC : UITableViewController<AddEventTVCDelegate>

@property (strong,nonatomic) NSString *month;
@property (nonatomic) int day;

@end
