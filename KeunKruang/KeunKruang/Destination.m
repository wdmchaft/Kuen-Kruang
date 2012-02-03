//
//  Destination.m
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 1/19/12.
//  Copyright (c) 2012 Chulalongkorn University. All rights reserved.
//

#import "Destination.h"

@implementation Destination
@synthesize code,fullname,country;
-(void) dealloc{
    [code release];
    [fullname release];
    [country release];
    [super dealloc];
}

@end
