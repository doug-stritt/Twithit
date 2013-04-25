//
//  BioViewController.m
//  TwitHit
//
//  Created by Doug Strittmatter on 6/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BioViewController.h"
#import "FriendsListViewController.h"
#import "XAuthTwitterEngine.h"
#import "Constants.h"

@implementation BioViewController

@synthesize intRow;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andDictFriend:(NSDictionary *)dictFriend {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		dictNewFriend = dictFriend;
		
		
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	_engine = [[XAuthTwitterEngine alloc] initXAuthWithDelegate:self];
	_engine.consumerKey = kOAuthConsumerKey;
	_engine.consumerSecret = kOAuthConsumerSecret;
	
	[txtDescription setFont:[UIFont fontWithName:@"Helvetica" size:12]];
	
	lblScreenName.text = [NSString stringWithFormat:@"@%@",[dictNewFriend valueForKey:@"screen_name"]];
	lblName.text = [dictNewFriend valueForKey:@"name"];
	
	NSString *strLocation = [dictNewFriend valueForKey:@"location"];
	if ([strLocation length] > 0) {
		lblLocation.text = [dictNewFriend valueForKey:@"location"];
	} else {
		lblLocation.text = @"Not Available";
	}
	
	NSString *strWebsite = [dictNewFriend valueForKey:@"url"];
	if ([strWebsite length] > 0) {
		lblWebsite.text = [dictNewFriend valueForKey:@"url"];
	} else {
		lblWebsite.text = @"Not Available";
	}
	
	NSString *strDescription = [dictNewFriend valueForKey:@"description"];
	if ([strDescription length] > 0) {
		txtDescription.text = [dictNewFriend valueForKey:@"description"];
	} else {
		txtDescription.text = @"Not Available";
	}
	NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *pngFilePath = [NSString stringWithFormat:@"%@/%@.png",docDir,[dictNewFriend valueForKey:@"screen_name"]];
	imgProfile.image = [UIImage imageWithContentsOfFile:pngFilePath];
	//NSURL* url = [NSURL URLWithString:[dictNewFriend valueForKey:@"profile_image_url"]];
	//imgProfile.image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
}


- (IBAction)backButtonAction {
	// get the view that's currently showing
	UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view view
	UIView *theWindow = [currentView superview];
	
	// remove the current view and replace with myView1
	[currentView removeFromSuperview];
	
	// set up an animation for the transition between the views
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.5];
	[animation setType:kCATransitionPush];
	[animation setSubtype:kCATransitionFromLeft];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[theWindow layer] addAnimation:animation forKey:@"SwitchToView1"];
}


- (IBAction)profileButtonAction
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://mobile.twitter.com/%@", [dictNewFriend valueForKey:@"screen_name"]]]];
}


- (IBAction)deleteButtonAction
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete Friend" 
													message:@"Are you sure you want to delete this friend?"
												   delegate:self 
										  cancelButtonTitle:@"Cancel" 
										  otherButtonTitles:nil];
	[alert addButtonWithTitle:@"OK"];
	[alert show];
	[alert release];
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
		
		if ([_engine isAuthorized])
		{
			NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
			// create new array if there isn't one
			if ([[NSUserDefaults standardUserDefaults] objectForKey: @"friendsList"]) {
				// retrieve stored friends list
				NSData *friendData = [defaults objectForKey:@"friendsList"];
				NSMutableArray *arrFriendsList = [[NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:friendData]] retain];			
			
				for (NSDictionary *dictFriend in arrFriendsList)
				{
					if ([(NSString*)[dictNewFriend valueForKey:@"name"] isEqualToString:(NSString *)[dictFriend valueForKey:@"name"]]) {
						
						[arrFriendsList removeObjectIdenticalTo:dictFriend];
						
						// store new friends list
						NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrFriendsList];
						[defaults setObject:data forKey:@"friendsList"];
						[defaults synchronize];
						
						[[NSNotificationCenter defaultCenter]
						 postNotificationName: @"ReloadFriendsList"
						 object: nil];
						
						break;
					}
				}
			}
			
			[self unfollowFriend];
			[self backButtonAction];
		} else {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable to delete friend" 
															message:@"Please login to Twitter to delete friends."
														   delegate:nil 
												  cancelButtonTitle:@"OK" 
												  otherButtonTitles:nil];
			[alert show];
			[alert release];
		}

		
    }
}


- (void)unfollowFriend
{	
	/*spinner = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhite] autorelease];
	spinner.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2 - 20);
	[self.view addSubview: spinner];
	[spinner startAnimating];
	btnBack.enabled = NO;*/
	
	
	[_engine disableUpdatesFor:[dictNewFriend valueForKey:@"screen_name"]];
	
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


#pragma mark -
#pragma mark TwitterEngineDelegate methods

- (void)userInfoReceived:(NSArray *)userInfo forRequest:(NSString *)identifier
{
    NSLog(@"Got user info:\r%@", userInfo);
	dictNewFriend = [userInfo objectAtIndex:0];
	
	int requestType = [[dictNewFriend objectForKey:@"source_api_request_type"] intValue];
	
	if (requestType == 18) {
		// deleted friend
		NSLog(@"deleted friend");
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"@%@ Unfollowed",[dictNewFriend objectForKey:@"screen_name"]]
														message:[NSString stringWithFormat:@"You're no longer following @%@ on Twitter.",[dictNewFriend objectForKey:@"screen_name"]]
													   delegate:nil 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}	
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
