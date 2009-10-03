//
//  UserTextEntryViewController.h
//  hLog
//
//  Created by Bhoomi on 3/9/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

// Import All needed header files bellow.
#import <UIKit/UIKit.h>
#import "HealthTrackerAppDelegate.h"

// Defining Interface  with needed Protocol (if any).
// Protocols generally define inside '< >'bracates.
@interface UserTextEntryViewController : UIViewController <UITextViewDelegate,UITextFieldDelegate>
{
	
	/* 
	 Tools That you have used in xib file, need to bind with its controller file.
	 This is done by Declaring tool with IBOutlet as Prefix.
	 
	 Tools That you haven't used in xib but used in controller file, need not to bind with xib,
	 such tools do not have IBOutlet as Prefix.
	 
	 Declaration of all global variables and objects also here.
	 */
	
	IBOutlet UITextView *txtView;
	IBOutlet UIBarButtonItem *btnCancel;
	IBOutlet UIBarButtonItem *btnDone;
	int selectedIndex;
	NSString *selectedName;
	HealthTrackerAppDelegate *appDelegate;
	NSString *TextData;
	IBOutlet UITableViewCell *Cell1;
	IBOutlet UIButton *Cell2;
	IBOutlet UITextField *txtField;
	NSString *Data1;
	UILabel *label1;
	int MED_ID;
	BOOL ISEmail;
	
}

@property(nonatomic,retain) NSString *Data1;
@property(nonatomic,readwrite) int MED_ID;
// Defining Property as per fields, tools, variables and objects.
@property(nonatomic, readwrite)int selectedIndex;
@property(nonatomic, retain)NSString *selectedName;
@property(nonatomic, retain)NSString *TextData;

// Declaration of all Public methods that are going to implement inside implementation file, need to declare here.
-(IBAction)Done:(id)sender;
-(IBAction)Cancel:(id)sender;
-(void)StoreData;
-(void)ShowAlert:(NSString *)Message;
@end
