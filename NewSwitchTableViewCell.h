//
//  NewSwitchTableViewCell.h
//  hLog
//
//  Created by Bhoomi on 3/13/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthTrackerAppDelegate.h"
#import "CustomSwitch.h"

@interface NewSwitchTableViewCell : UITableViewCell {

	UILabel *lblName;
	CustomSwitch *SwIsKid;
	HealthTrackerAppDelegate *appDelegate;
	
}

@property(nonatomic,retain) UILabel *lblName;
@property(nonatomic,retain) CustomSwitch *SwIsKid;

- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;

@end
