//
//  Flight.h
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 1/17/12.
//  Copyright (c) 2012 Chulalongkorn University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Flight : NSObject{
    NSInteger primaryKey;
    NSString *no;
    NSDate *datetime;
    NSString *dest;
    NSString *PPno;
    NSInteger PPtype;
    NSInteger visa;
}
@property(nonatomic,assign,readonly) NSInteger primaryKey;
@property(nonatomic,retain) NSString *no;
@property(nonatomic,retain) NSDate *datetime;
@property(nonatomic,retain) NSString *dest;
@property(nonatomic,retain) NSString *PPno;
@property(nonatomic) NSInteger PPtype;
@property(nonatomic) NSInteger visa;

//Static methods.
+ (void) getInitialDataToDisplay:(NSString *)dbPath;
+ (void) finalizeStatements;

//Instance methods.
- (id) initWithPrimaryKey:(NSInteger)pk;
- (void) deleteF;
- (void) addF;


@end
