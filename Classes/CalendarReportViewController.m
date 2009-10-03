//
//  CalendarReportViewController.m
//  hLog
//
//  Created by Bhoomi on 4/1/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import "CalendarReportViewController.h"
#import "AddUserButtonTableViewCell.h"
#import "SettingTableViewCell.h"

#define Field_Array [NSArray arrayWithObjects: @"BP",@"Blood Sugar",@"Temperature",@"Fasting Blood Sugar", @"Pulse",@"Respiration",@"Weight",@"Height",@"Pain",@"Other-Vitals",@"Sleep Times",@"Sleep Duration", @"Exercise",@"Mood",@"Activity",@"Diapering", @"Food Consumption",@"Calories Consumed",@"Alcohol",@"Cigarettes",@"Drugs",@"Menstruation",@"Other-Routines",@"Medicine",nil]
#define Field_Table_Array [NSArray arrayWithObjects: @"BP",@"BloodSugar",@"TemperatureF",@"Fasting", @"Pulse",@"Respiration",@"WeightKgs",@"HeightCms",@"Pain",@"Other_Vitals",@"Sleep",@"Sleep1", @"Exercise_id",@"Mood",@"Activity",@"Diapering", @"Feeding",@"calories",@"Alcohol",@"Cigarrettes",@"Drugs",@"Menstrution",@"Other_Routines",@"Medicine_Entry",nil]


@implementation CalendarReportViewController
#pragma mark Button Click Methods

//// Called when clicked on Done Button
-(IBAction)btnDone_click:(id)sender
{
	ToolBar.hidden=TRUE;
	DatePicker.hidden=TRUE;
	[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
	if(SelectedTag==0)
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		if([appDelegate.ReportEndDate isEqualToString:@""])
		{
			appDelegate.ReportStartDate=[appDelegate.DateFormatter stringFromDate:DatePicker.date];
			appDelegate.ReportStartDate=appDelegate.ReportStartDate;
		}
		else
		{
			NSDate *date=[appDelegate.DateFormatter dateFromString:appDelegate.ReportEndDate];
			if([DatePicker.date timeIntervalSinceDate:date]>0)
			{
				UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Start date must be \n less than or equal to end date" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alert show];
				[alert release];
			}
			else
			{
				appDelegate.ReportStartDate=[appDelegate.DateFormatter stringFromDate:DatePicker.date];
				appDelegate.ReportStartDate=[NSString stringWithFormat:@"%@",appDelegate.ReportStartDate];
			}
		}
		[Pool release];
	}
	else if(SelectedTag==1)
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		if([appDelegate.ReportStartDate isEqualToString:@""])
		{
			
		}
		else
		{
			NSDate *date=[appDelegate.DateFormatter dateFromString:appDelegate.ReportStartDate];
			if([DatePicker.date timeIntervalSinceDate:date]<0)
			{
				UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"End date must be \n greater than or equal to start date" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alert show];
				[alert release];
			}
			else
			{
				appDelegate.ReportEndDate=[appDelegate.DateFormatter stringFromDate:DatePicker.date];
				appDelegate.ReportEndDate=[NSString stringWithFormat:@"%@",appDelegate.ReportEndDate];
			}
		}
		[Pool release];
	}
	[tblView reloadData];
}

///// Called when press Cancel Button
-(IBAction)btnCancel_Clicked:(id)sender
{
	tblView.userInteractionEnabled=TRUE;
	ToolBar.hidden=TRUE;
	DatePicker.hidden=TRUE;
}

///// Check All fields

-(IBAction)checkAll:(id)sender
{
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	for(int i=0; i<[selectedArray count]; i++)
	{
		[selectedArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",1]];
	}
	[tblView reloadData];
	[Pool release];
}

//// Uncheck All fields
-(IBAction)uncheckAll:(id)sender
{
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	for(int i=0; i<[selectedArray count]; i++)
	{
		[selectedArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",0]];
	}
	[tblView reloadData];
	[Pool release];
}

/// Call When Press report Button
-(IBAction)btnReport_Click:(id)sender
{	
	Activity.hidden=FALSE;
	[Activity startAnimating];
	DatePicker.hidden=TRUE;
	ToolBar.hidden=TRUE;
	tblView.userInteractionEnabled=FALSE; 
	btnReport.enabled=FALSE;
	[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
	[NSThread detachNewThreadSelector:@selector(ShowReport) toTarget:self withObject:nil];
}

//// Called When Click on Send Via Mail
-(IBAction)btnSend_Click:(id)sender
{
	[self ConcateString]; 
	if([arr2 count]>0)
	{
		[self LoadReport];
		if([appDelegate.WeekArray count]>0)
		{
			if(!tmpArray)
				tmpArray=[[NSMutableArray alloc]init];
			else
				[tmpArray removeAllObjects];
			[tmpArray addObjectsFromArray:[appDelegate.WeekArray mutableCopy]];
			[appDelegate.WeekArray removeAllObjects];
			for(int i=0;i<[tmpArray count];i++)
			{
				NSString *str=[tmpArray objectAtIndex:i];
				[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
				NSDate *tmpDate=[appDelegate.DateFormatter dateFromString:str];
				[appDelegate.DateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
				str=[appDelegate.DateFormatter stringFromDate:tmpDate];
				[appDelegate.WeekArray addObject:[str mutableCopy]];
			}
			NSSortDescriptor *lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
			[appDelegate.WeekArray sortUsingDescriptors:[NSArray arrayWithObject:lastNameDescriptor]];
			//bubbleSort(appDelegate.WeekArray);	
			
			[tmpArray removeAllObjects];
			[tmpArray addObjectsFromArray:[appDelegate.WeekArray mutableCopy]];
			[appDelegate.WeekArray removeAllObjects];
			for(int i=0;i<[tmpArray count];i++)
			{
				NSString *str=[tmpArray objectAtIndex:i];
				[appDelegate.DateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
				
				NSDate *tmpDate=[appDelegate.DateFormatter dateFromString:str];
				[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
				str=[appDelegate.DateFormatter stringFromDate:tmpDate];
				[appDelegate.WeekArray addObject:[str mutableCopy]];
			}
			
			
			[self makeCsvFile];		
			appDelegate.isForMail=TRUE;
			appDelegate.isfromRoot=FALSE;
			if(!appDelegate.RegistrationDic)
				appDelegate.RegistrationDic=[[NSMutableDictionary alloc]init];
			else
				[appDelegate.RegistrationDic removeAllObjects];
			[appDelegate.RegistrationDic setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"SMTP"]  forKey:@"SMTP Host"];
			[appDelegate.RegistrationDic setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"FromEmail"]  forKey:@"From E-Mail"];
			[appDelegate.RegistrationDic setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"Password"]   forKey:@"Password"];
			[appDelegate.RegistrationDic setValue:@""   forKey:@"Contact_Info"];
			[appDelegate.RegistrationDic setValue:@""   forKey:@"Contact_ID"];
			appDelegate.isforReport=FALSE;
			if(!appDelegate.NewTableArray)
				appDelegate.NewTableArray=[[NSMutableArray alloc]init];
			if([appDelegate.NewTableArray count]>0)
				[appDelegate.NewTableArray removeAllObjects];
			if(!appDelegate.objFirstViewController)
			{
				appDelegate.objFirstViewController=[[FirstViewController alloc]initWithNibName:@"First_View" bundle:nil];
			}
			[appDelegate.NewTableArray removeAllObjects];
			[self.navigationController pushViewController:appDelegate.objFirstViewController animated:YES];	
		}
		else
		{ 
			UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"There are no records to export" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			alert.tag=5;
			[alert show];
			[alert release];
		}
	}
	else
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Select at least one field to send a mail" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		alert.tag=5;
		[alert show];
		[alert release];
		Activity.hidden=TRUE;
		[Activity stopAnimating];
		tblView.userInteractionEnabled=TRUE;
		btnReport.enabled=TRUE;
		[[UIApplication sharedApplication] endIgnoringInteractionEvents];
	}
}

/// Called when Get Records form Table
-(void)LoadReport
{
	NSAutoreleasePool  *Pool=[[NSAutoreleasePool alloc]init];
	@try 
	{
		NSArray *Start=[appDelegate.ReportStartDate componentsSeparatedByString:@" "];
		NSArray *End=[appDelegate.ReportEndDate componentsSeparatedByString:@" "];
		if(!appDelegate.ReportArray)
		{
			appDelegate.ReportArray=[[NSMutableDictionary alloc]init];
		}
		else if([appDelegate.ReportArray count]>0)
		{
			[appDelegate.ReportArray removeAllObjects];
		}		
		if(!appDelegate.WeekArray)
		{
			appDelegate.WeekArray=[[NSMutableArray alloc]init];
		}
		else if([appDelegate.WeekArray count]>0)
		{
			[appDelegate.WeekArray removeAllObjects];
		}
		NSString *Coulmnname=@"";
		NSArray *arr23=[appDelegate.SelectedReportField componentsSeparatedByString:@", "]; 
		for(int i=0;i<[arr23 count];i++)
		{
			NSString *Str=[arr23 objectAtIndex:i];
			Index=[Field_Table_Array indexOfObject:Str];
			Coulmnname=[Field_Table_Array objectAtIndex:Index];
			if(Index==6)
			{
				if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Weight"] isEqualToString:@"LBs"])
				{
					Coulmnname=@"WeightLbs";
				}
				else
				{
					Coulmnname=@"WeightKgs";
				}				
			}			
			if(Index==7)
			{
				if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Height"] isEqualToString:@"Inches"])
				{
					Coulmnname=@"HeightInch";
				}
				else
				{
					Coulmnname=@"HeightCms";
				}				
			}			
			if(Index==2)
			{
				if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Temperature"] isEqualToString:@"F"])
				{
					Coulmnname=@"TemperatureF";
				}
				else
				{
					Coulmnname=@"TemperatureC";
				}
			}			
			NSString *TableName=@"Vitals_Detail";
			if(Index>9)
			{
				TableName=@"Routine_Detail";
			}
			if(Index==23)
			{
				TableName=@"Medicine";
			}
			NSLog(@"%d",Index);
			if(Index==21)
			{			
				[appDelegate SelectWeeklyDataForMemstrual:[NSString stringWithFormat:@"%@ %@",[Start objectAtIndex:0],[Start objectAtIndex:1]]  PassEndDate:[NSString stringWithFormat:@"%@ %@",[End objectAtIndex:0],[End objectAtIndex:1]] andUserID:appDelegate.SelectedUserID]; 
			}			
			else
			{
				[appDelegate GetVitalsCalendarData:Coulmnname StartDate:[Start objectAtIndex:0]  Enddate:[End objectAtIndex:0] StartTime:[Start objectAtIndex:1] EndTime:[End objectAtIndex:1] andUserID:appDelegate.SelectedUserID andTableName:TableName];
			}
		}	
	}
	@catch (NSException * e)
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Catch" message:[NSString stringWithFormat:@"%@",e] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}	
	[Pool release];
}

///// Make CVS base on Records

-(void)makeCsvFile
{
	NSString *csvString=@"";
	[arr1 insertObject:@"Date/Time" atIndex:0];
	for(int i=0;i<[arr1 count];i++)
	{
		if(i==([arr1 count]-1))
		{				
			csvString=[csvString stringByAppendingString:[NSString stringWithFormat:@"\"%@\"\n",[arr1 objectAtIndex:i]]];			
		}
		else
		{							
			csvString=[csvString stringByAppendingString:[NSString stringWithFormat:@"\"%@\",",[arr1 objectAtIndex:i]]];			
		}
	}
	
	for(int i=0;i<[appDelegate.WeekArray count];i++)
	{
		Date=(NSString*)[appDelegate.WeekArray objectAtIndex:i];
		csvString=[csvString stringByAppendingString:[NSString stringWithFormat:@"%@,",Date]];
		
		for(int j=0;j<[arr2 count];j++)
		{
			FieldName=[arr2 objectAtIndex:j];
			NSDictionary *Dict;
			Str1=@"";
			if([FieldName isEqualToString:@"Menstruation"])
			{
				Dict=[appDelegate.ReportArray valueForKey:FieldName];
				if([[Dict valueForKey:[NSString stringWithFormat:@"%@",Date]] length]>0)
				{
					Str1=@"Start Date";
				}
				else if([[Dict valueForKey:[NSString stringWithFormat:@"%@",Date]] length]>0)
				{
					Str1=@"End Date";
				}
				else
					Str1=@"";
			}
			else
			{
				if([FieldName isEqualToString:@"WeightKgs"])
				{
					if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Weight"] isEqualToString:@"LBs"])
					{								
						FieldName=@"WeightLbs";
					}
					else
					{								
						FieldName=@"WeightKgs";
					}
				}
				if([FieldName isEqualToString:@"HeightCms"])
				{
					if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Height"] isEqualToString:@"Inches"])
					{
						FieldName=@"HeightInch";
					}
					else
					{
						FieldName=@"HeightCms";
					}
				}
				if([FieldName isEqualToString:@"TemperatureF"])
				{
					if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Temperature"] isEqualToString:@"F"])
					{
						FieldName=@"TemperatureF";
					}
					else
					{
						FieldName=@"TemperatureC";
					}
				}
				Dict=[appDelegate.ReportArray valueForKey:FieldName];
				Str1=[Dict valueForKey:Date];
				if([FieldName isEqualToString:@"Medicine_Entry"])
					Str1 = [Str1 stringByReplacingOccurrencesOfString:@" \n"  withString:@","];
				
				Str1=[Str1 stringByReplacingOccurrencesOfString:@"\""  withString:@"''"];
				if([Str1 length]>0)
				{
					if(([FieldName isEqualToString:@"WeightKgs"] || [FieldName isEqualToString:@"WeightLbs"]))
					{
						if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Weight"] isEqualToString:@"LBs"])
						{
							Str1=[NSString stringWithFormat:@"%@ Lbs",Str1];
						}
						else
						{
							Str1=[NSString stringWithFormat:@"%@ Kgs",Str1];
						}
					}
					if([FieldName isEqualToString:@"HeightCms"] || [FieldName isEqualToString:@"HeightInch"])
					{
						if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Height"] isEqualToString:@"Inches"])
						{
							Str1=[NSString stringWithFormat:@"%@ Feet",Str1];
						}
						else
						{
							Str1=[NSString stringWithFormat:@"%@ Meter",Str1];
						}
					}
					if([FieldName isEqualToString:@"TemperatureF"] || [FieldName isEqualToString:@"TemperatureC"])
					{
						if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Temperature"] isEqualToString:@"F"])
						{
							Str1=[NSString stringWithFormat:@"%@  F",Str1];
						}
						else
						{
							Str1=[NSString stringWithFormat:@"%@  C",Str1];
						}
					}
					if([FieldName isEqualToString:@"BP"])
					{
						Str1=[NSString stringWithFormat:@"%@ mmHg",Str1];
					}
				}
			}
			if(j==([arr2 count]-1))
			{
				csvString=[csvString stringByAppendingString:[NSString stringWithFormat:@"\"%@\"\n",Str1]];
			}
			else
			{
				csvString=[csvString stringByAppendingString:[NSString stringWithFormat:@"\"%@\",",Str1]];
			}
		}
		
	}
	//NSLog(csvString);
	csvString = [csvString stringByReplacingOccurrencesOfString:@"(null)"  withString:@""];
	[appDelegate WriteFiles:csvString];
}

////// Concate Fields Base on selected Fields

-(void)ConcateString
{
	appDelegate.ReportField=@"";
	appDelegate.SelectedReportField=@""; 
	if(!arr1)
	{
		arr1=[[NSMutableArray alloc]init];
	}
	else
		[arr1 removeAllObjects];
	if(!arr2)
	{
		arr2=[[NSMutableArray alloc]init];
	}
	else
		[arr2 removeAllObjects];
	
	for(int i=0;i<[Field_Array count];i++)
	{
		if([[selectedArray objectAtIndex:i]intValue]==1)
		{
			[arr2 addObject:[Field_Table_Array  objectAtIndex:i]];
			[arr1 addObject:[Field_Array objectAtIndex:i]];
		}
	}
	if([arr2 count]>0)
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		if([arr1 count]>0)
		{
			for(int i=0;i<[arr1 count];i++)
			{
				if(i==([arr1 count]-1))
				{				
					appDelegate.ReportField=[appDelegate.ReportField stringByAppendingString:[NSString stringWithFormat:@"%@",[arr1 objectAtIndex:i]]];
					appDelegate.SelectedReportField=[appDelegate.SelectedReportField stringByAppendingString:[NSString stringWithFormat:@"%@",[arr2 objectAtIndex:i]]];
				}
				else
				{							
					appDelegate.ReportField=[appDelegate.ReportField stringByAppendingString:[NSString stringWithFormat:@"%@, ",[arr1 objectAtIndex:i]]];
					appDelegate.SelectedReportField=[appDelegate.SelectedReportField stringByAppendingString:[NSString stringWithFormat:@"%@, ",[arr2 objectAtIndex:i]]];
				}
			}
		}
		[Pool release];
	}
}

///// Go To report Controller if alleast one FIeld selected
-(void)ShowReport
{	
	[self ConcateString]; 
	if([arr2 count]>0)
	{		
		[self LoadReport];
		if([appDelegate.WeekArray count]>0)
		{
			[self performSelectorOnMainThread:@selector(PushReport)  withObject:nil waitUntilDone:YES];
			[selectedArray removeAllObjects];
		}
		else
		{
			UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"No data present for reporting." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			alert.tag=5;
			[alert show];
			[alert release];
			Activity.hidden=TRUE;
			[Activity stopAnimating];
			tblView.userInteractionEnabled=TRUE;
			btnReport.enabled=TRUE;
			[[UIApplication sharedApplication] endIgnoringInteractionEvents];
		}		
	}
	else
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Select at least one field to be displayed in report!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		alert.tag=5;
		[alert show];
		[alert release];
		Activity.hidden=TRUE;
		[Activity stopAnimating];
		tblView.userInteractionEnabled=TRUE;
		btnReport.enabled=TRUE;
		[[UIApplication sharedApplication] endIgnoringInteractionEvents];
	}
}

//// Go to Report View
-(void)PushReport
{
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	appDelegate.isforReport=TRUE;
	if(!appDelegate.objShowReportViewController)
		appDelegate.objShowReportViewController=[[ShowReportViewController alloc]initWithNibName:@"ShowCalendar" bundle:nil];
	appDelegate.isFromReport=TRUE;
	appDelegate.isDailyReport=TRUE;
	[[UIApplication sharedApplication] endIgnoringInteractionEvents];
	[self.navigationController pushViewController:appDelegate.objShowReportViewController animated:YES];
	[Pool release];
}

#pragma mark View Methods
// Called after the view has been loaded. For view controllers created in code, this is after -loadView. For view controllers unarchived from a nib, this is after the view is set.
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	appDelegate=[[UIApplication sharedApplication]delegate];
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	tblView.delegate=self;
	tblView.dataSource=self;
	tblView.rowHeight=45;
	self.navigationItem.rightBarButtonItem=btnReport;
	[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
	[DatePicker setDate:[NSDate date] animated:YES];
	ToolBar.tintColor=[UIColor blackColor];
	lblData=[[UILabel alloc]init];
	lblData.frame=CGRectMake(3,13 , 250, 20);
	lblData.font=[UIFont systemFontOfSize:15];
	lblData.textColor=[UIColor whiteColor];
	lblData.backgroundColor=[UIColor clearColor];
	DatePicker.frame=CGRectMake(0, 200, 320, 216);
	ToolBar.frame=CGRectMake(0, 200, 320, 44);
	[ToolBar addSubview:lblData];
	[DatePicker setMaximumDate:[NSDate date]];
	selectedImage = [UIImage imageNamed:@"checked.png"];
	unselectedImage = [UIImage imageNamed:@"unchecked.png"];
	DatePicker.maximumDate=[NSDate date];
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Back";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];
	UIView *view=[[UIView alloc]init];
	view.frame=CGRectMake(50,0, 230, 30);
	UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(23, 0, 130, 30)];
	[label1 setFont:[UIFont boldSystemFontOfSize:18.0]];
	[label1 setBackgroundColor:[UIColor clearColor]];
	[label1 setTextAlignment:UITextAlignmentCenter];
 	[label1 setTextColor:[UIColor whiteColor]];
	[label1 setText:@"Reports"];
	[view addSubview:label1];
	Activity=[[UIActivityIndicatorView alloc]init];
	Activity.frame=CGRectMake(5, 0, 30, 30);
	[view addSubview:Activity];	
	self.navigationItem.titleView=view;
	[view release];
	[label1 release];
	[Pool release];
	if(!selectedArray)
		selectedArray=[[NSMutableArray alloc ]init];
    [super viewDidLoad];
}

// Called when the view is about to made visible. Default does nothing

- (void)viewWillAppear:(BOOL)animated
{
	[[UIApplication sharedApplication] endIgnoringInteractionEvents];
	[[UIDevice currentDevice] setOrientation:UIInterfaceOrientationPortrait];	
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	DatePicker.hidden=TRUE;
	ToolBar.hidden=TRUE; 
	btnReport.enabled=TRUE;
	Activity.hidden=TRUE;
	[Activity stopAnimating];
	[self populateSelectedArray];
	tblView.userInteractionEnabled=TRUE;
	[self.view bringSubviewToFront:DatePicker];
	[tblView reloadData];
	[Pool release];
}

// Called when the view has been fully transitioned onto the screen. Default does nothing
- (void)viewDidAppear:(BOOL)animated
{
	self.view.frame=CGRectMake(0, 0, 320, 416);
	[tblView scrollRectToVisible:CGRectMake(0, 0, 320, 50)  animated:NO];
}

/// Check which Item is selected or not for showing in table
- (void)populateSelectedArray
{
	if([selectedArray count]>0)
	{
		[selectedArray removeAllObjects];
	}
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	if([appDelegate.ReportField isEqualToString:@""])
	{
		for (int i=0; i < [Field_Array count]; i++)
		{
			[selectedArray addObject:[NSNumber numberWithBool:NO]];
		}
	}
	else
	{
		NSArray *arr5=[appDelegate.ReportField componentsSeparatedByString:@", "];
		for(int i=0;i<[Field_Array count];i++)
		{
			NSString *Str=[Field_Array objectAtIndex:i];
			BOOL result = [arr5 containsObject:Str];
			
			if(result==TRUE)
			{
				[selectedArray addObject:[NSNumber numberWithBool:YES]];
			}
			else
			{
				[selectedArray addObject:[NSNumber numberWithBool:NO]];
			}
		}
	}
	[Pool release];
}

#pragma mark Table View Delegate Methods
// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if(section==0)
	{
		return 2;
	}
	else
		return [Field_Array count];
}

// Customize the appearance of table view cells.
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	if(indexPath.section==1)
	{
		static NSString *CellIdentifier1 = @"Cell1";
		
		SettingTableViewCell  *cell1;
		cell1 = (SettingTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
		if (cell1 == nil) {
			cell1 = [[[SettingTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier1] autorelease];
		}
		
		selected = [selectedArray objectAtIndex:[indexPath row]];
		cell1.btnDelete.image = ([selected boolValue]) ? selectedImage : unselectedImage;
		cell1.txtAmount.hidden=TRUE;
		cell1.lblName.text=[Field_Array objectAtIndex:indexPath.row]; 
		return cell1;
	}
	else
	{
		static NSString *CellIdentifier = @"Cell";
		AddUserButtonTableViewCell *cell;
		cell = (AddUserButtonTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[AddUserButtonTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
			[cell.BtnSelect addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
		}
		switch(indexPath.row)
		{
			case 0:
				cell.lblName.text=@"Start Date";
				cell.BtnSelect.tag=0;
				if([appDelegate.ReportStartDate length]>0)
				{
					[cell.BtnSelect setTitle:[NSString stringWithFormat:@"  %@",appDelegate.ReportStartDate]  forState:UIControlStateNormal];
				}
				else
				{
					[cell.BtnSelect setTitle:[NSString stringWithFormat:@"  %@",@"Select Start Date"]  forState:UIControlStateNormal];
				}
				return cell;
			case 1:
				cell.lblName.text=@"End Date";
				cell.BtnSelect.tag=1;
				if([appDelegate.ReportEndDate length]>0)
				{
					[cell.BtnSelect setTitle:[NSString stringWithFormat:@"  %@",appDelegate.ReportEndDate]  forState:UIControlStateNormal];
				}
				else
				{
					[cell.BtnSelect setTitle:[NSString stringWithFormat:@"  %@",@"Select End Date"]  forState:UIControlStateNormal];
				}
				return cell;
		}	
	}
	return @"";	
}

// called on finger up if user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	DatePicker.hidden=TRUE;
	ToolBar.hidden=TRUE;
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	if(indexPath.section==1)
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		[tblView deselectRowAtIndexPath:indexPath animated:YES];		
		BOOL selected1 = [[selectedArray objectAtIndex:[indexPath row]] boolValue];
		[selectedArray replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithBool:!selected1]];
		[tblView reloadData];
		[Pool release];
	}
	else
	{
		if(indexPath.row==0)
		{
			NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
			DatePicker.hidden=FALSE;
			ToolBar.hidden=FALSE;
			if([appDelegate.ReportStartDate length]==0)
			{
				[DatePicker setDate:[NSDate date] animated:YES];
			}
			else
			{
				[DatePicker setDate:[appDelegate.DateFormatter dateFromString:appDelegate.ReportStartDate]];
			}
			lblData.text=@"Select Start Date";
			SelectedTag=0;
			[Pool release];
		}
		if(indexPath.row==1)
		{
			NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
			if([appDelegate.ReportStartDate length]==0)
			{
				DatePicker.hidden=TRUE;
				ToolBar.hidden=TRUE;
				UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Select the start date first!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[Alert show];
				[Alert release];
				return;
			}
			else
			{
				DatePicker.hidden=FALSE;
				ToolBar.hidden=FALSE;
				if([appDelegate.ReportEndDate length]==0)
				{
					[DatePicker setDate:[NSDate date] animated:YES];
				}
				else
				{
					[DatePicker setDate:[appDelegate.DateFormatter dateFromString:appDelegate.ReportEndDate]];
				}
				lblData.text=@"Select End Date";
			}
			SelectedTag=1;
			[Pool release];
		}
	}
}

/// Click on DateTime Combo Box
-(IBAction)ClickButton:(id)sender
{
	UIButton *btn=(UIButton*)sender;
	if(btn.tag==0)
	{
		DatePicker.hidden=FALSE;
		ToolBar.hidden=FALSE;
		if([appDelegate.ReportStartDate length]==0)
		{
			[DatePicker setDate:[NSDate date] animated:YES];
		}
		else
		{
			[DatePicker setDate:[appDelegate.DateFormatter dateFromString:appDelegate.ReportStartDate]];
		}
		lblData.text=@"Select Start Date";
		SelectedTag=0;
	}
	else if(btn.tag==1)
	{
		if([appDelegate.ReportStartDate length]==0)
		{
			DatePicker.hidden=TRUE;
			ToolBar.hidden=TRUE;
			UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Select the start date first!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[Alert show];
			[Alert release];
			return;
		}
		else
		{
			DatePicker.hidden=FALSE;
			ToolBar.hidden=FALSE;
			if([appDelegate.ReportEndDate length]==0)
			{
				[DatePicker setDate:[NSDate date] animated:YES];
			}
			else
			{
				[DatePicker setDate:[appDelegate.DateFormatter dateFromString:appDelegate.ReportEndDate]];
			}
			lblData.text=@"Select End Date";
		}
		SelectedTag=1;
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
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.0
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[tblView release];
	[btnReport release];
	[selectedLabel release];
	[DatePicker release];
	[ToolBar release];
	[lblData release];
	[btnDone release];
	[ShowReportView release];
    [super dealloc];
}


@end
