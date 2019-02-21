//
//  ViewController.m
//  SEMS_ParseRSS
//
//  Created by Mohammad on 11/27/13.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "ViewController.h"
#import "MasterViewController.h"
#import "ConnectionClass.h"

@interface ViewController ()
{
    ConnectionClass *cc;
}

@end

@implementation ViewController

@synthesize readyToGo = _readyToGo;
@synthesize hostName;
@synthesize hostPort;
@synthesize testPass;
@synthesize keywordTextField;
@synthesize urlTextFeild;
//
//hostName=@"localhost";
//hostPort=@"4443";

//testPass= @"hello";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.urlTextFeild.delegate=self;
    cc = [[ConnectionClass alloc] init];
    cc.delegate = self;
    _readyToGo=NO;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//---------------------------------Enter URL and Process without connecting to Server----------------------------


- (IBAction)passURL:(id)sender
{
    UINavigationController *nav =[self.storyboard instantiateViewControllerWithIdentifier:@"Nav"];
//    MasterViewController *VC2 = [self.storyboard instantiateViewControllerWithIdentifier: @"MasterViewController"];
    MasterViewController *VC2= (MasterViewController *)nav.topViewController;
    VC2.urlFromTextFeild= self.urlTextFeild.text;
    [self presentViewController:nav animated:YES completion:nil];
}

//{
//UINavigationController *nav =[self.storyboard instantiateViewControllerWithIdentifier:@"TicketsListNav"];
//TicketListViewController *third = (TicketListViewController *)nav.topViewController;
//// other stuff here
//[self presentViewController:nav animated:YES completion:nil];
//}
//-------------------------------------------Apple RSS Feed Button---------------------------------------

- (IBAction)Default:(id)sender {
    
    UINavigationController *nav =[self.storyboard instantiateViewControllerWithIdentifier:@"Nav"];
    MasterViewController *VC2= (MasterViewController *)nav.topViewController;
    VC2.urlFromTextFeild= @"http://images.apple.com/main/rss/hotnews/hotnews.rss";
    [self presentViewController:nav animated:YES completion:nil];
    
//    MasterViewController *VC2 = [self.storyboard instantiateViewControllerWithIdentifier: @"MasterViewController"];
//    VC2.urlFromTextFeild= @"http://images.apple.com/main/rss/hotnews/hotnews.rss";
//    [self presentViewController:VC2 animated:YES completion:nil];

}
//-------------------------------------------Nasa RSS Feed Button---------------------------------------

- (IBAction)Nasa:(id)sender {
    
    UINavigationController *nav =[self.storyboard instantiateViewControllerWithIdentifier:@"Nav"];
    MasterViewController *VC2= (MasterViewController *)nav.topViewController;
    VC2.urlFromTextFeild= @"http://www.nasa.gov/rss/dyn/breaking_news.rss";
    [self presentViewController:nav animated:YES completion:nil];

}
//-------------------------------------------Cnet RSS Feed Button---------------------------------------

- (IBAction)Cnet:(id)sender {
    
    UINavigationController *nav =[self.storyboard instantiateViewControllerWithIdentifier:@"Nav"];
    MasterViewController *VC2= (MasterViewController *)nav.topViewController;
    VC2.urlFromTextFeild= @"http://news.cnet.com/8300-30252_3-246.xml";
    [self presentViewController:nav animated:YES completion:nil];
}
//-------------------------------------------France.fr RSS Feed Button---------------------------------------

- (IBAction)FranceFR:(id)sender {

    UINavigationController *nav =[self.storyboard instantiateViewControllerWithIdentifier:@"Nav"];
    MasterViewController *VC2= (MasterViewController *)nav.topViewController;
    VC2.urlFromTextFeild= @"http://www.france.fr/en/feeds/all/rss.xml";
    [self presentViewController:nav animated:YES completion:nil];
}

//-------------------------------------------Lausanne Météo RSS Feed Button---------------------------------------

- (IBAction)LausanneWeather:(id)sender {
    // This option has only one RSS item so we can't do anything on it
    UINavigationController *nav =[self.storyboard instantiateViewControllerWithIdentifier:@"Nav"];
    MasterViewController *VC2= (MasterViewController *)nav.topViewController;
    VC2.urlFromTextFeild= @"http://weather.yahooapis.com/forecastrss?w=783058&u=c";
    [self presentViewController:nav animated:YES completion:nil];
}

//-------------------------------------------NewYorkTimes RSS Feed Button---------------------------------------

- (IBAction)YahooNews:(id)sender {

    UINavigationController *nav =[self.storyboard instantiateViewControllerWithIdentifier:@"Nav"];
    MasterViewController *VC2= (MasterViewController *)nav.topViewController;
//    VC2.urlFromTextFeild= @"http://news.yahoo.com/rss/";
    VC2.urlFromTextFeild= @"http://www.nytimes.com/services/xml/rss/nyt/National.xml";
    [self presentViewController:nav animated:YES completion:nil];
}
//-------------------------------------------Second functional Button---------------------------------------
/* (Sender)
1) In this step of application user can enter the Keyword and URL.
2) App connects to server
3)Server finds the keyword in the description of each RSS
4)Server sends the new result to the app
5) App shows the new list
*/

- (IBAction)newList:(id)sender {
    
//    NSString* host = hostName;
//    int port = [hostPort intValue];
    [cc connectTo:@"localhost" onPort:4443];
//    [connectButton setEnabled:NO];
    NSString *messageExample;

    messageExample=[NSString stringWithFormat:@"%@,%@",keywordTextField.text,urlTextFeild.text];
    [cc sendMessage:messageExample];
    
//    [cc sendMessage:keywordTextField.text];
//
//    if(self.readyToGo) {
//
//        [cc sendMessage:keywordTextField.text];
//        
//
//    }
//    
    NSLog(@"Method %@ was invoked.", NSStringFromSelector(_cmd));

    
    
    UINavigationController *nav =[self.storyboard instantiateViewControllerWithIdentifier:@"Nav"];
    MasterViewController *VC2= (MasterViewController *)nav.topViewController;
    VC2.connectToServer=YES;
    VC2.urlFromTextFeild= @"http://news.yahoo.com/rss/";
//    VC2.returnedResults=_resultFromServer;
    [self presentViewController:nav animated:YES completion:nil];
}

//-----------------------------------End of the default buttons-------------------------------------

-(void)setReadyToGoField{
    NSLog(@"you should do something");
    self.readyToGo = YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return[textField resignFirstResponder];
}
@end
