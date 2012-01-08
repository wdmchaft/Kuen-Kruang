//
//  LuggageParser.h
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 1/9/12.
//  Copyright (c) 2012 Chulalongkorn University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Luggage.h"

@interface LuggageParser : NSObject<NSXMLParserDelegate>{
    NSMutableString *currentNodeContent;
    NSMutableArray  *lug;
    NSXMLParser     *parser;
    Luggage *l;
}
@property (readonly, retain) NSMutableArray *lug;

-(id) loadXMLByURL:(NSString *)urlString;

@end
