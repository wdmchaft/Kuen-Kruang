//
//  DocumentView.m
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 1/9/12.
//  Copyright (c) 2012 Chulalongkorn University. All rights reserved.
//

#import "DocumentView.h"

@implementation DocumentView
@synthesize webView,fullnameCountry,selectedCountry;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title=fullnameCountry;
    NSString *urlAddress=[NSString  stringWithFormat:@"http://app.lingoomtang.com/boarding/document/getDoc/%@",selectedCountry];
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [webView loadRequest:requestObj];    
    webView.scalesPageToFit=YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
}

- (void)viewDidUnload
{
    [webView release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.navigationItem.title=@"ข้อมูลสัมภาระ";
}
- (void) dealloc
{
    [webView release];
    [super dealloc];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
}
@end
