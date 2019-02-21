//
//  UnitRSS.m
//  SEMS_ParseRSS
//
//  Created by Mohammad on 11/27/13.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "UnitRSS.h"
#import "GTMNSString+HTML.h"

@implementation UnitRSS

-(NSAttributedString*)cellMessage
{
    if (_cellMessage!=nil) return _cellMessage;
    
    NSDictionary* boldStyle = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:16.0]};
    NSDictionary* normalStyle = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:16.0]};
    
    NSMutableAttributedString* articleAbstract = [[NSMutableAttributedString alloc] initWithString:self.title];
    
    [articleAbstract setAttributes:boldStyle
                             range:NSMakeRange(0, self.title.length)];
    
    [articleAbstract appendAttributedString:
     [[NSAttributedString alloc] initWithString:@"\n\n"]
     ];
    
    int startIndex = [articleAbstract length];
    
    NSString* description = [NSString stringWithFormat:@"%@...", [self.description substringToIndex:100]];
    description = [description gtm_stringByUnescapingFromHTML];
    
    [articleAbstract appendAttributedString:
     [[NSAttributedString alloc] initWithString: description]
     ];
    
    [articleAbstract setAttributes:normalStyle
                             range:NSMakeRange(startIndex, articleAbstract.length - startIndex)];
    
    _cellMessage = articleAbstract;
    return _cellMessage;
    
}

@end
