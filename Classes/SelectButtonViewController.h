//
//  SelectButtonViewController.h
//  hLog
//
//  Created by Bhoomi on 3/24/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthTrackerAppDelegate.h"
#import "SelectSettingsViewController.h"
#import "Medicine.h"
#import "Vitals_Detail.h"
#import "Routine_Detail.h"
#import "UserViewController.h"
#import "CalendarReportViewController.h"
#import "FirstViewController.h"
#import "RootViewController.h"
#import "InfoViewController.h"

@interface SelectButtonViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>{

	IBOutlet UITableView *tblView;
	HealthTrackerAppDelegate *appDelegate;
	//int SelectedIndex;
	FirstViewController  *objAddUser;
	CalendarReportViewController *objReport;	
	NSString *Date;
	NSString *DateTime;
	NSString *Mins;
	FirstViewController *ObjFirstViewController;
	UILabel *label1;
	NSArray *arr;
	IBOutlet UIButton *btnInfo;
	InfoViewController *objInfoViewController;
	int Days;
}

//@property(nonatomic,readwrite) int SelectedIndex; 
-(IBAction)btnInfo_Clicked:(id)sender;
@end
