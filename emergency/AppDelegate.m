//
//  AppDelegate.m
//  emergency
//
//  Created by Marco Velluto on 22/08/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "Database.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [Parse setApplicationId:@"G15Lr835iCCJPtZzSqlMuCqPkKx27zF1e9PkexLu" clientKey:@"LoXF38I380Uxe0UzukA7EN4ZMLW23fJiUPZSVLp8"]; [[UIApplication sharedApplication]registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound];
    

    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 
#pragma mark - Push Notifications
#pragma mark -

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
   [PFPush storeDeviceToken:deviceToken];
    [PFPush subscribeToChannelInBackground:@""];

    /** -- Per inserire un canale personalizzato
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation addUniqueObject:@"Pippo" forKey:@"channels"];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
    */

}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Failed to register for Push %@",error);
    
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
    // Create empty photo object
    
    NSLog(@"didReceiveRemoteNotification:%@", userInfo);
    Database *db = [[Database alloc] init];
    NSString *str = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    [db addNotification:str];
    NSLog(@"%@", [db allElements]);
    
    NSLog(@"didReceiveRemoteNotification:%@", userInfo);
}

@end
