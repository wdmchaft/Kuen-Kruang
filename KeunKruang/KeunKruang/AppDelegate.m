//
//  KeunKruangAppDelegate.m
//  KeunKruang
//
//  Created by Napawan Srisuksawad on 10/7/11.
//  Copyright 2011 Chulalongkorn University. All rights reserved.
//

#import "AppDelegate.h"
#import "Passport.h"
#import "Flight.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize pp;
@synthesize f;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //Copy database to the user's phone if needed.
    [self copyDatabaseIfNeeded];
    
    //Initialize the coffee array.
    NSMutableArray *ppArray = [[NSMutableArray alloc] init];
    NSMutableArray *fArray = [[NSMutableArray alloc] init];
    self.pp = ppArray;
    self.f=fArray;
    [ppArray release];
    [fArray release];
    //Once the db is copied, get the initial data to display on the screen.
    [Passport getInitialDataToDisplay:[self getDBPath]];
    [Flight getInitialDataToDisplay:[self getDBPath]];
    // Add the tab bar controller's current view as a subview of the window
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    application.applicationIconBadgeNumber = 0;
    // Handle launching from a notification
    UILocalNotification *localNotif =
    [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotif) {
        NSLog(@"Recieved Notification %@",localNotif);
    }
    return YES;
}
- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
    // Handle the notificaton when the app is running
    NSLog(@"Recieved Notification %@",notif);
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/
- (void) copyDatabaseIfNeeded {
    //Using NSFileManager we can perform many file system operations.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString *dbPath = [self getDBPath];
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    
    if(!success) {
        
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"KeunKruang.sqlite"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        
        if (!success)
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}
- (NSString *) getDBPath {
    //Search for standard documents using NSSearchPathForDirectoriesInDomains
    //First Param = Searching the documents directory
    //Second Param = Searching the Users directory and not the System
    //Expand any tildes and identify home directories.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"KeunKruang.sqlite"];
}
- (void) removePassport:(Passport *)selected{
    //Delete it from the database.
    [selected deletePP];
    
    //Remove it from the array.
    [pp removeObject:selected];
}
- (void) addPassport:(Passport *)selected{
    //Add it to the database.
    [selected addPP];
    
    //Add it to the coffee array.
    [pp addObject:selected];
}
- (void) removeFlight:(Flight *)selected{
    //Delete it from the database.
    [selected deleteF];
    
    //Remove it from the array.
    [f removeObject:selected];
}
- (void) addFlight:(Flight *)selected{
    //Add it to the database.
    [selected addF];
    
    //Add it to the coffee array.
    [f addObject:selected];
}
- (void) updateFlight:(Flight *)selected{
    //update
    [selected changeVisa];
    
    //refrsh array
    [f removeAllObjects];
    [Flight getInitialDataToDisplay:[self getDBPath]];
}
@end
