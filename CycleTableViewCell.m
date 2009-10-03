//
//  CycleTableViewCell.m
//  hLog
//
//  Created by MAC02 on 4/28/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import "CycleTableViewCell.h"


@implementation CycleTableViewCell
@synthesize lblEnd,lblStart,lblName,btnEnd,btnStart;

// Designated initializer.  If the cell can be reused, you must pass in a reuse identifier.  You should use the same reuse identifier for all cells of the same form.  
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) 
	{        
		UIView *myContentview=self.contentView;		
		lblName=[self newLabelWithPrimaryColor:[UIColor colorWithRed:0.317 green:0.4 blue:0.56 alpha:1.0] selectedColor:[UIColor whiteColor] fontSize:13 bold:YES];
		lblName.textAlignment=UITextAlignmentRight;
		[myContentview addSubview:lblName];
		[lblName release];		
		
		lblEnd=[self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor whiteColor] fontSize:13.5 bold:YES];
		lblEnd.textAlignment=UITextAlignmentLeft;
		[myContentview addSubview:lblEnd];
		[lblEnd release];
		
		lblStart=[self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor whiteColor] fontSize:13.5 bold:YES];
		lblStart.textAlignment=UITextAlignmentLeft;
		[myContentview addSubview:lblStart];
		[lblStart release];
		
		btnStart = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		btnStart.enabled=TRUE;		
		[btnStart setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
		[btnStart setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
	
		[btnStart setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		btnStart.font=[UIFont boldSystemFontOfSize:13.5];
		[btnStart setTitle:@"Start" forState:UIControlStateNormal];
		[btnStart setTitle:@"Start" forState:UIControlStateSelected];
		btnStart.frame=CGRectMake(150, 7, 70, 22);
		[myContentview addSubview:btnStart];
		[btnStart release];		
		
		btnEnd = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		btnEnd.enabled=TRUE;
		[btnEnd setTitle:@"End " forState:UIControlStateNormal];
		[btnEnd setTitle:@"End " forState:UIControlStateSelected];
		btnEnd.font=[UIFont boldSystemFontOfSize:13.5];
		[btnEnd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[btnEnd setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
		[btnEnd setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
		btnEnd.frame=CGRectMake(149, 35, 70, 22);
		[myContentview addSubview:btnEnd];
		[btnEnd release];		
    }
    return self;
}

///// Set Frame of lables,textfield,Button,image etc in table view cell 
- (void)layoutSubviews 
{	
    [super layoutSubviews];	
	lblName.frame =  CGRectMake(2, 5, 140, 30);

}

 // animate between regular and selected state
- (void)setSelected:(BOOL)selected animated:(BOOL)animated 
{
    [super setSelected:selected animated:animated];
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

- (void)dealloc 
{
    [super dealloc];
}


@end
