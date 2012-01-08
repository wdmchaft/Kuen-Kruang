//
//  Visa.m
//  ThaiVisaGuru
//
//  Created by Napawan Srisuksawad on 12/26/11.
//  Copyright (c) 2011 Chulalongkorn University. All rights reserved.
//

#import "Visa.h"

@implementation Visa
@synthesize shortname, fullname,or_visa,or_day,of_day,of_visa;
-(void) dealloc{
    [fullname release];
    [shortname release];
    [super dealloc];
}

@end
