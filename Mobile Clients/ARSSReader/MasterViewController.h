//
//  MasterViewController.h
//  SEMS_ParseRSS
//
//  Created by Mohammad on 11/27/13.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController 
@property(strong, nonatomic) NSString *urlFromTextFeild;

- (IBAction)backURL:(id)sender;

//@property(strong,nonatomic)NSMutableArray *returnedResults;
@property(nonatomic,assign)BOOL *connectToServer;

@end
