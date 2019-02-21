//
//  DetailViewController.h
//  SEMS_ParseRSS
//
//  Created by Mohammad on 11/27/13.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
