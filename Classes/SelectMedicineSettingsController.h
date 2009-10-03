//
//  SelectMedicineSettingsController.h
//  hLog
//
//  Created by Bhoomi on 3/12/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//


// Import All needed header files bellow.
#import <UIKit/UIKit.h>
#import "HealthTrackerAppDelegate.h"

// Defining Interface  with needed Protocol (if any).
// Protocols generally define inside '< >'bracates.
@interface SelectMedicineSettingsController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
	/* 
	 Tools That you have used in xib file, need to bind with its controller file.
	 This is done by Declaring tool with IBOutlet as Prefix.
	 
	 Tools That you haven't used in xib but used in controller file, need not to bind with xib,
	 such tools do not have IBOutlet as Prefix.
	 
	 Declaration of all global variables and objects also here.
	 */
	
	IBOutlet UITableView *tblSettings;
	IBOutlet UIBarButtonItem *btnSave;
	IBOutlet UIBarButtonItem *btnCancle;
	NSMutableArray *selectedArray;
	UIImage *selectedImage;
	UIImage *unselectedImage;
	NSMutableArray *arr;
	HealthTrackerAppDelegate *appDelegate;
	NSMutableArray *selectedArrayData;
	int IncrementCount;
	NSMutableArray *arr1;
	NSString *NameValue;
	UILabel *label1;
}
// Declaration of all Public methods that are going to implement inside implementation file, need to declare here.
-(IBAction)Cancle:(id)sender;
-(IBAction)Save:(id)sender;
- (void)populateSelectedArray;
-(IBAction)checkAll:(id)sender;
-(IBAction)uncheckAll:(id)sender;
@end
