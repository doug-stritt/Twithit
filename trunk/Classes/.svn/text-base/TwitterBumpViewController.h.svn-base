//
//  TwitterBumpViewController.h
//  TwitterBump
//
//  Created by Doug Strittmatter on 5/25/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterBumpConnector.h"
#import "MGTwitterEngine.h" 
#import "TwitterBumpAppDelegate.h"
#import "XAuthTwitterViewController.h"
#import "XAuthTwitterEngineDelegate.h"


@class XAuthTwitterEngine;

@interface TwitterBumpViewController : UIViewController <XAuthTwitterEngineDelegate,BumpDelegate, MGTwitterEngineDelegate>  {

	XAuthTwitterEngine *_engine;
	int responseCount;
	TwitterBumpConnector *bumpConn;
	NSString *username;
	NSString *status;
	NSMutableArray *arrFriendsList;
	UIActivityIndicatorView	*spinner;
	IBOutlet UIView *activityIndicatorContainer;
	
	IBOutlet UILabel *lblTitle;
	IBOutlet UILabel *lblScreenName;
	IBOutlet UIImageView *imgMigrating;
	IBOutlet UIButton *btnBump;
	IBOutlet UIBarButtonItem *btnLogin;
}

@property (nonatomic, retain) TwitterBumpConnector *bumpConn;
@property (nonatomic, retain) XAuthTwitterEngine *_engine;

-(IBAction) startBumpButtonPress;
-(IBAction) loginButtonPress;
- (void)twitterSucceeded:(NSNotification *)aNotification;
- (void)twitterFailed:(NSNotification *)aNotification;
- (void)bumpFailed:(NSNotification *)aNotification;
- (void)startActivityViewer:(NSNotification *)aNotification;
- (void)loginLabel:(NSNotification *)aNotification;
- (NSInteger)getObjectIndex:(NSMutableArray *)array byName:(NSString *)theName;

@end

