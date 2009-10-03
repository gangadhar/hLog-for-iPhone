//
//  ReportselectionViewController.h
//  HealthTracker
//
//  Created by Bhoomi on 3/3/09.
//  Copyright 2009 Elan. All rights reserved.
//

// Import All needed header files bellow.
#import <UIKit/UIKit.h>
#import "ReportViewController.h" 
#import "HealthTrackerAppDelegate.h"

// Defining Interface  with needed Protocol (if any).
// Protocols generally define inside '< >'bracates.
@interface ReportselectionViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate>{

	
	/* 
	 Tools That you have used in xib file, need to bind with its controller file.
	 This is done by Declaring tool with IBOutlet as Prefix.
	 
	 Tools That you haven't used in xib but used in controller file, need not to bind with xib,
	 such tools do not have IBOutlet as Prefix.
	 
	 Declaration of all global variables and objects also here.
	 */
	IBOutlet UITableView *tblView;
	IBOutlet UIBarButtonItem *btnReport;
	ReportViewController *ReportView;
	IBOutlet UIPickerView *PickerView;
	IBOutlet UIToolbar *ToolBar;
	IBOutlet UIBarButtonItem *btnDone;
	UILabel *lblData;
	UISegmentedControl *Segment;
	int SelectedTag;
	HealthTrackerAppDelegate *appdelegate;
	UIButton *btnSelected;
	NSDateFormatter *DateFormatter;
}


// Declaration of all Public methods that are going to implement inside implementation file, need to declare here.
-(IBAction)btnReport_clicked:(id)sender;
-(IBAction)btnDone_Clicked:(id)sender;
@end
