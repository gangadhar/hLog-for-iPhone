//
//  FirstViewController.h
//  hLog
//
//  Created by Bhoomi on 3/30/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectSettingsViewController.h"
#import "HealthTrackerAppDelegate.h"
#import "AddNewUserController.h" 
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"
#import "ContactViewController.h"
#import "UserTextEntryViewController.h"
#import "SelectViewController.h"

@interface FirstViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,SKPSMTPMessageDelegate>{

	IBOutlet UITableView *tblView;
	AddNewUserController *AddNewUser;
	HealthTrackerAppDelegate *appDelegate;
	IBOutlet UIBarButtonItem *btnSend;
	//Outlet UIToolbar *toolbar;
	IBOutlet UIActivityIndicatorView *activity;
	IBOutlet UILabel *lblmessage;
	ContactViewController *objContactViewController;
	NSTimer *time;
	BOOL isSendSuccessfull;
	NSDateFormatter *dateFormatter;
	
}



-(IBAction)btnSend_Click:(id)sender;

@end
