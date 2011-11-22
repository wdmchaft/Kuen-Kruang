//
//  Passport.m
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 10/19/11.
//  Copyright (c) 2011 Chulalongkorn University. All rights reserved.
//

#import "Passport.h"
#import "AppDelegate.h"

static sqlite3_stmt *init_statement = nil;
static sqlite3 *database = nil;

@implementation Passport
@synthesize no,type,expire,primaryKey;

+ (void) getInitialDataToDisplay:(NSString *)dbPath {
     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        const char *sql = "select * from Passport";
        sqlite3_stmt *selectstmt;
        if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
            
            while(sqlite3_step(selectstmt) == SQLITE_ROW) {
                
                NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
                Passport *pp1 = [[Passport alloc] initWithPrimaryKey:primaryKey];
                pp1.no = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
                pp1.type = sqlite3_column_int(init_statement, 2);
                NSString *expire_str=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 3)];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                // this is imporant - we set our input date format to match our input string
                // if format doesn't match you'll get nil from your string, so be careful
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *dateFromString = [[NSDate alloc] init];
                // voila!
                dateFromString = [dateFormatter dateFromString:expire_str];
                [dateFormatter release];
                pp1.expire = dateFromString;
                
                [appDelegate.pp addObject:pp1];
                [pp1 release];
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
- (void) deletePP {
    if(init_statement == nil) {
        const char *sql = "delete from Passport where id = ?";
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
        const char *sql = "insert into Passport(no, type, expire) Values(?, ?, ?)";
        if(sqlite3_prepare_v2(database, sql, -1, &init_statement, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
    }
    
    sqlite3_bind_text(init_statement, 1, [no UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(init_statement, 2, [type intValue]);
    sqlite3_bind_text(init_statement, 3, [expire UTF8String], -1, SQLITE_TRANSIENT);
 
    if(SQLITE_DONE != sqlite3_step(init_statement))
        NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
    else
        //SQLite provides a method to get the last primary key inserted by using sqlite3_last_insert_rowid
        primaryKey = sqlite3_last_insert_rowid(database);
    
    //Reset the add statement.
    sqlite3_reset(init_statement);
}
@end
