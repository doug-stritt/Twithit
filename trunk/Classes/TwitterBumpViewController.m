//
//  TwitterBumpViewController.m
//  TwitterBump
//
//  Created by Doug Strittmatter on 5/25/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "TwitterBumpViewController.h"
#import "Constants.h"
#import "BioViewController.h"
#import "XAuthTwitterEngine.h"
#import "UIAlertView+Helper.h"
#import "OAToken.h"

@implementation TwitterBumpViewController

@synthesize bumpConn,_engine;

-(IBAction) startBumpButtonPress {

	if ([_engine isAuthorized]) {
		if (!bumpConn) {
			bumpConn = [[[TwitterBumpConnector alloc] init] retain];
		}
		btnBump.hidden = YES;
		[[NSNotificationCenter defaultCenter]
		 postNotificationName: @"StartActivityViewer"
		 object: nil];
		[[NSNotificationCenter defaultCenter]
		 postNotificationName: @"ToggleTabBarDisabled"
		 object: nil];
		[bumpConn startBump];
	} else {
		XAuthTwitterViewController *xauthController = [[XAuthTwitterViewController alloc] init];
		[self presentModalViewController: xauthController animated: YES];

	}
	
}


-(IBAction) loginButtonPress {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject: nil forKey: @"authData"];
	[defaults synchronize];
	
	XAuthTwitterViewController *xauthController = [[XAuthTwitterViewController alloc] init];
	[self presentModalViewController: xauthController animated: YES];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	
	_engine = [[XAuthTwitterEngine alloc] initXAuthWithDelegate:self];
	_engine.consumerKey = kOAuthConsumerKey;
	_engine.consumerSecret = kOAuthConsumerSecret;
	
	if (![_engine isAuthorized])
	{
		XAuthTwitterViewController *xauthController = [[XAuthTwitterViewController alloc] init];
		[self presentModalViewController: xauthController animated: YES];
	}
	
	
	if ([[NSUserDefaults standardUserDefaults] stringForKey: @"username"]) {
		lblScreenName.text = [NSString stringWithFormat:@"@%@",[[NSUserDefaults standardUserDefaults] objectForKey: @"username"]];
		[btnLogin setTitle:@"Logout"];
	}

	
	
	[[NSNotificationCenter defaultCenter] addObserver: self
											 selector:@selector(twitterSucceeded:)
												 name: @"TwitterSucceeded"
											   object: username];
	[[NSNotificationCenter defaultCenter] addObserver: self
											 selector:@selector(twitterFailed:)
												 name: @"TwitterFailed"
											   object: nil];
	[[NSNotificationCenter defaultCenter] addObserver: self
											 selector:@selector(startActivityViewer:)
												 name: @"StartActivityViewer"
											   object: nil];
	[[NSNotificationCenter defaultCenter] addObserver: self
											 selector:@selector(stopActivityViewer:)
												 name: @"StopActivityViewer"
											   object: nil];
	[[NSNotificationCenter defaultCenter] addObserver: self
											 selector:@selector(bumpFailed:)
												 name: @"BumpFailed"
											   object: nil];
	[[NSNotificationCenter defaultCenter] addObserver: self
											 selector:@selector(loginLabel:)
												 name: @"LoginLabel"
											   object: username];
}


- (void)twitterSucceeded:(NSNotification *)aNotification {
	btnBump.hidden = NO;
	activityIndicatorContainer.hidden = YES;
	[spinner stopAnimating];
	 
	
	[[NSNotificationCenter defaultCenter]
	 postNotificationName: @"SwitchTab"
	 object: nil];
	
	[[NSNotificationCenter defaultCenter]
	 postNotificationName: @"NotificationLoadBio"
	 object: (NSDictionary*)[aNotification object]];
}


- (void)twitterFailed:(NSNotification *)aNotification {
	imgMigrating.hidden = NO;
	btnBump.hidden = NO;
	activityIndicatorContainer.hidden = YES;
	[spinner stopAnimating];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable to add friend" message:@"Twitter is busy or has lost your connection."
												   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}


- (void)bumpFailed:(NSNotification *)aNotification {
	activityIndicatorContainer.hidden = YES;
	[spinner stopAnimating];
	btnBump.hidden = NO;
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


- (void)startActivityViewer:(NSNotification *)aNotification {
	btnBump.hidden = YES;
	spinner = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge] autorelease];
	spinner.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2 + 100);
	activityIndicatorContainer.hidden = NO;
	[self.view addSubview: spinner];
	[spinner startAnimating];
}


- (void)loginLabel:(NSNotification *)aNotification {
	lblScreenName.text = [NSString stringWithFormat:@"@%@",[[NSUserDefaults standardUserDefaults] objectForKey: @"username"]];
	[btnLogin setTitle:@"Logout"];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


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
}


-(void)applicationWillTerminate:(UIApplication *)application{
	[bumpConn stopBump];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
