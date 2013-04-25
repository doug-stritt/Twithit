//
//  TwitterFeedViewController.h
//  TwitHit
//
//  Created by Doug Strittmatter on 6/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SA_OAuthTwitterController.h"
#import "MGTwitterEngine.h"
#import	"SA_OAuthTwitterEngine.h"

@interface TwitterFeedViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SA_OAuthTwitterControllerDelegate, MGTwitterEngineDelegate, SA_OAuthTwitterEngineDelegate> {
	SA_OAuthTwitterEngine *_engine;
	int responseCount;
	NSMutableArray *arrStatusList;
	UIActivityIndicatorView	*spinner;
	IBOutlet UITableView *statusTableView;
}

@property (nonatomic, retain) NSMutableArray *arrStatusList;
@property (nonatomic, retain) NSMutableArray *sectionsArray;
@property (nonatomic, retain) IBOutlet UITableView *statusTableView;

- (void)configureSections;
- (void)getTwitterStatuses;


@end
