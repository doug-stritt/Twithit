//
//  FriendsListViewController.m
//  OAuthTwitterDemo
//
//  Created by Doug Strittmatter on 6/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FriendsListViewController.h"
#import "SA_OAuthTwitterEngine.h"
#import "Constants.h"
#import "BioViewController.h"


@implementation FriendsListViewController


@synthesize arrFriends, arrFriendsList, sectionsArray, collation, friendsTableView;



#pragma mark -
#pragma mark Initialization


//=============================================================================================================================
#pragma mark ViewController Stuff

-(void) viewDidLoad
{
	[super viewDidLoad];
	
	[[NSNotificationCenter defaultCenter] addObserver: self
											 selector:@selector(reloadFriendsList:)
												 name: @"ReloadFriendsList"
											   object: nil];
	
	[[NSNotificationCenter defaultCenter] addObserver: self
											 selector:@selector(loadBio:)
												 name: @"NotificationLoadBio"
											   object: nil];
	[self loadFriends];
}


- (void) viewDidAppear: (BOOL)animated {
	
	/*sectionsArray = [[NSMutableArray alloc] init];
	sectionsArrayAlphabet = [[NSMutableArray alloc] init];
	
	sectionsArrayAlphabetAll = [[NSMutableArray alloc] init];
	[sectionsArrayAlphabetAll addObject:@"A"];
	[sectionsArrayAlphabetAll addObject:@"B"];
	[sectionsArrayAlphabetAll addObject:@"C"];
	[sectionsArrayAlphabetAll addObject:@"D"];
	[sectionsArrayAlphabetAll addObject:@"E"];
	[sectionsArrayAlphabetAll addObject:@"F"];
	[sectionsArrayAlphabetAll addObject:@"G"];
	[sectionsArrayAlphabetAll addObject:@"H"];
	[sectionsArrayAlphabetAll addObject:@"I"];
	[sectionsArrayAlphabetAll addObject:@"J"];
	[sectionsArrayAlphabetAll addObject:@"K"];
	[sectionsArrayAlphabetAll addObject:@"L"];
	[sectionsArrayAlphabetAll addObject:@"M"];
	[sectionsArrayAlphabetAll addObject:@"N"];
	[sectionsArrayAlphabetAll addObject:@"O"];
	[sectionsArrayAlphabetAll addObject:@"P"];
	[sectionsArrayAlphabetAll addObject:@"Q"];
	[sectionsArrayAlphabetAll addObject:@"R"];
	[sectionsArrayAlphabetAll addObject:@"S"];
	[sectionsArrayAlphabetAll addObject:@"T"];
	[sectionsArrayAlphabetAll addObject:@"U"];
	[sectionsArrayAlphabetAll addObject:@"V"];
	[sectionsArrayAlphabetAll addObject:@"W"];
	[sectionsArrayAlphabetAll addObject:@"X"];
	[sectionsArrayAlphabetAll addObject:@"Y"];
	[sectionsArrayAlphabetAll addObject:@"Z"];
	
	[self getTwitterFriends];
	NSLog(@"arrFriends count %i", [arrFriendsList count]);
	for (NSString *letter in sectionsArrayAlphabetAll)
	{
		//NSString *currentLetter = [NSString stringWithFormat:@"%@", sectionsArrayAlphabet objectAtIndex:letterCount];
		NSMutableArray *friendsAlphabetArray = [[NSMutableArray alloc] init];
		
		for (NSMutableDictionary *dictFriend in arrFriendsList)
		{
			NSString *currentName = [NSString stringWithFormat:@"%@", [dictFriend objectForKey:@"name"]];
			NSLog(@"currentName %@",[[currentName substringToIndex:1] capitalizedString]);
			if ([letter isEqualToString:[[currentName substringToIndex:1] capitalizedString]]) {
				[friendsAlphabetArray addObject:dictFriend];
			}
			
		}
		
		if ([friendsAlphabetArray count] > 0) {
			letterCount++;
			[sectionsArrayAlphabet addObject:letter];
		
			NSDictionary *friendsAlphabetDict = [[NSDictionary dictionaryWithObject:friendsAlphabetArray 
																		forKey:letter] retain];
			[sectionsArray addObject:friendsAlphabetDict];
			//[friendsAlphabetArray release];
		}
		
	}
	
	[friendsTableView reloadData];*/
}


-(void) loadFriends
{
	sectionsArray = [[NSMutableArray alloc] init];
	sectionsArrayAlphabet = [[NSMutableArray alloc] init];
	
	sectionsArrayAlphabetAll = [[NSMutableArray alloc] init];
	[sectionsArrayAlphabetAll addObject:@"A"];
	[sectionsArrayAlphabetAll addObject:@"B"];
	[sectionsArrayAlphabetAll addObject:@"C"];
	[sectionsArrayAlphabetAll addObject:@"D"];
	[sectionsArrayAlphabetAll addObject:@"E"];
	[sectionsArrayAlphabetAll addObject:@"F"];
	[sectionsArrayAlphabetAll addObject:@"G"];
	[sectionsArrayAlphabetAll addObject:@"H"];
	[sectionsArrayAlphabetAll addObject:@"I"];
	[sectionsArrayAlphabetAll addObject:@"J"];
	[sectionsArrayAlphabetAll addObject:@"K"];
	[sectionsArrayAlphabetAll addObject:@"L"];
	[sectionsArrayAlphabetAll addObject:@"M"];
	[sectionsArrayAlphabetAll addObject:@"N"];
	[sectionsArrayAlphabetAll addObject:@"O"];
	[sectionsArrayAlphabetAll addObject:@"P"];
	[sectionsArrayAlphabetAll addObject:@"Q"];
	[sectionsArrayAlphabetAll addObject:@"R"];
	[sectionsArrayAlphabetAll addObject:@"S"];
	[sectionsArrayAlphabetAll addObject:@"T"];
	[sectionsArrayAlphabetAll addObject:@"U"];
	[sectionsArrayAlphabetAll addObject:@"V"];
	[sectionsArrayAlphabetAll addObject:@"W"];
	[sectionsArrayAlphabetAll addObject:@"X"];
	[sectionsArrayAlphabetAll addObject:@"Y"];
	[sectionsArrayAlphabetAll addObject:@"Z"];
	
	[self getTwitterFriends];
	NSLog(@"arrFriends count %i", [arrFriendsList count]);
	for (NSString *letter in sectionsArrayAlphabetAll)
	{
		//NSString *currentLetter = [NSString stringWithFormat:@"%@", sectionsArrayAlphabet objectAtIndex:letterCount];
		NSMutableArray *friendsAlphabetArray = [[NSMutableArray alloc] init];
		
		for (NSMutableDictionary *dictFriend in arrFriendsList)
		{
			NSString *currentName = [NSString stringWithFormat:@"%@", [dictFriend objectForKey:@"name"]];
			NSLog(@"currentName %@",[[currentName substringToIndex:1] capitalizedString]);
			if ([letter isEqualToString:[[currentName substringToIndex:1] capitalizedString]]) {
				[friendsAlphabetArray addObject:dictFriend];
			}
			
		}
		
		if ([friendsAlphabetArray count] > 0) {
			letterCount++;
			[sectionsArrayAlphabet addObject:letter];
			
			NSDictionary *friendsAlphabetDict = [[NSDictionary dictionaryWithObject:friendsAlphabetArray 
																			 forKey:letter] retain];
			[sectionsArray addObject:friendsAlphabetDict];
			//[friendsAlphabetArray release];
		}
		
	}
	
	[friendsTableView reloadData];
}


#pragma mark -
#pragma mark Table view datasource and delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
	// Number of sections is the number of regions
	//return letterCount;
	return [sectionsArray count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

	return [sectionsArrayAlphabet objectAtIndex:section];
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {

	return sectionsArrayAlphabetAll;
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
	
	return index;
}


- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {

	NSDictionary *dictLetter = [sectionsArray objectAtIndex:section];
	NSArray *arrayLetter = [dictLetter objectForKey:[sectionsArrayAlphabet objectAtIndex:section]];
	return [arrayLetter count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *MyIdentifier = @"MyIdentifier";
	
	// Try to retrieve from the table view a now-unused cell with the given identifier.
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	
	// If no cell is available, create a new one using the given identifier.
	if (cell == nil) {
		// Use the default cell style.
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
		
		// disable cell highlight
		//cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		/*UIImageView *imgBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bio_bg_noarrow.png"]];
		[cell.contentView addSubview:imgBackground];
		[imgBackground release];
		
		UILabel *screenNameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(144.0, 33.0, 150.0, 18.0)] autorelease];		
		screenNameLabel.tag = 1;		
		screenNameLabel.font = [UIFont systemFontOfSize:12.0];		
		screenNameLabel.textColor = [UIColor whiteColor];
		screenNameLabel.backgroundColor = [UIColor clearColor];		
		screenNameLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;		
		[cell.contentView addSubview:screenNameLabel];*/
		
		UILabel *nameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(100.0, 14.0, 200.0, 18.0)] autorelease];		
		nameLabel.tag = 2;		
		nameLabel.font = [UIFont boldSystemFontOfSize:18.0];
		[nameLabel setHighlightedTextColor:[UIColor whiteColor]];
		nameLabel.backgroundColor = [UIColor clearColor];
		nameLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;		
		[cell.contentView addSubview:nameLabel];
		
		/*UILabel *locLabel = [[[UILabel alloc] initWithFrame:CGRectMake(128.0, -10.0, 150.0, 18.0)] autorelease];		
		locLabel.tag = 3;		
		locLabel.font = [UIFont systemFontOfSize:12.0];
		locLabel.textColor = [UIColor whiteColor];
		locLabel.backgroundColor = [UIColor clearColor];
		locLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;		
		[cell.contentView addSubview:locLabel];
		
		UILabel *urlLabel = [[[UILabel alloc] initWithFrame:CGRectMake(128.0, 5.0, 150.0, 18.0)] autorelease];		
		urlLabel.tag = 4;		
		urlLabel.font = [UIFont systemFontOfSize:12.0];
		urlLabel.textColor = [UIColor cyanColor];
		urlLabel.backgroundColor = [UIColor clearColor];
		urlLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;		
		[cell.contentView addSubview:urlLabel];*/
		
		UIImageView *profileImage = [[[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 48.0, 48.0)] autorelease];
		profileImage.tag = 5;
		[cell.contentView addSubview:profileImage];
	}
	
	UILabel *screenNameLabel = (UILabel *)[cell.contentView viewWithTag:1];
	UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:2];
	UILabel *locLabel = (UILabel *)[cell.contentView viewWithTag:3];
	UILabel *urlLabel = (UILabel *)[cell.contentView viewWithTag:4];
	UIImageView *profileImage = (UIImageView *)[cell.contentView viewWithTag:5];

	// Set up the cell.
	//NSDictionary *dictFriend = [arrFriendsList objectAtIndex:indexPath.row];
	NSDictionary *dictLetter = [sectionsArray objectAtIndex:indexPath.section];
	NSArray *arrayLetter = [dictLetter objectForKey:[sectionsArrayAlphabet objectAtIndex:indexPath.section]];
	NSDictionary *dictFriend = [arrayLetter objectAtIndex:indexPath.row];
	screenNameLabel.text = [dictFriend valueForKey:@"screen_name"];
	nameLabel.text = [dictFriend objectForKey:@"name"];
	locLabel.text = [dictFriend objectForKey:@"location"];
	urlLabel.text = [dictFriend objectForKey:@"url"];
	
	NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *pngFilePath = [NSString stringWithFormat:@"%@/%@.png",docDir,[dictFriend valueForKey:@"screen_name"]];
	NSString *genericFilePath = [NSString stringWithFormat:@"%@/Tweet.png",docDir];

	if (![UIImage imageWithContentsOfFile:pngFilePath]) {
		
		profileImage.image = [UIImage imageWithContentsOfFile:genericFilePath];
		
		UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dictFriend valueForKey:@"profile_image_url"]]]];
		
		NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
		
		NSString *pngFilePath = [NSString stringWithFormat:@"%@/%@.png",docDir,[dictFriend valueForKey:@"screen_name"]];
		NSData *data1 = [NSData dataWithData:UIImagePNGRepresentation(image)];
		[data1 writeToFile:pngFilePath atomically:YES];
		
		[image release];
		
		profileImage.image = [UIImage imageWithContentsOfFile:pngFilePath];
		
		//NSURL* url = [NSURL URLWithString:[dictFriend valueForKey:@"profile_image_url"]];
		//profileImage.image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
	} else {
		profileImage.image = [UIImage imageWithContentsOfFile:pngFilePath];
	}
	
	//NSLog(@"arrFriendsList %@", arrFriendsList);
	//NSLog(@"dictFriend %@", [dictFriend valueForKey:@"screen_name"]);
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSDictionary *dictLetter = [sectionsArray objectAtIndex:indexPath.section];
	NSArray *arrayLetter = [dictLetter objectForKey:[sectionsArrayAlphabet objectAtIndex:indexPath.section]];
	NSDictionary *dictFriend = [arrayLetter objectAtIndex:indexPath.row];
	
	BioViewController *bioViewController = [[BioViewController alloc] initWithNibName:@"BioViewController" 
																			   bundle:nil 
																		andDictFriend:dictFriend];

	// get the view that's currently showing
	UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view view
	UIView *theWindow = [currentView superview];
	
	// remove the current view and replace with myView1
	[currentView addSubview:bioViewController.view];
	
	// set up an animation for the transition between the views
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.5];
	[animation setType:kCATransitionPush];
	[animation setSubtype:kCATransitionFromRight];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[theWindow layer] addAnimation:animation forKey:@"SwitchToView1"];
	
	[tableView  deselectRowAtIndexPath:indexPath  animated:YES]; 
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {		
	//cell.backgroundColor = [UIColor clearColor];		
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return 48;
}




/*
 To conform to Human Interface Guildelines, since selecting a row would have no effect (such as navigation), make sure that rows cannot be selected.
 */
/*- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}*/


- (void)getTwitterFriends {
	
	if (spinner) {
		[spinner stopAnimating];
	} 
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	// create new array if there isn't one
	if ([[NSUserDefaults standardUserDefaults] objectForKey: @"friendsList"]) {
		// retrieve stored friends list
		NSData *friendData = [defaults objectForKey:@"friendsList"];
		arrFriendsList = [[NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:friendData]] retain];			
	} 
}


- (void)reloadFriendsList:(NSNotification *)aNotification; {
	[self loadFriends];
	[friendsTableView reloadData];
}


-(void) loadBio:(NSNotification*)aNotification
{
	BioViewController *bioViewController = [[BioViewController alloc] initWithNibName:@"BioViewController" 
																			   bundle:nil 
																		andDictFriend:(NSDictionary*)[aNotification object]];
	
	// get the view that's currently showing
	UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view view
	UIView *theWindow = [currentView superview];
	
	// remove the current view and replace with myView1
	[currentView addSubview:bioViewController.view];
	
	// set up an animation for the transition between the views
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.5];
	[animation setType:kCATransitionPush];
	[animation setSubtype:kCATransitionFromRight];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[theWindow layer] addAnimation:animation forKey:@"SwitchToView1"];
}


- (void)dealloc {
	[sectionsArrayAlphabet release];
	[sectionsArray release];
    [super dealloc];
}


@end
