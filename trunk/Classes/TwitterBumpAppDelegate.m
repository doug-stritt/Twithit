//
//  TwitterBumpAppDelegate.m
//  TwitterBump
//
//  Created by Doug Strittmatter on 5/25/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "TwitterBumpAppDelegate.h"
#import "TwitterBumpViewController.h"

@implementation TwitterBumpAppDelegate

@synthesize window;
@synthesize twitterBumpViewController;
@synthesize tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions { 
	
	// disable app shutdown
	[[UIApplication sharedApplication] setIdleTimerDisabled: YES];
	
	UIImageView *imgBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
	[tabBarController.view insertSubview:imgBackground atIndex:0]; 
	[imgBackground release];
	
	[[NSNotificationCenter defaultCenter] addObserver: self
											 selector:@selector(toggleTabBarEnabled:)
												 name: @"ToggleTabBarEnabled"
											   object: nil];
	[[NSNotificationCenter defaultCenter] addObserver: self
											 selector:@selector(toggleTabBarDisabled:)
												 name: @"ToggleTabBarDisabled"
											   object: nil];
	[[NSNotificationCenter defaultCenter] addObserver: self
											 selector:@selector(switchTab:)
												 name: @"SwitchTab"
											   object: nil];
    
    // Override point for customization after app launch    
    [window addSubview:tabBarController.view];
    [window makeKeyAndVisible];
	
	return YES;
}


-(void)applicationWillTerminate:(UIApplication *)application
{
	[twitterBumpViewController applicationWillTerminate:application];
}


- (void)toggleTabBarEnabled:(NSNotification *)aNotification {
	tabBarController.tabBar.userInteractionEnabled = YES;	
}


- (void)toggleTabBarDisabled:(NSNotification *)aNotification {
	tabBarController.tabBar.userInteractionEnabled = NO;
	
}


- (void)switchTab:(NSNotification *)aNotification {
	tabBarController.selectedIndex = 1;
	
}


- (void)dealloc {
    [twitterBumpViewController release];
    [window release];
    [super dealloc];
}


@end
