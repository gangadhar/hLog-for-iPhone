//
//  DrawReports.h
//  HealthTracker
//
//  Created by Bhoomi on 3/3/09.
//  Copyright 2009 Elan. All rights reserved.
//

// Import All needed header files bellow.
#import <Foundation/Foundation.h>

// Defining Interface  with needed Protocol (if any).
// Protocols generally define inside '< >'bracates.
@interface DrawReports : UIView {
	
	double Left_Margin;
	double Bottom_Margin;
	
	double X_Interval;
	double Y_Interval;
	
	CGRect WorkArea;
	
	
	NSMutableArray* X;
	NSMutableArray* Y;
	NSMutableArray* Values;	
	
}

@property(nonatomic,retain)NSMutableArray* X;
@property(nonatomic,retain)NSMutableArray* Y;
@property(nonatomic,retain)NSMutableArray* Values;

@property(nonatomic,readwrite)double Left_Margin;
@property(nonatomic,readwrite)double Bottom_Margin;


// Declaration of all Public methods that are going to implement inside implementation file, need to declare here.




@end
