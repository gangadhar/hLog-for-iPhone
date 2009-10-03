//
//  EnterPasscodeViewController.h
//  hLog
//
//  Created by Bhoomi on 3/18/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthTrackerAppDelegate.h"

@interface EnterPasscodeViewController : UIViewController <UITextFieldDelegate>
{
	IBOutlet UITextField *txtPassword;
	IBOutlet UITextField *txtRetypePassword;
	IBOutlet UITextField *txtOldPassword;
	
	IBOutlet UILabel *lblPassword;
	IBOutlet UILabel *lblRetypePassword;
	IBOutlet UILabel *lblOldPassword;
	IBOutlet UIBarButtonItem *btnSave;
	HealthTrackerAppDelegate *appDelegate;
	BOOL Flag;
	UITextField *SelectedText;
}

@property(nonatomic,readwrite) BOOL Flag;

-(IBAction)btnSave_click:(id)sender;

@end

