//
//  ReportViewController.m
//  HealthTracker
//  Created by Bhoomi on 3/3/09.
//  Copyright 2009 Elan. All rights reserved.
//

// Import All needed header files bellow.
#import "ReportViewController.h"


@implementation ReportViewController

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	DateFormatter1=[[NSDateFormatter alloc]init];	
	DateFormatter=[[NSDateFormatter alloc]init];
//	[DateFormatter setDateFormat:@"yyyy-MM-dd"];
	[DateFormatter setDateFormat:@"MM-dd-yyyy"];
	appDelegate=[[UIApplication sharedApplication]delegate];
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
	
	objChartView=[[DrawReports alloc]initWithFrame:CGRectMake(0, 0, 320, 416)];
	[objChartView setBackgroundColor:[UIColor lightGrayColor]];
	[self.view addSubview:objChartView];
	//[objChartView release];
	self.navigationItem.title=[NSString stringWithFormat:@"%@",appDelegate.SelectColumnName1]; 
	objChartView.Left_Margin=25;
	objChartView.Bottom_Margin=20;
	
	if(objChartView.X)
	{
		objChartView.X=nil;
	}
	if(!objChartView.X)
	{
		objChartView.X=[[NSMutableArray alloc]init];
	}	
	
	if(DateArray)
	{
		DateArray=nil;
	}
	if(!DateArray)
	{
		DateArray=[[NSMutableArray alloc]init];
	}	
	
	if(objChartView.Y)
	{
		objChartView.Y=nil;
	}
	if(!objChartView.Y)
	{
		objChartView.Y=[[NSMutableArray alloc]init];
	}	
	if(objChartView.Values)
	{
		objChartView.Values=nil;
	}
	if(!objChartView.Values)
	{
		objChartView.Values=[[NSMutableArray alloc]init];
	}	
	if(appDelegate.isDailyReport==TRUE)
	{
		[self SetHeaderLable:-6 withEndatae:0];
	}
	else
	{
		[self SetTimeLable];
	}
}

-(void)SetTimeLable
{
	
	[DateFormatter1 setDateFormat:@"HH"];
	NSString *string=[DateFormatter1 stringFromDate:[NSDate date]];
	for(int i=1;i<=[string intValue];i++)
	{
		[DateArray addObject:[NSString stringWithFormat:@"%02d:00",i]];
		[objChartView.X addObject:[NSString stringWithFormat:@"%02d:00",i]];
		[objChartView.Values addObject:@"0"];
	}
	[appDelegate SelectHourlyReportData:appDelegate.SelectColumnName   FromDate:[DateFormatter stringFromDate:[NSDate date]] andUserID:appDelegate.SelectedUserID]; 
	
	if([appDelegate.SelectColumnName isEqualToString:@"Mood"])
	{
		[objChartView.Y addObject:@"1"];
		[objChartView.Y addObject:@"2"];
		[objChartView.Y addObject:@"3"];
		[objChartView.Y addObject:@"4"];
		
		for(int i=0;i<[appDelegate.HourlyReportArray  count];i++)
		{
			
			NSDictionary *Dict=[appDelegate.HourlyReportArray objectAtIndex:i];
			NSString *Value=[Dict objectForKey:@"SelectData"];
			NSString *Date=[Dict objectForKey:@"Time"];
			BOOL result=[DateArray containsObject:Date];
			if(result==TRUE)
			{
				int Index=[DateArray indexOfObject:Date];
				
				if([Value isEqualToString:@"Stressed"])
				{
					[objChartView.Values replaceObjectAtIndex:Index  withObject:@"1"];
				}
				else if([Value isEqualToString:@"Relaxed"])
				{
					[objChartView.Values replaceObjectAtIndex:Index  withObject:@"2"];
				}
				else if([Value isEqualToString:@"Happy"])
				{
					[objChartView.Values replaceObjectAtIndex:Index  withObject:@"3"];
				}
				else if([Value isEqualToString:@"Depressed"])
				{
					[objChartView.Values replaceObjectAtIndex:Index  withObject:@"4"];
				}
			}
		}
		
	}
	else if([appDelegate.SelectColumnName isEqualToString:@"Temperature"])
	{
		[objChartView.Y addObject:@"20"];
		[objChartView.Y addObject:@"40"];
		[objChartView.Y addObject:@"60"];
		[objChartView.Y addObject:@"80"];
		[objChartView.Y addObject:@"100"];
		for(int i=0;i<[appDelegate.HourlyReportArray  count];i++)
		{
			
			NSDictionary *Dict=[appDelegate.HourlyReportArray objectAtIndex:i];
			NSString *Value=[Dict objectForKey:@"SelectData"];
			NSString *Date=[Dict objectForKey:@"Time"];
			BOOL result=[DateArray containsObject:Date];
			if(result==TRUE)
			{
				int Index=[DateArray indexOfObject:Date];
				if([Value length]>0)
				{
					Value=[Value stringByReplacingOccurrencesOfString:@" º" withString:@""];
					[objChartView.Values replaceObjectAtIndex:Index  withObject:Value];
				}
			}
			
			
		}
		NSString *Data=@"0";
		for(int j=0;j<[objChartView.Values count];j++)
		{

			if([[objChartView.Values objectAtIndex:j] length]>0 && (![[objChartView.Values objectAtIndex:j]isEqualToString:@"0"]) )
			{
				Data=[objChartView.Values objectAtIndex:j];
			}
			else
			{
				[objChartView.Values replaceObjectAtIndex:j  withObject:Data];
			}
		}
	}
	else if([appDelegate.SelectColumnName isEqualToString:@"BP_Entry"])
	{
		[objChartView.Y addObject:@"0"];
		[objChartView.Y addObject:@"40"];
		[objChartView.Y addObject:@"80"];
		[objChartView.Y addObject:@"120"];
		[objChartView.Y addObject:@"160"];
		[objChartView.Y addObject:@"200"];
		
		for(int i=0;i<[appDelegate.HourlyReportArray  count];i++)
		{
			NSDictionary *Dict=[appDelegate.HourlyReportArray objectAtIndex:i];
			NSString *Value=[Dict objectForKey:@"SelectData"];
			NSString *Date=[Dict objectForKey:@"Time"];
			BOOL result=[DateArray containsObject:Date];
			if(result==TRUE)
			{
				int Index=[DateArray indexOfObject:Date];
				if([Value length]>0)
				{
					Value=[Value stringByReplacingOccurrencesOfString:@" º" withString:@""];
					NSArray *arr=[Value componentsSeparatedByString:@"/"];
					if([appDelegate.SelectColumnName1 isEqualToString:@"BP(Systolic)"])
					{
						[objChartView.Values replaceObjectAtIndex:Index  withObject:[arr objectAtIndex:0]];
					}
					else
					{
						if([arr count]>1)
						{
							[objChartView.Values replaceObjectAtIndex:Index  withObject:[arr objectAtIndex:1]];
						}
					}
				}
				
			}
		}
		NSString *Data=@"0";
		for(int j=0;j<[objChartView.Values count];j++)
		{
			if([[objChartView.Values objectAtIndex:j] length]>0 && (![[objChartView.Values objectAtIndex:j]isEqualToString:@"0"]) )
			{
				Data=[objChartView.Values objectAtIndex:j];
			}
			else
			{
				[objChartView.Values replaceObjectAtIndex:j  withObject:Data];
			}
		}
	}
	else if([appDelegate.SelectColumnName isEqualToString:@"HeartRate"])
	{
		[objChartView.Y addObject:@"25"];
		[objChartView.Y addObject:@"50"];
		[objChartView.Y addObject:@"75"];
		[objChartView.Y addObject:@"100"];
		[objChartView.Y addObject:@"125"];
		[objChartView.Y addObject:@"150"];
		[objChartView.Y addObject:@"175"];
		[objChartView.Y addObject:@"200"];
		for(int i=0;i<[appDelegate.HourlyReportArray  count];i++)
		{
			
			NSDictionary *Dict=[appDelegate.HourlyReportArray objectAtIndex:i];
			NSString *Value=[Dict objectForKey:@"SelectData"];
			NSString *Date=[Dict objectForKey:@"Time"];
			BOOL result=[DateArray containsObject:Date];
			if(result==TRUE)
			{
				int Index=[DateArray indexOfObject:Date];
				if([Value length]>0)
				{
					[objChartView.Values replaceObjectAtIndex:Index  withObject:Value];
				}
				
			}
		}
		NSString *Data=@"0";
		for(int j=0;j<[objChartView.Values count];j++)
		{
			if([[objChartView.Values objectAtIndex:j] length]>0 && (![[objChartView.Values objectAtIndex:j]isEqualToString:@"0"]) )
			{
				Data=[objChartView.Values objectAtIndex:j];
			}
			else
			{
				[objChartView.Values replaceObjectAtIndex:j  withObject:Data];
			}
		}
	}
	else if([appDelegate.SelectColumnName isEqualToString:@"CigarateSmoked"])
	{
		[objChartView.Y addObject:@"0"];
		[objChartView.Y addObject:@"1"];
		
		for(int i=0;i<[appDelegate.HourlyReportArray  count];i++)
		{
			
			NSDictionary *Dict=[appDelegate.HourlyReportArray objectAtIndex:i];
			NSString *Value=[Dict objectForKey:@"SelectData"];
			NSString *Date=[Dict objectForKey:@"Time"];
			BOOL result=[DateArray containsObject:Date];
			if(result==TRUE)
			{
				int Index=[DateArray indexOfObject:Date];
				if([Value length]>0)
				{
					[objChartView.Values replaceObjectAtIndex:Index  withObject:Value];
				}
				
			}
		}
	}
	

}

-(void)SetHeaderLable:(NSInteger)StartPoint withEndatae:(NSInteger)EndPoint
{
//	[DateFormatter setDateFormat:@"yyyy-dd-MM"];
	
	[DateFormatter1 setDateFormat:@"dd-MMM"];
	NSDateComponents *comps= [[[NSDateComponents alloc] init] autorelease];
	
	[comps setDay:StartPoint];
	
	NSDate *StartDate = [[NSCalendar currentCalendar] dateByAddingComponents:comps toDate:[NSDate date] options:0];	
	NSString *Date3=[DateFormatter1 stringFromDate:StartDate];
	
	[objChartView.X addObject:Date3];
	[DateArray addObject:[DateFormatter stringFromDate:StartDate]];
	[objChartView.Values addObject:@"0"];
	[comps setDay:EndPoint-5]; //Use what you want here, set other components as needed
	NSDate *TmpDate = [[NSCalendar currentCalendar] dateByAddingComponents:comps toDate:[NSDate date] options:0];
	Date3=[DateFormatter1 stringFromDate:TmpDate];
	
	[objChartView.X addObject:Date3];
	[DateArray addObject:[DateFormatter stringFromDate:TmpDate]];
	[objChartView.Values addObject:@"0"];
	
	[comps setDay:EndPoint-4]; //Use what you want here, set other components as needed
	TmpDate = [[NSCalendar currentCalendar] dateByAddingComponents:comps toDate:[NSDate date] options:0];
	Date3=[DateFormatter1 stringFromDate:TmpDate];
	[objChartView.X addObject:Date3];
	[DateArray addObject:[DateFormatter stringFromDate:TmpDate]];
	[objChartView.Values addObject:@"0"];
	
	[comps setDay:EndPoint-3]; //Use what you want here, set other components as needed
	TmpDate = [[NSCalendar currentCalendar] dateByAddingComponents:comps toDate:[NSDate date] options:0];
	Date3=[DateFormatter1 stringFromDate:TmpDate];
	[objChartView.X addObject:Date3];
	[DateArray addObject:[DateFormatter stringFromDate:TmpDate]];
	[objChartView.Values addObject:@"0"];
	
	[comps setDay:EndPoint-2]; //Use what you want here, set other components as needed
	TmpDate = [[NSCalendar currentCalendar] dateByAddingComponents:comps toDate:[NSDate date] options:0];
	Date3=[DateFormatter1 stringFromDate:TmpDate];
	[objChartView.X addObject:Date3];
	[DateArray addObject:[DateFormatter stringFromDate:TmpDate]];
	[objChartView.Values addObject:@"0"];
	
	[comps setDay:EndPoint-1]; //Use what you want here, set other components as needed
	
	TmpDate = [[NSCalendar currentCalendar] dateByAddingComponents:comps toDate:[NSDate date] options:0];
	Date3=[DateFormatter1 stringFromDate:TmpDate];
	[DateArray addObject:[DateFormatter stringFromDate:TmpDate]];
	[objChartView.X addObject:Date3];
	[objChartView.Values addObject:@"0"];
	
	[comps setDay:EndPoint]; //Use what you want here, set other components as needed
	NSDate *EndDate = [[NSCalendar currentCalendar] dateByAddingComponents:comps toDate:[NSDate date] options:0];
	//NSString *Date1=[DateFormatter stringFromDate: EndDate];
	
	 Date3=[DateFormatter1 stringFromDate:EndDate];
	[DateArray addObject:[DateFormatter stringFromDate:EndDate]];
	[objChartView.X addObject:Date3];
	[objChartView.Values addObject:@"0"];
	
	[appDelegate SelectReportData:appDelegate.SelectColumnName  FromDate:[DateFormatter stringFromDate:StartDate] ToDate:[DateFormatter stringFromDate:EndDate] andUserID:appDelegate.SelectedUserID]; 
	
	if([appDelegate.SelectColumnName isEqualToString:@"Mood"])
	{
		[objChartView.Y addObject:@"1"];
		[objChartView.Y addObject:@"2"];
		[objChartView.Y addObject:@"3"];
		[objChartView.Y addObject:@"4"];
		
		for(int i=0;i<[appDelegate.DailyReportArray count];i++)
		{
			
			NSDictionary *Dict=[appDelegate.DailyReportArray objectAtIndex:i];
			NSString *Value=[Dict objectForKey:@"SelectData"];
			NSString *Date=[Dict objectForKey:@"Date"];
			BOOL result=[DateArray containsObject:Date];
			if(result==TRUE)
			{
				int Index=[DateArray indexOfObject:Date];
				
				if([Value isEqualToString:@"Stressed"])
				{
					[objChartView.Values replaceObjectAtIndex:Index  withObject:@"1"];
				}
				else if([Value isEqualToString:@"Relaxed"])
				{
					[objChartView.Values replaceObjectAtIndex:Index  withObject:@"2"];
				}
				else if([Value isEqualToString:@"Happy"])
				{
					[objChartView.Values replaceObjectAtIndex:Index  withObject:@"3"];
				}
				else if([Value isEqualToString:@"Depressed"])
				{
					[objChartView.Values replaceObjectAtIndex:Index  withObject:@"4"];
				}
			}
		}
		
	}
	else if([appDelegate.SelectColumnName isEqualToString:@"NoofHoursofSleep"])
	{
		[objChartView.Y addObject:@"4"];
		[objChartView.Y addObject:@"9"];
		[objChartView.Y addObject:@"14"];
		[objChartView.Y addObject:@"19"];
		[objChartView.Y addObject:@"24"];
		for(int i=0;i<[appDelegate.DailyReportArray count];i++)
		{
			NSDictionary *Dict=[appDelegate.DailyReportArray objectAtIndex:i];
			NSString *Value=[Dict objectForKey:@"SelectData"];
			NSString *Date=[Dict objectForKey:@"Date"];
			BOOL result=[DateArray containsObject:Date];
			if(result==TRUE)
			{
				int Index=[DateArray indexOfObject:Date];
				[objChartView.Values replaceObjectAtIndex:Index  withObject:Value];				
			}
		}
	}
	else if([appDelegate.SelectColumnName isEqualToString:@"Weight_Pound"])
	{
		[objChartView.Y addObject:@"50"];
		[objChartView.Y addObject:@"100"];
		[objChartView.Y addObject:@"150"];
		[objChartView.Y addObject:@"200"];
		[objChartView.Y addObject:@"250"];
		[objChartView.Y addObject:@"300"];
		[objChartView.Y addObject:@"350"];
		[objChartView.Y addObject:@"400"];
		
		for(int i=0;i<[appDelegate.DailyReportArray count];i++)
		{
			
			NSDictionary *Dict=[appDelegate.DailyReportArray objectAtIndex:i];
			NSString *Value=[Dict objectForKey:@"SelectData"];
			NSString *Date=[Dict objectForKey:@"Date"];
			BOOL result=[DateArray containsObject:Date];
			if(result==TRUE)
			{
				int Index=[DateArray indexOfObject:Date];
				[objChartView.Values replaceObjectAtIndex:Index  withObject:Value];				
			}
		}
		
	}
	else if([appDelegate.SelectColumnName isEqualToString:@"Weight_KGS"])
	{
		[objChartView.Y addObject:@"30"];
		[objChartView.Y addObject:@"60"];
		[objChartView.Y addObject:@"90"];
		[objChartView.Y addObject:@"120"];
		[objChartView.Y addObject:@"150"];
		
		for(int i=0;i<[appDelegate.DailyReportArray count];i++)
		{
			
			NSDictionary *Dict=[appDelegate.DailyReportArray objectAtIndex:i];
			NSString *Value=[Dict objectForKey:@"SelectData"];
			NSString *Date=[Dict objectForKey:@"Date"];
			BOOL result=[DateArray containsObject:Date];
			if(result==TRUE)
			{
				int Index=[DateArray indexOfObject:Date];
				[objChartView.Values replaceObjectAtIndex:Index  withObject:Value];				
			}
		}
		
	}
	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	
	[objChartView release];
	[DateFormatter1 release];
	[DateArray release];
 	[DateFormatter release];
	
    [super dealloc];
}


@end
