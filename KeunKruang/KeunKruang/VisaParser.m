//
//  DetailParser.m
//  ThaiVisaGuru
//
//  Created by Napawan Srisuksawad on 12/26/11.
//  Copyright (c) 2011 Chulalongkorn University. All rights reserved.
//

#import "VisaParser.h"

@implementation VisaParser
@synthesize Visa_l;
-(id) loadXMLByURL:(NSString *)urlString
{
    Visa_l          = [[NSMutableArray alloc] init];
    NSURL *url      = [NSURL URLWithString:urlString];
    NSData  *data   = [[NSData alloc] initWithContentsOfURL:url];
    parser          = [[NSXMLParser alloc] initWithData:data];
    [data release];
    parser.delegate = self;
    [parser parse];
    return self;
}
- (void) dealloc
{
    [Visa_l release];
    [parser release];
    [super dealloc];
}
- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementname isEqualToString:@"visa"])
    {
        currentCountry = [Visa alloc];
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
    if ([elementname isEqualToString:@"ord_need"])
    {
        currentCountry.or_visa = [currentNodeContent integerValue];
    }
    if ([elementname isEqualToString:@"ord_day"])
    {
        currentCountry.or_day = [currentNodeContent integerValue];
    }
    if ([elementname isEqualToString:@"off_need"])
    {
        currentCountry.of_visa = [currentNodeContent integerValue];
    }
    if ([elementname isEqualToString:@"off_day"])
    {
        currentCountry.of_day = [currentNodeContent integerValue];
    }
    if ([elementname isEqualToString:@"country"])
    {
        [Visa_l addObject:currentCountry];
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
