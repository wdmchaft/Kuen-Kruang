//
//  Passport.m
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 10/19/11.
//  Copyright (c) 2011 Chulalongkorn University. All rights reserved.
//

#import "Passport.h"

static sqlite3_stmt *init_statement = nil;

@implementation Passport
@synthesize no,type,expire,primaryKey;

-(id)initWithPK:(NSInteger)pk db:(sqlite3 *)db{
    if(self =[super init]){
        primaryKey=pk;
        dbase=db;
        if(init_statement==nil){
            const char *sql="SELECT * FROM Passport WHERE id=?";
            if(sqlite3_prepare(dbase, sql, -1, &init_statement, NULL)!= SQLITE_OK){
                NSAssert1(0, @"Error : '%s'.", sqlite3_errmsg(dbase));
            }
        }
        sqlite3_bind_int(init_statement,1,primaryKey);
        if(sqlite3_step(init_statement)==SQLITE_ROW){
            //no
            self.no = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 1)];
            //type
            self.type = sqlite3_column_int(init_statement, 2);
            //expire
            NSString *expire_str=[NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 3)];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            // this is imporant - we set our input date format to match our input string
            // if format doesn't match you'll get nil from your string, so be careful
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *dateFromString = [[NSDate alloc] init];
            // voila!
            dateFromString = [dateFormatter dateFromString:expire_str];
            [dateFormatter release];
            self.expire = dateFromString;
            NSLog(@":%@ %d %@",self.no,self.type,self.expire);
        }
        else{
            self.no=@"Nothing";
        }
        sqlite3_reset(init_statement);
    }
    return self;
}
@end
