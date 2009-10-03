//
//  SelectSettingsViewController.h
//  hLog
//
//  Created by MAC02 on 3/30/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "PasscodeSettingsViewController.h"
#import "RootViewController.h"
#import "HealthTrackerAppDelegate.h"
#import "UnitsViewController.h"
#import "FirstViewController.h"

@interface SelectSettingsViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
	IBOutlet UITableView *tblView;
	IBOutlet UIBarButtonItem *btnSave;
	HealthTrackerAppDelegate *appDelegate;
	RootViewController *objAddUserRoot;
	UnitsViewController *objAddUserUnits;
	
	IBOutlet UIToolbar *toolBar;
	IBOutlet UIActivityIndicatorView *Activity;
	NSMutableArray *arr1;
	NSMutableArray *arr2;
	NSString *Str1;
	NSString *FieldName;
	NSString *Date;
	NSMutableArray *tmpArray;
	int Index;
	NSString *csvString;
} 
@property (nonatomic,retain)NSMutableArray *tmpArray;
-(IBAction)send_All:(id)sender;
-(IBAction)send_PersonalInfo:(id)sender;
//-(void)LoadReport;// :(NSString *)StartDate :(NSString*)EndDate;
-(void)makeCsvFile;
-(void)MakePersonalData;
-(void)pushView;
-(NSString*)numberFormate:(NSInteger)jValue :(NSInteger)iValue :(NSArray*)array;
@end
