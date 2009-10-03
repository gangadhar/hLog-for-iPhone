//
//  SleepTableViewCell.m
//  hLog
//
//  Created by MAC02 on 5/20/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import "SleepTableViewCell.h"


@implementation SleepTableViewCell
@synthesize lblName,txtEnd,txtStart;

// Designated initializer.  If the cell can be reused, you must pass in a reuse identifier.  You should use the same reuse identifier for all cells of the same form.  
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Initialization code
		UIView *myContentview=self.contentView;		
		lblName=[self newLabelWithPrimaryColor:[UIColor colorWithRed:0.317 green:0.4 blue:0.56 alpha:1.0] selectedColor:[UIColor whiteColor] fontSize:13 bold:YES];
		lblName.textAlignment=UITextAlignmentRight;
		[myContentview addSubview:lblName];
		[lblName release];
		
		
		txtEnd=[[UITextField alloc]init];
		txtEnd.font=[UIFont boldSystemFontOfSize:13];
		txtEnd.borderStyle=UITextBorderStyleRoundedRect;
		[myContentview addSubview:txtEnd];
		[txtEnd release];
		
		txtStart=[[UITextField alloc]init];
		txtStart.font=[UIFont boldSystemFontOfSize:13];
		txtStart.borderStyle=UITextBorderStyleRoundedRect;
		[myContentview addSubview:txtStart];
		[txtStart release];
		
		
    }
    return self;
}

///// Set Frame of lables,textfield,Button,image etc in table view cell 
- (void)layoutSubviews 
{	
    [super layoutSubviews];	
	lblName.frame =  CGRectMake(2, 5, 140, 30);
	txtStart.frame=CGRectMake(150, 5, 140, 25);
	txtEnd.frame=CGRectMake(150, 36, 140, 25);
}

 // animate between regular and selected state
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
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
	newLabel.backgroundColor = [UIColor clearColor];
	newLabel.opaque = YES;
	newLabel.textColor = primaryColor;
	
	newLabel.highlightedTextColor = selectedColor;
	newLabel.font = font;	
	return newLabel;	
}

@end
