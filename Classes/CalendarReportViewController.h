//
//  CalendarReportViewController.h
//  hLog
//
//  Created by Bhoomi on 4/1/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthTrackerAppDelegate.h"
#import "ShowReportViewController.h"
#import "FirstViewController.h"

@interface CalendarReportViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate> {

	IBOutlet UITableView *tblView;
	IBOutlet UIBarButtonItem *btnReport;
	HealthTrackerAppDelegate *appDelegate;
	UILabel *selectedLabel;
	IBOutlet UIDatePicker *DatePicker;
	IBOutlet UIToolbar *ToolBar;
	UILabel *lblData;
	IBOutlet UIBarButtonItem *btnDone;
	int SelectedTag;
	int Index;
	
	ShowReportViewController *ShowReportView;
	ShowReportViewController  *objShowreport;
	
	NSMutableArray *selectedArray;
	UIImage *selectedImage;
	UIImage *unselectedImage;
	NSMutableArray *arr1;
	NSMutableArray *arr2;
	UIActivityIndicatorView *Activity;
	IBOutlet UIToolbar *tlbar;
	ShowReportViewController *objAddUser;
	IBOutlet UIBarButtonItem *btnCancel;
	NSNumber *selected;
	IBOutlet UIBarButtonItem *btnSend;
	NSString *Str1;
	NSString *FieldName;
	NSString *Date;
	NSMutableArray *tmpArray;
}
-(IBAction)btnCancel_Clicked:(id)sender;


-(void)ConcateString;
-(IBAction)btnSend_Click:(id)sender;
-(IBAction)checkAll:(id)sender;
-(IBAction)uncheckAll:(id)sender;
-(void)populateSelectedArray;
-(IBAction)btnReport_Click:(id)sender;
-(IBAction)btnDone_click:(id)sender;
-(void)LoadReport;
-(void)makeCsvFile;
@end
