//
//  UnitsViewController.h
//  hLog
//
//  Created by Bhoomi on 3/30/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthTrackerAppDelegate.h"
#import "EnterPasscodeViewController.h"
@interface UnitsViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate>
{
	IBOutlet UITableView *tblView;
	EnterPasscodeViewController *PasscodeSettingsView;
	HealthTrackerAppDelegate *appDelegate;
	UITextField *tf;
	UIAlertView *alert1;
}


-(void)termCondition;

@end
