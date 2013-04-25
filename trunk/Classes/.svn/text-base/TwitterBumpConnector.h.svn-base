//
//  TwitterBumpConnector.h
//  TwitterBump
//
//  Created by Doug Strittmatter on 5/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bump.h"
#import "FriendsListViewController.h"
#import "XAuthTwitterEngineDelegate.h"
#import "OAToken.h"

@class TwitterBumpViewController;
@class XAuthTwitterEngine;

@interface TwitterBumpConnector : NSObject <XAuthTwitterEngineDelegate,BumpDelegate> {
	Bump *bumpObject;
	TwitterBumpViewController *twitterViewController;

	XAuthTwitterEngine *_engine;
	int packetsAttempted;
	int packetsSent;
	int responseCount;
	NSDictionary *dictNewFriend;
	NSMutableArray *arrFriendsList;
}

@property (nonatomic, assign) TwitterBumpViewController *twitterViewController;
@property (nonatomic, assign) NSDictionary *dictNewFriend;
@property (nonatomic, assign) NSMutableArray *arrFriendsList;
@property (nonatomic, retain) XAuthTwitterEngine *_engine;

- (void) sendTwitterInfo;
- (void) startBump;
- (void) shareViaBump;
- (void) stopBump;
- (void) addFriend;
- (void) saveProfileImage:(NSString *)url screen_name:(NSString *)screen_name;
- (NSInteger)getObjectIndex:(NSMutableArray *)array byName:(NSString *)theName;

@end
