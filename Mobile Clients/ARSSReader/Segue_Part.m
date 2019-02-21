//
//  Segue_Part.m
//  SEMS_ParseRSS
//
//  Created by Mohammad on 12/5/13.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "Segue_Part.h"

@implementation Segue_Part

- (void) perform {
    
   
        [[self sourceViewController] presentModalViewController:[self destinationViewController] animated:NO];
    
}

@end

