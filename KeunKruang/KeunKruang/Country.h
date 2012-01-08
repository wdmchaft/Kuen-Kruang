//
//  Country.h
//  TestXML
//
//  Created by Napawan Srisuksawad on 12/22/11.
//  Copyright (c) 2011 Chulalongkorn University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Country : NSObject
{
    NSString     *shortname;
    NSString     *fullname;
}

@property (nonatomic, retain) NSString   *shortname;
@property (nonatomic, retain) NSString   *fullname;

@end
