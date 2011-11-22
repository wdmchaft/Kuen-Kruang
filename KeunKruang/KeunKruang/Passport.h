//
//  Passport.h
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 10/19/11.
//  Copyright (c) 2011 Chulalongkorn University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface Passport : NSObject{
    NSString *no;
    NSInteger primaryKey;
    NSInteger type;
    NSDate *expire;
}

@property(nonatomic,assign,readonly) NSInteger primaryKey;
@property(nonatomic,retain) NSString *no;
@property(nonatomic) NSInteger type;
@property(nonatomic,retain) NSDate *expire;

//Static methods.
+ (void) getInitialDataToDisplay:(NSString *)dbPath;
+ (void) finalizeStatements;

//Instance methods.
- (id) initWithPrimaryKey:(NSInteger)pk;
- (void) deletePP;
- (void) addPP;

@end
