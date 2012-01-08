//
//  Luggage.h
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 1/9/12.
//  Copyright (c) 2012 Chulalongkorn University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Luggage : NSObject
{
    NSString     *shortname;
    NSString     *fullname;
    NSInteger    *load_piece;
    NSInteger    *load_weight;
    NSInteger    *car_piece;
    NSInteger    *car_weight;
}
@property (nonatomic, retain) NSString   *shortname;
@property (nonatomic, retain) NSString   *fullname;
@property NSInteger *load_piece;
@property NSInteger *load_weight;
@property NSInteger *car_piece;
@property NSInteger *car_weight;
@end
