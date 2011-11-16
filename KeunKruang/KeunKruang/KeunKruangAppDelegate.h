//
//  KeunKruangAppDelegate.h
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 10/7/11.
//  Copyright 2011 Chulalongkorn University. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Passport;

@interface KeunKruangAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate,UINavigationBarDelegate>{
    NSMutableArray *pp;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) NSMutableArray *pp;

- (void) copyDatabaseIfNeeded;
- (NSString *) getDBPath;
- (void) removePassport:(Passport *)selected;

@end
