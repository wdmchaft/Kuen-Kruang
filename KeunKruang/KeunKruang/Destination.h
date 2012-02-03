//
//  Destination.h
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 1/19/12.
//  Copyright (c) 2012 Chulalongkorn University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Destination : NSObject{
    NSString     *code;
    NSString     *fullname;
    NSString     *country;
}

@property (nonatomic, retain) NSString   *code;
@property (nonatomic, retain) NSString   *fullname;
@property (nonatomic, retain) NSString   *country;

@end
