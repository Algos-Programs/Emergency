//
//  NotificationsViewController.h
//  emergency
//
//  Created by Marco Velluto on 17/09/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"

@interface NotificationsViewController : UITableViewController <UIAlertViewDelegate> {
    NSMutableArray *values;
    Database *db;
}
- (IBAction)pressButtonTrash:(id)sender;
@end
