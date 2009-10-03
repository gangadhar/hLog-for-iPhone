//
//  AddNewUserTableCell.m
//  hLog
//
//  Created by Bhoomi on 02/03/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import "AddNewUserTableCell.h"


@implementation AddNewUserTableCell
@synthesize lblName,txtDeatils,txt,btnCall;

// Designated initializer.  If the cell can be reused, you must pass in a reuse identifier.  You should use the same reuse identifier for all cells of the same form.  
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier])
	{
		UIView *MycontentView =self.contentView;
		
		self.lblName = [self newLabelWithPrimaryColor:[UIColor colorWithRed:0.317 green:0.4 blue:0.56 alpha:1.0] selectedColor:[UIColor whiteColor] fontSize:13 bold:YES];
		self.lblName.textAlignment = UITextAlignmentRight; // default
		[MycontentView addSubview:self.lblName];
		[self.lblName release];

		txtDeatils = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor whiteColor] fontSize:14 bold:YES];
		txtDeatils.textAlignment = UITextAlignmentLeft; // default
		txtDeatils.numberOfLines=0;
		[MycontentView addSubview:txtDeatils];
		[txtDeatils release];
		
		self.txt=[[UITextField alloc]init];
		self.txt.hidden=TRUE;
		self.txt.backgroundColor=[UIColor clearColor];
		self.txt.textColor=[UIColor blackColor];
		self.txt.font=[UIFont boldSystemFontOfSize:16];
		self.txt.keyboardAppearance=UIKeyboardAppearanceAlert; 
		self.txt.borderStyle=UITextBorderStyleNone;
		self.txt.secureTextEntry=TRUE;
		self.txt.enabled=FALSE;
		[MycontentView addSubview:self.txt];
		[self.txt release];		
		
		btnCall = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		[btnCall setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[btnCall setBackgroundImage:[UIImage imageNamed:@"call.png"] forState:UIControlStateNormal];
		[btnCall setBackgroundImage:[UIImage imageNamed:@"call.png"] forState:UIControlStateSelected];
		[btnCall setBackgroundImage:[UIImage imageNamed:@"call.png"] forState:UIControlStateHighlighted];
		btnCall.hidden=TRUE;
		btnCall.enabled=TRUE;
		[MycontentView addSubview:btnCall];
		[btnCall release];	
    }
    return self;
}

///// Set Frame of lables,textfield,Button,image etc in table view cell 
- (void)layoutSubviews
{	
    [super layoutSubviews];
	CGRect contentRect = self.contentView.bounds;   	
	CGFloat boundsX = contentRect.origin.x;
	self.lblName.frame =  CGRectMake(2, 7, 100, 30);
	self.txtDeatils.frame = CGRectMake(boundsX + 110, 5, 175, self.frame.size.height-8);
	self.txt.frame = CGRectMake(boundsX + 110, 10, 175, 30);
	btnCall.frame=CGRectMake(250, 5, 26, 26);
}

 // animate between regular and selected state
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

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
