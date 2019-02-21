//
//  TableHeaderView.m
//  SEMS_ParseRSS
//
//  Created by Mohammad on 11/27/13.
//

#import "TableHeaderView.h"

@interface TableHeaderView()
{
	UILabel* label;
}
@end

@implementation TableHeaderView

- (id)initWithText:(NSString*)text
{
	UIImage* header = [UIImage imageNamed:@"SEMS_header.png"];
    if ((self = [super initWithImage:header])) {
		label = [[UILabel alloc] initWithFrame:CGRectMake(10,40,200,70)];
		[self addSubview:label];
    }
    return self;
}

- (void)setUrlHeaderName:(NSString*)text
{
	label.text = text;
}

@end