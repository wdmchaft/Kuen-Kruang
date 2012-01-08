//
//  XMLParser.m
//  TestXML
//
//  Created by Napawan Srisuksawad on 12/22/11.
//  Copyright (c) 2011 Chulalongkorn University. All rights reserved.
//

#import "CListParser.h"

@implementation CListParser
@synthesize country_l;

-(id) loadXMLByURL:(NSString *)urlString
{
    country_l          = [[NSMutableArray alloc] init];
    NSURL *url      = [NSURL URLWithString:urlString];
    NSData  *data   = [[NSData alloc] initWithContentsOfURL:url];
    parser          = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
    return self;
}
- (void) dealloc
{
    [parser release];
    [super dealloc];
}
- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementname isEqualToString:@"country"])
    {
        currentCountry = [Country alloc];
    }
}
- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementname isEqualToString:@"shortname"])
    {
        currentCountry.shortname = currentNodeContent;
    }
    if ([elementname isEqualToString:@"fullname"])
    {
        currentCountry.fullname = currentNodeContent;
    }
    if ([elementname isEqualToString:@"country"])
    {
        [country_l addObject:currentCountry];
        [currentCountry release];
        currentCountry = nil;
        [currentNodeContent release];
        currentNodeContent = nil;
    }
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    currentNodeContent = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
@end
