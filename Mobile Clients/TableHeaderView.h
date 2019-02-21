//
//  TableHeaderView.h
//  SEMS_ParseRSS
//
//  Created by Mohammad on 11/27/13.
//

#import <UIKit/UIKit.h>

@interface TableHeaderView : UIImageView
- (id)initWithText:(NSString*)text; 
- (void)setUrlHeaderName:(NSString*)text; // Write the URL name on the header
@end