//
//  DestParser.m
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 1/19/12.
//  Copyright (c) 2012 Chulalongkorn University. All rights reserved.
//

#import "DestParser.h"

@implementation DestParser
@synthesize dest_l;

-(id) loadXMLByURL:(NSString *)urlString
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    dest_l          = [[NSMutableArray alloc] init];
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
    if ([elementname isEqualToString:@"airport"])
    {
        currentDest = [Destination alloc];
    }
}
- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementname isEqualToString:@"code"])
    {
        currentDest.code = currentNodeContent;
    }
    if ([elementname isEqualToString:@"fullname"])
    {
        currentDest.fullname = currentNodeContent;
    }
    if ([elementname isEqualToString:@"country"])
    {
        currentDest.country = currentNodeContent;
    }
    if ([elementname isEqualToString:@"airport"])
    {
        [dest_l addObject:currentDest];
        [currentDest release];
        currentDest = nil;
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

