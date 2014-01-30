//
//  Event.h
//  CalenderProject
//
//  Created by Ben Frisbie on 1/29/14.
//  Copyright (c) 2014 Ben Frisbie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (strong,nonatomic) NSString *date;
@property (strong,nonatomic) NSString *time;
@property (strong,nonatomic) NSString *location;
@property (strong,nonatomic) NSString *title;

@end
