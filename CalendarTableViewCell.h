//
//  CalendarTableViewCell.h
//  hLog
//
//  Created by Bhoomi on 4/2/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthTrackerAppDelegate.h"
#import "ShowReportViewController.h"

@interface CalendarTableViewCell : UITableViewCell {
	
	UILabel *Hour1;
	UILabel *Hour2;
	UILabel *Hour3;
	UILabel *Hour4;
	UILabel *Hour5;
	UILabel *Hour6;
	UILabel *Hour7;
	UILabel *Hour8;
	UILabel *Hour9;
	UILabel *Hour10;
	UILabel *Hour11;
	UILabel *Hour12;
	UILabel *Hour13;
	UILabel *Hour14;
	UILabel *Hour15;
	UILabel *Hour16;
	UILabel *Hour17;
	UILabel *Hour18;
	UILabel *Hour19;
	UILabel *Hour20;
	UILabel *Hour21;
	UILabel *Hour22;
	UILabel *Hour23;
	UILabel *Hour24;
	UILabel *lbl;
	HealthTrackerAppDelegate *Delegate;
	NSMutableArray *Columns;


}

@property(nonatomic,retain) UILabel *Hour1;
@property(nonatomic,retain) UILabel *Hour2;
@property(nonatomic,retain) UILabel *Hour3;
@property(nonatomic,retain) UILabel *Hour4;
@property(nonatomic,retain) UILabel *Hour5;
@property(nonatomic,retain) UILabel *Hour6;
@property(nonatomic,retain) UILabel *Hour7;
@property(nonatomic,retain) UILabel *Hour8;
@property(nonatomic,retain) UILabel *Hour9;
@property(nonatomic,retain) UILabel *Hour10;
@property(nonatomic,retain) UILabel *Hour11;
@property(nonatomic,retain) UILabel *Hour12;
@property(nonatomic,retain) UILabel *Hour13;
@property(nonatomic,retain) UILabel *Hour14;
@property(nonatomic,retain) UILabel *Hour15;
@property(nonatomic,retain) UILabel *Hour16;
@property(nonatomic,retain) UILabel *Hour17;
@property(nonatomic,retain) UILabel *Hour18;
@property(nonatomic,retain) UILabel *Hour19;
@property(nonatomic,retain) UILabel *Hour20;
@property(nonatomic,retain) UILabel *Hour21;
@property(nonatomic,retain) UILabel *Hour22;
@property(nonatomic,retain) UILabel *Hour23;
@property(nonatomic,retain) UILabel *Hour24;

- (void)addColumn:(CGFloat)position;

-(UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;
-(UILabel *)CellLable:(NSInteger)Label;
@end

