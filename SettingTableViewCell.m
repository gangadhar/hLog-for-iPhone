//
//  SettingTableViewCell.m
//  hLog
//
//  Created by Bhoomi on 3/3/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import "SettingTableViewCell.h"


@implementation SettingTableViewCell
@synthesize lblName,btnDelete,txtAmount;

// Designated initializer.  If the cell can be reused, you must pass in a reuse identifier.  You should use the same reuse identifier for all cells of the same form.  
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier])
	{ 		
		UIView *MycontentView =self.contentView;
		self.lblName=[[UILabel alloc]init];
		self.lblName.textColor=[UIColor colorWithRed:0.317 green:0.4 blue:0.56 alpha:1.0];
		self.lblName.highlightedTextColor=[UIColor whiteColor];
		self.lblName.backgroundColor=[UIColor clearColor];
		self.lblName.font=[UIFont boldSystemFontOfSize:15.0];
		self.lblName.textAlignment = UITextAlignmentLeft; // default
		self.lblName.numberOfLines=0;
		[MycontentView addSubview:self.lblName];
		[self.lblName release];
		
		btnDelete=[[UIImageView alloc]init];
		[MycontentView addSubview:btnDelete];
		[btnDelete release];
	
		txtAmount=[[UITextField alloc]init];
		self.txtAmount.frame = CGRectMake(180, 8, 70, 25);
		txtAmount.borderStyle=UITextBorderStyleRoundedRect;
		txtAmount.clearButtonMode =UITextFieldViewModeWhileEditing;
		txtAmount.keyboardType=UIKeyboardTypeNumberPad;
		txtAmount.font=[UIFont systemFontOfSize:15];
		[MycontentView addSubview:txtAmount];
		[txtAmount release];		
    }
    return self;
}

 // animate between regular and selected state
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


///// Set Frame of lables,textfield,Button,image etc in table view cell 
- (void)layoutSubviews {
	
    [super layoutSubviews];
	CGRect contentRect = self.contentView.bounds;   
	
	CGFloat boundsX = contentRect.origin.x;
	CGRect frame;
	Delegate=[[UIApplication sharedApplication]delegate];
	
	if(Delegate.ISfromDefaultUser==TRUE)
	{
		frame = CGRectMake(boundsX + 260, self.frame.size.height/2-8, 22, 22);
		self.btnDelete.frame = frame;
	}
	else
	{
		frame = CGRectMake(boundsX + 280, self.frame.size.height/2-8, 22, 22);
		self.btnDelete.frame = frame;
	}	
	
	if(Delegate.IsFromMedicine)
	{
		frame = CGRectMake(9, 5, 135, self.frame.size.height-8);
		self.lblName.frame = frame;
	}
	else
	{
		frame = CGRectMake(9, 5, 245, self.frame.size.height-8);
		self.lblName.frame = frame;
	}
	
}


////// Create Lable with Textfont color, font size, background color etc,
- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold
{	
    UIFont *font;
    if (bold) {
        font = [UIFont boldSystemFontOfSize:fontSize];
    } else {
        font = [UIFont systemFontOfSize:fontSize];
    }	
	UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	newLabel.backgroundColor = [UIColor whiteColor];
	newLabel.opaque = YES;
	newLabel.textColor = primaryColor;
	newLabel.highlightedTextColor = selectedColor;
	newLabel.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
	newLabel.font = font;	
	return newLabel;
}

- (void)dealloc {
    [super dealloc];
}


@end
