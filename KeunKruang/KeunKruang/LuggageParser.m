//
//  LuggageParser.m
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 1/9/12.
//  Copyright (c) 2012 Chulalongkorn University. All rights reserved.
//

#import "LuggageParser.h"

@implementation LuggageParser
@synthesize lug;
-(id) loadXMLByURL:(NSString *)urlString
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    lug          = [[NSMutableArray alloc] init];
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
    [lug release];
    [parser release];
    [super dealloc];
}
- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementname isEqualToString:@"result"])
    {
        l = [Luggage alloc];
    }
}
- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementname isEqualToString:@"shortname"])
    {
        l.shortname = currentNodeContent;
    }
    if ([elementname isEqualToString:@"fullname"])
    {
        l.fullname = currentNodeContent;
    }
    if ([elementname isEqualToString:@"load_piece"])
    {
        l.load_piece = [currentNodeContent integerValue];
    }
    if ([elementname isEqualToString:@"load_weight"])
    {
        l.load_weight = [currentNodeContent integerValue];
    }
    if ([elementname isEqualToString:@"car_piece"])
    {
        l.car_piece = [currentNodeContent integerValue];
    }
    if ([elementname isEqualToString:@"car_weight"])
    {
        l.car_weight = [currentNodeContent integerValue];
    }
    if ([elementname isEqualToString:@"result"])
    {
        [lug addObject:l];
        [l release];
        l = nil;
        [currentNodeContent release];
        currentNodeContent = nil;
    }
}
- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    currentNodeContent = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
-(void) parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"parserDidStartDocument");
}

-(void) parserDidEndDocument: (NSXMLParser *)parser
{
    NSLog(@"parserDidEndDocument");
}

@end
