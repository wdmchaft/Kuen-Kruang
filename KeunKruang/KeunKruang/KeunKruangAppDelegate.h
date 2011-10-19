//
//  KeunKruangAppDelegate.h
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 10/7/11.
//  Copyright 2011 Chulalongkorn University. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface KeunKruangAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate,UINavigationBarDelegate>{
    sqlite3 *dbase;
    NSMutableArray *pp;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) NSMutableArray *pp;

@end
