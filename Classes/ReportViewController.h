//
//  ReportViewController.h
//  HealthTracker
//
//  Created by Bhoomi on 3/3/09.
//  Copyright 2009 Elan. All rights reserved.
//

// Import All needed header files bellow.
#import <UIKit/UIKit.h>
#import "DrawReports.h"
#import "HealthTrackerAppDelegate.h"

// Defining Interface  with needed Protocol (if any).
// Protocols generally define inside '< >'bracates.
@interface ReportViewController : UIViewController {

	DrawReports *objChartView;
	HealthTrackerAppDelegate *appDelegate;
	NSDateFormatter *DateFormatter1;
	NSMutableArray *DateArray;
 	NSDateFormatter *DateFormatter;
}

-(void)SetHeaderLable:(NSInteger)StartPoint withEndatae:(NSInteger)EndPoint;
-(void)SetTimeLable;
@end
