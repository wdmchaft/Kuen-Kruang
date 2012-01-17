//
//  KeunKruangAppDelegate.h
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 10/7/11.
//  Copyright 2011 Chulalongkorn University. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Passport,Flight;

@interface AppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate,UINavigationBarDelegate>{
    NSMutableArray *pp;
    NSMutableArray *f;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) NSMutableArray *pp;
@property (nonatomic, retain) NSMutableArray *f;

- (void) copyDatabaseIfNeeded;
- (NSString *) getDBPath;
- (void) removePassport:(Passport *)selected;
- (void) addPassport:(Passport *)selected;
- (void) removeFlight:(Flight *)selected;
- (void) addFlight:(Flight *)selected;

@end
