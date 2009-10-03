//
//  CalendarTableViewCell.m
//  hLog
//
//  Created by Bhoomi on 4/2/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import "CalendarTableViewCell.h"


@implementation CalendarTableViewCell
@synthesize Hour1,Hour2,Hour3,Hour4,Hour5,Hour6,Hour7,Hour8,Hour9,Hour10,Hour11,Hour12,Hour13,Hour14,Hour15,Hour16,Hour17,Hour18,Hour19,Hour20,Hour21,Hour22,Hour23,Hour24;

// Designated initializer.  If the cell can be reused, you must pass in a reuse identifier.  You should use the same reuse identifier for all cells of the same form.  
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) 
	{		
		UIView *myContentview=self.contentView;
		Delegate=[[UIApplication sharedApplication]delegate];
		Delegate.Columns=[NSMutableArray arrayWithCapacity:23];
		Hour1=[[UILabel alloc]init];
		Hour1.textColor=[UIColor  blackColor];
		Hour1.highlightedTextColor=[UIColor whiteColor];
		Hour1.font=[UIFont systemFontOfSize:12.5];
		Hour1.textAlignment=UITextAlignmentCenter;
		Hour1.numberOfLines=0;
		[myContentview addSubview:Hour1];
		[Hour1 release];
		
		Hour2=[[UILabel alloc]init];
		Hour2.textColor=[UIColor  blackColor];
		Hour2.highlightedTextColor=[UIColor whiteColor];
		Hour2.font=[UIFont systemFontOfSize:12.5];
		Hour2.textAlignment=UITextAlignmentCenter;
		Hour2.numberOfLines=0;
		[myContentview addSubview:Hour2];
		[Hour2 release];		
		
		Hour3=[[UILabel alloc]init];
		Hour3.textColor=[UIColor  blackColor];
		Hour3.highlightedTextColor=[UIColor whiteColor];
		Hour3.font=[UIFont systemFontOfSize:12.5];
		Hour3.textAlignment=UITextAlignmentCenter;
		Hour3.numberOfLines=0;
		[myContentview addSubview:Hour3];
		[Hour3 release];		
		
		Hour4=[[UILabel alloc]init];
		Hour4.textColor=[UIColor  blackColor];
		Hour4.highlightedTextColor=[UIColor whiteColor];
		Hour4.font=[UIFont systemFontOfSize:12.5];
		Hour4.textAlignment=UITextAlignmentCenter;
		Hour4.numberOfLines=0;
		[myContentview addSubview:Hour4];
		[Hour4 release];		
		
		Hour5=[[UILabel alloc]init];
		Hour5.textColor=[UIColor  blackColor];
		Hour5.highlightedTextColor=[UIColor whiteColor];
		Hour5.font=[UIFont systemFontOfSize:12.5];
		Hour5.textAlignment=UITextAlignmentCenter;
		Hour5.numberOfLines=0;
		[myContentview addSubview:Hour5];
		[Hour5 release];		
		
		Hour6=[[UILabel alloc]init];
		Hour6.textColor=[UIColor  blackColor];
		Hour6.highlightedTextColor=[UIColor whiteColor];
		Hour6.font=[UIFont systemFontOfSize:12.5];
		Hour6.textAlignment=UITextAlignmentCenter;
		Hour6.numberOfLines=0;
		[myContentview addSubview:Hour6];
		[Hour6 release];		
		
		Hour7=[[UILabel alloc]init];
		Hour7.textColor=[UIColor  blackColor];
		Hour7.highlightedTextColor=[UIColor whiteColor];
		Hour7.font=[UIFont systemFontOfSize:12.5];
		Hour7.textAlignment=UITextAlignmentCenter;
		Hour7.numberOfLines=0;
		[myContentview addSubview:Hour7];
		[Hour7 release];
		
		Hour8=[[UILabel alloc]init];
		Hour8.textColor=[UIColor  blackColor];
		Hour8.highlightedTextColor=[UIColor whiteColor];
		Hour8.font=[UIFont systemFontOfSize:12.5];
		Hour8.textAlignment=UITextAlignmentCenter;
		Hour8.numberOfLines=0;
		[myContentview addSubview:Hour8];
		[Hour8 release];
		
		Hour9=[[UILabel alloc]init];
		Hour9.textColor=[UIColor  blackColor];
		Hour9.highlightedTextColor=[UIColor whiteColor];
		Hour9.font=[UIFont systemFontOfSize:12.5];
		Hour9.textAlignment=UITextAlignmentCenter;
		Hour9.numberOfLines=0;
		[myContentview addSubview:Hour9];
		[Hour9 release];
		
		Hour10=[[UILabel alloc]init];
		Hour10.textColor=[UIColor  blackColor];
		Hour10.highlightedTextColor=[UIColor whiteColor];
		Hour10.font=[UIFont systemFontOfSize:12.5];
		Hour10.textAlignment=UITextAlignmentCenter;
		Hour10.numberOfLines=0;
		[myContentview addSubview:Hour10];
		[Hour10 release];
		
		Hour12=[[UILabel alloc]init];
		Hour12.textColor=[UIColor  blackColor];
		Hour12.highlightedTextColor=[UIColor whiteColor];
		Hour12.font=[UIFont systemFontOfSize:12.5];
		Hour12.textAlignment=UITextAlignmentCenter;
		Hour12.numberOfLines=0;
		[myContentview addSubview:Hour12];
		[Hour12 release];
		
		Hour13=[[UILabel alloc]init];
		Hour13.textColor=[UIColor  blackColor];
		Hour13.highlightedTextColor=[UIColor whiteColor];
		Hour13.font=[UIFont systemFontOfSize:12.5];
		Hour13.textAlignment=UITextAlignmentCenter;
		Hour13.numberOfLines=0;
		[myContentview addSubview:Hour13];		
		[Hour13 release];		
		
		Hour14=[[UILabel alloc]init];
		Hour14.textColor=[UIColor  blackColor];
		Hour14.highlightedTextColor=[UIColor whiteColor];
		Hour14.font=[UIFont systemFontOfSize:12.5];
		Hour14.textAlignment=UITextAlignmentCenter;
		Hour14.numberOfLines=0;
		[myContentview addSubview:Hour14];
		[Hour14 release];
		
		Hour11=[[UILabel alloc]init];
		Hour11.textColor=[UIColor  blackColor];
		Hour11.highlightedTextColor=[UIColor whiteColor];
		Hour11.font=[UIFont systemFontOfSize:12.5];
		Hour11.textAlignment=UITextAlignmentCenter;
		Hour11.numberOfLines=0;
		[myContentview addSubview:Hour11];
		[Hour11 release];
		
		Hour15=[[UILabel alloc]init];
		Hour15.textColor=[UIColor  blackColor];
		Hour15.highlightedTextColor=[UIColor whiteColor];
		Hour15.font=[UIFont systemFontOfSize:12.5];
		Hour15.textAlignment=UITextAlignmentCenter;
		Hour15.numberOfLines=0;
		[myContentview addSubview:Hour15];
		[Hour15 release];
		
		Hour16=[[UILabel alloc]init];
		Hour16.textColor=[UIColor  blackColor];
		Hour16.highlightedTextColor=[UIColor whiteColor];
		Hour16.font=[UIFont systemFontOfSize:12.5];
		Hour16.textAlignment=UITextAlignmentCenter;
		Hour16.numberOfLines=0;
		[myContentview addSubview:Hour16];
		[Hour16 release];
		
		Hour17=[[UILabel alloc]init];
		Hour17.textColor=[UIColor  blackColor];
		Hour17.highlightedTextColor=[UIColor whiteColor];
		Hour17.font=[UIFont systemFontOfSize:12.5];
		Hour17.textAlignment=UITextAlignmentCenter;
		Hour17.numberOfLines=0;
		[myContentview addSubview:Hour17];
		[Hour17 release];
		
		Hour18=[[UILabel alloc]init];
		Hour18.textColor=[UIColor  blackColor];
		Hour18.highlightedTextColor=[UIColor whiteColor];
		Hour18.font=[UIFont systemFontOfSize:12.5];
		Hour18.textAlignment=UITextAlignmentCenter;
		Hour18.numberOfLines=0;
		[myContentview addSubview:Hour18];
		[Hour18 release];
		
		Hour19=[[UILabel alloc]init];
		Hour19.textColor=[UIColor  blackColor];
		Hour19.highlightedTextColor=[UIColor whiteColor];
		Hour19.font=[UIFont systemFontOfSize:12.5];
		Hour19.textAlignment=UITextAlignmentCenter;
		Hour19.numberOfLines=0;
		[myContentview addSubview:Hour19];
		[Hour19 release];
		
		Hour20=[[UILabel alloc]init];
		Hour20.textColor=[UIColor  blackColor];
		Hour20.highlightedTextColor=[UIColor whiteColor];
		Hour20.font=[UIFont systemFontOfSize:12.5];
		Hour20.textAlignment=UITextAlignmentCenter;
		Hour20.numberOfLines=0;
		[myContentview addSubview:Hour20];
		[Hour20 release];
		
		Hour21=[[UILabel alloc]init];
		Hour21.textColor=[UIColor  blackColor];
		Hour21.highlightedTextColor=[UIColor whiteColor];
		Hour21.font=[UIFont systemFontOfSize:12.5];
		Hour21.textAlignment=UITextAlignmentCenter;
		Hour21.numberOfLines=0;
		[myContentview addSubview:Hour21];
		[Hour21 release];	
		
		Hour22=[[UILabel alloc]init];
		Hour22.textColor=[UIColor  blackColor];
		Hour22.highlightedTextColor=[UIColor whiteColor];
		Hour22.font=[UIFont systemFontOfSize:12.5];
		Hour22.textAlignment=UITextAlignmentCenter;
		Hour22.numberOfLines=0;
		[myContentview addSubview:Hour22];
		[Hour22 release];	
		
		
		Hour23=[[UILabel alloc]init];
		Hour23.textColor=[UIColor  blackColor];
		Hour23.highlightedTextColor=[UIColor whiteColor];
		Hour23.font=[UIFont systemFontOfSize:12.5];
		Hour23.textAlignment=UITextAlignmentCenter;
		Hour23.numberOfLines=0;
		[myContentview addSubview:Hour23];
		[Hour23 release];	
		
		
		Hour24=[[UILabel alloc]init];
		Hour24.textColor=[UIColor  blackColor];
		Hour24.highlightedTextColor=[UIColor whiteColor];
		Hour24.font=[UIFont systemFontOfSize:12.5];
		Hour24.textAlignment=UITextAlignmentCenter;
		Hour24.numberOfLines=0;
		[myContentview addSubview:Hour24];
		[Hour24 release];	
		
    }
    return self;
}

 // animate between regular and selected state
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:FALSE animated:animated];
	
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
	newLabel.backgroundColor = [UIColor clearColor];
	newLabel.opaque = YES;
	newLabel.textColor = primaryColor;
	newLabel.highlightedTextColor = selectedColor;
	newLabel.font = font;	
	return newLabel;
	
}

///// Set Frame of lables,textfield,Button,image etc in table view cell 

- (void)layoutSubviews {
	
    [super layoutSubviews];	

	Hour1.frame=CGRectMake(0, 5, 80-3,  self.frame.size.height-8);	
	Hour2.frame=CGRectMake(90*1+3, 5, 80-3,  self.frame.size.height-8);	
	Hour3.frame=CGRectMake(90*2+3, 5, 80-3,  self.frame.size.height-8);	
	Hour4.frame=CGRectMake(90*3+3, 5, 80-3,  self.frame.size.height-8);	
	Hour5.frame=CGRectMake(90*4+3, 5, 80-3,  self.frame.size.height-8);	
	Hour6.frame=CGRectMake(90*5+3, 5, 80-3,  self.frame.size.height-8);	
	Hour7.frame=CGRectMake(90*6+3, 5, 80-3,  self.frame.size.height-8);
	Hour8.frame=CGRectMake(90*7+3, 5, 80-3,  self.frame.size.height-8);	
	Hour9.frame=CGRectMake(90*8+3, 5, 80-3,  self.frame.size.height-8);
	
	Hour10.frame=CGRectMake(90*9+3, 5, 80-3,  self.frame.size.height-8);	
	Hour11.frame=CGRectMake(90*10+3, 5, 80-3,  self.frame.size.height-8);	
	Hour12.frame=CGRectMake(90*11+3, 5, 80-3,  self.frame.size.height-8);	
	Hour13.frame=CGRectMake(90*12+3, 5, 80-3,  self.frame.size.height-8);	
	Hour14.frame=CGRectMake(90*13+3, 5, 80-3,  self.frame.size.height-8);	
	Hour15.frame=CGRectMake(90*14+3, 5, 80-3,  self.frame.size.height-8);	
	Hour16.frame=CGRectMake(90*15+3, 5, 80-3,  self.frame.size.height-8);	
	Hour17.frame=CGRectMake(90*16+3, 5, 80-3,  self.frame.size.height-8);	
	Hour18.frame=CGRectMake(90*17+3, 5, 80-3,  self.frame.size.height-8);	
	Hour19.frame=CGRectMake(90*18+3, 5, 80-3,  self.frame.size.height-8);	
	Hour20.frame=CGRectMake(90*19+3, 5, 80-3,  self.frame.size.height-8);	
	Hour21.frame=CGRectMake(90*20+3, 5, 80-3,  self.frame.size.height-8);
	Hour22.frame=CGRectMake(90*21+3, 5, 80-3,  self.frame.size.height-8);
	Hour23.frame=CGRectMake(90*22+3, 5, 80-3,  self.frame.size.height-8);
	Hour24.frame=CGRectMake(90*23+3, 5, 80-3,  self.frame.size.height-8);
}

/////// Aclled when touch on label...
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{	
	
	Delegate=[[UIApplication sharedApplication]delegate];
	if(Delegate.ISEdit==TRUE)
	{
		UITouch *touch = [touches anyObject];
		NSLog(@"Touch");
		Delegate.SelectedLocation = [touch locationInView: [touch view]];
		int x=Delegate.SelectedLocation.x;
		int Z=x/90;
		lbl=[self CellLable:Z+1];
		lbl.backgroundColor=[UIColor colorWithRed:0.3607  green:0.5333 blue:0.9019 alpha:1.0];
		lbl.textColor=[UIColor whiteColor];
		Delegate.Row=self.tag;
		[Delegate.objShowReportViewController Click_Edit:lbl]; 
		
		[NSTimer scheduledTimerWithTimeInterval:(0.4) target:self selector:@selector(RemoveColor) userInfo:nil repeats:NO];
	}
//	
	
}

///// Change Label Color
-(void)RemoveColor
{
	lbl.backgroundColor=[UIColor clearColor];
	lbl.textColor=[UIColor blackColor];
}



/////// Return selected lable for change background color of label
-(UILabel *)CellLable:(NSInteger)Label
{
	//CalendarTableViewCell *cell=(CalendarTableViewCell *)[tblView cellForRowAtIndexPath:indexPathObj];
	
	switch (Label) 
	{
		case 1:
			return self.Hour1;
		case 2:
			return self.Hour2;
		case 3:
			return self.Hour3;
		case 4:
			return self.Hour4;
		case 5:
			return self.Hour5;
		case 6:
			return self.Hour6;
		case 7:
			return self.Hour7;
		case 8:
			return self.Hour8;
		case 9:
			return self.Hour9;
		case 10:
			return self.Hour10;
		case 11:
			return self.Hour11;
		case 12:
			return self.Hour12;
		case 13:
			return self.Hour13;
		case 14:
			return self.Hour14;
		case 15:
			return self.Hour15;
		case 16:
			return self.Hour16;
		case 17:
			return self.Hour17;
		case 18:
			return self.Hour18;
		case 19:
			return self.Hour19;
		case 20:
			return self.Hour20;
		case 21:
			return self.Hour21;
		case 22:
			return self.Hour22;
		case 23:
			return self.Hour23;
		case 24:
			return self.Hour24;
		default:
			break;
	}
	return nil;
}


- (void)dealloc {
    [super dealloc];
}

- (void)addColumn:(CGFloat)position {
//	[Columns removeAllObjects]; 
	Delegate=[[UIApplication sharedApplication]delegate];
	[Delegate.Columns addObject:[NSNumber numberWithFloat:position]];
	
}

///// Draw Line between Columns
- (void)drawRect:(CGRect)rect { 
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	Delegate=[[UIApplication sharedApplication]delegate];
	// just match the color and size of the horizontal line
	CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.5, 1.0); 
	CGContextSetLineWidth(ctx, 0.50);
	
	for (int i = 0; i < [Delegate.Columns count]; i++) {
		// get the position for the vertical line
		CGFloat f = [((NSNumber*) [Delegate.Columns objectAtIndex:i]) floatValue];
		if(i==0)
			f=90;
		CGContextMoveToPoint(ctx, f, 0);
		CGContextAddLineToPoint(ctx, f, self.bounds.size.height);
	}
	
	CGContextStrokePath(ctx);
	
	[super drawRect:rect];
} 
@end
