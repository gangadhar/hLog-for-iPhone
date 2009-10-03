//
//  SleepTableViewCell.h
//  hLog
//
//  Created by MAC02 on 5/20/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SleepTableViewCell : UITableViewCell {

	UILabel *lblName;
	UITextField *txtStart;
	UITextField *txtEnd;
	
}

@property(nonatomic,retain) UILabel *lblName;
@property(nonatomic,retain) UITextField *txtStart;
@property(nonatomic,retain) UITextField *txtEnd;

-(UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;


@end
