//
//  ConnectionClass.h
//  SEMS_ParseRSS
//
//  Created by Mohammad on 12/12/13.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectionClassDelegate.h"
@class ViewController;

@interface ConnectionClass : NSObject<NSStreamDelegate>

{
    NSInputStream *inStream;
    NSOutputStream *outStream;
    NSMutableData *outData;
    int outIndex;
    BOOL outReady;
    BOOL outConnected;
    BOOL inConnected;
}
@property (nonatomic, strong) id<ConnectionClassDelegate > delegate;
-(void) connectTo: (NSString*) host onPort: (int) port;
-(void) sendMessage: (NSString*) message;





@end    
