//
//  DayViewController.h
//  CalenderProject
//
//  Created by Ben Frisbie on 1/16/14.
//  Copyright (c) 2014 Ben Frisbie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayViewController : UIViewController

@property (strong,nonatomic) NSString *month;
@property (nonatomic) int day;
@property (strong, nonatomic) IBOutlet UILabel *monthlabel;
@property (strong, nonatomic) IBOutlet UILabel *daylabel;

@end
