//
//  SelectViewController.h
//  HealthTracker
//
//  Created by MAC02 on 8/27/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthTrackerAppDelegate.h"
#import "AddNewUserController.h"
@interface SelectViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>{

	IBOutlet UITableView *tblView;
	HealthTrackerAppDelegate *appDelegate;
	NSMutableArray *EmailArray;
	//Outlet UIBarButtonItem *btnSave; 
	NSString *selectedemail;
	int row;
	int Section;
	int SelectedIndexRow;
	int USER_ID;
	AddNewUserController *AddNewUser;
}

@property(nonatomic,retain) NSMutableArray *EmailArray;
@property(nonatomic,readwrite) int SelectedIndexRow;
@property(nonatomic,readwrite) int USER_ID;


@end
