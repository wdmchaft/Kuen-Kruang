//
//  Weather.h
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 10/16/11.
//  Copyright (c) 2011 Chulalongkorn University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Weather : UIViewController{
    IBOutlet UIWebView *webView;
}
@property (nonatomic, retain) UIWebView *webView;
@end
