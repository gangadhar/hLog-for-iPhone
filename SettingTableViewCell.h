//
//  SettingTableViewCell.h
//  hLog
//
//  Created by Bhoomi on 3/3/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthTrackerAppDelegate.h"

@interface SettingTableViewCell : UITableViewCell {

	UILabel *lblName;
	UIImageView *btnDelete;
	UITextField *txtAmount;
	HealthTrackerAppDelegate *Delegate;
}

@property(nonatomic,retain) UILabel *lblName;
@property(nonatomic,retain) UIImageView *btnDelete;
@property(nonatomic,retain) UITextField *txtAmount;
- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;


@end
