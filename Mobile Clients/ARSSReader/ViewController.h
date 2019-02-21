//
//  ViewController.h
//  SEMS_ParseRSS
//
//  Created by Mohammad on 11/27/13.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionClassDelegate.h" 
@class ConnectionClass;

@interface ViewController : UIViewController<UITextFieldDelegate,ConnectionClassDelegate>

@property (weak, nonatomic) IBOutlet UITextField *urlTextFeild;
@property(strong, nonatomic) NSString *BackURLTextField;
@property (strong,nonatomic) NSMutableArray* resultFromServer;
@property (weak, nonatomic) IBOutlet UITextField *keywordTextField;
@property (weak,nonatomic) NSString *hostName;
@property(weak,nonatomic) NSString *hostPort;
@property(weak,nonatomic) NSString *testPass;

@property BOOL readyToGo;


- (IBAction)passURL:(id)sender;
- (IBAction)Default:(id)sender;
- (IBAction)Nasa:(id)sender;
- (IBAction)Cnet:(id)sender;
- (IBAction)FranceFR:(id)sender;

- (IBAction)LausanneWeather:(id)sender;
- (IBAction)YahooNews:(id)sender;
- (IBAction)newList:(id)sender;






@end
