//
//  DailyStatusTableViewCell.m
//  hLog
//
//  Created by Bhoomi on 3/3/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import "DailyStatusTableViewCell.h"

@implementation DailyStatusTableViewCell
@synthesize lblName,lblNameTwo,btnCall;

// Designated initializer.  If the cell can be reused, you must pass in a reuse identifier.  You should use the same reuse identifier for all cells of the same form.  
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
       
		UIView *myContentview=self.contentView;

		lblName=[[UILabel alloc]init];
		lblName.textColor=[UIColor  colorWithRed:0.317 green:0.4 blue:0.56 alpha:1.0];
		lblName.highlightedTextColor=[UIColor whiteColor];
		lblName.font=[UIFont boldSystemFontOfSize:13.0];		
		lblName.textAlignment=UITextAlignmentRight;
		[myContentview addSubview:lblName];
		[lblName release];		
		
		self.lblNameTwo=[[UILabel alloc]init];
		self.lblNameTwo.textColor=[UIColor  blackColor];
		self.lblNameTwo.highlightedTextColor=[UIColor whiteColor];
		self.lblNameTwo.font=[UIFont boldSystemFontOfSize:14.0];		
		self.lblNameTwo.numberOfLines=0;
		self.lblNameTwo.textAlignment=UITextAlignmentLeft;
		[myContentview addSubview:self.lblNameTwo];
		[self.lblNameTwo release];
		
		btnCall = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		[btnCall setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[btnCall setBackgroundImage:[UIImage imageNamed:@"call.png"] forState:UIControlStateNormal];
		[btnCall setBackgroundImage:[UIImage imageNamed:@"call.png"] forState:UIControlStateSelected];
		[btnCall setBackgroundImage:[UIImage imageNamed:@"call.png"] forState:UIControlStateHighlighted];
		btnCall.hidden=TRUE;
		btnCall.enabled=TRUE;
		[myContentview addSubview:btnCall];
		[btnCall release];		
    }
    return self;
}

 // animate between regular and selected state
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

////// Create Lable with Textfont color, font size, background color etc,
-(UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold
{
	UIFont *font;
    if (bold) {
        font = [UIFont boldSystemFontOfSize:fontSize];
    } else {
        font = [UIFont systemFontOfSize:fontSize];
    }
	
    /*
	 Views are drawn most efficiently when they are opaque and do not have a clear background, so set these defaults.  To show selection properly, however, the views need to be transparent (so that the selection color shows through).  This is handled in setSelected:animated:.
	 */
	UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
	newLabel.backgroundColor = [UIColor whiteColor];
	newLabel.opaque = YES;
	newLabel.textColor = primaryColor;
	newLabel.highlightedTextColor = selectedColor;
	newLabel.font = font;	
	return newLabel;
	
}


///// Set Frame of lables,textfield,Button,image etc in table view cell 
- (void)layoutSubviews {
	
    [super layoutSubviews];
	
	self.lblName.frame =  CGRectMake(2, 6, 140, 30);
	self.lblNameTwo.frame =  CGRectMake(150, 5, 132,  self.frame.size.height-8);
	btnCall.frame=CGRectMake(250, 5, 26, 26);
}

- (void)dealloc {
    [super dealloc];
}


@end
