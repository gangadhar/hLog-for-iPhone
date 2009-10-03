//
//  DrawReports.m
//  HealthTracker
//  Created by Bhoomi on 3/3/09.
//  Copyright 2009 Elan. All rights reserved.
//
//
// Import All needed header files bellow.
#import "DrawReports.h"
//
//
@implementation DrawReports
//
//- (id)initWithFrame:(CGRect)frame {
//    if (self = [super initWithFrame:frame]) {
//		xData=[[NSMutableArray alloc]init];
//		yData=[[NSMutableArray alloc]init];
//		xValue=[[NSMutableArray alloc]init];
//		yValue=[[NSMutableArray alloc]init];
//        // Initialization code
//    }
//    return self;
//}
//
//- (void)drawRect:(CGRect)rect 
//{
//    // Drawing code
//	
//	//[xValue addObject:@"50"];
//	[xValue addObject:@"102"];
//	[xValue addObject:@"154"];
//	[xValue addObject:@"206"];
//	[xValue addObject:@"258"];
//	[xValue addObject:@"310"];
//	
//	[yValue addObject:@"45"];
//	[yValue addObject:@"135"];
//	[yValue addObject:@"230"];
//	[yValue addObject:@"335"];
//	[yValue addObject:@"415"];
//	
//	CGContextRef context = UIGraphicsGetCurrentContext();
//	CGContextSetLineWidth(context, 2.0f);
//	CGFloat gray[4] = {0.55, 0.30, 0.99, 1.0f};
//	CGContextSetStrokeColor(context, gray);
//	CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
//	
//	CGContextMoveToPoint(context, 50, 40);
//	CGContextAddLineToPoint(context, 50, 380);
//	
//	CGContextMoveToPoint(context, 50, 380);
//	CGContextAddLineToPoint(context, 310, 380);
//	
//	CGContextMoveToPoint(context, 45, 40);
//	CGContextAddLineToPoint(context, 55, 40);
//	
//	CGContextMoveToPoint(context, 45, 125);
//	CGContextAddLineToPoint(context, 55, 125);
//	
//	
//	CGFloat gray1[4] = {0.25, 0.50, 0.01, 1.0f};
//	CGContextSetStrokeColor(context, gray1);
//	CGContextMoveToPoint(context, 45, 205);
//	CGContextAddLineToPoint(context, 55, 205);
//	
//	CGContextMoveToPoint(context, 45, 290);
//	CGContextAddLineToPoint(context, 55, 290);
//	
//	CGContextMoveToPoint(context, 102, 375);
//	CGContextAddLineToPoint(context, 102, 385);
//	
//	CGContextMoveToPoint(context, 154, 375);
//	CGContextAddLineToPoint(context, 154, 385);
//	
//	CGContextMoveToPoint(context, 206, 375);
//	CGContextAddLineToPoint(context, 206, 385);
//	
//	CGContextMoveToPoint(context, 258, 375);
//	CGContextAddLineToPoint(context, 258, 385);
//	
//	CGContextMoveToPoint(context, 310, 375);
//	CGContextAddLineToPoint(context, 310, 385);
//	
//	
//	UILabel *lbl1=[[UILabel alloc]init];
//	lbl1.text=@"Best ";
//	lbl1.lineBreakMode=TRUE;
//	lbl1.numberOfLines=0;
//	lbl1.font=[UIFont systemFontOfSize:12];
//	lbl1.textColor=[UIColor redColor];
//	lbl1.textAlignment=UITextAlignmentRight;
//	lbl1.backgroundColor=[UIColor clearColor];
//	
//	lbl1.frame=CGRectMake(0,36, 46, 14);
//	
//	[self addSubview:lbl1];
//	
//	UILabel *lbl2=[[UILabel alloc]init];
//	lbl2.text=@"Better ";
//	lbl2.textAlignment=UITextAlignmentRight;
//	lbl2.font=[UIFont systemFontOfSize:12];
//	lbl2.textColor=[UIColor redColor];
//	lbl2.backgroundColor=[UIColor clearColor];
//	lbl2.frame=CGRectMake(00,110, 46, 28);
//	[self addSubview:lbl2];
//	
//	
//	UILabel *lbl3=[[UILabel alloc]init];
//	lbl3.text=@"Good ";
//	lbl3.textAlignment=UITextAlignmentRight;
//	lbl3.font=[UIFont systemFontOfSize:12];
//	lbl3.textColor=[UIColor redColor];
//	lbl3.backgroundColor=[UIColor clearColor];
//	lbl3.frame=CGRectMake(00,190, 46, 28);
//	[self addSubview:lbl3];
//	
//	
//	UILabel *lbl4=[[UILabel alloc]init];
//	lbl4.text=@"Not\nGood ";
//	lbl4.textAlignment=UITextAlignmentCenter;
//	lbl4.font=[UIFont systemFontOfSize:12];
//	lbl4.textColor=[UIColor redColor];
//	lbl4.backgroundColor=[UIColor clearColor];
//	lbl4.lineBreakMode=TRUE;
//	lbl4.numberOfLines=0;
//	lbl4.frame=CGRectMake(00,275, 50, 40);
//	[self addSubview:lbl4];
//	
//	UILabel *lbl5=[[UILabel alloc]init];
//	lbl5.text=@"08:00";
//	lbl5.textAlignment=UITextAlignmentLeft;
//	lbl5.font=[UIFont systemFontOfSize:12];
//	lbl5.backgroundColor=[UIColor whiteColor];
//	lbl5.textColor=[UIColor redColor];
//	lbl5.frame=CGRectMake(70,385, 50, 14);
//	//lbl5.transform=CGAffineTransformMakeRotation(-1.6);
//	[self addSubview:lbl5];
//	
//	UILabel *lbl6=[[UILabel alloc]init];
//	lbl6.text=@"10:00";
//	lbl6.textAlignment=UITextAlignmentLeft;
//	lbl6.font=[UIFont systemFontOfSize:12];
//	lbl6.textColor=[UIColor redColor];
//	lbl6.backgroundColor=[UIColor whiteColor];
//	lbl6.frame=CGRectMake(122,385, 50, 14);
//	//lbl6.transform=CGAffineTransformMakeRotation(-1.6);
//	[self addSubview:lbl6];
//	
//	
//	UILabel *lbl7=[[UILabel alloc]init];
//	lbl7.text=@"12:00";
//	lbl7.textAlignment=UITextAlignmentLeft;
//	lbl7.font=[UIFont systemFontOfSize:12];
//	lbl7.textColor=[UIColor redColor];
//	lbl7.backgroundColor=[UIColor whiteColor];
//	lbl7.frame=CGRectMake(174,385, 50, 14);
//	//lbl7.transform=CGAffineTransformMakeRotation(-1.6);
//	[self addSubview:lbl7];
//	
//	
//	UILabel *lbl8=[[UILabel alloc]init];
//	lbl8.text=@"14:00";
//	lbl8.textAlignment=UITextAlignmentLeft;
//	lbl8.font=[UIFont systemFontOfSize:12];
//	lbl8.textColor=[UIColor redColor];
//	lbl8.backgroundColor=[UIColor whiteColor];
//	lbl8.frame=CGRectMake(226,385, 50, 14);
//	//lbl8.transform=CGAffineTransformMakeRotation(-1.6);
//	[self addSubview:lbl8];
//	
//	
//	UILabel *lbl9=[[UILabel alloc]init];
//	lbl9.text=@"16:00";
//	lbl9.textAlignment=UITextAlignmentLeft;
//	lbl9.font=[UIFont systemFontOfSize:12];
//	lbl9.textColor=[UIColor redColor];
//	lbl9.backgroundColor=[UIColor whiteColor];
//	lbl9.frame=CGRectMake(278,385, 50, 14);
//	//lbl9.transform=CGAffineTransformMakeRotation(-1.6);
//	//UINavigationBar *nvBar=[[UINavigationBar alloc]init];
//	//	nvBar.frame=CGRectMake(0, 0, 320, 35);
//	//	
//	//	UINavigationItem *nitem=[[UINavigationItem alloc]init];
//	//	nitem.title=@"Chart";
//	////	[nvBar addSubview:nitem];
//	//	nvBar.;
//	//	[self addSubview:nvBar];
//	[self addSubview:lbl9];
//	[self drawChart:context];
//	CGContextStrokePath(context);
//}
//
//
//-(void)drawChart:(CGContextRef)context
//{
//	[self fillData];
//	for(int i=0; i<[yData count]-1; i++)
//	{
//		NSString* strYData = [yData objectAtIndex:i];
//		NSString *strdata1=[yData objectAtIndex:i+1];
//		
//		for(int j=0; j<[xData count];j++)
//		{
//			if([strYData isEqualToString:[xData objectAtIndex:j]])
//			{
//				for(int k=0;k<[xData count]; k++)
//				{
//					if([strdata1 isEqualToString:[xData objectAtIndex:k]])
//					{
//						CGContextMoveToPoint(context, [[xValue objectAtIndex:i]intValue], [[yValue objectAtIndex:j]intValue]);
//						CGContextAddLineToPoint(context, [[xValue objectAtIndex:i+1]intValue], [[yValue objectAtIndex:k]intValue]);
//					}
//				}
//			}
//		}
//	}
//	
//	
//}
//
//-(void)fillData
//{
//	
//	[xData addObject:@"Best"];
//	[xData addObject:@"Better"];
//	[xData addObject:@"Good"];
//	[xData addObject:@"Not Good"];
//	
//	
//	[yData addObject:@"Good"];
//	[yData addObject:@"Better"];
//	[yData addObject:@"Good"];
//	[yData addObject:@"Not Good"];
//	[yData addObject:@"Best"];
//}
//
//
//- (void)dealloc {
//    [super dealloc];
//}
//
//@end


@synthesize X,Y,Values,Left_Margin,Bottom_Margin;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		X=[[NSMutableArray alloc]init];
		Y=[[NSMutableArray alloc]init];		
		Values=[[NSMutableArray alloc]init];	
		
		Left_Margin=50;
		Bottom_Margin=50;
		
		WorkArea=CGRectMake(Left_Margin, Bottom_Margin, self.frame.size.width-Left_Margin-5, self.frame.size.height-Bottom_Margin-5);
		
		self.backgroundColor=[UIColor whiteColor];
		
		//
		//[X addObject:@"1"];
		//		[X addObject:@"2"];
		//		[X addObject:@"3"];	
		//		[X addObject:@"5"];
		//		[X addObject:@"6"];	
		//	[X addObject:@"7"];
		//		[X addObject:@"8"];
		//		[X addObject:@"9"];	
		//		[X addObject:@"10"];
		//[X addObject:@"11"];	
		
		///[Y addObject:@"2"];
		//[Y addObject:@"4"];
		//[Y addObject:@""];
		//[Y addObject:@"6"];
		//		[Y addObject:@"8"];	
		//		[Y addObject:@"10"];
		//		[Y addObject:@"12"];
		//		[Y addObject:@"14"];	
		
		//[Values addObject:@"1"];
		//		[Values addObject:@"2"];
		//		[Values addObject:@"3"];	
		//		[Values addObject:@"5"];
		//		[Values addObject:@"6"];	
		//	[Values addObject:@"1"];
		//		[Values addObject:@"2"];
		//		[Values addObject:@"3"];	
		//		[Values addObject:@"5"];		
		
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetLineWidth(context, 1.5);
	
	X_Interval=(self.frame.size.width-Left_Margin-5)/X.count;
	Y_Interval=(self.frame.size.height-Bottom_Margin-5)/Y.count;
	
	CGFloat gray1[4] =  {0.3921f, 0.5294f, 0.1294f, 1.0f};
	
	CGContextSetStrokeColor(context, gray1);
	
	//Draw X Axis Line
	CGContextMoveToPoint(context, 5+Left_Margin, 5);
	CGContextAddLineToPoint(context, 5+Left_Margin, self.frame.size.height-Bottom_Margin);
	CGContextStrokePath(context);
	
	//Draw Y Axis Line
	CGContextMoveToPoint(context, Left_Margin, self.frame.size.height-Bottom_Margin-5);
	CGContextAddLineToPoint(context, self.frame.size.width-5, self.frame.size.height-Bottom_Margin-5);
	CGContextStrokePath(context);
	
	//Draw X axis
	NSString* Value;
	for(int i=0;i<X.count;i++)
	{
		
		CGFloat gray2[4] = {0.5960f, 0.0f, 0.0f, 1.0f};
		
		CGContextSetStrokeColor(context, gray2);
		
		CGContextMoveToPoint(context, Left_Margin+(i+1)*X_Interval, self.frame.size.height-Bottom_Margin-6);
		CGContextAddLineToPoint(context, Left_Margin+(i+1)*X_Interval, self.frame.size.height-Bottom_Margin);
		CGContextStrokePath(context);
		
		Value=[X objectAtIndex:i];
		[Value drawInRect:CGRectMake(5+Left_Margin+(i)*X_Interval, self.frame.size.height-Bottom_Margin, X_Interval, 20) withFont:[UIFont systemFontOfSize:10] lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentCenter];
	}
	
	//Draw Y axis
	for(int i=0;i<Y.count;i++)
	{
		CGFloat gray3[4] = {0.5960f, 0.0f, 0.0f, 1.0f};
		
		CGContextSetStrokeColor(context, gray3);
		
		CGContextMoveToPoint(context, Left_Margin, self.frame.size.height-Bottom_Margin-(i+1)*Y_Interval);
		CGContextAddLineToPoint(context, Left_Margin+6, self.frame.size.height-Bottom_Margin-(i+1)*Y_Interval);
		CGContextStrokePath(context);
		
		Value=[Y objectAtIndex:i];
		[Value drawInRect:CGRectMake(5, self.frame.size.height-Bottom_Margin-(i+1)*Y_Interval, Left_Margin-5, 20) withFont:[UIFont systemFontOfSize:10] lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentRight];
	}
	
	
	//CGFloat gray[4] = {0.6f, 0.5f, 0.9f, 1.0f};
	CGFloat gray[4] = {0.5960f, 0.0f, 0.0f, 1.0f};
	
	CGContextSetStrokeColor(context, gray);
	
	CGContextSetLineWidth(context, 3.5);
	
	double valueGap=0;
	
	if(Y.count>=2)
		valueGap=[[Y objectAtIndex:1] doubleValue]-[[Y objectAtIndex:0] doubleValue];
	
	double v,old,new;
	//Draw Y axis
	for(int i=0;i<Values.count;i++)
	{		
		v=[[Values objectAtIndex:i] doubleValue];
		
		if(i>0)
		{
			new=v;
			
			if(old>0)
				CGContextMoveToPoint(context, Left_Margin+(i)*X_Interval, self.frame.size.height-Bottom_Margin-(old)*Y_Interval/valueGap);
			else
				CGContextMoveToPoint(context, Left_Margin+(i)*X_Interval, self.frame.size.height-Bottom_Margin-5);
			
			if(new>0)
				CGContextAddLineToPoint(context, Left_Margin+(i+1)*X_Interval, self.frame.size.height-Bottom_Margin-(new)*Y_Interval/valueGap);
			else
				CGContextAddLineToPoint(context, Left_Margin+(i+1)*X_Interval, self.frame.size.height-Bottom_Margin-5);
			
			CGContextStrokePath(context);
			
			old=v;
		}
		else
		{
			old=v;
		}
	}	
}


- (void)dealloc {
    [super dealloc];
}


@end

