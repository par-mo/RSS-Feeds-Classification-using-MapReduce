//
//  ImportRSS.m
//  SEMS_ParseRSS
//
//  Created by Mohammad on 11/27/13.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "ImportRSS.h"

#import "RXMLElement.h"
#import "UnitRSS.h"

@implementation ImportRSS

-(void)fetchRssWithURL:(NSURL*)url complete:(RSSLoaderCompleteBlock)callbackFunction
{
    
    NSURLConnection *conn = [[NSURLConnection alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    (void)[conn initWithRequest:request delegate:self];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
         if ([data length] == 0 && error == nil) {
             // handle empty response
         } else if (error != nil) {
             // handle error
             NSLog(@"Error %@", [error localizedDescription]);
         } else if ([httpResponse statusCode] == 200) {
             RXMLElement *rss = [RXMLElement elementFromXMLData:data];
             RXMLElement *rssChild = [rss child:@"channel"];
             RXMLElement* title = [rssChild child:@"title"];
             NSArray* items = [[rss child:@"channel"] children:@"item"];
             
             NSMutableArray* result = [NSMutableArray arrayWithCapacity:items.count];
             
             //more code
             for (RXMLElement *e in items) {
                 
                 //iterate over the articles
                 UnitRSS* item = [[UnitRSS alloc] init];
                 item.title = [[e child:@"title"] text];
                 item.description = [[e child:@"description"] text];
                 item.urlRSS = [NSURL URLWithString: [[e child:@"link"] text]];
                 if (item.urlRSS != NULL) {
                     [result addObject: item];
                 }
             }
             
             callbackFunction([title text], result);
         }
     }];
    
}

@end
