//
//  RSSItem.h
//  ARSSReader
//
//  Created by Mohammad on 11/27/13.
//

#import <Foundation/Foundation.h>

@interface RSSItem : NSObject

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSURL* link;
@property (strong, nonatomic) NSString* description;
@property (strong, nonatomic) NSAttributedString* cellMessage;

@end