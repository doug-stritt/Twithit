//
//  TwitterFeedViewController.m
//  TwitHit
//
//  Created by Doug Strittmatter on 6/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TwitterFeedViewController.h"
#import "SA_OAuthTwitterEngine.h"
#import "Constants.h"

@implementation TwitterFeedViewController

@synthesize arrStatusList, statusTableView;


#pragma mark -
#pragma mark Initialization


//=============================================================================================================================
#pragma mark ViewController Stuff

- (void) viewDidAppear: (BOOL)animated {
	
	if (_engine) return;
	_engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate: self];
	_engine.consumerKey = kOAuthConsumerKey;
	_engine.consumerSecret = kOAuthConsumerSecret;
	responseCount = 0;
	
	
	statusTableView.backgroundColor = [UIColor clearColor];
	statusTableView.separatorColor = [UIColor clearColor];
	
	spinner = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhite] autorelease];
	spinner.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2 + 10);
	[self.view addSubview: spinner];
	[spinner startAnimating];
	
	UIViewController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine: _engine delegate: self];
	
	if (controller) {
		[self presentModalViewController: controller animated: YES];
	} else {
		[self getTwitterStatuses];
	}
	
}


#pragma mark -
#pragma mark Table view datasource and delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
	// Number of sections is the number of regions
	return 1;
}


- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
	return [arrStatusList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *MyIdentifier = @"MyIdentifier";
	
	
	// Try to retrieve from the table view a now-unused cell with the given identifier.
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	
	// If no cell is available, create a new one using the given identifier.
	if (cell == nil) {
		// Use the default cell style.
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		UIImageView *imgBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"status_bg.png"]];
		[cell.contentView addSubview:imgBackground];
		//cell.backgroundColor = [UIColor clearColor];
		[imgBackground release];
		
		UILabel *nameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(128.0, -30.0, 150.0, 18.0)] autorelease];		
		nameLabel.tag = 2;		
		nameLabel.font = [UIFont boldSystemFontOfSize:14.0];
		nameLabel.textColor = [UIColor whiteColor];
		nameLabel.backgroundColor = [UIColor clearColor];
		nameLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;		
		[cell.contentView addSubview:nameLabel];
		
		UITextView *textViewStatus = [[[UITextView alloc] initWithFrame:CGRectMake(120.0, 25.0, 170.0, 98.0)] autorelease];		
		textViewStatus.tag = 3;		
		textViewStatus.font = [UIFont systemFontOfSize:12.0];
		textViewStatus.textColor = [UIColor whiteColor];
		textViewStatus.backgroundColor = [UIColor clearColor];
		textViewStatus.userInteractionEnabled = NO; 
		//textViewStatus.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;		
		[cell.contentView addSubview:textViewStatus];
		
		UIImageView *profileImage = [[[UIImageView alloc] initWithFrame:CGRectMake(45.0, 17.0, 73.0, 73.0)] autorelease];
		profileImage.tag = 5;
		[cell.contentView addSubview:profileImage];
	}
	
	UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:2];
	UITextView *textViewStatus = (UITextView *)[cell.contentView viewWithTag:3];
	UIImageView *profileImage = (UIImageView *)[cell.contentView viewWithTag:5];

	// Set up the cell.
	NSDictionary *dictStatus = [arrStatusList objectAtIndex:indexPath.row];
	NSDictionary *dictUser = [dictStatus objectForKey:@"user"];
	nameLabel.text = [dictUser objectForKey:@"screen_name"];
	textViewStatus.text = [dictStatus objectForKey:@"text"];
	NSURL* url = [NSURL URLWithString:[dictUser valueForKey:@"profile_image_url"]];
	profileImage.image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
	
	return cell;
}




- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {		
	cell.backgroundColor = [UIColor clearColor];		
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return 135;
}


/*
 To conform to Human Interface Guildelines, since selecting a row would have no effect (such as navigation), make sure that rows cannot be selected.
 */
/*- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 return nil;
 }*/


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
#pragma mark SA_OAuthTwitterControllerDelegate
- (void) OAuthTwitterController: (SA_OAuthTwitterController *) controller authenticatedWithUsername: (NSString *) username {
	NSLog(@"Authenicated for %@", username);
	[self getTwitterFriends];
}

- (void) OAuthTwitterControllerFailed: (SA_OAuthTwitterController *) controller {
	NSLog(@"Authentication Failed!");
}

- (void) OAuthTwitterControllerCanceled: (SA_OAuthTwitterController *) controller {
	NSLog(@"Authentication Canceled.");
}


//=============================================================================================================================
#pragma mark TwitterEngineDelegate
- (void) requestSucceeded: (NSString *) requestIdentifier {
	NSLog(@"Request %@ succeeded", requestIdentifier);
}


- (void) requestFailed: (NSString *) requestIdentifier withError: (NSError *) error {
	NSLog(@"Request %@ failed with error: %@", requestIdentifier, error);
	[spinner stopAnimating];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Failed" message:@"Please check your network settings and try again."
												   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}


- (void)statusesReceived:(NSArray *)statuses forRequest:(NSString *)identifier
{
    NSLog(@"Got statuses:\r%@", statuses);
	
	[spinner stopAnimating];
	
	arrStatusList = [[NSMutableArray arrayWithArray:statuses] retain];
	
	[statusTableView reloadData];
}


- (void)directMessagesReceived:(NSArray *)messages forRequest:(NSString *)identifier
{
    NSLog(@"Got direct messages:\r%@", messages);
}


- (void)userInfoReceived:(NSArray *)userInfo forRequest:(NSString *)identifier
{
    NSLog(@"Got user info:\r%@", userInfo);
	
}


- (void)getTwitterStatuses {
	[_engine getFollowedTimelineSinceID:nil 
						 startingAtPage:1 
								  count:25];
}


- (void)dealloc {
	[_engine release];
    [super dealloc];
}


@end
