//
//  UserViewController.h
//  hLog
//
//  Created by Bhoomi on 3/30/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNewUserController.h"
#import "HealthTrackerAppDelegate.h"
#import "Vitals_Detail.h"
#import "Routine_Detail.h"
#import "Menstural_Cycle.h"
#import "UserTextEntryViewController.h"
#import "SelectOptionsViewController.h"
#import "DailyStatusTableViewCell.h"
#import "SettingsViewController.h"
#import "PainViewController.h"

@interface UserViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate,UITextFieldDelegate>{

	IBOutlet UITableView *tblView;
	IBOutlet UIBarButtonItem *btnSave;
	
	HealthTrackerAppDelegate *appDelegate;
	NSMutableArray *VitalsArray;
	NSMutableArray *RoutinesArray;
	NSString *DailySettings;
	IBOutlet UIPickerView *PickerView;
	IBOutlet UIDatePicker *DatePicker;
	IBOutlet UIToolbar *ToolBar;
	IBOutlet UIBarButtonItem *btnDone;	
	int SelectedTag;
	UILabel *lblData;
	NSMutableDictionary *data;
	UIBarButtonItem *temporaryBarButtonItem;
	IBOutlet UIBarButtonItem *btnVitals;
	IBOutlet UIBarButtonItem *btnRoutines;
	UINavigationController *SettingsCon2;
	UINavigationController *SettingsCon;
	IBOutlet UIToolbar *ToolBar1;
	NSArray	*arr1;
	BOOL IsStart;
	BOOL IsEnd;
	IBOutlet UIBarButtonItem *btnCancel;
	int SelectedIndex;
	IBOutlet UIToolbar *ToolBarRV;
	IBOutlet UIButton *btnDelete1;
	IBOutlet UIView *viewFooterVital;
	IBOutlet UIView *viewFooterRoutine;
	UIView *ViewHead;
	PainViewController *ObjPainViewController;
	NSString *strRestaurantTypeSecond;
	NSString *strRestaurantType;	
	IBOutlet UIDatePicker *TimeDatePicker;
	NSArray *arr2;
	NSArray *arr3;
	BOOL IsStartFirstTime;
	BOOL IsStartEnabled;
	BOOL isEndDisabled;
	NSDate *UserDate;

}
@property(nonatomic,readwrite) int SelectedIndex;
@property(nonatomic,readwrite) BOOL isEndDisabled;
@property(nonatomic,retain) NSDate *UserDate;


-(IBAction)btnCancel_Clicked:(id)sender;
-(IBAction)btnDeleteVital_clicked:(id)sender;
-(IBAction)btnDeleteRoutine_clicked:(id)sender;
-(IBAction)btnSettings_clicked:(id)sender;
-(IBAction)btnSave_Clicked:(id)sender;
-(IBAction)btnDone_CLicked:(id)sender;
-(IBAction)btnVitals_CLicked:(id)sender;
-(IBAction)btnRoutines_CLicked:(id)sender;
-(NSMutableArray *)FillArray:(int)i;
-(int)GetPickerRow:(NSString *)String component:(NSInteger)Tag;
-(void)VitalsData:(DailyStatusTableViewCell *)cell;
-(void)RoutineData:(DailyStatusTableViewCell *)cell;
-(void)SaveMensturalCycle;
-(void)SetCycleData;
-(void)StoreExerciseDuration:(int)Routine_ID;
-(void)SaveFeedingDetail:(NSInteger)Routine_ID;
@end
