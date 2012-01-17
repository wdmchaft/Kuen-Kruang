//
//  Flight.m
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 1/17/12.
//  Copyright (c) 2012 Chulalongkorn University. All rights reserved.
//

#import "Flight.h"
#import "AppDelegate.h"

static sqlite3_stmt *init_statement = nil;

static sqlite3 *database = nil;

@implementation Flight
@synthesize primaryKey,no,datetime,dest,PPno,PPtype,visa;

+ (void) getInitialDataToDisplay:(NSString *)dbPath {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        const char *sql = "select * from Flight";
        sqlite3_stmt *selectstmt;
        if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
            
            while(sqlite3_step(selectstmt) == SQLITE_ROW) {
                
                NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
                Flight *f1 = [[Flight alloc] initWithPrimaryKey:primaryKey];
                f1.no = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
                NSString *dt_str=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                // this is imporant - we set our input date format to match our input string
                // if format doesn't match you'll get nil from your string, so be careful
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                NSDate *dateFromString = [NSDate alloc];
                // voila!
                dateFromString = [dateFormatter dateFromString:dt_str];
                [dateFormatter release];
                f1.datetime = dateFromString;
                f1.dest = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 3)];
                f1.PPno = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 4)];
                f1.PPtype = sqlite3_column_int(selectstmt, 5);
                f1.visa = sqlite3_column_int(selectstmt, 6);
                [appDelegate.f addObject:f1];
                [f1 release];
                dateFromString=nil;
                [dateFromString release];
            }
        }
    }
    else
        sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
}
- (id) initWithPrimaryKey:(NSInteger) pk {
    [super init];
    primaryKey = pk;
    
    return self;
}
+ (void) finalizeStatements {
    if(database) sqlite3_close(database);
    if(init_statement) sqlite3_finalize(init_statement);
}
- (void) deleteF {
    if(init_statement == nil) {
        const char *sql = "delete from Flight where ID = ?";
        if(sqlite3_prepare_v2(database, sql, -1, &init_statement, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
    }
    
    //When binding parameters, index starts from 1 and not zero.
    sqlite3_bind_int(init_statement, 1, primaryKey);
    
    if (SQLITE_DONE != sqlite3_step(init_statement))
        NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
    
    sqlite3_reset(init_statement);
}

- (void) addPP {
    if(init_statement == nil) {
        const char *sql = "insert into Flight(No, DateTime, Destination, PPNo, PPType, Visa) Values(?, ?, ?, ?, ?, ?)";
        if(sqlite3_prepare_v2(database, sql, -1, &init_statement, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
    }
    
    sqlite3_bind_text(init_statement, 1, [no UTF8String], -1, SQLITE_TRANSIENT);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:datetime];
    [dateFormatter release];
    sqlite3_bind_text(init_statement, 2, [strDate UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(init_statement, 3, [dest UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(init_statement, 4, [PPno UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(init_statement, 5, PPtype);
    sqlite3_bind_int(init_statement, 6, visa);
    if(SQLITE_DONE != sqlite3_step(init_statement))
        NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
    else
        //SQLite provides a method to get the last primary key inserted by using sqlite3_last_insert_rowid
        primaryKey = sqlite3_last_insert_rowid(database);
    
    //Reset the add statement.
    sqlite3_reset(init_statement);
}


@end
