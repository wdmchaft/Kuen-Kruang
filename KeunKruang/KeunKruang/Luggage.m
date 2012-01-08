//
//  Luggage.m
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 1/9/12.
//  Copyright (c) 2012 Chulalongkorn University. All rights reserved.
//

#import "Luggage.h"

@implementation Luggage
@synthesize shortname, fullname,load_piece,load_weight,car_piece,car_weight;
-(void) dealloc{
    [fullname release];
    [shortname release];
    [super dealloc];
}
@end
