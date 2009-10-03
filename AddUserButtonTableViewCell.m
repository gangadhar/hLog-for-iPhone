//
//  AddUserButtonTableViewCell.m
//  hLog
//
//  Created by Bhoomi on 3/3/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import "AddUserButtonTableViewCell.h"


@implementation AddUserButtonTableViewCell
@synthesize BtnSelect,lblName;

// Designated initializer.  If the cell can be reused, you must pass in a reuse identifier.  You should use the same reuse identifier for all cells of the same form.  
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
      
		UIView *myContentview=self.contentView;
		
		lblName=[[UILabel alloc]init];
		lblName.textColor=[UIColor colorWithRed:0.317 green:0.4 blue:0.56 alpha:1.0];
		lblName.highlightedTextColor=[UIColor whiteColor];
		lblName.font=[UIFont boldSystemFontOfSize:13.0];
		lblName.textAlignment=UITextAlignmentRight;
		lblName.frame =  CGRectMake(2, 5, 100, 30);
		[myContentview addSubview:lblName];
		[lblName release];
		
		BtnSelect = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		[BtnSelect setTitle:@"  ---Select option---" forState:UIControlStateNormal];
		[BtnSelect setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[BtnSelect setBackgroundImage:[UIImage imageNamed:@"02.jpg"] forState:UIControlStateNormal];
		[BtnSelect setBackgroundImage:[UIImage imageNamed:@"02.jpg"] forState:UIControlStateSelected];
		[BtnSelect setBackgroundImage:[UIImage imageNamed:@"02.jpg"] forState:UIControlStateHighlighted];
		[BtnSelect setFont:[UIFont boldSystemFontOfSize:13]];
		BtnSelect.enabled=TRUE;
		BtnSelect.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
		BtnSelect.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
		BtnSelect.frame = CGRectMake( 105, 5, 190, 30);
		[myContentview addSubview:BtnSelect];
		[BtnSelect release];
		
	}
    return self;
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


- (void)layoutSubviews {
	
    [super layoutSubviews];
	

}
- (void)dealloc {
    [super dealloc];
}


@end
