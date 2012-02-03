//
//  DestParser.h
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 1/19/12.
//  Copyright (c) 2012 Chulalongkorn University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Destination.h"

@interface DestParser : NSObject<NSXMLParserDelegate>{
    NSMutableString *currentNodeContent;
    NSMutableArray  *dest_l;
    NSXMLParser     *parser;
    Destination *currentDest;
}
@property (readonly, retain) NSMutableArray *dest_l;

-(id) loadXMLByURL:(NSString *)urlString;

@end
