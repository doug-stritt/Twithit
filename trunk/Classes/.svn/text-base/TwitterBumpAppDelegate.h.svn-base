//
//  TwitterBumpAppDelegate.h
//  TwitterBump
//
//  Created by Doug Strittmatter on 5/25/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TwitterBumpViewController;

@interface TwitterBumpAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UITabBarController *tabBarController;
    TwitterBumpViewController *twitterBumpViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet TwitterBumpViewController *twitterBumpViewController;

- (void)toggleTabBarEnabled:(NSNotification *)aNotification;
- (void)toggleTabBarDisabled:(NSNotification *)aNotification;
- (void)switchTab:(NSNotification *)aNotification;

@end

