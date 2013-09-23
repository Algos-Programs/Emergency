//
//  NotificationsViewController.m
//  emergency
//
//  Created by Marco Velluto on 17/09/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import "NotificationsViewController.h"
#import "Database.h"
#import "DetailNotificheViewController.h"

@interface NotificationsViewController ()

@end

@implementation NotificationsViewController

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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    values = [[NSArray alloc] init];
    
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    Database *db = [[Database alloc] init];
    values = [db allElements];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return values.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.textLabel.text = [[values objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.detailTextLabel.text = [[values objectAtIndex:indexPath.row] objectForKey:@"data"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"pushSingleNotification" sender:[NSString stringWithFormat:@"%i", indexPath.row]];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailNotificheViewController *dnvc = segue.destinationViewController;
    NSString *senderStr = (NSString *)sender;
    int row = [senderStr intValue];
    dnvc.textNotitication = (NSDictionary *)[values objectAtIndex:row];
}
@end
