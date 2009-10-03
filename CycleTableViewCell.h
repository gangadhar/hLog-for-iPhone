//
//  CycleTableViewCell.h
//  hLog
//
//  Created by MAC02 on 4/28/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CycleTableViewCell : UITableViewCell {

	UILabel *lblName;
	UIButton *btnStart;
	UIButton *btnEnd;
	UILabel *lblStart;
	UILabel *lblEnd;
}

@property(nonatomic,retain)	UILabel *lblName;
@property(nonatomic,retain) UIButton *btnStart;
@property(nonatomic,retain) UIButton *btnEnd;
@property(nonatomic,retain) UILabel *lblStart;
@property(nonatomic,retain) UILabel *lblEnd;
-(UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;

@end
