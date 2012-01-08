//
//  DocumentView.h
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 1/9/12.
//  Copyright (c) 2012 Chulalongkorn University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DocumentView : UIViewController{
    IBOutlet UIWebView *webView;
    NSString *selectedCountry;
    NSString *fullnameCountry;
}
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) NSString *selectedCountry;
@property (nonatomic, retain) NSString *fullnameCountry;
@end
