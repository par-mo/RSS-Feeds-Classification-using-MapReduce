//
//  MasterViewController.m
//  SEMS_ParseRSS
//
//  Created by Mohammad on 11/27/13.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ViewController.h"
#import "TableHeaderView.h"

#import "ImportRSS.h"
#import "UnitRSS.h"

@interface MasterViewController ()
{
    NSArray *_objects;
    NSURL* feedURL;
    NSString *urlFinal;
    UIRefreshControl* refreshControl;


}
@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //configuration
//    self.title = _urlFromTextFeild;
    self.title= @"Connecting to the site";
    urlFinal=_urlFromTextFeild;
    feedURL = [NSURL URLWithString:_urlFromTextFeild];
    
    //add refresh control to the table view
    refreshControl = [[UIRefreshControl alloc] init];
    
    [refreshControl addTarget:self
                       action:@selector(refreshInvoked:forState:)
             forControlEvents:UIControlEventValueChanged];
    
    NSString* fetchMessage = [NSString stringWithFormat:@"Loading: %@",urlFinal];
    
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:fetchMessage
                                                                     attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:11.0]}];
    
    [self.tableView addSubview: refreshControl];
    self.tableView.tableHeaderView = [[TableHeaderView alloc] initWithText: _urlFromTextFeild];
    [self refreshFeed];
}

-(void) refreshInvoked:(id)sender forState:(UIControlState)state
{
    [self refreshFeed];
}

-(void)refreshFeed
{
    ImportRSS* rss = [[ImportRSS alloc] init];
    [rss fetchRssWithURL:feedURL
                complete:^(NSString *title, NSArray *results) {
                    

                    //completed fetching the RSS
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //UI code on the main queue
                        [(TableHeaderView*)self.tableView.tableHeaderView setUrlHeaderName:title];

                        
                        NSMutableArray *returnedResults = [NSMutableArray array];

                        
                        
//                        NSLog(@"%@",[results[1] title]);

                        _objects = results;
                        
//                        NSLog(@"%@",[returnedResults[0] description]);

//---------------------------------How the second button work?-----------------------------------
                        if (_connectToServer)
                        {
                            // if the user click on the Advace Search
                            _objects = returnedResults;
                            [returnedResults addObject:results[0]];
                            [returnedResults addObject:results[1]];
                        }
                        [self.tableView reloadData];
                        // Stop refresh control
                        [refreshControl endRefreshing];
                    });
                }];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    UnitRSS *object = _objects[indexPath.row];
    cell.textLabel.attributedText = object.cellMessage;
    cell.textLabel.numberOfLines = 0;
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UnitRSS *item = [_objects objectAtIndex:indexPath.row];
    CGRect cellMessageRect = [item.cellMessage boundingRectWithSize:CGSizeMake(200,10000)
                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                            context:nil];
    return cellMessageRect.size.height;
    [self performSegueWithIdentifier:@"showDetail" sender:self];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        UnitRSS *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }

}





- (IBAction)backURL:(id)sender
{
    ViewController *ViewC = [self.storyboard instantiateViewControllerWithIdentifier: @"ViewController"];
    ViewC.BackURLTextField= self.urlFromTextFeild;
    [self presentViewController:ViewC animated:YES completion:nil];
    

}
@end
