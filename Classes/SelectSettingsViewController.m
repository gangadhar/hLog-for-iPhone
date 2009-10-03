//
//  SelectSettingsViewController.m
//  hLog
//
//  Created by MAC02 on 3/30/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import "SelectSettingsViewController.h"
#import "AddNewUserTableCell.h"
#import "UnitsViewController.h"

#define Field_Array [NSArray arrayWithObjects: @"BP",@"Blood Sugar",@"Temperature",@"Fasting Blood Sugar", @"Pulse",@"Respiration",@"Weight",@"Height",@"Pain",@"Other-Vitals",@"Sleep Times",@"Sleep Duration", @"Exercise",@"Mood",@"Activity",@"Diapering", @"Food Consumption",@"Calories Consumed",@"Alcohol",@"Cigarettes",@"Drugs",@"Menstruation",@"Other-Routines",@"Medicine",nil]
#define Field_Table_Array [NSArray arrayWithObjects: @"BP",@"BloodSugar",@"TemperatureF",@"Fasting", @"Pulse",@"Respiration",@"WeightKgs",@"HeightCms",@"Pain",@"Other_Vitals",@"Sleep",@"Sleep1", @"Exercise_id",@"Mood",@"Activity",@"Diapering", @"Feeding",@"calories",@"Alcohol",@"Cigarrettes",@"Drugs",@"Menstrution",@"Other_Routines",@"Medicine_Entry",nil]


#define PersonalInfo_Array [NSArray arrayWithObjects: @"Name",@"Date Of Birth",@"Gender",@"Blood Group", @"Diabetes",@"Smoking",@"Drinking",@"Drug Intake",@"Past History",nil]
#define PersonalInfo_Table_Array [NSArray arrayWithObjects: @"UserName",@"DOB",@"Gender",@"BloodGroup", @"Diabetes",@"Smoking",@"Drinking",@"Drug",@"Past",nil]

#define HealthCare_Array [NSArray arrayWithObjects: @"Health Care Provider Name",@"Health Care Provider Phone No",nil]
#define HealthCare_Table_Array [NSArray arrayWithObjects: @"PastName",@"PastPhoneNumber",nil]

#define Insurance_Array [NSArray arrayWithObjects: @"Insurance Identification", @"Insurance Policy Number",@"Insurance Phone No",@"Emergency Contact",nil]
#define Insurance_Table_Array [NSArray arrayWithObjects: @"PastIdentification", @"PastPolicyNo",@"PastPhone",@"PastEmrContact",nil]


@implementation SelectSettingsViewController
@synthesize tmpArray;
#pragma mark View Methods
// Called after the view has been loaded. For view controllers created in code, this is after -loadView. For view controllers unarchived from a nib, this is after the view is set.
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	tblView.delegate=self;
	tblView.dataSource=self;
	tblView.rowHeight=50;//50	
	appDelegate=[[UIApplication sharedApplication]delegate];
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Back";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];
	
    [super viewDidLoad];
}

// Called when the view is about to made visible. Default does nothing
- (void)viewWillAppear:(BOOL)animated
{
	self.navigationItem.title=@"Settings";
	self.navigationItem.rightBarButtonItem=nil;
	[appDelegate SelectsUsers];
	for(int i=0;i<[appDelegate.UserArray count];i++)
	{
		NSDictionary *dic=[appDelegate.UserArray objectAtIndex:i];
		if([[dic valueForKey:@"Default"]intValue]==1)
		{
			appDelegate.AddNewUserDict=[appDelegate.UserArray objectAtIndex:i];	
			appDelegate.SelectedUserID=[[appDelegate.AddNewUserDict valueForKey:@"UserID"]intValue];
			[appDelegate selectPastData:appDelegate.SelectedUserID];
			NSString *Past=@"";
			NSString *PastID=@"";
			for(int i=0;i<[appDelegate.PastArray count];i++)
			{
				NSDictionary *DIC=[appDelegate.PastArray objectAtIndex:i];
				if(i==([appDelegate.PastArray count]-1))
				{
					Past=[Past stringByAppendingString:[NSString stringWithFormat:@"%@",[DIC valueForKey:@"Name"]]];
					PastID=[PastID stringByAppendingString:[NSString stringWithFormat:@"%@",[DIC valueForKey:@"PastID"]]];
				}
				else
				{
					Past=[Past stringByAppendingString:[NSString stringWithFormat:@"%@, ",[DIC valueForKey:@"Name"]]];
					PastID=[PastID stringByAppendingString:[NSString stringWithFormat:@"%@, ",[DIC valueForKey:@"PastID"]]];
				}
			}
			
			[appDelegate.AddNewUserDict setValue:Past forKey:@"Past"];
			[appDelegate.AddNewUserDict setValue:PastID forKey:@"PastID"];
			appDelegate.UserName=[appDelegate.AddNewUserDict valueForKey:@"UserName"];					
			break;
		}
	}
	Activity.hidden=TRUE;
	[Activity stopAnimating];
	[tblView reloadData];
}

#pragma mark Table view methods
// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell =(UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}	
	cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
	cell.indentationLevel = 1;
	cell.textColor= [UIColor colorWithRed:0.317 green:0.4 blue:0.56 alpha:1.0];
	if(indexPath.row==0)
	{
		cell.text=@"Users";
	}
	else if(indexPath.row==1)
	{
		cell.text=@"Units";
	}
	else  if(indexPath.row==2)
	{
		cell.text=@"Passcode";
	}	
	cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[tblView deselectRowAtIndexPath:indexPath animated:YES];
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	if(indexPath.row==0)
	{
		appDelegate.iSfromAddUser=TRUE; 
		appDelegate.ISfromDefaultUser=TRUE;
		appDelegate.ISfromSettings=0;
		[self.navigationController pushViewController:appDelegate.objRootViewController animated:YES];	
		
	}
	else if(indexPath.row==2)
	{
		appDelegate.iSfromAddUser=FALSE; 
		appDelegate.ISfromSettings=2;
		if(!objAddUserUnits)
		{
			objAddUserUnits=[[UnitsViewController alloc]initWithNibName:@"UnitsView" bundle:nil];
		}
		[self.navigationController pushViewController:objAddUserUnits animated:YES];
	}
	else if(indexPath.row==1)
	{		
		appDelegate.ISfromSettings=1;
		if(!objAddUserUnits)
		{
			objAddUserUnits=[[UnitsViewController alloc]initWithNibName:@"UnitsView" bundle:nil];
		}
		[self.navigationController pushViewController:objAddUserUnits animated:YES];
	}
	[Pool release];	
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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

-(void)SendAllData
{
	Activity.hidden=FALSE;
	[Activity startAnimating];
	[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
}

#pragma mark Button Click Methods


///// Make String For Vitals,Routine,Medicine and Menstrul Cycle Data
-(IBAction)send_All:(id)sender
{
	[NSThread detachNewThreadSelector:@selector(SendAllData) toTarget:self withObject:nil];
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
		[arr2 addObject:[Field_Table_Array  objectAtIndex:i]];
		[arr1 addObject:[Field_Array objectAtIndex:i]];
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
		/////  Get value for one field every time
		
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
		if(Index==21)
		{			
			[appDelegate SelectAllDataForMemstrual:appDelegate.SelectedUserID]; 
		}			
		else
		{
			[appDelegate GetAllCalendarData:Coulmnname andUserID:appDelegate.SelectedUserID andTableName:TableName];
		}
	}		
	if(!self.tmpArray)
		self.tmpArray=[[NSMutableArray alloc]init];
	else
		[self.tmpArray removeAllObjects];
	[self.tmpArray addObjectsFromArray:[appDelegate.WeekArray mutableCopy]];
	//[tmpArray retain];
	[appDelegate.WeekArray removeAllObjects];
	for(int i=0;i<[self.tmpArray count];i++)
	{
		NSString *str=[self.tmpArray objectAtIndex:i];
		[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
		NSDate *tmpDate=[appDelegate.DateFormatter dateFromString:str];
		[appDelegate.DateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
		str=[appDelegate.DateFormatter stringFromDate:tmpDate];
		[appDelegate.WeekArray addObject:[str mutableCopy]];
	}
	NSSortDescriptor *lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
	[appDelegate.WeekArray sortUsingDescriptors:[NSArray arrayWithObject:lastNameDescriptor]];
	
	[self.tmpArray removeAllObjects];
	[self.tmpArray addObjectsFromArray:[appDelegate.WeekArray mutableCopy]];
	[appDelegate.WeekArray removeAllObjects];
	for(int i=0;i<[tmpArray count];i++)
	{
		NSString *str=[self.tmpArray objectAtIndex:i];
		[appDelegate.DateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
		
		NSDate *tmpDate=[appDelegate.DateFormatter dateFromString:str];
		[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
		str=[appDelegate.DateFormatter stringFromDate:tmpDate];
		[appDelegate.WeekArray addObject:[str mutableCopy]];
	}
	[self MakePersonalData];
	csvString =[NSString stringWithFormat:@"%@ \n\nRoutine and Vitals Data \n\n",csvString];
	[self makeCsvFile];		
	[self pushView];
}

///// Go to the Send mail View for User Selection
-(void)pushView
{
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
	[[UIApplication sharedApplication] endIgnoringInteractionEvents];
	Activity.hidden=TRUE;
	[Activity stopAnimating];
}

//// Call When User want to send personal info
-(IBAction)send_PersonalInfo:(id)sender
{
	[NSThread detachNewThreadSelector:@selector(SendAllData) toTarget:self withObject:nil];
	[self MakePersonalData];
	[appDelegate WriteFiles:csvString];
	[self pushView];
}

///// Make String For Personal Data
-(void)MakePersonalData
{
	csvString=@"\"Personal Information\" \n\n";
	//	int Count=1;
	for(int i=0;i<[PersonalInfo_Array count];i++)
	{
		if(i==[PersonalInfo_Table_Array count]-1)
		{				
			csvString=[csvString stringByAppendingString:[NSString stringWithFormat:@"\"%@\"\n",[PersonalInfo_Array objectAtIndex:i]]];			
		}
		else
		{							
			csvString=[csvString stringByAppendingString:[NSString stringWithFormat:@"\"%@\",",[PersonalInfo_Array objectAtIndex:i]]];			
		}
	}
	for(int i=0;i<[PersonalInfo_Table_Array count];i++)
	{
		NSString *Value=@"";
		Value=[appDelegate.AddNewUserDict valueForKey:[PersonalInfo_Table_Array objectAtIndex:i]];
		if([Value isEqualToString:@"0"])
		{
			Value=@"No";
		}
		if([Value isEqualToString:@"1"])
		{
			Value=@"Yes";
		}
		Value=[Value stringByReplacingOccurrencesOfString:@"\""  withString:@"''"];
		if(i==[PersonalInfo_Table_Array count]-1)
		{				
			csvString=[csvString stringByAppendingString:[NSString stringWithFormat:@"\"%@\"\n",Value]];			
		}
		else
		{							
			csvString=[csvString stringByAppendingString:[NSString stringWithFormat:@"\"%@\",",Value]];			
		}
	}
	csvString=[NSString stringWithFormat:@"%@\nHealth Care Provider\n",csvString];
	[appDelegate selectHealthcare:appDelegate.SelectedUserID];
	if([appDelegate.HealthInsuranceArray count]>0)
	{
		for(int i=0;i<[HealthCare_Array count];i++)
		{
			if(i==[HealthCare_Array count]-1)
			{				
				csvString=[csvString stringByAppendingString:[NSString stringWithFormat:@"\"%@\"\n",[HealthCare_Array objectAtIndex:i]]];			
			}
			else
			{							
				csvString=[csvString stringByAppendingString:[NSString stringWithFormat:@"\"%@\",",[HealthCare_Array objectAtIndex:i]]];			
			}
		}
		for(int i=0;i<[appDelegate.HealthInsuranceArray count];i++)
		{
			NSDictionary *DIC=[appDelegate.HealthInsuranceArray objectAtIndex:i];
			for(int j=0;j<[HealthCare_Array count];j++)
			{
				NSString *Value=@"";
				if([[HealthCare_Table_Array objectAtIndex:j] isEqualToString:@"PastPhoneNumber"])
				{
					///// Put - betwwen phone number
					NSLog(@"PastPhoneNumber");
					Value=[self numberFormate:j :i :HealthCare_Table_Array];
					
				}
				else
					Value=[DIC valueForKey:[HealthCare_Table_Array objectAtIndex:j]];
				if(j==[HealthCare_Array count]-1)
				{				
					csvString=[csvString stringByAppendingString:[NSString stringWithFormat:@"\"%@\"\n",Value]];			
				}
				else
				{							
					csvString=[csvString stringByAppendingString:[NSString stringWithFormat:@"\"%@\",",Value]];			
				}
			}
		}
	}
	csvString=[NSString stringWithFormat:@"%@\nInsurance Information\n",csvString];
	[appDelegate selectInsuranceInfo:appDelegate.SelectedUserID];
	if([appDelegate.HealthInsuranceArray count]>0)
	{
		for(int i=0;i<[Insurance_Array count];i++)
		{
			if(i==[Insurance_Array count]-1)
			{				
				csvString=[csvString stringByAppendingString:[NSString stringWithFormat:@"\"%@\"\n",[Insurance_Array objectAtIndex:i]]];			
			}
			else
			{							
				csvString=[csvString stringByAppendingString:[NSString stringWithFormat:@"\"%@\",",[Insurance_Array objectAtIndex:i]]];			
			}
		}
		for(int i=0;i<[appDelegate.HealthInsuranceArray count];i++)
		{
			NSDictionary *DIC=[appDelegate.HealthInsuranceArray objectAtIndex:i];
			for(int j=0;j<[Insurance_Array count];j++)
			{
				NSString *Value=@"";
				if([[Insurance_Table_Array objectAtIndex:j] isEqualToString:@"PastEmrContact"])
				{
					///// Put - betwwen phone number
					
					Value=[self numberFormate:j :i :Insurance_Table_Array];
				}
				else if([[Insurance_Table_Array objectAtIndex:j] isEqualToString:@"PastPhone"])
				{
					
					Value=[self numberFormate:j :i :Insurance_Table_Array];
				}					
				else
					Value=[DIC valueForKey:[Insurance_Table_Array objectAtIndex:j]];
				if(j==[Insurance_Array count]-1)
				{				
					csvString=[csvString stringByAppendingString:[NSString stringWithFormat:@"\"%@\"\n",Value]];			
				}
				else
				{							
					csvString=[csvString stringByAppendingString:[NSString stringWithFormat:@"\"%@\",",Value]];			
				}
			}
		}
	}
}

////// Make CSV file
-(void)makeCsvFile
{	
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
					/////////// Put units behind field value
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
	csvString = [csvString stringByReplacingOccurrencesOfString:@"(null)"  withString:@""];
	[appDelegate WriteFiles:csvString];
}


-(NSString*)numberFormate:(NSInteger)jValue :(NSInteger)iValue :(NSArray*)array
{
	NSString *Value=@"";
	NSDictionary *DIC=[appDelegate.HealthInsuranceArray objectAtIndex:iValue];
	//NSLog(@"%d",[[DIC valueForKey:[array objectAtIndex:jValue]] length]);
	if([[DIC valueForKey:[array objectAtIndex:jValue]] length]==10)
	{
		NSRange range;
		range.length=3;
		range.location=0;
		Value=[[NSString stringWithFormat:@"%@",[DIC valueForKey:[array objectAtIndex:jValue]]]substringWithRange:range];
		NSMutableArray *PhoneArray=[[NSMutableArray alloc]init];
		[PhoneArray addObject:Value];
		range.length=3;
		range.location=3;
		Value=[[NSString stringWithFormat:@"%@",[DIC valueForKey:[array objectAtIndex:jValue]]]substringWithRange:range];
		[PhoneArray addObject:Value];
		range.length=4;
		range.location=6;
		Value=[[NSString stringWithFormat:@"%@",[DIC valueForKey:[array objectAtIndex:jValue]]]substringWithRange:range];
		[PhoneArray addObject:Value];
		Value=[NSString stringWithFormat:@"%@-%@-%@",[PhoneArray objectAtIndex:0],[PhoneArray objectAtIndex:1],[PhoneArray objectAtIndex:2]];
		[PhoneArray release];
	}
	else if ([[DIC valueForKey:[array objectAtIndex:jValue]] length]==11)
	{
		NSRange range;
		range.length=1;
		range.location=0;
		Value=[[NSString stringWithFormat:@"%@",[DIC valueForKey:[array objectAtIndex:jValue]]]substringWithRange:range];
		NSMutableArray *PhoneArray=[[NSMutableArray alloc]init];
		[PhoneArray addObject:Value];
		range.length=3;
		range.location=1;
		Value=[[NSString stringWithFormat:@"%@",[DIC valueForKey:[array objectAtIndex:jValue]]]substringWithRange:range];
		[PhoneArray addObject:Value];
		range.length=3;
		range.location=4;
		Value=[[NSString stringWithFormat:@"%@",[DIC valueForKey:[array objectAtIndex:jValue]]]substringWithRange:range];
		[PhoneArray addObject:Value];
		range.length=4;
		range.location=7;
		Value=[[NSString stringWithFormat:@"%@",[DIC valueForKey:[array objectAtIndex:jValue]]]substringWithRange:range];
		[PhoneArray addObject:Value];
		Value=[NSString stringWithFormat:@"%@-%@-%@-%@",[PhoneArray objectAtIndex:0],[PhoneArray objectAtIndex:1],[PhoneArray objectAtIndex:2],[PhoneArray objectAtIndex:3]];
		[PhoneArray release];
	}
	else
	{
		Value=[DIC valueForKey:[array objectAtIndex:jValue]];
	}
	return Value;
}

- (void)dealloc {
	
	[tblView release];
	[btnSave release];
	//[PasscodeSettingsView release];
	
    [super dealloc];
}


@end
