//
//  CalendarTableViewCell1.m
//  hLog
//
//  Created by Bhoomi on 24/04/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import "CalendarTableViewCell1.h"


@implementation CalendarTableViewCell1
@synthesize lblName;

// Designated initializer.  If the cell can be reused, you must pass in a reuse identifier.  You should use the same reuse identifier for all cells of the same form.  
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) 
	{
        // Initialization code
		UIView *myContentview=self.contentView;		
		lblName=[self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor whiteColor] fontSize:11.5 bold:YES];
		lblName.textAlignment=UITextAlignmentCenter;
		[myContentview addSubview:lblName];
		[lblName release];		
    }
    return self;
}

- (void)layoutSubviews
{	
    [super layoutSubviews];
	appdelegate=[[UIApplication sharedApplication]delegate];
	if(appdelegate.isforReport)
	{
		self.lblName.frame =  CGRectMake(2, self.frame.size.height/2-10, 97, 20);
		self.lblName.font=[UIFont boldSystemFontOfSize:11.5];
		lblName.textAlignment=UITextAlignmentCenter;
		self.lblName.numberOfLines=1;
	}
	else
	{
		self.lblName.frame =  CGRectMake(10, 5, 250, self.frame.size.height-8);
		self.lblName.font=[UIFont boldSystemFontOfSize:14];
		lblName.textAlignment=UITextAlignmentLeft;
		self.lblName.numberOfLines=0;
	}
	//self.lblNameEmail.frame =  CGRectMake(10, 25, 250, 20);
}

 // animate between regular and selected state
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:FALSE animated:animated];
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
	newLabel.backgroundColor = [UIColor clearColor];
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
