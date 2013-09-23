//
//  Database.h
//  emergency
//
//  Created by Marco Velluto on 20/09/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Database : NSObject {
    sqlite3 *db;
}

- (void)initDB;
- (void)addNotification:(NSString *)title;
- (NSMutableArray *)allElements;
- (void)removeObjectFromNumerId:(int)numerRecord;
@end
