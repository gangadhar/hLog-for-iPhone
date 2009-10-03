//
//  SelectButtonViewController.m
//  hLog
//
//  Created by Bhhomi on 3/24/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import "SelectButtonViewController.h"
#import "FirstViewController.h"

@implementation SelectButtonViewController

// Called after the view has been loaded. For view controllers created in code, this is after -loadView. For view controllers unarchived from a nib, this is after the view is set.
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{	
	tblView.delegate=self;
	tblView.dataSource=self; 
	appDelegate=[[UIApplication sharedApplication]delegate];
	tblView.rowHeight=55;
	self.navigationController.navigationBar.barStyle= UIBarStyleBlackOpaque; 
	UIBarButtonItem *btnInformation=[[UIBarButtonItem alloc]initWithCustomView:btnInfo];
	self.navigationItem.rightBarButtonItem=btnInformation;	
	[btnInformation release];
	
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Back";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];
	
	label1 = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 190, 44)];
	label1.numberOfLines=0;
	[label1 setFont:[UIFont boldSystemFontOfSize:17.0]];
	[label1 setBackgroundColor:[UIColor clearColor]];
	[label1 setTextAlignment:UITextAlignmentCenter];
 	[label1 setTextColor:[UIColor whiteColor]];
	
	[appDelegate SelectsUsers];
	if([appDelegate.UserArray count]==0)
	{
		[appDelegate MakeDictForNewUser]; 
		appDelegate.UserStatus=@"Add User";
		appDelegate.iSfromAddUser=TRUE; 
		appDelegate.isForMail=FALSE;
		if(!appDelegate.objFirstViewController)
		{
			appDelegate.objFirstViewController=[[FirstViewController alloc]initWithNibName:@"First_View" bundle:nil];
		}
		[self.navigationController pushViewController:appDelegate.objFirstViewController animated:YES];
	}
	if(!appDelegate.objUserViewController)
	{
		appDelegate.objUserViewController=[[UserViewController alloc]initWithNibName:@"UserSelect" bundle:nil];
	}
	if(!appDelegate.objFirstViewController)
	{
		appDelegate.objFirstViewController=[[FirstViewController alloc]initWithNibName:@"First_View" bundle:nil];
	}
	if(!objReport)
	{
		objReport=[[CalendarReportViewController alloc]initWithNibName:@"Calendar" bundle:nil];
	}	
	if(!appDelegate.SelectSettingsView)
	{
		appDelegate.SelectSettingsView=[[SelectSettingsViewController alloc]initWithNibName:@"First_Settings" bundle:nil];
	}	
	if(!appDelegate.objRootViewController)
	{
		appDelegate.objRootViewController=[[RootViewController alloc]initWithNibName:@"RootViewController" bundle:nil];
	}	
	if(!appDelegate.objSelectOptionsViewController)
	{
		appDelegate.objSelectOptionsViewController=[[SelectOptionsViewController alloc]initWithNibName:@"SelectOptions" bundle:nil];
	}	
	appDelegate.objShowReportViewController=[[ShowReportViewController alloc]initWithNibName:@"ShowCalendar" bundle:nil];
    [super viewDidLoad];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

// Called when the view is about to made visible. Default does nothing
- (void)viewWillAppear:(BOOL)animated
{	

	[tblView scrollRectToVisible:CGRectMake(0, 0, 320, 50)  animated:YES];	
	if(appDelegate.ISLiteVersion)
	{
		NSString *LiteDate=[[NSUserDefaults standardUserDefaults] valueForKey:@"IsLiteVersion"];
		[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy"];
		NSDate *Lite=[appDelegate.DateFormatter dateFromString:LiteDate]; 		
		NSTimeInterval Time=[[NSDate date] timeIntervalSinceDate:Lite];
		Days=(Time/3600);
		Days=(Days/24);
	}
	
	[appDelegate SelectsUsers];
	if([appDelegate.UserArray count]==0)
	{
		appDelegate.UserName=@"No User";
		appDelegate.SelectedUserID=0;
	}
	else
	{
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
	}	
	[label1 setText:[NSString stringWithFormat:@"%@ \n hLog",appDelegate.UserName]];
	self.navigationItem.titleView=label1;
}

#pragma mark Table view methods
// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return 7 ;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{    
    static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell =(UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}	
	cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
	cell.indentationLevel = 4;    
	switch (indexPath.row) 
	{
		case 0:
			cell.text=@"Vitals";
			cell.image= [UIImage imageNamed:@"log_data.png"];			
			break;
		case 1:
			cell.text=@"Routines";
			cell.image=[UIImage imageNamed:@"log_routines.png"];
			break;
		case 2:
			cell.text=@"Medicines";
			cell.image=[UIImage imageNamed:@"medicines.png"];
			break;
		case 3:
			cell.text=@"My Favorites";
			cell.image=[UIImage imageNamed:@"favorites.png"];
			break;
		case 4:
			cell.text=@"User Profile";
			cell.image=[UIImage imageNamed:@"user_settings.png"];
			break;
		case 5:
			cell.text=@"Reports";
			cell.image=[UIImage imageNamed:@"reports.png"];
			break;
		case 6:
			cell.text=@"Settings";
			cell.image=[UIImage imageNamed:@"preferences.png"];
			break;
		default:
			break;
	}
	cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	[tblView deselectRowAtIndexPath:indexPath animated:YES];		
	appDelegate.isFromEditReport=FALSE;
	appDelegate.ISfromDefaultUser=TRUE;	
	if(Days>15 && appDelegate.ISLiteVersion==TRUE)
	{
		//// Call When if app is Lite Version
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"The trial period has expired. Please buy the full version from App store" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else
	{
		if(appDelegate.SelectedUserID!=0)
		{
			appDelegate.isFromChart=FALSE;
			if(indexPath.row ==0 || indexPath.row==1 || indexPath.row==2 || indexPath.row==3)
			{
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy"];
				[Pool release];
				Date=[appDelegate.DateFormatter stringFromDate: [NSDate date]];
				appDelegate.isfromRoot=TRUE;
				NSAutoreleasePool *Pool1=[[NSAutoreleasePool alloc]init];
				[appDelegate.DateFormatter setDateFormat:@"HH:mm"];
				[Pool1 release];
				DateTime=[appDelegate.DateFormatter stringFromDate:[NSDate date]];
				arr=[DateTime componentsSeparatedByString:@":"];
				Mins=[arr objectAtIndex:1];
				//if([arr count]>1)
//				{
//					Mins=[appDelegate CheckTIme:[[arr objectAtIndex:1]intValue]];
//				}				
			}
			if(indexPath.row==0)
			{
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				[appDelegate SelectVitalsDetail:Date  AndTime:[NSString stringWithFormat:@"%@:%@",[arr objectAtIndex:0],Mins] andUserID:appDelegate.SelectedUserID];
				if([appDelegate.DailyArray count]>0)
				{
					appDelegate.Vitals_Detailref =[appDelegate.DailyArray objectAtIndex:0];
				}
				else
				{
					if(!appDelegate.Vitals_Detailref)
					{
						appDelegate.Vitals_Detailref=[[Vitals_Detail alloc]init];
					}
					else
					{
						[appDelegate.Vitals_Detailref ClearData];
					}
					appDelegate.Vitals_Detailref.User_ID1=appDelegate.SelectedUserID;
					appDelegate.Vitals_Detailref.EntryDate=Date;
					appDelegate.Vitals_Detailref.EntryTime=[NSString stringWithFormat:@"%@:%@",[arr objectAtIndex:0],Mins];
				}
				appDelegate.objUserViewController.SelectedIndex=0;
				[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
				appDelegate.objUserViewController.UserDate=[appDelegate.DateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@",appDelegate.Vitals_Detailref.EntryDate,appDelegate.Vitals_Detailref.EntryTime]];
				[self.navigationController pushViewController:appDelegate.objUserViewController animated:YES];
				[Pool release];
			}
			else if(indexPath.row==1)
			{			
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				[appDelegate SelectRoutinesDetail:Date  AndTime:[NSString stringWithFormat:@"%@:%@",[arr objectAtIndex:0],Mins] andUserID:appDelegate.SelectedUserID];
				[appDelegate selectMenstural:appDelegate.SelectedUserID  passDate:[NSString stringWithFormat:@"%@ %@:%@",Date,[arr objectAtIndex:0],Mins]];
				if([appDelegate.HourlyDataArray count]>0)
				{
					appDelegate.Routine_Detailrf =[appDelegate.HourlyDataArray objectAtIndex:0];
					[appDelegate SelectExercise_Duration:appDelegate.Routine_Detailrf.Routine_ID];
					appDelegate.Routine_Detailrf.Exercise=@"";
					for(int i=0;i<[appDelegate.ExerciseDurationArray count];i++)
					{
						NSDictionary *Dic=[appDelegate.ExerciseDurationArray objectAtIndex:i];
						int Dur=[[Dic valueForKey:@"Duration"]intValue];
						
					    int	Hours=Dur%60;
						int Minutes=Dur/60;
						///// Get All Exercise data for particular Date and time and User
						if(i==([appDelegate.ExerciseDurationArray count]-1))
						{
							appDelegate.Routine_Detailrf.Exercise_Duration=[appDelegate.Routine_Detailrf.Exercise_Duration stringByAppendingString:[NSString stringWithFormat:@"%@",[Dic valueForKey:@"Duration"]]];
							appDelegate.Routine_Detailrf.Exercise_Dru_ID=[appDelegate.Routine_Detailrf.Exercise_Dru_ID stringByAppendingString:[NSString stringWithFormat:@"%@",[Dic valueForKey:@"Exercise_ID"]]];
							appDelegate.Routine_Detailrf.Exercise=[appDelegate.Routine_Detailrf.Exercise stringByAppendingString:[NSString stringWithFormat:@"%@ (%d:%d)",[Dic valueForKey:@"Exercise_ID"],Minutes,Hours]];
						}
						else
						{
							appDelegate.Routine_Detailrf.Exercise_Duration=[appDelegate.Routine_Detailrf.Exercise_Duration stringByAppendingString:[NSString stringWithFormat:@"%@, ",[Dic valueForKey:@"Duration"]]];
							appDelegate.Routine_Detailrf.Exercise_Dru_ID=[appDelegate.Routine_Detailrf.Exercise_Dru_ID stringByAppendingString:[NSString stringWithFormat:@"%@, ",[Dic valueForKey:@"Exercise_ID"]]];
							appDelegate.Routine_Detailrf.Exercise=[appDelegate.Routine_Detailrf.Exercise stringByAppendingString:[NSString stringWithFormat:@"%@ (%d:%d), ",[Dic valueForKey:@"Exercise_ID"],Minutes,Hours]];
						}
					}
					[appDelegate SelectFeedDeatl:appDelegate.Routine_Detailrf.Routine_ID];
					///// Get All Feed data for particular Date and time and User
					if([appDelegate.UnitDictionary count]>0)
					{
						NSArray *array=[appDelegate.UnitDictionary allKeys];
						appDelegate.Routine_Detailrf.Feeding=@"";
						for(int i=0;i<[appDelegate.UnitDictionary count];i++)
						{							
							NSDictionary *Dic=[appDelegate.UnitDictionary objectForKey:[array objectAtIndex:i]];
							if(i==([appDelegate.UnitDictionary count]-1))
							{
								appDelegate.Routine_Detailrf.Feeding=[appDelegate.Routine_Detailrf.Feeding stringByAppendingString:[NSString stringWithFormat:@"%@ (%@ %@)",[Dic valueForKey:@"Feed_Name"],[Dic valueForKey:@"Feed_Qty"],[Dic valueForKey:@"Feed_Unit"]]];								
							}
							else
							{
								appDelegate.Routine_Detailrf.Feeding=[appDelegate.Routine_Detailrf.Feeding stringByAppendingString:[NSString stringWithFormat:@"%@ (%@ %@),",[Dic valueForKey:@"Feed_Name"],[Dic valueForKey:@"Feed_Qty"],[Dic valueForKey:@"Feed_Unit"]]];								
							}
						}
					}
				}
				else
				{
					if(!appDelegate.Routine_Detailrf)
					{
						appDelegate.Routine_Detailrf=[[Routine_Detail alloc]init];
					}
					else
					{
						[appDelegate.Routine_Detailrf ClearData];
					}
					appDelegate.Routine_Detailrf.EntryDate=Date;
					appDelegate.Routine_Detailrf.EntryTime=[NSString stringWithFormat:@"%@:%@",[arr objectAtIndex:0],Mins];
					appDelegate.Routine_Detailrf.User_ID=appDelegate.SelectedUserID;
					[appDelegate.UnitDictionary removeAllObjects];
				}
				///// Get Menstrual cycle data particular Date and time and User
				if([appDelegate.MensturalArray count]>0)
				{
					appDelegate.Mensturalref=[appDelegate.MensturalArray objectAtIndex:0];
					int difference=1;
					if([appDelegate.Mensturalref.Daily_EndDate length]!=0)
					{
						[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
						NSDate *Date1=[appDelegate.DateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@",appDelegate.Routine_Detailrf.EntryDate,appDelegate.Routine_Detailrf.EntryTime]];
						NSDate *Date2=[appDelegate.DateFormatter dateFromString:appDelegate.Mensturalref.Daily_EndDate];
						difference=[Date1 timeIntervalSinceDate:Date2]; 
					}
					appDelegate.objUserViewController.isEndDisabled=FALSE;
					if(([appDelegate.Mensturalref.Daily_Date isEqualToString:[NSString stringWithFormat:@"%@",appDelegate.Routine_Detailrf.EntryDate]]))
					{
						
						appDelegate.SaveMenstural=TRUE;
						appDelegate.objUserViewController.SelectedIndex=1;
						[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
						appDelegate.objUserViewController.UserDate=[appDelegate.DateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@",appDelegate.Routine_Detailrf.EntryDate,appDelegate.Routine_Detailrf.EntryTime]];
						[self.navigationController pushViewController:appDelegate.objUserViewController animated:YES];
						[Pool release];
						return;
					}
					if([appDelegate.Mensturalref.Daily_EndDate isEqualToString:[NSString stringWithFormat:@"%@ %@",appDelegate.Routine_Detailrf.EntryDate,appDelegate.Routine_Detailrf.EntryTime]])
					{
						appDelegate.objUserViewController.isEndDisabled=TRUE;
					}
					if([appDelegate.Mensturalref.Daily_EndDate length]==0)
					{
						appDelegate.objUserViewController.isEndDisabled=TRUE;
					}
					if([appDelegate.Mensturalref.EndDate length]>0 && difference>0)
					{
						
						[appDelegate.Mensturalref ClearData];
						appDelegate.Mensturalref.User_ID=appDelegate.SelectedUserID;
						appDelegate.Mensturalref.Daily_Date=Date;
						appDelegate.SaveMenstural=FALSE;
					}
					else
						appDelegate.SaveMenstural=TRUE;
				}
				else
				{
					if(!appDelegate.Mensturalref)
					{
						appDelegate.Mensturalref=[[Menstural_Cycle alloc]init];
					}
					else
					{
						[appDelegate.Mensturalref ClearData];
					}
					appDelegate.Mensturalref.User_ID=appDelegate.SelectedUserID;
					appDelegate.Mensturalref.Daily_Date=Date;
					appDelegate.SaveMenstural=FALSE; 
				}
				
				appDelegate.objUserViewController.SelectedIndex=1;
				[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
				appDelegate.objUserViewController.UserDate=[appDelegate.DateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@",appDelegate.Routine_Detailrf.EntryDate,appDelegate.Routine_Detailrf.EntryTime]];
				
				[self.navigationController pushViewController:appDelegate.objUserViewController animated:YES];
				[Pool release];
			}
			else if(indexPath.row==2)
			{
				//// Get Medicine data for particular datetime and user
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];						
				appDelegate.DailyTag=20; 
				appDelegate.isFromChart=TRUE; 
				appDelegate.objSelectOptionsViewController.NavText=@"Medicine";
				appDelegate.SelectedStatus=@"Medicine";
				appDelegate.isFromChart=FALSE;		
				appDelegate.isfromFavourite=TRUE;
				[appDelegate Medicinedata:Date  ToTime:[NSString stringWithFormat:@"%@:%@",[arr objectAtIndex:0],Mins] anduserid:appDelegate.SelectedUserID]; 
				if([appDelegate.EntryArray count]>0)
				{
					appDelegate.MedicineRef =[appDelegate.EntryArray objectAtIndex:0];
					appDelegate.SelectedItems=appDelegate.MedicineRef.Medicine_Insert_ID;
					[appDelegate SelectMedicineDeatl:appDelegate.MedicineRef.MedicineID];
				}
				else
				{
					if(!appDelegate.MedicineRef)
					{
						appDelegate.MedicineRef=[[Medicine alloc]init];
					}
					else
					{
						[appDelegate.MedicineRef ClearData];					
					}
					appDelegate.MedicineRef.EntryDate=Date;
					appDelegate.MedicineRef.EntryTime=[NSString stringWithFormat:@"%@:%@",[arr objectAtIndex:0],Mins];
					appDelegate.MedicineRef.UserID=appDelegate.SelectedUserID;
					appDelegate.SelectedItems=@"";
					[appDelegate.UnitDictionary removeAllObjects];
				}			
				[self.navigationController pushViewController:appDelegate.objSelectOptionsViewController animated:YES];
				[Pool release];
			}
			else if(indexPath.row==3)
			{			
				///////////////   Vitals Data
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				[appDelegate SelectVitalsDetail:Date  AndTime:[NSString stringWithFormat:@"%@:%@",[arr objectAtIndex:0],Mins] andUserID:appDelegate.SelectedUserID];
				
				if([appDelegate.DailyArray count]>0)
				{
					appDelegate.Vitals_Detailref =[appDelegate.DailyArray objectAtIndex:0];
				}
				else
				{
					if(!appDelegate.Vitals_Detailref)
					{
						appDelegate.Vitals_Detailref=[[Vitals_Detail alloc]init];
					}
					else
					{
						[appDelegate.Vitals_Detailref ClearData];
						
					}
					appDelegate.Vitals_Detailref.EntryDate=Date;
					appDelegate.Vitals_Detailref.EntryTime=[NSString stringWithFormat:@"%@:%@",[arr objectAtIndex:0],Mins];
					appDelegate.Vitals_Detailref.User_ID1=appDelegate.SelectedUserID;
				}
				
				////////// Routine Data
				[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy"];
				Date=[appDelegate.DateFormatter stringFromDate:[NSDate date]];
				[appDelegate.DateFormatter setDateFormat:@"HH:mm"];
				DateTime=[appDelegate.DateFormatter stringFromDate:[NSDate date]];
				arr=[DateTime componentsSeparatedByString:@":"];
				Mins=[arr objectAtIndex:1];			
				//if([arr count]>1)
//				{
//					Mins=[appDelegate CheckTIme:[[arr objectAtIndex:1]intValue]];
//				}
				[appDelegate SelectRoutinesDetail:Date  AndTime:[NSString stringWithFormat:@"%@:%@",[arr objectAtIndex:0],Mins] andUserID:appDelegate.SelectedUserID];
				[appDelegate selectMenstural:appDelegate.SelectedUserID  passDate:[NSString stringWithFormat:@"%@ %@:%@",Date,[arr objectAtIndex:0],Mins]];
				if([appDelegate.HourlyDataArray count]>0)
				{
					appDelegate.Routine_Detailrf =[appDelegate.HourlyDataArray objectAtIndex:0];
					[appDelegate SelectExercise_Duration:appDelegate.Routine_Detailrf.Routine_ID];
					appDelegate.Routine_Detailrf.Exercise=@"";
					///get all exercise data for particular datetime and user
					for(int i=0;i<[appDelegate.ExerciseDurationArray count];i++)
					{
						NSDictionary *Dic=[appDelegate.ExerciseDurationArray objectAtIndex:i];
						int Dur=[[Dic valueForKey:@"Duration"]intValue];
					    int	Hours=Dur/60;
						int Minutes=Dur%60;
						if(i==([appDelegate.ExerciseDurationArray count]-1))
						{
							appDelegate.Routine_Detailrf.Exercise_Duration=[appDelegate.Routine_Detailrf.Exercise_Duration stringByAppendingString:[NSString stringWithFormat:@"%@",[Dic valueForKey:@"Duration"]]];
							appDelegate.Routine_Detailrf.Exercise_Dru_ID=[appDelegate.Routine_Detailrf.Exercise_Dru_ID stringByAppendingString:[NSString stringWithFormat:@"%@",[Dic valueForKey:@"Exercise_ID"]]];
							appDelegate.Routine_Detailrf.Exercise=[appDelegate.Routine_Detailrf.Exercise stringByAppendingString:[NSString stringWithFormat:@"%@ (%d:%d)",[Dic valueForKey:@"Exercise_ID"],Hours,Minutes]];
						}
						else
						{
							appDelegate.Routine_Detailrf.Exercise_Duration=[appDelegate.Routine_Detailrf.Exercise_Duration stringByAppendingString:[NSString stringWithFormat:@"%@, ",[Dic valueForKey:@"Duration"]]];
							appDelegate.Routine_Detailrf.Exercise_Dru_ID=[appDelegate.Routine_Detailrf.Exercise_Dru_ID stringByAppendingString:[NSString stringWithFormat:@"%@, ",[Dic valueForKey:@"Exercise_ID"]]];
							appDelegate.Routine_Detailrf.Exercise=[appDelegate.Routine_Detailrf.Exercise stringByAppendingString:[NSString stringWithFormat:@"%@ (%d:%d), ",[Dic valueForKey:@"Exercise_ID"],Hours,Minutes]];
						}
					}
					[appDelegate SelectFeedDeatl:appDelegate.Routine_Detailrf.Routine_ID];
					///get all Feed data for particular datetime and user
					if([appDelegate.UnitDictionary count]>0)
					{
						NSArray *array=[appDelegate.UnitDictionary allKeys];
						appDelegate.Routine_Detailrf.Feeding=@"";
						for(int i=0;i<[appDelegate.UnitDictionary count];i++)
						{
							
							NSDictionary *Dic=[appDelegate.UnitDictionary objectForKey:[array objectAtIndex:i]];
							if(i==([appDelegate.UnitDictionary count]-1))
							{
								appDelegate.Routine_Detailrf.Feeding=[appDelegate.Routine_Detailrf.Feeding stringByAppendingString:[NSString stringWithFormat:@"%@ (%@ %@)",[Dic valueForKey:@"Feed_Name"],[Dic valueForKey:@"Feed_Qty"],[Dic valueForKey:@"Feed_Unit"]]];								
							}
							else
							{
								appDelegate.Routine_Detailrf.Feeding=[appDelegate.Routine_Detailrf.Feeding stringByAppendingString:[NSString stringWithFormat:@"%@ (%@ %@), ",[Dic valueForKey:@"Feed_Name"],[Dic valueForKey:@"Feed_Qty"],[Dic valueForKey:@"Feed_Unit"]]];								
							}
						}
					}
				}
				else
				{
					if(!appDelegate.Routine_Detailrf)
					{
						appDelegate.Routine_Detailrf=[[Routine_Detail alloc]init];
					}
					else
					{
						[appDelegate.Routine_Detailrf ClearData];
					}
					appDelegate.Routine_Detailrf.EntryDate=Date;
					appDelegate.Routine_Detailrf.EntryTime=[NSString stringWithFormat:@"%@:%@",[arr objectAtIndex:0],Mins];
					appDelegate.Routine_Detailrf.User_ID=appDelegate.SelectedUserID;
					[appDelegate.UnitDictionary removeAllObjects];
				}		
				//// Get Menstrul Cycle data base on current date time and User_ID
				if([appDelegate.MensturalArray count]>0)
				{
					appDelegate.Mensturalref=[appDelegate.MensturalArray objectAtIndex:0];
					int difference=1;
					if([appDelegate.Mensturalref.Daily_EndDate length]!=0)
					{
						[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
						NSDate *Date1=[appDelegate.DateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@",appDelegate.Routine_Detailrf.EntryDate,appDelegate.Routine_Detailrf.EntryTime]];
						NSDate *Date2=[appDelegate.DateFormatter dateFromString:appDelegate.Mensturalref.Daily_EndDate];
						difference=[Date1 timeIntervalSinceDate:Date2]; 
					}
					appDelegate.objUserViewController.isEndDisabled=FALSE;
					if(([appDelegate.Mensturalref.Daily_Date isEqualToString:[NSString stringWithFormat:@"%@",appDelegate.Routine_Detailrf.EntryDate]]))
					{
						appDelegate.SaveMenstural=TRUE;
						appDelegate.objUserViewController.SelectedIndex=3;
						[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
						appDelegate.objUserViewController.UserDate=[appDelegate.DateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@",appDelegate.Vitals_Detailref.EntryDate,appDelegate.Vitals_Detailref.EntryTime]];
						[self.navigationController pushViewController:appDelegate.objUserViewController animated:YES];
						[Pool release];
						return;
					}
					if([appDelegate.Mensturalref.Daily_EndDate isEqualToString:[NSString stringWithFormat:@"%@ %@",appDelegate.Routine_Detailrf.EntryDate,appDelegate.Routine_Detailrf.EntryTime]])
					{
						appDelegate.objUserViewController.isEndDisabled=TRUE;
					}
					//if([appDelegate.Mensturalref.EndDate length]>0 && (![appDelegate.Mensturalref.Daily_EndDate isEqualToString:[NSString stringWithFormat:@"%@ %@",appDelegate.Routine_Detailrf.EntryDate,appDelegate.Routine_Detailrf.EntryTime]]))
					if([appDelegate.Mensturalref.EndDate length]>0 && difference>0)
					{
						
						
						[appDelegate.Mensturalref ClearData];
						appDelegate.Mensturalref.User_ID=appDelegate.SelectedUserID;
						appDelegate.Mensturalref.Daily_Date=Date;
						appDelegate.SaveMenstural=FALSE;
					}
					else
						appDelegate.SaveMenstural=TRUE;
				}
				else
				{
					if(!appDelegate.Mensturalref)
					{
						appDelegate.Mensturalref=[[Menstural_Cycle alloc]init];
					}
					else
					{
						[appDelegate.Mensturalref ClearData];
					}
					appDelegate.Mensturalref.User_ID=appDelegate.SelectedUserID;
					appDelegate.Mensturalref.Daily_Date=Date;		
					appDelegate.SaveMenstural=FALSE; 
				}
				
				appDelegate.objUserViewController.SelectedIndex=3;
				[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
				appDelegate.objUserViewController.UserDate=[appDelegate.DateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@",appDelegate.Vitals_Detailref.EntryDate,appDelegate.Vitals_Detailref.EntryTime]];
				[self.navigationController pushViewController:appDelegate.objUserViewController animated:YES];
				[Pool release];
			}
			else if(indexPath.row==4)
			{		
				//// Open User Profile Screen
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				appDelegate.UserStatus=@"User Profile";			
				appDelegate.isfromRoot=TRUE;
				appDelegate.iSfromAddUser=TRUE; 
				appDelegate.iSfromUsers=FALSE;
				appDelegate.ISfromSettings=0;
				appDelegate.isForMail=FALSE;
				[self.navigationController pushViewController:appDelegate.objFirstViewController animated:YES];
				[Pool release];
			}
			else if(indexPath.row==5)
			{
				///// Open report page with one week difference
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
				NSDateComponents *comps= [[[NSDateComponents alloc] init] autorelease];			
				[comps setDay:-6]; //Use what you want here, set other components as needed
				NSDate *EndDate = [[NSCalendar currentCalendar] dateByAddingComponents:comps toDate:[NSDate date] options:0];
				DateTime= [appDelegate.DateFormatter stringFromDate: EndDate];
				arr=[DateTime componentsSeparatedByString:@":"];
				Mins=[arr objectAtIndex:1];
				//if([arr count]>1)
//				{
//					Mins=[appDelegate CheckTIme:[[arr objectAtIndex:1]intValue]];
				//}			
				appDelegate.ReportStartDate=[NSString stringWithFormat:@"%@:%@",[arr objectAtIndex:0],Mins];			
				[comps setDay:0]; //Use what you want here, set other components as needed
				EndDate = [[NSCalendar currentCalendar] dateByAddingComponents:comps toDate:[NSDate date] options:0];
				DateTime= [appDelegate.DateFormatter stringFromDate: EndDate];
				arr=[DateTime componentsSeparatedByString:@":"];
				Mins=[arr objectAtIndex:1];
				//if([arr count]>1)
//				{
//					Mins=[appDelegate CheckTIme:[[arr objectAtIndex:1]intValue]];
//				}
				appDelegate.ReportEndDate=[NSString stringWithFormat:@"%@:%@",[arr objectAtIndex:0],Mins];			
				appDelegate.ReportField=@"";
				[self.navigationController pushViewController:objReport animated:YES];
				[Pool release];
			}
		}
		if(indexPath.row==6)
		{		
			//// Go to setting page for user,units,passcode settings and send mail
			NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
			appDelegate.iSfromUsers=TRUE;
			appDelegate.ISfromDefaultUser=TRUE;
			appDelegate.isfromRoot=TRUE;
			[self.navigationController pushViewController:appDelegate.SelectSettingsView animated:YES];	
			[Pool release];
		}	
	}	
}

#pragma mark Button Click Mwthods

//// Go to Info page
-(IBAction)btnInfo_Clicked:(id)sender
{
	if(!objInfoViewController)
	{
		objInfoViewController=[[InfoViewController alloc]initWithNibName:@"InfoViewController" bundle:nil];
	}	
	[self.navigationController pushViewController:objInfoViewController animated:YES];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload 
{
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
	[tblView release];
	//[UserView release];
    [super dealloc];
}


@end
