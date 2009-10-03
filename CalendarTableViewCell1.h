//
//  CalendarTableViewCell1.h
//  hLog
//
//  Created by Bhoomi on 24/04/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthTrackerAppDelegate.h"

@interface CalendarTableViewCell1 : UITableViewCell {
	
	UILabel *lblName;
//	UILabel *lblNameEmail;
	HealthTrackerAppDelegate *appdelegate;
}
@property(nonatomic,retain) UILabel *lblName;
//@property(nonatomic,retain) UILabel *lblNameEmail;
-(UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;

@end
