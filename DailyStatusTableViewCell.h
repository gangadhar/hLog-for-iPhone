//
//  DailyStatusTableViewCell.h
//  hLog
//
//  Created by Bhoomi on 3/3/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DailyStatusTableViewCell : UITableViewCell {

	UILabel *lblName;
	UILabel *lblNameTwo;
	UIButton *btnCall;
}

@property(nonatomic,retain) UILabel *lblName;

@property(nonatomic,retain) UILabel *lblNameTwo;
@property(nonatomic,retain) UIButton *btnCall;
-(UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;

@end
