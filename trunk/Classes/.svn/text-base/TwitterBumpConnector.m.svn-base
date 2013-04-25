//
//  TwitterBumpConnector.m
//  TwitterBump
//
//  Created by Doug Strittmatter on 5/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TwitterBumpConnector.h"
#import "TwitterBumpViewController.h"
#import "TwitterBumpAppDelegate.h"
#import "Constants.h"
#import "XAuthTwitterEngine.h"
#import "UIAlertView+Helper.h"

@implementation TwitterBumpConnector

@synthesize twitterViewController;
@synthesize dictNewFriend;
@synthesize arrFriendsList;
@synthesize _engine;

- (id) init {
	if(self = [super init]){
		bumpObject = [[Bump alloc] init];
		
		_engine = [[XAuthTwitterEngine alloc] initXAuthWithDelegate:self];
		_engine.consumerKey = kOAuthConsumerKey;
		_engine.consumerSecret = kOAuthConsumerSecret;

	}
	return self;
}


-(void) configBump{
	[bumpObject configAPIKey:@"a10700236d034decb94e8150c6dcee68"];
}


- (void) startBump{
	NSLog(@"startBump");
	// TEST: bump workaround
	//[_engine getUserInformationFor:@"strittnine"];
	
	[self configBump];
	[bumpObject setDelegate:self];
	[bumpObject configHistoryMessage:@"%1 just started a TwitHit with %2!"];
	[bumpObject configActionMessage:@"Bump with another TwitHit owner to start transfer."];
	[bumpObject connect];
}


- (void) shareViaBump{
	[self configBump];
	[bumpObject setDelegate:self];
	[bumpObject configHistoryMessage:@"%1 just shared Twitter Bump for the iPhone with %2!"];
	[bumpObject configActionMessage:@"Bump with someone running the standalone Bump app to share Twitter Bump."];
	[bumpObject connectToShareThisApp];
}


- (void) stopBump{
	NSLog(@"stopBump");
	[bumpObject disconnect];
}


- (void) bumpDataReceived:(NSData *)chunk{
	NSLog(@"bumpDataReceived");
	
	//The chunk was packaged by the other user using an NSKeyedArchiver, so we unpackage it here with our NSKeyedUnArchiver
	NSDictionary *responseDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:chunk];
	//[self printDict:responseDictionary];
	
	//responseDictionary no contains an Identical dictionary to the one that the other user sent us
	NSString *userName = [responseDictionary objectForKey:@"USER_ID"];
	
	// get user info
	[_engine getUserInformationFor:userName];
}


-(void) sendTwitterInfo {
	NSMutableDictionary *twitterDict = [[NSMutableDictionary alloc] initWithCapacity:1];

	[twitterDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey: @"username"]  forKey:@"USER_ID"];

	NSData *twitterChunk = [NSKeyedArchiver archivedDataWithRootObject:twitterDict];
	[twitterDict release];
	packetsAttempted++;
	[bumpObject send:twitterChunk];
}


- (void) bumpDidConnect{
	NSLog(@"bumpDidConnect");
	[self sendTwitterInfo];
}


- (void) bumpSendSuccess{
	//This callback method lets you know that the [Bump send:] method that you called was succesful in sending your chunk up to Bump's server.
	//This doesn't guarantee that the other handset has received the chunk.
	packetsSent++;
	NSLog(@"packet success %d of %d", packetsSent, packetsAttempted);
}


- (void) bumpDidDisconnect:(BumpDisconnectReason)reason{
	NSString *alertText;
	switch (reason) {
		case END_OTHER_USER_QUIT:
			alertText = @"Other user has quit.";
			break;
		case END_LOST_NET:
			alertText = @"Connection to Bump server was lost.";
			break;
		case END_OTHER_USER_LOST:
			alertText = @"Connection to other user was lost.";
			break;
		case END_USER_QUIT:
			alertText = @"You have been disconnected.";
			break;
		default:
			alertText = @"You have been disconnected.";
			break;
	}
	
	if(reason != END_USER_QUIT){ 
		//if the local user initiated the quit,restarting the app is already being handled
		//other wise we'll restart here

		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Disconnected" message:alertText delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}

	[[NSNotificationCenter defaultCenter]
	 postNotificationName: @"ToggleTabBarEnabled"
	 object: nil];
	
	[[NSNotificationCenter defaultCenter]
	 postNotificationName: @"BumpFailed"
	 object: nil];
}


- (void) bumpConnectFailed:(BumpConnectFailedReason)reason{
	
	NSString *alertText;
	switch (reason) {
		case FAIL_NETWORK_UNAVAILABLE:
			alertText = @"Please check your network settings and try again.";
			break;
		case FAIL_INVALID_AUTHORIZATION:
			//the user should never see this, since we'll pass in the correct API auth strings.
			//just for debug.
			alertText = @"Failed to connect to the Bump service. Auth error.";
			break;
		default:
			alertText = @"Failed to connect to the Bump service.";
			break;
	}
	
	if(reason != FAIL_USER_CANCELED){
		//if the user canceled they know it and they don't need a popup.
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Failed" message:alertText delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	
	[[NSNotificationCenter defaultCenter]
	 postNotificationName: @"ToggleTabBarEnabled"
	 object: nil];
	
	[[NSNotificationCenter defaultCenter]
	 postNotificationName: @"BumpFailed"
	 object: nil];
}


// for Debug -- prints contents of NSDictionary
-(void)printDict:(NSDictionary *)ddict {
	NSLog(@"---printing Dictionary---");
	NSArray *keys = [ddict allKeys];
	for (id key in keys) {
		NSLog(@"   key = %@     value = %@",key,[ddict objectForKey:key]);
	}	
}


#pragma mark -
#pragma mark XAuthTwitterEngineDelegate methods

- (void) storeCachedTwitterXAuthAccessTokenString: (NSString *)tokenString forUsername:(NSString *)username
{
	//
	// Note: do not use NSUserDefaults to store this in a production environment. 
	// ===== Use the keychain instead. Check out SFHFKeychainUtils if you want 
	//       an easy to use library. (http://github.com/ldandersen/scifihifi-iphone) 
	//
	NSLog(@"Access token string returned: %@", tokenString);
	
	[[NSUserDefaults standardUserDefaults] setObject:tokenString forKey:kCachedXAuthAccessTokenStringKey];
}

- (NSString *) cachedTwitterXAuthAccessTokenStringForUsername: (NSString *)username;
{
	NSString *accessTokenString = [[NSUserDefaults standardUserDefaults] objectForKey:kCachedXAuthAccessTokenStringKey];
	
	NSLog(@"About to return access token string: %@", accessTokenString);
	
	return accessTokenString;
}


- (void) twitterXAuthConnectionDidFailWithError: (NSError *)error;
{
	NSLog(@"Error: %@", error);
	
	UIAlertViewQuick(@"Authentication error", @"Please check your username and password and try again.", @"OK");
}



//=============================================================================================================================
#pragma mark SA_OAuthTwitterEngineDelegate
- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}



//=============================================================================================================================
#pragma mark TwitterEngineDelegate
- (void) requestSucceeded: (NSString *) requestIdentifier {
	NSLog(@"Request %@ succeeded", requestIdentifier);
}


- (void) requestFailed: (NSString *) requestIdentifier withError: (NSError *) error {
	NSLog(@"Request %@ failed with error: %@", requestIdentifier, error);
	
	[[NSNotificationCenter defaultCenter]
	 postNotificationName: @"ToggleTabBarEnabled"
	 object: nil];
}


- (void)statusesReceived:(NSArray *)statuses forRequest:(NSString *)identifier
{
    NSLog(@"Got statuses:\r%@", statuses);
}


- (void)directMessagesReceived:(NSArray *)messages forRequest:(NSString *)identifier
{
    NSLog(@"Got direct messages:\r%@", messages);
}


- (void)userInfoReceived:(NSArray *)userInfo forRequest:(NSString *)identifier
{
    NSLog(@"Got user info:\r%@", userInfo);
	dictNewFriend = [userInfo objectAtIndex:0];
	
	int requestType = [[dictNewFriend objectForKey:@"source_api_request_type"] intValue];
	
	if (requestType == 12) {
		// received user info
		
		// add friend to friend list
		[self addFriend];
		
		[[NSNotificationCenter defaultCenter]
		 postNotificationName: @"ToggleTabBarEnabled"
		 object: nil];
		
		// find if already following friend
		int isFollowing = [[dictNewFriend objectForKey:@"following"] intValue];
		if (isFollowing == 0) {
			// add friend
			[_engine enableUpdatesFor:[dictNewFriend objectForKey:@"screen_name"]];
		} 
	} else if (requestType == 17) {
		// added friend
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"@%@ Added",[dictNewFriend objectForKey:@"screen_name"]]
														message:[NSString stringWithFormat:@"You're now following @%@ on Twitter!",[dictNewFriend objectForKey:@"screen_name"]]
													   delegate:nil 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
		
		[[NSNotificationCenter defaultCenter]
		 postNotificationName: @"ReloadFriendsList"
		 object: nil];
	} else if (requestType == 18) {
		// deleted friend
	}	
}


- (void)addFriend {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	// create new array if there isn't one
	if (![defaults objectForKey:@"friendsList"]) {	
		arrFriendsList = [[NSMutableArray alloc] init];
		[arrFriendsList addObject:dictNewFriend];
		[self saveProfileImage:[dictNewFriend objectForKey:@"profile_image_url"] screen_name:[dictNewFriend objectForKey:@"screen_name"]];
		NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrFriendsList];
		[defaults setObject: data forKey: @"friendsList"];
		[defaults synchronize];
	} else {
		
		// retrieve stored friends list
		NSData *dataFriend = [defaults objectForKey:@"friendsList"];
		arrFriendsList = [[NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:dataFriend]] retain];
		NSMutableArray *tempFriendsList = [NSMutableArray arrayWithArray:arrFriendsList];		
		
		for (NSDictionary *dict in tempFriendsList) {
			// remove friend if previously added
			if ([[dictNewFriend objectForKey:@"screen_name"] isEqual:[dict objectForKey:@"screen_name"]]) {
				int friendIndex = [self getObjectIndex:arrFriendsList byName:[dictNewFriend objectForKey:@"screen_name"]];
				[arrFriendsList removeObjectAtIndex:friendIndex];
			}
			
			// save image
			NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
			NSString *pngFilePath = [NSString stringWithFormat:@"%@/%@.png",docDir,[dict objectForKey:@"screen_name"]];
			if (![UIImage imageWithContentsOfFile:pngFilePath]) {
				[self saveProfileImage:[dict objectForKey:@"profile_image_url"] screen_name:[dict objectForKey:@"screen_name"]];
			}
		}
		
		// add new friend to friend array
		[arrFriendsList addObject:dictNewFriend];
		
		// sort array
		[arrFriendsList sortUsingDescriptors:[NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)] autorelease]]]; 		

		// store new friends list
		NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrFriendsList];
		[defaults setObject:data forKey:@"friendsList"];
		[defaults synchronize];
	}
	
	[[NSNotificationCenter defaultCenter]
	 postNotificationName: @"TwitterSucceeded"
	 object: dictNewFriend];
	
}


- (NSInteger)getObjectIndex:(NSMutableArray *)array byName:(NSString *)theName {
    NSInteger idx = 0;
    for (NSDictionary* dict in array) {
        if ([[dict objectForKey:@"screen_name"] isEqualToString:theName])
            return idx;
        ++idx;
    }
    return NSNotFound;
}


- (void)saveProfileImage:(NSString *)url screen_name:(NSString *)screen_name {
	UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
	
	NSLog(@"%f,%f",image.size.width,image.size.height);
	
	// Let's save the file into Document folder.
	// You can also change this to your desktop for testing. (e.g. /Users/kiichi/Desktop/)
	//NSString *deskTopDir = @"/Users/doug/Desktop/";
	
	NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	
	// If you go to the folder below, you will find those pictures
	NSLog(@"%@",docDir);
	
	NSLog(@"saving png");
	NSString *pngFilePath = [NSString stringWithFormat:@"%@/%@.png",docDir,screen_name];
	NSData *data1 = [NSData dataWithData:UIImagePNGRepresentation(image)];
	[data1 writeToFile:pngFilePath atomically:YES];
	
	/*NSLog(@"saving jpeg");
	NSString *jpegFilePath = [NSString stringWithFormat:@"%@/test.jpeg",docDir];
	NSData *data2 = [NSData dataWithData:UIImageJPEGRepresentation(image, 1.0f)];//1.0f = 100% quality
	[data2 writeToFile:jpegFilePath atomically:YES];*/
	
	NSLog(@"saving image done");
	
	[image release];
}



@end
