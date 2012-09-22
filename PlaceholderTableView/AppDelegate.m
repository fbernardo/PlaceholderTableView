//
//  AppDelegate.m
//  PlaceholderTableView
//
//  Created by Fábio Bernardo on 9/21/12.
//  Copyright (c) 2012 Fábio Bernardo. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    ViewController *vc = [[ViewController alloc] initWithNibName:nil bundle:nil];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
