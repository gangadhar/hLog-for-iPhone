//
//  AddUserButtonTableViewCell.h
//  hLog
//
//  Created by Bhoomi on 3/3/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddUserButtonTableViewCell : UITableViewCell {

	
	UILabel *lblName;
	UIButton *BtnSelect;
	
}

@property(nonatomic,retain) UILabel *lblName;
@property(nonatomic,retain) UIButton *BtnSelect;

-(UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;




@end
