//
//  AppDelegate.m
//  SearchBarBug
//
//  Created by Mouhcine El Amine on 07/01/14.
//  Copyright (c) 2014 Mouhcine El Amine. All rights reserved.
//

#import "AppDelegate.h"
#import "JASidePanelController.h"
#import "MenuViewController.h"
#import "CenterViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    JASidePanelController *rootViewController = [[JASidePanelController alloc] init];
    rootViewController.shouldResizeLeftPanel = YES;
    rootViewController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[CenterViewController alloc] init]];
    rootViewController.leftPanel = [[MenuViewController alloc] init];
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
