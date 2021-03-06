//
//  AppDelegate.m
//  Scientific Method
//
//  Created by Connor Koehler on 5/1/13.
//  Copyright (c) 2013 Lordtechy. All rights reserved.
//

#import "AppDelegate.h"
 
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    
    tabBarItem1.title = @"Overview";
    tabBarItem2.title = @"Concepts";
    tabBarItem3.title = @"Glossery";
    tabBarItem4.title = @"Elements";
    
    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"overview_black.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"overview_grey.png"]];
    [tabBarItem1 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],UITextAttributeTextColor, nil] forState:UIControlStateSelected];
    [tabBarItem1 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[self colorWithHexString:@"838080"],UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    
    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"concepts_black.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"concepts_grey.png"]];
    [tabBarItem2 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],UITextAttributeTextColor, nil] forState:UIControlStateSelected];
    [tabBarItem2 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[self colorWithHexString:@"838080"],UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    
    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"glossery_black_small.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"glossery_grey_small.png"]];
    [tabBarItem3 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],UITextAttributeTextColor, nil] forState:UIControlStateSelected];
    [tabBarItem3 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[self colorWithHexString:@"838080"],UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    
    [tabBarItem4 setFinishedSelectedImage:[UIImage imageNamed:@"Atom_black_small.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"Atom_grey_small.png"]];
    [tabBarItem4 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],UITextAttributeTextColor, nil] forState:UIControlStateSelected];
    [tabBarItem4 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[self colorWithHexString:@"838080"],UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    
    
    
    
    [[tabBarController tabBar]setBackgroundImage:[UIImage imageNamed:@"TabBarBackground6.png"]];
    return YES;
}


-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
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

@end
