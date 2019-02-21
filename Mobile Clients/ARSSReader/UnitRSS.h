//
//  UnitRSS.h
//  SEMS_ParseRSS
//
//  Created by Mohammad on 11/27/13.
//

#import <Foundation/Foundation.h>

@interface UnitRSS : NSObject

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSURL* urlRSS;
@property (strong, nonatomic) NSString* description;
@property (strong, nonatomic) NSAttributedString* cellMessage;

@end