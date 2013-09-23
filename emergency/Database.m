//
//  Database.m
//  emergency
//
//  Created by Marco Velluto on 20/09/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import "Database.h"

@implementation Database

NSString *kName = @"name";
NSString *kTimeStamp = @"timeStamp";
NSString *kTableName = @"Notifications";



#pragma mark - Private Methods

- (NSString *) filePath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    
    return [documentsDir stringByAppendingPathComponent:@"database.sql"];
}

- (void) openDB {
    
    //-- Create Database --
    if (sqlite3_open([[self filePath] UTF8String], &(db)) != SQLITE_OK) {
        
        sqlite3_close(db);
        NSLog(@"ERROR: Database falied to open.");
    }
}

- (void)createTable{
    char *err;
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' "
                     "INTEGER PRIMARY KEY, '%@' TEXT, '%@' DATETIME DEFAULT CURRENT_TIMESTAMP);", kTableName, @"id", kName, kTimeStamp];
    
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        
        sqlite3_close(db);
        NSLog(@"ERROR: Table %@ falied create.", kTableName);
    }
}

#pragma mark - 
#pragma mark - Metodi pubblici
#pragma mark -

- (id) init {
    self = [super init];
    [self filePath];
    [self openDB];
    [self createTable];
    return self;
}

- (void)addNotification:(NSString *)title {
    NSString *sql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO '%@' ('%@')"
                     "VALUES ('%@')", kTableName,kName, title];
    
    
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        
        sqlite3_close(db);
        NSLog(@"ERROR: Not Posssible Insert New Recrodc with error: %s",err);
    }
}

- (NSMutableArray *)allElements{
    
    NSString * qsql = [NSString stringWithFormat:@"SELECT * FROM '%@'", kTableName];
    sqlite3_stmt *statment;
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statment, nil) == SQLITE_OK) {
        
        while (sqlite3_step(statment) == SQLITE_ROW) {
            
            int recordNumber = sqlite3_column_int(statment, 0);
            
            char *field1 = (char *) sqlite3_column_text(statment, 1);
            NSString *name = [[NSString alloc] initWithUTF8String:field1];
            
            char *field2 = (char *) sqlite3_column_text(statment, 2);
            NSString *data = [[NSString alloc] initWithUTF8String:field2];
            
            [tempArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                  name, @"name",
                                  data, @"data",
                                  [NSString stringWithFormat:@"%i", recordNumber], @"id",
                                  nil]];
        }//end while
        sqlite3_finalize(statment);
    }//end if
    else
        NSLog(@"***** Error do not possible get all pesi");
    
    return tempArray;
}


- (void)removeObjectFromNumerId:(int)numerRecord {
    NSString * query = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %d = %@", kTableName, numerRecord, @"id"];
    sqlite3_stmt *compiledStatement;
    char *err;
    if (sqlite3_exec(db, [query UTF8String], nil, &compiledStatement, &err) != SQLITE_OK) {
        
        sqlite3_close(db);
        NSLog(@"****** Error Delete Record. '%s'", err);
    }
}

/**
 Svuota la tabella passata da tutti gli elementi.
 
 @param tableName -> Tabella dal quale eliminare i record.
 @param db -> Database dove applicare l'operazione.
 
 @return db -> Database con l'operazione di eliminazione applicata.
 */
- (void)removeAll {
    
    NSString *query = [NSString stringWithFormat:@"DELETE FROM \"main\".\"%@\"", kTableName];
    sqlite3_stmt *compiledStatement;
    char *err;
    if (sqlite3_exec(db, [query UTF8String], nil, &compiledStatement, &err) != SQLITE_OK) {
        
        sqlite3_close(db);
        NSLog(@"******Error Empty Ithems from table %@, with error. '%s'", kTableName, err);
        sqlite3_close(db);
    }
    else {
        NSLog(@"Empty Table %@ successfull", kTableName);
    }
}


@end
