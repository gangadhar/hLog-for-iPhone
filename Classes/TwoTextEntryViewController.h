//
//  TwoTextEntryViewController.h
//  hLog
//
//  Created by MAC02 on 7/30/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthTrackerAppDelegate.h"
#import "UserTextEntryViewController.h"
@interface TwoTextEntryViewController : UIViewController <UITextFieldDelegate,UIPickerViewDelegate>{

	IBOutlet UITextField *txtQty;
	IBOutlet UITextField *txtUnit;
	NSString *strQty;
	NSString *strUnit;
	int SelectedIndex;
	int Index;
	NSString *HeaderLabel;
	HealthTrackerAppDelegate *appDelegate;
	IBOutlet UIBarButtonItem *btnCancel;
	IBOutlet UIBarButtonItem *btnDone;
	IBOutlet UIBarButtonItem *btnSave;
	IBOutlet UIButton *btnUnit;
	IBOutlet UIPickerView *PickerView;
	IBOutlet UIToolbar *ToolBar;
	UILabel *label1;
//	UILabel *lblData;
	UITextField *SelectedText;
	NSMutableDictionary *DIC1;
	
}

@property(nonatomic,retain) NSString *strQty;
@property(nonatomic,retain) NSString *strUnit;
@property(nonatomic,readwrite) int SelectedIndex;
@property(nonatomic,readwrite)int Index;
@property(nonatomic,retain)NSString *HeaderLabel;

-(IBAction)btnCancel:(id)sender;
-(IBAction)btnDone:(id)sender;
-(IBAction)btnSave:(id)sender;
-(void)StoreData;
@end
