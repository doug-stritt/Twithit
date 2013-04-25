//
//  FriendsListViewController.h
//  OAuthTwitterDemo
//
//  Created by Doug Strittmatter on 6/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>

@interface FriendsListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	int responseCount;
	int letterCount;
	NSArray *arrFriends;
	NSMutableArray *arrFriendsList;
	NSMutableArray *sectionsArray;
	NSMutableArray *sectionsArrayAlphabetAll;
	NSMutableArray *sectionsArrayAlphabet;
	UILocalizedIndexedCollation *collation;
	UINavigationBar *navBar;
	UIActivityIndicatorView	*spinner;
	IBOutlet UITableView *friendsTableView;
}

@property (nonatomic, retain) NSArray *arrFriends;
@property (nonatomic, retain) NSMutableArray *arrFriendsList;
@property (nonatomic, retain) NSMutableArray *sectionsArray;
@property (nonatomic, retain) UILocalizedIndexedCollation *collation;
@property (nonatomic, retain) IBOutlet UITableView *friendsTableView;


- (void)configureSections;
- (void)getTwitterFriends;
- (void)reloadFriendsList:(NSNotification *)aNotification;


@end