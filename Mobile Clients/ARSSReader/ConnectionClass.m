//
//  ConnectionClass.m
//  SEMS_ParseRSS
//
//  Created by Mohammad on 12/12/13.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "ConnectionClass.h"
#import "ViewController.h"
#define BUFSIZE 1024


@implementation ConnectionClass
@synthesize delegate;

- (id) init {
    self = [super init];
    if(self) {
        outData = [NSMutableData dataWithCapacity: BUFSIZE];
        outIndex = 0;
        outReady = NO;
        outConnected = NO;
        inConnected = NO;
    }
    return self;
}
-(void) dealloc {
    [inStream close];
    [outStream close];
}


-(void) connectTo:(NSString*) host onPort: (int) port
{
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (__bridge  CFStringRef)host, port, &readStream, &writeStream);
    inStream = (__bridge_transfer NSInputStream*)readStream;
    outStream = (__bridge_transfer NSOutputStream*)writeStream;
    [inStream setDelegate:self];
    [outStream setDelegate:self];
    [inStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inStream open];
    [outStream open];
 }

-(void) writeData
{
    uint8_t *outBytes = (uint8_t *)[outData mutableBytes];
    int data_len = [outData length];
    unsigned int len = BUFSIZ;
    if((data_len-outIndex) < BUFSIZ) {
        len = data_len - outIndex;
    }
    outBytes += outIndex;
    uint8_t buf[len];
    memcpy(buf, outBytes, len);
    if(len > 0) {
        len = [outStream write:buf maxLength:len];
        outIndex += len;
    }
}
-(void) sendMessage: (NSString*) message
{
    NSString *msgLine = [NSString stringWithFormat:@"%@\n", message];
    [outData setData:[msgLine dataUsingEncoding:NSASCIIStringEncoding]];
    outIndex = 0;
    if(outReady) {
        [self writeData];
    }
}
- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode {
    NSLog(@"stream:handleEvent: is invoked...");
    
    switch(eventCode) {
            
        case NSStreamEventOpenCompleted: {
            NSString *kind;
            if([stream isKindOfClass:[NSOutputStream class]]) {
                kind = @"OUT";
                outConnected = YES;
            } else if([stream isKindOfClass:[NSInputStream class]]) {
                kind = @"IN";
                inConnected = YES;
            }
            
            NSLog(@"--> connection %@ successfuly opened.", kind);
            if(outConnected && inConnected) {
                [delegate setReadyToGoField];
            }
            break;
        }
            
        case NSStreamEventHasSpaceAvailable: {
            NSLog(@"--> space is available");
            if(stream == outStream) {
                if([outData length] == 0) {
                    outReady = YES;
                    break;
                }
                [self writeData];
            }
            break;
        }
            
        case NSStreamEventHasBytesAvailable: {
            NSLog(@"some bytes are available");
            if(stream == inStream) {
                int size = BUFSIZ;
                uint8_t fromServer[size];
                size = [inStream read:fromServer maxLength:size];
                if(!size) {
                    if([stream streamStatus] != NSStreamStatusAtEnd) {
                        NSLog(@"Failed reading data from iRemoteServer");
                    }
                } else {
//                    NSData *stringData = [NSData dataWithBytes:fromServer length:size];
//                    NSString * mot = [[NSString alloc] initWithData:stringData encoding:NSASCIIStringEncoding];
//                    [delegate putTheFrenchWord:mot];
                }
            }
            break;
        }
            
        case NSStreamEventErrorOccurred: {
            NSError *theError = [stream streamError];
            
            NSLog(@"--> An error is occured : %@", [theError description]);
            [stream close];
            break;
        }
            
        case NSStreamEventEndEncountered: {
        }
            
        case NSStreamEventNone: {
        }
            
    }
}




@end
