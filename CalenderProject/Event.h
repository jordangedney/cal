//
//  Event.h
//  CalenderProject
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (strong,nonatomic) NSString *date;  //Events date
@property (strong,nonatomic) NSString *time;  //Events time
@property (strong,nonatomic) NSString *location;  //Events location
@property (strong,nonatomic) NSString *title;  //Events title

@end
