//
//  FlipTopPopToRoot.m
//  ARSSReader
//
//  Created by Mohammad on 12/5/13.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "FlipTopPopToRoot.h"

@implementation FlipTopPopToRoot

- (void) perform {
    
   
        [[self sourceViewController] presentModalViewController:[self destinationViewController] animated:NO];
    
}

@end

