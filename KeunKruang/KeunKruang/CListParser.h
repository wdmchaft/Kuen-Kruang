//
//  XMLParser.h
//  TestXML
//
//  Created by Napawan Srisuksawad on 12/22/11.
//  Copyright (c) 2011 Chulalongkorn University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Country.h"

@interface CListParser : NSObject <NSXMLParserDelegate>{
    NSMutableString *currentNodeContent;
    NSMutableArray  *country_l;
    NSXMLParser     *parser;
    Country *currentCountry;
}
@property (readonly, retain) NSMutableArray *country_l;

-(id) loadXMLByURL:(NSString *)urlString;
@end
