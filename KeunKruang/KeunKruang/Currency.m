//
//  Currency.m
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 10/16/11.
//  Copyright (c) 2011 Chulalongkorn University. All rights reserved.
//

#import "Currency.h"

@implementation Currency
@synthesize webView;
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
    self.navigationItem.title=@"อัตราแลกเปลี่ยน";
    NSString *urlAddress=@"http://www.bangkokbank.com/_layouts/NR/BangkokBankThaiWebApps/WebApp%20Currency%20Exchange%20Thai2/user_conversion_popup.asp";
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
    self.navigationItem.title=@"อื่นๆ";
}
- (void) dealloc
{
    [webView release];
    [super dealloc];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
