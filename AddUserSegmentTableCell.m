//
//  AddUserSegmentTableCell.m
//  hLog
//
//  Created by Bhoomi on 3/28/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import "AddUserSegmentTableCell.h"


@implementation AddUserSegmentTableCell
@synthesize BtnSelect,lblName;

// Designated initializer.  If the cell can be reused, you must pass in a reuse identifier.  You should use the same reuse identifier for all cells of the same form.  
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier 
{	
	NSArray *segmentTextContent = [NSArray arrayWithObjects: @"Male", @"Female", nil];
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) 
	{		
		UIView *myContentview=self.contentView;
		
		lblName=[self newLabelWithPrimaryColor:[UIColor colorWithRed:0.317 green:0.4 blue:0.56 alpha:1.0] selectedColor:[UIColor whiteColor] fontSize:13 bold:YES];
		lblName.textAlignment=UITextAlignmentRight;
		[myContentview addSubview:lblName];
		[lblName release];
		
		BtnSelect=[[UISegmentedControl alloc] initWithItems:segmentTextContent];
		BtnSelect.segmentedControlStyle  =UISegmentedControlStyleBar;
		BtnSelect.tintColor=[UIColor lightGrayColor]; 
		[myContentview addSubview:BtnSelect];
		[BtnSelect release];		
	}
    return self;
}

////// Create Lable with Textfont color, font size, background color etc,
-(UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold
{
	UIFont *font;
    if (bold) 
	{
        font = [UIFont boldSystemFontOfSize:fontSize];
    }
	else
	{
        font = [UIFont systemFontOfSize:fontSize];
    }
	
 	UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
	newLabel.backgroundColor = [UIColor whiteColor];
	newLabel.opaque = YES;
	newLabel.textColor=primaryColor;
	newLabel.highlightedTextColor = selectedColor;
	newLabel.font = font;	
	return newLabel;	
}

 // animate between regular and selected state
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:FALSE animated:animated];
	
    // Configure the view for the selected state
}

///// Set Frame of lables,textfield,Button,image etc in table view cell 
- (void)layoutSubviews
{	
    [super layoutSubviews];
	
	CGRect contentRect = self.contentView.bounds;	
    CGFloat boundsX = contentRect.origin.x;
	App=[[UIApplication sharedApplication]delegate];
	self.lblName.frame =  CGRectMake(2, 5, 100, 30);
	if(App.ISfromSettings==0)
	{
		self.BtnSelect.frame = CGRectMake(boundsX + 105, 6, 190, 27);
	}
	else
	{
		self.BtnSelect.frame = CGRectMake(boundsX + 125, 6, 153, 27);
	}
}

@end
