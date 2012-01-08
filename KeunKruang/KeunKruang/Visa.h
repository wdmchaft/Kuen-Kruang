//
//  Visa.h
//  ThaiVisaGuru
//
//  Created by Napawan Srisuksawad on 12/26/11.
//  Copyright (c) 2011 Chulalongkorn University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Visa : NSObject
{
    NSString     *shortname;
    NSString     *fullname;
    NSInteger    *or_visa;
    NSInteger    *or_day;
    NSInteger    *of_visa;
    NSInteger    *of_day;
}
@property (nonatomic, retain) NSString   *shortname;
@property (nonatomic, retain) NSString   *fullname;
@property NSInteger *or_visa;
@property NSInteger *or_day;
@property NSInteger *of_visa;
@property NSInteger *of_day;
@end
