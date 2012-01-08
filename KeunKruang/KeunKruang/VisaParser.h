//
//  DetailParser.h
//  ThaiVisaGuru
//
//  Created by Napawan Srisuksawad on 12/26/11.
//  Copyright (c) 2011 Chulalongkorn University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Visa.h"

@interface VisaParser : NSObject<NSXMLParserDelegate>{
    NSMutableString *currentNodeContent;
    NSMutableArray  *Visa_l;
    NSXMLParser     *parser;
    Visa *currentCountry;
}
@property (readonly, retain) NSMutableArray *Visa_l;

-(id) loadXMLByURL:(NSString *)urlString;
@end

