//
//  AddNewUserTableCell.h
//  hLog
//
//  Created by Bhoomi on 02/03/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddNewUserTableCell : UITableViewCell {
	UILabel *lblName;
	UILabel *txtDeatils;
	UITextField *txt;
	UIButton *btnCall;
}

@property(nonatomic,retain) UILabel *lblName;

@property(nonatomic,retain)  UILabel *txtDeatils;
@property(nonatomic,retain)  UITextField *txt;
@property(nonatomic,retain)  UIButton *btnCall;
- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;
@end
