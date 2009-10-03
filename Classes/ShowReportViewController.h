//
//  ShowReportViewController.h
//  hLog
//
//  Created by Bhoomi on 4/1/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthTrackerAppDelegate.h"
#import "UserViewController.h"
//#import "DailyStatusViewController.h"
//#import "HourlyStatusViewController.h"

@interface UIDevice (Extended)
- (UIInterfaceOrientation)setOrientation:(UIInterfaceOrientation)interfaceOrientation;
//addTextFieldWithValue:(NSString*)value label:(NSString*)label;

@end


@interface ShowReportViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
	HealthTrackerAppDelegate *appDelegate;
	BOOL isRotate;
	IBOutlet UITableView *tblView;
	IBOutlet UITableView *tblView1;
	IBOutlet UIView *viewHeader;
	int Index;
	IBOutlet UIScrollView *ScrollView;
//	IBOutlet UIScrollView *ScrollView1;
	IBOutlet UIScrollView *ScrollView2;
	int Count;
	NSString *FieldName;		
	NSMutableArray *arr3;
	int TotlaDataCount;
	int DisplanyCount;
	BOOL ISFinish;
	IBOutlet UIBarButtonItem *btnEdit;
	IBOutlet UILabel *lblDateTime;
	BOOL ISEdit;
	int Row;
	int Width;
	NSIndexPath *indexPathObj;
	int height;
	UIActivityIndicatorView *Activity;
	UILabel *lblHeader;
	UILabel *lblFooter;
	NSString *DateTime;
	NSString *Date;
	NSString *strLabel;
	NSString *Str1;
	BOOL isPortrait;
	NSMutableArray *tmpArray;
}

-(IBAction)btnEdit_Click:(id)sender;
-(void)LoadReport;
-(void)Click_Edit:(UILabel *)lbl;
-(CGFloat)findHeightForCell:(NSString *)text;
//-(NSMutableArray *)bubbleSort:(NSMutableArray *)array ;
@end
