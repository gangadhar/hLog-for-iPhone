//
//  NewSwitchTableViewCell.m
//  hLog
//
//  Created by Bhoomi on 3/13/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import "NewSwitchTableViewCell.h"


@implementation NewSwitchTableViewCell
@synthesize lblName,SwIsKid;

// Designated initializer.  If the cell can be reused, you must pass in a reuse identifier.  You should use the same reuse identifier for all cells of the same form.  
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
		
		UIView *MycontentView =self.contentView;
		appDelegate=[[UIApplication sharedApplication]delegate];
		if(appDelegate.iSfromAddUser==FALSE)
		{
			self.lblName = [self newLabelWithPrimaryColor:[UIColor colorWithRed:0.317 green:0.4 blue:0.56 alpha:1.0] selectedColor:[UIColor whiteColor] fontSize:14 bold:YES];
		}
		else
		{
			self.lblName = [self newLabelWithPrimaryColor:[UIColor colorWithRed:0.317 green:0.4 blue:0.56 alpha:1.0] selectedColor:[UIColor whiteColor] fontSize:13 bold:YES];	
		}
		self.lblName.textAlignment = UITextAlignmentRight; // default
		[MycontentView addSubview:self.lblName];
		[self.lblName release];
		
		SwIsKid = [[CustomSwitch alloc] initWithFrame:CGRectZero];
		[SwIsKid setCenter:CGPointMake(160.0f,230.0f)];		
		
		if(appDelegate.iSfromAddUser==FALSE)
		{
			[SwIsKid setLeftLabelText: @"ON"];
			[SwIsKid setRightLabelText: @"OFF"];
		}
		else
		{
			[SwIsKid setLeftLabelText: @"YES"];
			[SwIsKid setRightLabelText: @"NO"];
		}
		[MycontentView addSubview:SwIsKid];
		[SwIsKid release];
    }
    return self;
}

///// Set Frame of lables,textfield,Button,image etc in table view cell 
- (void)layoutSubviews {
	
    [super layoutSubviews];
	CGRect contentRect = self.contentView.bounds;   
	
	CGFloat boundsX = contentRect.origin.x;
	appDelegate=[[UIApplication sharedApplication]delegate];
	if(appDelegate.iSfromAddUser==FALSE)
	{
		self.lblName.frame =  CGRectMake(2, 8, 170, 30);
		SwIsKid.frame = CGRectMake(boundsX + 190, 9, 90, 27);
	}
	else
	{
		self.lblName.frame =  CGRectMake(2, 5, 100, 30);
		SwIsKid.frame = CGRectMake(boundsX + 105, 7, 90, 27);
	}
	
}

// animate between regular and selected state
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:FALSE animated:animated];
	
    // Configure the view for the selected state
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
	newLabel.font = font;	
	return newLabel;
}
- (void)dealloc {
    [super dealloc];
}


@end
