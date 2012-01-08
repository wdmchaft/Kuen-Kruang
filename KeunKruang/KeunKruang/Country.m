//
//  Country.m
//  TestXML
//
//  Created by Napawan Srisuksawad on 12/22/11.
//  Copyright (c) 2011 Chulalongkorn University. All rights reserved.
//

#import "Country.h"

@implementation Country

@synthesize shortname, fullname;
-(void) dealloc{
    [shortname release];
    [fullname release];
    [super dealloc];
}
@end
