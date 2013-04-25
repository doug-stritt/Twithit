//
//  BioViewController.h
//  TwitHit
//
//  Created by Doug Strittmatter on 6/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "XAuthTwitterEngineDelegate.h"

@class XAuthTwitterEngine;

@interface BioViewController : UIViewController <UIAlertViewDelegate,XAuthTwitterEngineDelegate> {
	
	XAuthTwitterEngine *_engine;
	int intRow;
	IBOutlet UILabel *lblLocation;
	IBOutlet UILabel *lblScreenName;
	IBOutlet UILabel *lblName;
	IBOutlet UILabel *lblWebsite;
	IBOutlet UITextView *txtDescription;
	IBOutlet UIImageView *imgProfile;
	IBOutlet UIBarButtonItem *btnBack;
	NSDictionary *dictNewFriend;
}

@property int intRow;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andDictFriend:(NSDictionary*)dictFriend;
- (IBAction)backButtonAction;
- (IBAction)deleteButtonAction;
- (IBAction)profileButtonAction;

@end
