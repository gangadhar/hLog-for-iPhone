//
//  UserViewController.m
//  hLog
//
//  Created by Bhoomi on 3/30/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import "UserViewController.h"
#import "DailyStatusTableViewCell.h"
#import "AddUserButtonTableViewCell.h"
#import "CycleTableViewCell.h"
#import "SleepTableViewCell.h"

@implementation UserViewController
@synthesize SelectedIndex,isEndDisabled,UserDate;

#pragma mark Button_Click Methods


/// Called when user want to delete Vitals Entry
-(IBAction)btnDeleteVital_clicked:(id)sender
{
	UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"Do you wish to delete the Vitals Entry?" delegate:self cancelButtonTitle:@"No" destructiveButtonTitle:@"Delete Vitals Entry" otherButtonTitles:nil];
	action.actionSheetStyle=UIActionSheetStyleDefault;
	[action showInView:self.view.superview.superview];
	[action release];
}

//// Called When user want to delete Routine Entry
-(IBAction)btnDeleteRoutine_clicked:(id)sender
{
	UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"Do you wish to delete the Routines Entry?" delegate:self cancelButtonTitle:@"No" destructiveButtonTitle:@"Delete Routines Entry" otherButtonTitles:nil];
	action.actionSheetStyle=UIActionSheetStyleDefault;
	[action showInView:self.view.superview.superview];
	[action release];
}

//// Called when Click Save Botton
-(IBAction)btnSave_Clicked:(id)sender
{
	int Result;
	PickerView.hidden=TRUE;
	DatePicker.hidden=TRUE;
	ToolBar.hidden=TRUE;
	TimeDatePicker.hidden=TRUE;
	if(SelectedIndex==0)
	{
		///// Save Vitals Data
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		if([appDelegate.Vitals_Detailref.BP length]>0 || [appDelegate.Vitals_Detailref.BloodSugar length]>0 || [appDelegate.Vitals_Detailref.Pain length]>0 || [appDelegate.Vitals_Detailref.TempC length]>0 || [appDelegate.Vitals_Detailref.Fasting length]>0 || [appDelegate.Vitals_Detailref.Pulse length]>0 || [appDelegate.Vitals_Detailref.Respiration length]>0 || [appDelegate.Vitals_Detailref.Other length]>0 || [appDelegate.Vitals_Detailref.WeightKgs length]>0 || [appDelegate.Vitals_Detailref.HeightCms length]>0 || appDelegate.Vitals_Detailref.Magnitude!=0)
		{
			if([appDelegate.Vitals_Detailref.WeightLbs length]>0)
			{
				[[NSUserDefaults standardUserDefaults] setObject:appDelegate.Vitals_Detailref.WeightLbs forKey:[NSString stringWithFormat:@"%d_WeightLbs",appDelegate.SelectedUserID]];
				[[NSUserDefaults standardUserDefaults] synchronize];
				
				[[NSUserDefaults standardUserDefaults] setObject:appDelegate.Vitals_Detailref.WeightKgs forKey:[NSString stringWithFormat:@"%d_WeightKgs",appDelegate.SelectedUserID]];
				[[NSUserDefaults standardUserDefaults] synchronize];
			}
			
			if([appDelegate.Vitals_Detailref.HeightInch length]>0)
			{
				[[NSUserDefaults standardUserDefaults] setObject:appDelegate.Vitals_Detailref.HeightInch forKey:[NSString stringWithFormat:@"%d_HeightFeet",appDelegate.SelectedUserID]];
				[[NSUserDefaults standardUserDefaults] synchronize];
				
				[[NSUserDefaults standardUserDefaults] setObject:appDelegate.Vitals_Detailref.HeightCms forKey:[NSString stringWithFormat:@"%d_HeightCms",appDelegate.SelectedUserID]];
				[[NSUserDefaults standardUserDefaults] synchronize];
			}
			
			if(appDelegate.Vitals_Detailref.Vitals_ID==0)
			{
				Result=[appDelegate InsertVitalsDetail:appDelegate.Vitals_Detailref]; 
			}
			else
			{
				Result=[appDelegate UpdateVitalsDetail:appDelegate.Vitals_Detailref];
			}
			if(Result>0)
			{
				appDelegate.isDailyReport=TRUE;
				[self.navigationController popViewControllerAnimated:YES];
			}			
		}
		else
		{
			UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter the data in at least one field!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			alert.tag=10;
			[alert show];
			[alert release];
		}
		[Pool release];
	}
	else if(SelectedIndex==1)
	{
		///// Save Routine Data
		if([appDelegate.Routine_Detailrf.Sleep length]>0 || [appDelegate.Routine_Detailrf.Exercise length]>0 || [appDelegate.Routine_Detailrf.Mood length]>0 || [appDelegate.Routine_Detailrf.Activity length]>0 || [appDelegate.Routine_Detailrf.Diapering length]>0 || [appDelegate.Routine_Detailrf.Feeding length]>0 || [appDelegate.Routine_Detailrf.Alcohol length]>0 || [appDelegate.Routine_Detailrf.Cigarrettes length]>0 || [appDelegate.Routine_Detailrf.Drugs length]>0 || [appDelegate.Routine_Detailrf.Other length]>0 || appDelegate.Routine_Detailrf.calories!=-1)
		{
			if(([appDelegate.Routine_Detailrf.Sleep length]>0 && [appDelegate.Routine_Detailrf.WakeUpSleep length]>0) || ([appDelegate.Routine_Detailrf.Sleep length]==0 && [appDelegate.Routine_Detailrf.WakeUpSleep length]==0))
			{
				if(appDelegate.Routine_Detailrf.Routine_ID==0)
				{
					if(appDelegate.SaveMenstural==TRUE)
					{
						[self SaveMensturalCycle];
					}			
					Result=[appDelegate InsertRoutinesDetail:appDelegate.Routine_Detailrf];
					if(Result >0 && [appDelegate.Routine_Detailrf.Exercise_id length]>0)
					{
						[self StoreExerciseDuration:Result];
					}
					if(Result>0 && [appDelegate.UnitDictionary count]>0)
					{
						[self SaveFeedingDetail:Result];
					}
				}
				else
				{
					if(appDelegate.SaveMenstural==TRUE)
					{
						[self SaveMensturalCycle];
					}			
					Result=[appDelegate UpdateRoutinesDetail:appDelegate.Routine_Detailrf]; 
					[appDelegate DeleteAllCategoriesData:@"exercise_Duration"  IDname:@"Routine_ID" DeleteID:appDelegate.Routine_Detailrf.Routine_ID];
					if(Result >0 && [appDelegate.Routine_Detailrf.Exercise_id length]>0)
					{
						[self StoreExerciseDuration:appDelegate.Routine_Detailrf.Routine_ID];
					}
					[appDelegate DeleteAllCategoriesData:@"Feed_Detail"  IDname:@"Routine_ID" DeleteID:appDelegate.Routine_Detailrf.Routine_ID];
					if(Result>0 && [appDelegate.UnitDictionary count]>0)
					{
						[self SaveFeedingDetail:Result];
					}
				}
				if(Result>0)
				{
					appDelegate.isDailyReport=TRUE;
					[self.navigationController popViewControllerAnimated:YES];
				}	
			}
			else
			{
				UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Sleep and Wakeup sleep are compulsary fields!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				alert.tag=10;
				[alert show];
				[alert release];
			}
		}
		else
		{			
			if(appDelegate.SaveMenstural==TRUE)
			{
				[self SaveMensturalCycle];				
				[self.navigationController popViewControllerAnimated:YES];
			}
			else
			{
				UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter the data in at least one field!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				alert.tag=10;
				[alert show];
				[alert release];
			}
		}		
	}
	else
	{		
		//// Save Vitals And Routin Data(Favourite)
		if([appDelegate.Vitals_Detailref.BP length]>0 || [appDelegate.Vitals_Detailref.BloodSugar length]>0 || [appDelegate.Vitals_Detailref.TempC length]>0 || [appDelegate.Vitals_Detailref.Fasting length]>0 || [appDelegate.Vitals_Detailref.Pulse length]>0 || [appDelegate.Vitals_Detailref.Respiration length]>0 || [appDelegate.Vitals_Detailref.Other length]>0 || [appDelegate.Vitals_Detailref.WeightKgs length]>0 || [appDelegate.Vitals_Detailref.Pain length]>0 || [appDelegate.Vitals_Detailref.HeightCms length]>0 || appDelegate.Vitals_Detailref.Magnitude!=0)
		{
			NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
			if([appDelegate.Vitals_Detailref.WeightLbs length]>0)
			{
				[[NSUserDefaults standardUserDefaults] setObject:appDelegate.Vitals_Detailref.WeightLbs forKey:[NSString stringWithFormat:@"%d_WeightLbs",appDelegate.SelectedUserID]];
				[[NSUserDefaults standardUserDefaults] synchronize];
				
				[[NSUserDefaults standardUserDefaults] setObject:appDelegate.Vitals_Detailref.WeightKgs forKey:[NSString stringWithFormat:@"%d_WeightKgs",appDelegate.SelectedUserID]];
				[[NSUserDefaults standardUserDefaults] synchronize];
			}
			
			if([appDelegate.Vitals_Detailref.HeightInch length]>0)
			{
				[[NSUserDefaults standardUserDefaults] setObject:appDelegate.Vitals_Detailref.HeightInch forKey:[NSString stringWithFormat:@"%d_HeightFeet",appDelegate.SelectedUserID]];
				[[NSUserDefaults standardUserDefaults] synchronize];
				
				[[NSUserDefaults standardUserDefaults] setObject:appDelegate.Vitals_Detailref.HeightCms forKey:[NSString stringWithFormat:@"%d_HeightCms",appDelegate.SelectedUserID]];
				[[NSUserDefaults standardUserDefaults] synchronize];
			}
			
			if(appDelegate.Vitals_Detailref.Vitals_ID==0)
			{
				Result=[appDelegate InsertVitalsDetail:appDelegate.Vitals_Detailref]; 
			}
			else
			{
				Result=[appDelegate UpdateVitalsDetail:appDelegate.Vitals_Detailref];
			}
			if(Result>0)
			{
				if([appDelegate.Routine_Detailrf.Sleep length]>0 || [appDelegate.Routine_Detailrf.Exercise length]>0 || [appDelegate.Routine_Detailrf.Mood length]>0 || [appDelegate.Routine_Detailrf.Activity length]>0 || [appDelegate.Routine_Detailrf.Diapering length]>0 || [appDelegate.Routine_Detailrf.Feeding length]>0 || [appDelegate.Routine_Detailrf.Alcohol length]>0 || [appDelegate.Routine_Detailrf.Cigarrettes length]>0 || [appDelegate.Routine_Detailrf.Drugs length]>0 || [appDelegate.Routine_Detailrf.Other length]>0  || [appDelegate.Routine_Detailrf.WakeUpSleep length]>0 || appDelegate.Routine_Detailrf.calories!=-1)
				{
					if(([appDelegate.Routine_Detailrf.Sleep length]>0 && [appDelegate.Routine_Detailrf.WakeUpSleep length]>0) || ([appDelegate.Routine_Detailrf.Sleep length]==0 && [appDelegate.Routine_Detailrf.WakeUpSleep length]==0))
					{
						if(appDelegate.Routine_Detailrf.Routine_ID==0)
						{
							if(appDelegate.SaveMenstural==TRUE)
							{
								[self SaveMensturalCycle];
							}
							Result=[appDelegate InsertRoutinesDetail:appDelegate.Routine_Detailrf]; 
							if(Result >0 && [appDelegate.Routine_Detailrf.Exercise_id length]>0)
							{
								[self StoreExerciseDuration:Result];
							}
							if(Result>0 && [appDelegate.UnitDictionary count]>0)
							{
								[self SaveFeedingDetail:Result];
							}
						}
						else
						{
							if(appDelegate.SaveMenstural==TRUE)
							{
								[self SaveMensturalCycle];
							}
							Result=[appDelegate UpdateRoutinesDetail:appDelegate.Routine_Detailrf]; 
							[appDelegate DeleteAllCategoriesData:@"exercise_Duration"  IDname:@"Routine_ID" DeleteID:appDelegate.Routine_Detailrf.Routine_ID];
							if(Result >0 && [appDelegate.Routine_Detailrf.Exercise_id length]>0)
							{
								[self StoreExerciseDuration:appDelegate.Routine_Detailrf.Routine_ID];										
							}
							[appDelegate DeleteAllCategoriesData:@"Feed_Detail"  IDname:@"Routine_ID" DeleteID:appDelegate.Routine_Detailrf.Routine_ID];
							if(Result>0 && [appDelegate.UnitDictionary count]>0)
							{
								[self SaveFeedingDetail:Result];
							}
						}
						if(Result>0)
						{
							[self.navigationController popViewControllerAnimated:YES];
						}
					}
					else
					{
						UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Sleep and Wakeup sleep are compulsary fields!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
						alert.tag=10;
						[alert show];
						[alert release];
					}
				}
				else
				{
					[self.navigationController popViewControllerAnimated:YES];
				}
			}		
			[Pool release];
		}
		else
		{
			if([appDelegate.Routine_Detailrf.Sleep length]>0 || [appDelegate.Routine_Detailrf.Exercise length]>0 || [appDelegate.Routine_Detailrf.Mood length]>0 || [appDelegate.Routine_Detailrf.Activity length]>0 || [appDelegate.Routine_Detailrf.Diapering length]>0 || [appDelegate.Routine_Detailrf.Feeding length]>0 || [appDelegate.Routine_Detailrf.Alcohol length]>0 || [appDelegate.Routine_Detailrf.Cigarrettes length]>0 || [appDelegate.Routine_Detailrf.Drugs length]>0 || [appDelegate.Routine_Detailrf.Other length]>0  || [appDelegate.Routine_Detailrf.WakeUpSleep length]>0)
			{
				if(([appDelegate.Routine_Detailrf.Sleep length]>0 && [appDelegate.Routine_Detailrf.WakeUpSleep length]>0) || ([appDelegate.Routine_Detailrf.Sleep length]==0 && [appDelegate.Routine_Detailrf.WakeUpSleep length]==0))
				{
					if(appDelegate.Routine_Detailrf.Routine_ID==0)
					{
						if(appDelegate.SaveMenstural==TRUE)
						{
							[self SaveMensturalCycle];
						}
						Result=[appDelegate InsertRoutinesDetail:appDelegate.Routine_Detailrf]; 
						if(Result >0 && [appDelegate.Routine_Detailrf.Exercise_id length]>0)
						{										
							[self StoreExerciseDuration:Result];
						}
					}
					else
					{
						if(appDelegate.SaveMenstural==TRUE)
						{
							[self SaveMensturalCycle];
						}
						Result=[appDelegate UpdateRoutinesDetail:appDelegate.Routine_Detailrf]; 
						[appDelegate DeleteAllCategoriesData:@"exercise_Duration"  IDname:@"Routine_ID" DeleteID:appDelegate.Routine_Detailrf.Routine_ID];
						if(Result >0 && [appDelegate.Routine_Detailrf.Exercise_id length]>0)
						{
							[self StoreExerciseDuration:appDelegate.Routine_Detailrf.Routine_ID];
						}
					}
					if(Result>0)
					{
						[self.navigationController popViewControllerAnimated:YES];
					}
				}
				else
				{
					UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Sleep and Wakeup sleep are compulsary fields!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
					alert.tag=10;
					[alert show];
					[alert release];
				}
			}
			else
			{
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				if(appDelegate.SaveMenstural==TRUE)
				{
					[self SaveMensturalCycle];
					[self.navigationController popViewControllerAnimated:YES];
				}			
				else
				{				
					UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter the data in at least one field!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
					alert.tag=10;
					[alert show];
					[alert release];
				}
				[Pool release];
			}
		}
	}
}

///// Save Feed Qty and Unit with ID in table
-(void)SaveFeedingDetail:(NSInteger)Routine_ID
{
	NSArray *array=[appDelegate.UnitDictionary allKeys];
	for(int i=0;i<[array count];i++)
	{
		if([appDelegate.UnitDictionary objectForKey:[array objectAtIndex:i]]!=nil)
		{
			NSMutableDictionary *DIC=[[appDelegate.UnitDictionary objectForKey:[array objectAtIndex:i]]mutableCopy];			
			[DIC setValue:[NSString stringWithFormat:@"%d",Routine_ID] forKey:@"Routine_ID"];
			[DIC setValue:[NSString stringWithFormat:@"%@ %@",appDelegate.Routine_Detailrf.EntryDate,appDelegate.Routine_Detailrf.EntryTime] forKey:@"Entry_Date"];
			[appDelegate InsertFeedDetail:DIC];
			[DIC release];
		}
	}
}

///// Save Menstural Cycle Data in to table
-(void)SaveMensturalCycle
{
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	if([appDelegate.Mensturalref.StartDate length]==0)
	{
		appDelegate.Mensturalref.Daily_StartDate=@"";
	}
	if([appDelegate.Mensturalref.EndDate length]==0)
	{
		appDelegate.Mensturalref.Daily_EndDate=@"";
	}
	if(([appDelegate.Mensturalref.StartDate length]>0 && [appDelegate.Mensturalref.Daily_StartDate length]==0) )//|| ([appDelegate.Mensturalref.StartDate length]>0 && [appDelegate.Mensturalref.EndDate length]==0))
	{
		appDelegate.Mensturalref.Daily_StartDate=[NSString stringWithFormat:@"%@ %@",appDelegate.Routine_Detailrf.EntryDate,appDelegate.Routine_Detailrf.EntryTime];
	}
	if([appDelegate.Mensturalref.EndDate length]>0 && [appDelegate.Mensturalref.Daily_EndDate length]==0)
	{
		appDelegate.Mensturalref.Daily_EndDate=[NSString stringWithFormat:@"%@ %@",appDelegate.Routine_Detailrf.EntryDate,appDelegate.Routine_Detailrf.EntryTime];
	}
	if(appDelegate.Mensturalref.Cycle_ID==0)
	{
		[appDelegate InsertMenstural:appDelegate.Mensturalref];
	}
	else
	{
		[appDelegate UpdateMenstural:appDelegate.Mensturalref]; 
	}
	[Pool release];
}

//// Store Exercise duration
-(void)StoreExerciseDuration:(int)Routine_ID
{
	arr2=[appDelegate.Routine_Detailrf.Exercise_Dru_ID componentsSeparatedByString:@", "];
	arr3=[appDelegate.Routine_Detailrf.Exercise_Duration componentsSeparatedByString:@", "];
	
	for(int i=0;i<[arr2 count];i++)
	{		
		[appDelegate InsertExercise_Duration:[arr2 objectAtIndex:i]  Dur:[[arr3 objectAtIndex:i]intValue] andDate:[NSString stringWithFormat:@"%@ %@",appDelegate.Routine_Detailrf.EntryDate,appDelegate.Routine_Detailrf.EntryTime] andID:Routine_ID];
	}	
}

//// Call When we press button Cancel when picker is visiable
-(IBAction)btnCancel_Clicked:(id)sender
{
	tblView.userInteractionEnabled=TRUE;
	PickerView.hidden=TRUE;
	ToolBar.hidden=TRUE;
	DatePicker.hidden=TRUE;
	TimeDatePicker.hidden=TRUE;
	btnSave.enabled=TRUE;
}

//// Call When we press button Done when picker is visiable
-(IBAction)btnDone_CLicked:(id)sender
{
	btnSave.enabled=TRUE;
	TimeDatePicker.hidden=TRUE;
	if(SelectedTag==0)
	{
		if(SelectedIndex==3)
		{
			//// Get Routine and Vital data(Favorite)
			NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
			DatePicker.hidden=TRUE;
			ToolBar.hidden=TRUE;
			TimeDatePicker.hidden=TRUE;
			NSString *Date=[appDelegate.DateFormatter stringFromDate: DatePicker.date];	
			TimeDatePicker.maximumDate=DatePicker.date;
			[TimeDatePicker setDate:DatePicker.date animated:YES];
			arr1=[Date componentsSeparatedByString:@" "];		
			NSString *DateTime=[arr1 objectAtIndex:1];
			Date=[arr1 objectAtIndex:0];
			NSArray *array2=[DateTime componentsSeparatedByString:@":"];
		//	NSString *Mins=[appDelegate CheckTIme:[[array2 objectAtIndex:1]intValue]];
			NSString *Mins=[array2 objectAtIndex:1];
			DateTime=[NSString stringWithFormat:@"%@:%@",[array2 objectAtIndex:0],Mins];
			
			if(!([Date isEqualToString:appDelegate.Vitals_Detailref.EntryDate] && [DateTime isEqualToString:appDelegate.Vitals_Detailref.EntryTime]))			
			{
				[appDelegate SelectVitalsDetail:Date  AndTime:DateTime andUserID:appDelegate.SelectedUserID];
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
					appDelegate.Vitals_Detailref.EntryTime=DateTime;
				}
			}		
			if(!([Date isEqualToString:appDelegate.Routine_Detailrf.EntryDate] && [DateTime isEqualToString:appDelegate.Routine_Detailrf.EntryTime]))
			{
				[appDelegate SelectRoutinesDetail:Date  AndTime:DateTime andUserID:appDelegate.SelectedUserID];
				[appDelegate selectMenstural:appDelegate.SelectedUserID  passDate:[NSString stringWithFormat:@"%@ %@",Date,DateTime]];
				if([appDelegate.HourlyDataArray count]>0)
				{
					appDelegate.Routine_Detailrf =[appDelegate.HourlyDataArray objectAtIndex:0];
					[appDelegate SelectExercise_Duration:appDelegate.Routine_Detailrf.Routine_ID];
					appDelegate.Routine_Detailrf.Exercise=@"";
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
					appDelegate.Routine_Detailrf.User_ID=appDelegate.SelectedUserID;
					appDelegate.Routine_Detailrf.EntryDate=Date;
					appDelegate.Routine_Detailrf.EntryTime=DateTime;
					[appDelegate.UnitDictionary removeAllObjects];
				}
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
					self.isEndDisabled=FALSE;
					if(([appDelegate.Mensturalref.Daily_Date isEqualToString:[NSString stringWithFormat:@"%@",appDelegate.Routine_Detailrf.EntryDate]]))
					{
						
						[self SetCycleData];
						[tblView reloadData];
						[Pool release];
						appDelegate.SaveMenstural=TRUE;
						return;
					}
					if([appDelegate.Mensturalref.Daily_EndDate isEqualToString:[NSString stringWithFormat:@"%@ %@",appDelegate.Routine_Detailrf.EntryDate,appDelegate.Routine_Detailrf.EntryTime]])
					{
						self.isEndDisabled=TRUE;
					}
					if([appDelegate.Mensturalref.Daily_EndDate length]==0)
					{
						self.isEndDisabled=TRUE;
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
						appDelegate.Mensturalref.User_ID=appDelegate.SelectedUserID;
						appDelegate.Mensturalref.Daily_Date=Date;
					}
					else
					{
						[appDelegate.Mensturalref ClearData];
						appDelegate.Mensturalref.User_ID=appDelegate.SelectedUserID;
						appDelegate.Mensturalref.Daily_Date=Date;
					}
					appDelegate.SaveMenstural=FALSE;
				}
				[self SetCycleData];
				//
			}
			[tblView reloadData];
			[Pool release];
		}
		else if(SelectedIndex==0)
		{
			//// Get Vitals data
			DatePicker.hidden=TRUE;
			ToolBar.hidden=TRUE;
			NSString *Date;
			[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];			
			Date=[appDelegate.DateFormatter stringFromDate: DatePicker.date];			
			arr1=[Date componentsSeparatedByString:@" "];			
			NSString *DateTime=[arr1 objectAtIndex:1];
			Date=[arr1 objectAtIndex:0];			
			if(!([Date isEqualToString:appDelegate.Vitals_Detailref.EntryDate] && [DateTime isEqualToString:appDelegate.Vitals_Detailref.EntryTime]))	
			{
				NSArray *array2=[DateTime componentsSeparatedByString:@":"];
				NSString *Mins=[array2 objectAtIndex:1];
				DateTime=[NSString stringWithFormat:@"%@:%@",[array2 objectAtIndex:0],Mins];
				[appDelegate SelectVitalsDetail:Date  AndTime:DateTime andUserID:appDelegate.SelectedUserID];
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
					appDelegate.Vitals_Detailref.EntryTime=DateTime;
				}
				if(appDelegate.Vitals_Detailref.Vitals_ID!=0)
				{
					tblView.tableFooterView=viewFooterVital;
				}
				else
				{
					tblView.tableFooterView=nil;
				}				
				[tblView reloadData];
			}		
		}
		else
		{
			//// Get Routine Data
			DatePicker.hidden=TRUE;
			ToolBar.hidden=TRUE;
			[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
			NSString *Date=[appDelegate.DateFormatter stringFromDate: DatePicker.date];		
			arr1=[Date componentsSeparatedByString:@" "];		
			TimeDatePicker.maximumDate= DatePicker.date;
			[TimeDatePicker setDate:DatePicker.date animated:YES];
			NSString *DateTime=[arr1 objectAtIndex:1];
			Date=[arr1 objectAtIndex:0];		
			if(!([Date isEqualToString:appDelegate.Routine_Detailrf.EntryDate] && [DateTime isEqualToString:appDelegate.Routine_Detailrf.EntryTime]))
			{
				NSArray *array2=[DateTime componentsSeparatedByString:@":"];
				NSString *Mins=[array2 objectAtIndex:1];
				DateTime=[NSString stringWithFormat:@"%@:%@",[array2 objectAtIndex:0],Mins];			
				[appDelegate SelectRoutinesDetail:Date  AndTime:DateTime andUserID:appDelegate.SelectedUserID];
				[appDelegate selectMenstural:appDelegate.SelectedUserID  passDate:[NSString stringWithFormat:@"%@ %@",Date,DateTime]];
				if([appDelegate.HourlyDataArray count]>0)
				{
					appDelegate.Routine_Detailrf =[appDelegate.HourlyDataArray objectAtIndex:0];
					[appDelegate SelectExercise_Duration:appDelegate.Routine_Detailrf.Routine_ID];
					appDelegate.Routine_Detailrf.Exercise=@"";
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
					appDelegate.Routine_Detailrf.User_ID=appDelegate.SelectedUserID;
					appDelegate.Routine_Detailrf.EntryDate=Date;
					[appDelegate.UnitDictionary removeAllObjects];
					appDelegate.Routine_Detailrf.EntryTime=DateTime;
				}
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
					self.isEndDisabled=FALSE;
					if(([appDelegate.Mensturalref.Daily_Date isEqualToString:[NSString stringWithFormat:@"%@",appDelegate.Routine_Detailrf.EntryDate]]))
					{
						
						[self SetCycleData];
						[tblView reloadData];
						appDelegate.SaveMenstural=TRUE;
					//	[Pool release];
						return;
					}
					//if([appDelegate.Mensturalref.EndDate length]>0 && (![appDelegate.Mensturalref.Daily_EndDate isEqualToString:[NSString stringWithFormat:@"%@ %@",appDelegate.Routine_Detailrf.EntryDate,appDelegate.Routine_Detailrf.EntryTime]]))
					
					if([appDelegate.Mensturalref.Daily_EndDate isEqualToString:[NSString stringWithFormat:@"%@ %@",appDelegate.Routine_Detailrf.EntryDate,appDelegate.Routine_Detailrf.EntryTime]])
					{
						self.isEndDisabled=TRUE;
					}
					if([appDelegate.Mensturalref.Daily_EndDate length]==0)
					{
						self.isEndDisabled=TRUE;
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
						appDelegate.Mensturalref.User_ID=appDelegate.SelectedUserID;
						appDelegate.Mensturalref.Daily_Date=Date;
					}
					else
					{
						[appDelegate.Mensturalref ClearData];
						appDelegate.Mensturalref.User_ID=appDelegate.SelectedUserID;
						appDelegate.Mensturalref.Daily_Date=Date;
					}
					appDelegate.SaveMenstural=FALSE; 
				}				
				if(appDelegate.Routine_Detailrf.Routine_ID!=0)
				{
					tblView.tableFooterView=viewFooterRoutine;
				}
				else
				{
					tblView.tableFooterView=nil;
				}
				[self SetCycleData];
				[tblView reloadData];
			}			
		}
	}
	else if(SelectedTag==1)
	{
		//// Store BP dataq
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		PickerView.hidden=TRUE;
		ToolBar.hidden=TRUE;		
		strRestaurantTypeSecond=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:[PickerView selectedRowInComponent:0]];		
		strRestaurantType=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:[PickerView selectedRowInComponent:1]];
		appDelegate.Vitals_Detailref.BP=[NSString stringWithFormat:@"%@/%@",strRestaurantTypeSecond,strRestaurantType];
		[tblView reloadData];	
		[Pool release];
	}
	else if(SelectedTag==2)
	{
		//// Store Blood Sugar
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		PickerView.hidden=TRUE;
		ToolBar.hidden=TRUE;
		strRestaurantTypeSecond=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:[PickerView selectedRowInComponent:0]];
		appDelegate.Vitals_Detailref.BloodSugar=strRestaurantTypeSecond; 
		[tblView reloadData];
		[Pool release];
	}
	else if(SelectedTag==17)
	{
		//// Store Fasting
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		PickerView.hidden=TRUE;
		ToolBar.hidden=TRUE;
		strRestaurantTypeSecond=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:[PickerView selectedRowInComponent:0]];
		appDelegate.Vitals_Detailref.Fasting=strRestaurantTypeSecond; 
		[tblView reloadData];
		[Pool release];
	}	
	else if(SelectedTag==3)
	{
		///Store Temperature
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		PickerView.hidden=TRUE;
		ToolBar.hidden=TRUE;			
		strRestaurantTypeSecond=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:[PickerView selectedRowInComponent:0]];		
		strRestaurantType=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",15]]  objectAtIndex:[PickerView selectedRowInComponent:1]];
		appDelegate.Vitals_Detailref.TempC=[NSString stringWithFormat:@"%@.%@",strRestaurantTypeSecond,strRestaurantType]; 
		double C=[appDelegate.Vitals_Detailref.TempC doubleValue];
		double F=(1.8 * C)+32;
		appDelegate.Vitals_Detailref.TempF=[NSString stringWithFormat:@"%.01f",F];
		[tblView reloadData];
		[Pool release];
	}
	else if(SelectedTag==4)
	{
		//Store Temperature
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		PickerView.hidden=TRUE;
		ToolBar.hidden=TRUE;		
		strRestaurantTypeSecond=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:[PickerView selectedRowInComponent:0]];		
		strRestaurantType=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",15]] objectAtIndex:[PickerView selectedRowInComponent:1]];
		appDelegate.Vitals_Detailref.TempF=[NSString stringWithFormat:@"%@.%@",strRestaurantTypeSecond,strRestaurantType]; 
		double F=[appDelegate.Vitals_Detailref.TempF doubleValue];
		double C=(F - 32)/1.8;
		appDelegate.Vitals_Detailref.TempC=[NSString stringWithFormat:@"%.01f ",C];
		[tblView reloadData];
		[Pool release];
	}
    else if(SelectedTag==5)
	{
		/// Store Pulse
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		PickerView.hidden=TRUE;
		ToolBar.hidden=TRUE;		
		strRestaurantTypeSecond=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:[PickerView selectedRowInComponent:0]];
		appDelegate.Vitals_Detailref.Pulse=strRestaurantTypeSecond; 
		[tblView reloadData];
		[Pool release];
	}		
	else if(SelectedTag==6)
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		PickerView.hidden=TRUE;
		ToolBar.hidden=TRUE;		
		strRestaurantTypeSecond=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:[PickerView selectedRowInComponent:0]];
		appDelegate.Vitals_Detailref.Respiration=strRestaurantTypeSecond; 
		[tblView reloadData];
		[Pool release];
	}	
	else if(SelectedTag==8)
	{
		//// Store Cigarrettes
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		PickerView.hidden=TRUE;
		ToolBar.hidden=TRUE;		
		strRestaurantType=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:[PickerView selectedRowInComponent:0]];
		appDelegate.Routine_Detailrf.Cigarrettes=[NSString stringWithFormat:@"%@",strRestaurantType];
		[tblView reloadData];
		[Pool release];
	}
	else if(SelectedTag==7)
	{
		//// Store Sleep Time
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		PickerView.hidden=TRUE;
		ToolBar.hidden=TRUE;		
		[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
		NSString *DateTime=[appDelegate.DateFormatter stringFromDate:TimeDatePicker.date];
		NSArray *arr4=[DateTime componentsSeparatedByString:@":"];
		NSString *Mins=[arr4 objectAtIndex:1];
		DateTime=[NSString stringWithFormat:@"%@:%@",[arr4 objectAtIndex:0],Mins];
		if([appDelegate.Routine_Detailrf.WakeUpSleep isEqualToString:@""])
		{
			appDelegate.Routine_Detailrf.Sleep=DateTime;
		}
		else
		{
			NSDate *WakeUpDate=[appDelegate.DateFormatter dateFromString:appDelegate.Routine_Detailrf.WakeUpSleep];
			NSDate *SleepDate=[appDelegate.DateFormatter dateFromString:DateTime];
			NSLog(@"%f",[WakeUpDate timeIntervalSinceDate:SleepDate]);
			if([WakeUpDate timeIntervalSinceDate:SleepDate]>=0)
			{
				appDelegate.Routine_Detailrf.Sleep=DateTime;
			}
			else
			{
				UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Slept time must be \n less than or equal to Wake up time" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alert show];
				[alert release];
				return;
			}
		}
		[tblView reloadData];
		[Pool release];
	}
	else if(SelectedTag==9)
	{
		/// Store Wake up time
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		PickerView.hidden=TRUE;
		ToolBar.hidden=TRUE;		
		[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
		NSString *DateTime=[appDelegate.DateFormatter stringFromDate:TimeDatePicker.date];
		
		NSArray *arr4=[DateTime componentsSeparatedByString:@":"];
		NSString *Mins=[arr4 objectAtIndex:1];
		DateTime=[NSString stringWithFormat:@"%@:%@",[arr4 objectAtIndex:0],Mins];
		
		NSDate *WakeUpDate=[appDelegate.DateFormatter dateFromString:DateTime];
		NSDate *SleepDate=[appDelegate.DateFormatter dateFromString:appDelegate.Routine_Detailrf.Sleep];
		NSLog(@"%f",[WakeUpDate timeIntervalSinceDate:SleepDate]);
		if([WakeUpDate timeIntervalSinceDate:SleepDate]>=0)
		{
			appDelegate.Routine_Detailrf.WakeUpSleep=DateTime;
		}
		else
		{
			UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Wake up time must be \n greater than or equal to Slept time" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alert show];
			[alert release];
			return;
		}
		[tblView reloadData];
		[Pool release];
	}
	else if(SelectedTag==10 || SelectedTag==12)
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		PickerView.hidden=TRUE;
		ToolBar.hidden=TRUE;		
		strRestaurantTypeSecond=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag+1]]  objectAtIndex:[PickerView selectedRowInComponent:1]];		
		strRestaurantType=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:[PickerView selectedRowInComponent:0]];		
		if(SelectedTag==10)
		{
			double Ounces=[strRestaurantTypeSecond intValue];
			Ounces=Ounces*0.0625;
			NSArray *arr4=[[NSString stringWithFormat:@"%.3f",Ounces] componentsSeparatedByString:@"."];
			appDelegate.Vitals_Detailref.WeightLbs= [NSString stringWithFormat:@"%@.%@",strRestaurantType,[arr4 objectAtIndex:1]];	
			NSString *ConvertPound=[NSString stringWithFormat:@"%@.%@",strRestaurantType,[arr4 objectAtIndex:1]];
			appDelegate.Vitals_Detailref.WeightKgs=[NSString stringWithFormat:@"%.3f",([ConvertPound doubleValue]/2.2)];			
			NSArray *arr=[appDelegate.Vitals_Detailref.WeightKgs componentsSeparatedByString:@"."];
			if([arr count]>1)
			{
				int GMS=[[arr objectAtIndex:1]intValue];
				if(GMS>=0 && GMS<=50)
				{
					GMS=0;
				}
				else if(GMS>50 && GMS<=150)
				{
					GMS=100;
				}
				else if(GMS>150 && GMS<=250)
				{
					GMS=200;
				}
				else if(GMS>250 && GMS<=350)
				{
					GMS=300;
				}
				else if(GMS>350 && GMS<=450)
				{
					GMS=400;
				}
				else if(GMS>450 && GMS<=550)
				{
					GMS=500;
				}
				else if(GMS>550 && GMS<=650)
				{
					GMS=600;
				}
				else if(GMS>650 && GMS<=750)
				{
					GMS=700;
				}
				else if(GMS>750 && GMS<=850)
				{
					GMS=800;
				}
				else if(GMS>850 && GMS<=999)
				{
					GMS=900;
				}
				else
					GMS=0;
				appDelegate.Vitals_Detailref.WeightKgs=[NSString stringWithFormat:@"%@.%03d",[arr objectAtIndex:0],GMS];
			}
		}
		if(SelectedTag==12)
		{
			appDelegate.Vitals_Detailref.WeightKgs= [NSString stringWithFormat:@"%@.%@",strRestaurantType,strRestaurantTypeSecond];			
			NSString *ConvertPound=[NSString stringWithFormat:@"%@.%@",strRestaurantType,strRestaurantTypeSecond];			
			appDelegate.Vitals_Detailref.WeightLbs=[NSString stringWithFormat:@"%.3f",([ConvertPound doubleValue]*2.2)];
		}		
		[tblView reloadData];
		[Pool release];
	}
	else if(SelectedTag==18)
	{
		/// Store Height in CMS
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		PickerView.hidden=TRUE;
		ToolBar.hidden=TRUE;
		strRestaurantTypeSecond=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",19]] objectAtIndex:[PickerView selectedRowInComponent:1]];		
		strRestaurantType=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:[PickerView selectedRowInComponent:0]];		
		appDelegate.Vitals_Detailref.HeightInch=[NSString stringWithFormat:@"%@' %@\"",strRestaurantType,strRestaurantTypeSecond] ;
		NSString *CMS= [appDelegate ConvertIntoCms:[NSString stringWithFormat:@"%@' %@\"",strRestaurantType,strRestaurantTypeSecond]];		
		appDelegate.Vitals_Detailref.HeightCms=	[NSString stringWithFormat:@"%@",CMS] ;
		[tblView reloadData];
		[Pool release];
	}
	else if(SelectedTag==20)
	{
		//// Store Height in FEET
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		PickerView.hidden=TRUE;
		ToolBar.hidden=TRUE;
		strRestaurantType=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:[PickerView selectedRowInComponent:0]];	
		strRestaurantTypeSecond=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag+1]] objectAtIndex:[PickerView selectedRowInComponent:1]];			
		if([strRestaurantType isEqualToString:@"2"] && [strRestaurantTypeSecond intValue]>72)
		{
			appDelegate.Vitals_Detailref.HeightCms=@"2.72";//[NSString stringWithFormat:@"%@.%@",strRestaurantType,strRestaurantTypeSecond];
		}
		else
			appDelegate.Vitals_Detailref.HeightCms=[NSString stringWithFormat:@"%@.%@",strRestaurantType,strRestaurantTypeSecond];
		NSString *Feet=[appDelegate ConvertFeets:appDelegate.Vitals_Detailref.HeightCms];		
		appDelegate.Vitals_Detailref.HeightInch=Feet;
		[tblView reloadData];
		[Pool release];		
	}
}

// called on finger up if user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	PickerView.hidden=TRUE;
	ToolBar.hidden=TRUE;
	DatePicker.hidden=TRUE;
	btnSave.enabled=TRUE;
	TimeDatePicker.hidden=TRUE;
}

//// Fill Array for picker
-(NSMutableArray *)FillArray:(int)i
{   
	NSMutableArray *TypeArray;
	TypeArray=[[[NSMutableArray alloc]init]autorelease];	
	
	//////////// Routine
	if(i==7)
	{
		for(int i=0;i<=24;i++)
		{
			[TypeArray addObject:[NSString stringWithFormat:@"%d",i]];
		}
	}
	else if(i==8)
	{
		for(int i=0;i<=10;i++)
		{
			[TypeArray addObject:[NSString stringWithFormat:@"%d",i]];
		}
	}
	//// Minutes
	else if(i==16)
	{
		for(int i=0;i<=56;i=i+15)
		{
			[TypeArray addObject:[NSString stringWithFormat:@"%d",i]];
		}
	}
	
	////////// Vitals 
	else if(i==1)
	{
		for(int i=50;i<=200;i++)
		{
			[TypeArray addObject:[NSString stringWithFormat:@"%d",i]];
		}
	}
	else if(i==2 || i==17){
		for(int i=1;i<=200;i++)
		{
			[TypeArray addObject:[NSString stringWithFormat:@"%d mg/dl",i]];
		}
	}
	else if(i==3)
	{
		for(int i=32;i<=45;i++)
		{
			[TypeArray addObject:[NSString stringWithFormat:@"%d",i]];
		}
	}
	else if(i==4){
		for(int i=90;i<=107;i++)
		{
			[TypeArray addObject:[NSString stringWithFormat:@"%d",i]];
		}
	}
	else if(i==5)
	{
		for(int i=40;i<200;i++)
		{
			[TypeArray addObject:[NSString stringWithFormat:@"%d",i]];
		}
	}
	else if(i==6)
	{
		for(int i=10;i<60;i++)
		{
			[TypeArray addObject:[NSString stringWithFormat:@"%d",i]];
		}
	}	
	else if(i==10)
	{
		for(int i=0;i<=334;i++)
		{
			[TypeArray addObject:[NSString stringWithFormat:@"%d",i]];
		}
	}
	else if(i==11)
	{
		for(int i=0;i<=15;i++)
		{
			[TypeArray addObject:[NSString stringWithFormat:@"%d",i]];
		}
	}
	else if(i==12)
	{
		for(int i=0;i<=151;i++)
		{
			[TypeArray addObject:[NSString stringWithFormat:@"%d",i]];
		}
	}
	else if(i==13)
	{
		for(int i=0;i<1000;i=i+100)
		{
			[TypeArray addObject:[NSString stringWithFormat:@"%03d",i]];
		}
	}	
	else if(i==15)
	{
		for(int i=0;i<10;i++)
		{
			[TypeArray addObject:[NSString stringWithFormat:@"%d",i]];
		}
	}	
	else if(i==18)
	{		
		for(int i=0;i<=8;i++)
		{
			[TypeArray addObject:[NSString stringWithFormat:@"%d",i]];
		}
	}
	else if(i==19)
	{
		for(int i=0;i<12;i++)
		{
			[TypeArray addObject:[NSString stringWithFormat:@"%d",i]];
		}
	}	
	else if(i==20)
	{
		for(int i=0;i<3;i++)
		{
			[TypeArray addObject:[NSString stringWithFormat:@"%d",i]];
		}
	}
	else if(i==21)
	{
		for(int i=0;i<=99;i++)
		{
			[TypeArray addObject:[NSString stringWithFormat:@"%d",i]];
		}
	}
	return TypeArray;
}

#pragma mark View Methods
// Called after the view has been loaded. For view controllers created in code, this is after -loadView. For view controllers unarchived from a nib, this is after the view is set.
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	appDelegate=[[UIApplication sharedApplication]delegate];
	self.navigationItem.rightBarButtonItem=btnSave;
	tblView.delegate=self;
	tblView.dataSource=self;
	tblView.rowHeight=40;
	[DatePicker setDate:[NSDate date] animated:YES];
	[TimeDatePicker setDate:[NSDate date] animated:YES];
	TimeDatePicker.frame=CGRectMake(0, 200, 320, 216);
	DatePicker.frame=CGRectMake(0, 200, 320, 216);
	PickerView.frame=CGRectMake(0, 200, 320, 216);
	PickerView.delegate=self;
	ToolBar.frame=CGRectMake(0, 200, 320, 44);
	ToolBar.tintColor=[UIColor blackColor];
	lblData=[[UILabel alloc]init];
	lblData.frame=CGRectMake(3,13 , 250, 20);
	lblData.font=[UIFont systemFontOfSize:15];
	lblData.textColor=[UIColor whiteColor];
	lblData.backgroundColor=[UIColor clearColor];
	[ToolBar addSubview:lblData];
	tblView.sectionFooterHeight=2;
	tblView.sectionHeaderHeight=2;
	DatePicker.maximumDate=[NSDate date];
	TimeDatePicker.maximumDate=[NSDate date];
	ToolBar1.tintColor=[UIColor blackColor];
	[self.view bringSubviewToFront:PickerView];
	[self.view bringSubviewToFront:DatePicker];
	[self.view bringSubviewToFront:TimeDatePicker];
	ViewHead=[[UIView alloc]init];
	ViewHead.frame=CGRectMake(0, 0, 320, 45);
	ViewHead.backgroundColor=[UIColor clearColor];
	UILabel *lblHeader=[[UILabel alloc]init];
	lblHeader.frame=CGRectMake(10, 5, 300, 40);
	lblHeader.text=@"Enter the data you want to log or browse to the data to be edited";
	lblHeader.numberOfLines=0;
	lblHeader.textAlignment=UITextAlignmentCenter;
	lblHeader.textColor=[UIColor colorWithRed:0.3019 green:0.3450 blue:0.4274 alpha:1.0];
	lblHeader.font=[UIFont systemFontOfSize:15];
	[ViewHead addSubview:lblHeader];
	lblHeader.backgroundColor=[UIColor clearColor];
	lblHeader.shadowColor = [UIColor whiteColor];
	lblHeader.shadowOffset = CGSizeMake(0.0, 1.0);
	[lblHeader release];
	viewFooterRoutine.backgroundColor=[UIColor groupTableViewBackgroundColor];
	viewFooterVital.backgroundColor=[UIColor groupTableViewBackgroundColor]; 
	ToolBarRV.tintColor=[UIColor blackColor]; 
	[Pool release];
	[super viewDidLoad];
}

// Called when the view is about to made visible. Default does nothing
- (void)viewWillAppear:(BOOL)animated
{
 	btnSave.enabled=TRUE;
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];	
	PickerView.hidden=TRUE;
	DatePicker.hidden=TRUE;
	TimeDatePicker.hidden=TRUE;
	ToolBar.hidden=TRUE;
	//if(!data)
	{
		data=[[NSMutableDictionary alloc]init];
	}
	for(int i = 1; i <=21; i++)
	{
		NSMutableArray *fillPicker=[self FillArray:i];		
		
		[data setObject:fillPicker forKey:[NSString stringWithFormat:@"%d",i]];		
	}
	if(!VitalsArray)
	{
		VitalsArray=[[NSMutableArray alloc]init];
	}
	if(!RoutinesArray)
	{
		RoutinesArray=[[NSMutableArray alloc]init];
	}
	[VitalsArray removeAllObjects];
	[RoutinesArray removeAllObjects];
	[appDelegate SelectUserSettings:appDelegate.SelectedUserID];
	if(SelectedIndex==3)
	{
		self.navigationItem.title=@"My Favorites";
		ToolBar1.hidden=FALSE;
		ToolBarRV.hidden=TRUE; 
		if([appDelegate.UserSettingsArray count]==1)
		{
			User_Settings *Data=[appDelegate.UserSettingsArray objectAtIndex:0];
			DailySettings=Data.DailyEntryDetail;
			if([Data.DailyEntryDetail length]>0)
			{
				VitalsArray = [[DailySettings componentsSeparatedByString:@","]retain]; 
			}
			else
			{
				[VitalsArray removeAllObjects];
			}
			DailySettings=Data.HourlyEntryDetail;
			if([Data.HourlyEntryDetail length]>0)
			{
				RoutinesArray  =[ [DailySettings componentsSeparatedByString:@","]retain]; 
			}
			else
			{
				[RoutinesArray removeAllObjects];
			}
		}
		if(([VitalsArray count]==0) && ([RoutinesArray count]==0))
		{
			self.navigationItem.rightBarButtonItem=nil;
		}
		else
		{
			self.navigationItem.rightBarButtonItem=btnSave;
		}
		[self SetCycleData];
		tblView.tableHeaderView=nil;  
		tblView.tableFooterView=nil;  
		[tblView reloadData];
	}
	else if(SelectedIndex==0)
	{
		ToolBar1.hidden=TRUE;
		ToolBarRV.hidden=FALSE;
		self.navigationItem.rightBarButtonItem=btnSave;
		self.navigationItem.title=@"Vitals";
		if(appDelegate.Vitals_Detailref.Vitals_ID!=0)
		{
			tblView.tableFooterView=viewFooterVital;
		}
		else
		{
			tblView.tableFooterView=nil;
		}	
		
		for(int i=1;i<=10;i++)
		{
			[VitalsArray addObject:[NSString stringWithFormat:@"%d",i]];
		}
		[RoutinesArray removeAllObjects];		
		ToolBarRV.frame=CGRectMake(0, 372, 320, 44);
		tblView.tableHeaderView=ViewHead;  
		[tblView reloadData];		
	}
	else
	{
		ToolBar1.hidden=TRUE;
		ToolBarRV.hidden=FALSE;
		self.navigationItem.rightBarButtonItem=btnSave;
		self.navigationItem.title=@"Routines";
		if(appDelegate.Routine_Detailrf.Routine_ID!=0)
		{
			tblView.tableFooterView=viewFooterRoutine;
		}
		else
		{
			tblView.tableFooterView=nil;
		}
		
		for(int i=1;i<=12;i++)
		{
			[RoutinesArray addObject:[NSString stringWithFormat:@"%d",i]];
		}
		[VitalsArray removeAllObjects];
		
		[self SetCycleData];
		ToolBarRV.frame=CGRectMake(0, 372, 320, 44);
		tblView.tableHeaderView=ViewHead;  
		[tblView reloadData];
	}
	if(appDelegate.isfromRoot==TRUE)
	{
		[tblView scrollRectToVisible:CGRectMake(0, 0, 320, 50)  animated:YES];
		TimeDatePicker.maximumDate=UserDate;
		[DatePicker setDate:UserDate animated:YES];
		DatePicker.maximumDate=[NSDate date];
		appDelegate.isfromRoot=FALSE;
	}	
	[Pool release];
}

// Called when the view is dismissed, covered or otherwise hidden. Default does nothing
- (void)viewWillDisappear:(BOOL)animated
{
	[data release]; 
}

 // Called when the view has been fully transitioned onto the screen. Default does nothing
-(void)viewDidAppear:(BOOL)animated
{
	[self.view bringSubviewToFront:ToolBar1];
	[self.view bringSubviewToFront:ToolBarRV];
	[self.view bringSubviewToFront:ToolBar];
	[self.view bringSubviewToFront:DatePicker];
	[self.view bringSubviewToFront:TimeDatePicker];
	[self.view bringSubviewToFront:PickerView];
	self.view.frame=CGRectMake(0, 0, 320, 416);
	ToolBar.frame=CGRectMake(0, 156, 320, 44);	
	ToolBarRV.frame=CGRectMake(0, 372, 320, 44);
	ToolBar1.frame=CGRectMake(0, 372, 320, 44);
	tblView.frame=CGRectMake(0, 0, 320, 372);	
	DatePicker.frame=CGRectMake(0, 200, 320, 216);
	TimeDatePicker.frame=CGRectMake(0, 200, 320, 216);
	PickerView.frame=CGRectMake(0, 200, 320, 216);	
}

///// Set Flags for Menstrual Cycle data 
-(void)SetCycleData
{	
	if([appDelegate.Mensturalref.StartDate length]>0)
	{
		if([appDelegate.Mensturalref.Daily_Date isEqualToString:appDelegate.Routine_Detailrf.EntryDate])
		{
			IsStartEnabled=TRUE;
		}
		else
			IsStartEnabled=FALSE;
		IsStartFirstTime=TRUE;
		IsStart=YES;
	}
	else
	{
		IsStartFirstTime=FALSE;
		IsStart=NO;
	}
	if([appDelegate.Mensturalref.EndDate length]>0)
	{
		IsEnd=YES;		
	}
	else
	{
		IsEnd=NO;
	}	
}

#pragma mark Table view methods

/// return height base on Text
-(CGFloat)findHeightForCell:(NSString *)text
{
	CGFloat		result = 40.0f;
	CGFloat		width = 0;
	
	width = 132;
	// fudge factor
	if (text)
	{
		CGSize		textSize = { width, 20000.0f };		// width and height of text area
		CGSize		size = [text sizeWithFont:[UIFont boldSystemFontOfSize:14.0f] constrainedToSize:textSize lineBreakMode:UILineBreakModeCharacterWrap];
		
		size.height += 25.0f;			// top and bottom margin
		result = MAX(size.height, 40.0f);	// at least one row		
	}
	else		
	{
		return 40;
	}
	return result;	
}

// Variable height support
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	if(indexPath.section==0)
	{
		return 40;
	}
	else if(indexPath.section==1)
	{
		if([[VitalsArray objectAtIndex:(indexPath.row)] intValue]==10)
		{
			return ([self findHeightForCell:appDelegate.Vitals_Detailref.Other]);
		}
		if([[VitalsArray objectAtIndex:(indexPath.row)] intValue]==9)
		{
			return ([self findHeightForCell:appDelegate.Vitals_Detailref.Pain]);
		}		
		return 40;
	}
	else
	{
		if([[RoutinesArray objectAtIndex:(indexPath.row)] intValue]==2)
		{
			return ([self findHeightForCell:appDelegate.Routine_Detailrf.Exercise]);
		}
		else if([[RoutinesArray objectAtIndex:(indexPath.row)] intValue]==3)
		{
			return [self findHeightForCell:appDelegate.Routine_Detailrf.Mood];
		}
		else if([[RoutinesArray objectAtIndex:(indexPath.row)] intValue]==4)
		{
			return ([self findHeightForCell:appDelegate.Routine_Detailrf.Activity]);
		}
		else if([[RoutinesArray objectAtIndex:(indexPath.row)] intValue]==6)
		{
			return [self findHeightForCell:appDelegate.Routine_Detailrf.Feeding];
		}
		else if([[RoutinesArray objectAtIndex:(indexPath.row)] intValue]==8)
		{
			return [self findHeightForCell:appDelegate.Routine_Detailrf.Alcohol];
		}
		else if([[RoutinesArray objectAtIndex:(indexPath.row)] intValue]==10)
		{
			return [self findHeightForCell:appDelegate.Routine_Detailrf.Drugs];
		}
		else if([[RoutinesArray objectAtIndex:(indexPath.row)] intValue]==11 )
		{
			
			if(IsStartFirstTime)
			{
				if(IsStart)
				{
					if(IsStartEnabled)
					{
						return 60;
					}
					else
						return 44;
				}
				else
				{
					return 60;
				}
			}
			else
			{
				return 60;
			}
			
		}
		else if([[RoutinesArray objectAtIndex:(indexPath.row)] intValue]==1)
		{
			return 65;
		}
		else if([[RoutinesArray objectAtIndex:(indexPath.row)] intValue]==12)
		{
			return [self findHeightForCell:appDelegate.Routine_Detailrf.Other];
		}
		return 40;
	}
	return 40;
}
// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	return 3;
}

 // fixed font style. use custom view (UILabel) if you want something different
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if(SelectedIndex==3)
	{
		if(section==0)
		{
			return @"";
		}
		else if(section==1)
		{
			if([VitalsArray count]>0)
				return @"Vitals Details";
			else 
				return @"";
		}
		else if(section==2)
		{
			if([RoutinesArray count]>0)
				return @"Routines Details";
			else 
				return @"";		
		}
	}
	else
		return @"";	
	return @"";
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if(section==0)
	{
		return 1;
	}
	if(section==1)
	{
		return [VitalsArray count];
	}
	if(section==2)
	{
		return [RoutinesArray  count];
	}
	return 0;
}

///// Called when User click on DateTIme Combo..
-(IBAction)ClickButton:(id)sender
{
	if(SelectedIndex==3 || SelectedIndex==0 )
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		DatePicker.hidden=FALSE;
		[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
		if([appDelegate.Vitals_Detailref.EntryDate length]==0)
		{
			[DatePicker setDate:[NSDate date] animated:YES];
		}
		else
		{
			[DatePicker setDate:[appDelegate.DateFormatter dateFromString: [NSString stringWithFormat:@"%@ %@",appDelegate.Vitals_Detailref.EntryDate,appDelegate.Vitals_Detailref.EntryTime]]];
		}
		ToolBar.hidden=FALSE;
		TimeDatePicker.hidden=TRUE;
		lblData.text=@"Select Date and Time";
		PickerView.hidden=TRUE;
		SelectedTag=0; 	
		[Pool release];
	}
	else
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		DatePicker.hidden=FALSE;
		[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
		if([appDelegate.Routine_Detailrf.EntryDate length]==0)
		{
			[DatePicker setDate:[NSDate date] animated:YES];
		}
		else
		{
			[DatePicker setDate:[appDelegate.DateFormatter dateFromString: [NSString stringWithFormat:@"%@ %@",appDelegate.Routine_Detailrf.EntryDate,appDelegate.Routine_Detailrf.EntryTime]]];
		}	
		ToolBar.hidden=FALSE;
		lblData.text=@"Select Date and Time";
		PickerView.hidden=TRUE;
		TimeDatePicker.hidden=TRUE;
		SelectedTag=0; 
		[Pool release];
	}
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if(indexPath.section==0)
	{
		///// DateTime Cell
		static NSString *CellIdentifier = @"Cell";		
		AddUserButtonTableViewCell  *cell = (AddUserButtonTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[AddUserButtonTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
			[cell.BtnSelect addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
		}
		cell.lblName.frame =  CGRectMake(2, 5, 140, 30);
		cell.BtnSelect.frame =  CGRectMake(150, 5, 140, 30 );
		cell.lblName.text=@"Date & Time";		
		if(SelectedIndex==1)
		{
			[cell.BtnSelect setTitle:[NSString stringWithFormat:@"  %@ %@",appDelegate.Routine_Detailrf.EntryDate,appDelegate.Routine_Detailrf.EntryTime] forState:UIControlStateNormal];
		}
		else
			[cell.BtnSelect setTitle:[NSString stringWithFormat:@"  %@ %@",appDelegate.Vitals_Detailref.EntryDate,appDelegate.Vitals_Detailref.EntryTime] forState:UIControlStateNormal];
		return cell;
	}
	else if(indexPath.section==1)
	{
		//// Vitals Data
		static NSString *CellIdentifier1 = @"Cell1";
		
		DailyStatusTableViewCell *cell1 = (DailyStatusTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
		if (cell1 == nil) {
			cell1 = [[[DailyStatusTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier1] autorelease];
			//		cell1.hidesAccessoryWhenEditing = NO;
		}		
		[appDelegate VitalName:[[VitalsArray objectAtIndex:(indexPath.row)] intValue]];
		NSDictionary *Dict=[appDelegate.EntryArray objectAtIndex:0];				
		cell1.lblName.text=[Dict valueForKey:@"Name"];
		cell1.btnCall.hidden=TRUE;
		cell1.lblNameTwo.tag=[[Dict valueForKey:@"Vital_ID"]intValue]; 
		if([[Dict valueForKey:@"Vital_ID"]intValue]==1)
		{
			cell1.lblNameTwo.text=appDelegate.Vitals_Detailref.BP; 
		}
		else if([[Dict valueForKey:@"Vital_ID"]intValue]==2)
		{
			cell1.lblNameTwo.text=appDelegate.Vitals_Detailref.BloodSugar; 
		}
		else if([[Dict valueForKey:@"Vital_ID"]intValue]==3)
		{
			if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Temperature"] isEqualToString:@"F"])
			{
				cell1.lblNameTwo.text=appDelegate.Vitals_Detailref.TempF;
			}
			else
			{
				cell1.lblNameTwo.text=appDelegate.Vitals_Detailref.TempC;
			}
		}
		else if([[Dict valueForKey:@"Vital_ID"]intValue]==4)
		{			
			cell1.lblNameTwo.text=appDelegate.Vitals_Detailref.Fasting; 
		}
		else if([[Dict valueForKey:@"Vital_ID"]intValue]==5)
		{
			cell1.lblNameTwo.text=appDelegate.Vitals_Detailref.Pulse; 
		}
		else if([[Dict valueForKey:@"Vital_ID"]intValue]==6)
		{
			cell1.lblNameTwo.text=appDelegate.Vitals_Detailref.Respiration; 
		}
		else if([[Dict valueForKey:@"Vital_ID"]intValue]==10)
		{
			cell1.lblNameTwo.text=appDelegate.Vitals_Detailref.Other; 
		}
		else if([[Dict valueForKey:@"Vital_ID"]intValue]==9)
		{
			if(appDelegate.Vitals_Detailref.Magnitude==0)
			{
				cell1.lblNameTwo.text=@"";
			}
			else
				cell1.lblNameTwo.text=[NSString stringWithFormat:@"%@ (%d)",appDelegate.Vitals_Detailref.Pain,appDelegate.Vitals_Detailref.Magnitude]; 
		}
		else if([[Dict valueForKey:@"Vital_ID"]intValue]==7)
		{
			if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Weight"] isEqualToString:@"LBs"])
			{
				cell1.lblNameTwo.text=appDelegate.Vitals_Detailref.WeightLbs;
			}
			else
			{
				cell1.lblNameTwo.text=appDelegate.Vitals_Detailref.WeightKgs;
			}
		}
		else if([[Dict valueForKey:@"Vital_ID"]intValue]==8)
		{
			if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Height"] isEqualToString:@"Inches"])
			{
				cell1.lblNameTwo.text=appDelegate.Vitals_Detailref.HeightInch;
			}
			else
			{
				cell1.lblNameTwo.text=appDelegate.Vitals_Detailref.HeightCms;
			}
		}
		cell1.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
		return cell1;
	}
	else 
	{		
		///// Routine Data
		DailyStatusTableViewCell *cell2;
		CycleTableViewCell *cell3;
		SleepTableViewCell *cell4;
		[appDelegate RoutineName:[[RoutinesArray objectAtIndex:(indexPath.row)] intValue]];
		NSDictionary *Dict=[appDelegate.EntryArray objectAtIndex:0];	
		if([[Dict valueForKey:@"Vital_ID"]intValue]==1)
		{
			//// For Wakeup Time and Time
			static NSString *CellIdentifier4 = @"Cell4";
			cell4 = (SleepTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
			if (cell4 == nil) {
				cell4 = [[[SleepTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier4] autorelease];
				cell4.lblName.text=@"Sleep Time";				
			}
			cell4.txtEnd.delegate=self;
			cell4.txtStart.delegate=self;
			cell4.txtEnd.tag=2;
			cell4.txtStart.tag=1;
			cell4.txtEnd.placeholder=@"Wake up time";
			cell4.txtStart.placeholder=@"sleep time";
			cell4.txtStart.text=appDelegate.Routine_Detailrf.Sleep;
			cell4.txtEnd.text=appDelegate.Routine_Detailrf.WakeUpSleep;			
			return cell4;
		}
		else if([[Dict valueForKey:@"Vital_ID"]intValue]==11)
		{
			//// For Menstruation Cycle
			static NSString *CellIdentifier3 = @"Cell3";
			cell3 = (CycleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
			if (cell3 == nil) {
				cell3 = [[[CycleTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier3] autorelease];
				[cell3.btnStart addTarget:self action:@selector(btnStart_Clicked:) forControlEvents:UIControlEventTouchUpInside];
				[cell3.btnEnd addTarget:self action:@selector(btnEnd_Clicked:) forControlEvents:UIControlEventTouchUpInside];
				cell3.lblName.text=@"Menstruation";
				cell3.lblEnd.text=@"End";
				cell3.lblStart.text=@"Start";					
			}
			cell3.btnStart.enabled=TRUE;
			if(IsStartFirstTime)
			{
				if(IsStart)
				{
					if(IsStartEnabled)
					{
						cell3.btnStart.frame=CGRectMake(142, 7, 70, 22);
						cell3.btnEnd.frame=CGRectMake(141, 35, 70, 22);
						cell3.lblStart.hidden=FALSE;
						cell3.btnStart.hidden=FALSE;
						cell3.btnStart.selected=NO;
						cell3.btnEnd.selected=IsEnd;
						[cell3.btnStart setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateDisabled];
						cell3.btnStart.enabled=FALSE;
				}
					else
					{
						cell3.btnEnd.frame=CGRectMake(141, 10, 70, 22);
						cell3.btnStart.hidden=TRUE;
						cell3.lblStart.hidden=TRUE;
						
						if(self.isEndDisabled)
						{			
							
							cell3.btnEnd.selected=IsEnd;
							cell3.btnEnd.enabled=TRUE;
						}
						else
						{
							cell3.btnEnd.selected=NO;
							[cell3.btnEnd setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateDisabled];
							cell3.btnEnd.enabled=FALSE;
						}
					}
				}
				else
				{
					cell3.btnStart.frame=CGRectMake(142, 7, 70, 22);
					cell3.btnEnd.frame=CGRectMake(141, 35, 70, 22);
					cell3.lblStart.hidden=FALSE;
					cell3.btnStart.hidden=FALSE;
					cell3.btnStart.selected=IsStart;
					cell3.btnEnd.selected=IsEnd;
				}
			}
			else
			{
				cell3.btnStart.frame=CGRectMake(142, 7, 70, 22);
				cell3.btnEnd.frame=CGRectMake(141, 35, 70, 22);
				cell3.lblStart.hidden=FALSE;
				cell3.btnStart.hidden=FALSE;
				cell3.btnStart.selected=IsStart;
				cell3.btnEnd.selected=IsEnd;
			}
			return cell3;			
		}
		else
		{
			static NSString *CellIdentifier2 = @"Cell2";
			cell2 = (DailyStatusTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
			if (cell2 == nil) {
				cell2 = [[[DailyStatusTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier2] autorelease];
			}
			cell2.lblName.text=[Dict valueForKey:@"Name"];
			cell2.lblNameTwo.tag=[[Dict valueForKey:@"Vital_ID"]intValue]; 
			cell2.btnCall.hidden=TRUE;
			if([[Dict valueForKey:@"Vital_ID"]intValue]==2)
			{
				cell2.lblNameTwo.text=appDelegate.Routine_Detailrf.Exercise; 
			}
			else if([[Dict valueForKey:@"Vital_ID"]intValue]==3)
			{
				cell2.lblNameTwo.text=appDelegate.Routine_Detailrf.Mood;
			}
			else if([[Dict valueForKey:@"Vital_ID"]intValue]==4)
			{			
				cell2.lblNameTwo.text=appDelegate.Routine_Detailrf.Activity; 
			}
			else if([[Dict valueForKey:@"Vital_ID"]intValue]==5)
			{
				cell2.lblNameTwo.text=appDelegate.Routine_Detailrf.Diapering; 
			}
			else if([[Dict valueForKey:@"Vital_ID"]intValue]==6)
			{
				cell2.lblNameTwo.text=appDelegate.Routine_Detailrf.Feeding;
			}
			else if([[Dict valueForKey:@"Vital_ID"]intValue]==8)
			{			
				cell2.lblNameTwo.text=appDelegate.Routine_Detailrf.Alcohol; 
			}
			else if([[Dict valueForKey:@"Vital_ID"]intValue]==9)
			{
				cell2.lblNameTwo.text=appDelegate.Routine_Detailrf.Cigarrettes; 
			}
			else if([[Dict valueForKey:@"Vital_ID"]intValue]==10)
			{
				cell2.lblNameTwo.text=appDelegate.Routine_Detailrf.Drugs;
			}
			else if([[Dict valueForKey:@"Vital_ID"]intValue]==12)
			{			
				cell2.lblNameTwo.text=appDelegate.Routine_Detailrf.Other; 
			}
			else if([[Dict valueForKey:@"Vital_ID"]intValue]==7)
			{			
				if(appDelegate.Routine_Detailrf.calories!=-1)
					cell2.lblNameTwo.text=[NSString stringWithFormat:@"%d",appDelegate.Routine_Detailrf.calories]; 
				else
					cell2.lblNameTwo.text=@""; 
			}
			else if([[Dict valueForKey:@"Vital_ID"]intValue]==10)
			{
				cell2.lblNameTwo.text=appDelegate.Mensturalref.StartDate; 
			}
			cell2.accessoryType=UITableViewCellAccessoryDisclosureIndicator;		
			return cell2;	
		}
	}
	return @"";
}

//// Called when user will click on Start Date

-(IBAction)btnStart_Clicked:(id)sender
{
	appDelegate.SaveMenstural=TRUE;
	if([appDelegate.Mensturalref.EndDate length]==0)
	{
		if(IsStart==FALSE )
		{
			IsStart=YES;
			appDelegate.Mensturalref.StartDate=@"Start";
		}
		else
		{
			IsStart=NO;
			appDelegate.Mensturalref.StartDate=@"";
		}
		[tblView reloadData];
	}
}

//// Called when user will click on End Date

-(IBAction)btnEnd_Clicked:(id)sender
{
	appDelegate.SaveMenstural=TRUE;
	if(IsEnd==FALSE && IsStart==YES)
	{
		[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy"];
		NSDate *StartDate=[appDelegate.DateFormatter dateFromString:appDelegate.Mensturalref.Daily_StartDate];   
		NSDate *EndDate=[appDelegate.DateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@",appDelegate.Routine_Detailrf.EntryDate,appDelegate.Routine_Detailrf.EntryTime]];
		int Difference=[EndDate timeIntervalSinceDate:StartDate];
		Difference=Difference/(24*3600);
		if(Difference<=0)
		{
			UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Start and end date cannot be the same." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
		else
		{
			IsEnd=YES;
			appDelegate.Mensturalref.EndDate=@"End";
		}
	}
	else
	{
		IsEnd=NO;
		appDelegate.Mensturalref.EndDate=@"";
	}
	[tblView reloadData];
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tblView deselectRowAtIndexPath:indexPath animated:YES];
	if(ToolBar.hidden==TRUE)
	{
		if(indexPath.section==0)
		{
			DatePicker.hidden=FALSE;
			btnSave.enabled=FALSE;
			TimeDatePicker.hidden=TRUE;
			NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
			[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
			if([appDelegate.Vitals_Detailref.EntryDate length]==0)
			{
				[DatePicker setDate:[NSDate date] animated:YES];
			}
			else
			{
				[DatePicker setDate:[appDelegate.DateFormatter dateFromString: [NSString stringWithFormat:@"%@ %@",appDelegate.Vitals_Detailref.EntryDate,appDelegate.Vitals_Detailref.EntryTime]]];
			}
			ToolBar.hidden=FALSE;
			lblData.text=@"Select Date and Time";
			PickerView.hidden=TRUE;
			SelectedTag=0; 
			[Pool release];
		}
		else if(indexPath.section==1)
		{		
			DailyStatusTableViewCell *cell=(DailyStatusTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
			[self VitalsData:cell];
		}
		else if(indexPath.section==2)
		{
			[appDelegate RoutineName:[[RoutinesArray objectAtIndex:(indexPath.row)] intValue]];
			NSDictionary *Dict=[appDelegate.EntryArray objectAtIndex:0];	
			if([[Dict valueForKey:@"Vital_ID"]intValue]!=11)
			{
				if([[Dict valueForKey:@"Vital_ID"]intValue]!=1)
				{
					NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
					DailyStatusTableViewCell *cell=(DailyStatusTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
					[self RoutineData:cell];					
					[Pool release];
				}
			}
		}
	}
}


//// Call when We go for some changes on routine Data
-(void)RoutineData:(DailyStatusTableViewCell *)cell
{
	SelectedTag=cell.lblNameTwo.tag; 
	if(cell.lblNameTwo.tag==4 || cell.lblNameTwo.tag==5 || cell.lblNameTwo.tag==2 || cell.lblNameTwo.tag==3 || cell.lblNameTwo.tag==6)
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		if(!appDelegate.objSelectOptionsViewController)
		{
			appDelegate.objSelectOptionsViewController=[[SelectOptionsViewController alloc]initWithNibName:@"SelectOptions" bundle:nil];
		}
		appDelegate.isfromFavourite=TRUE;
		appDelegate.DailyTag=cell.lblNameTwo.tag; 
		appDelegate.objSelectOptionsViewController.NavText=cell.lblName.text;
		appDelegate.SelectedStatus=@"Hourly";
		if(cell.lblNameTwo.tag==6)
		{
			appDelegate.IsFromMedicine=TRUE;
		}
		else
		{
			appDelegate.IsFromMedicine=FALSE;
		}
		[self.navigationController pushViewController:appDelegate.objSelectOptionsViewController animated:YES];
		[Pool release];		
	}
	else if(cell.lblNameTwo.tag==9)//|| cell.lblNameTwo.tag==9 || cell.lblNameTwo.tag==13 || SelectedTag==17
	{
		SelectedTag=8;
		DatePicker.hidden=TRUE;
		ToolBar.hidden=FALSE;
		TimeDatePicker.hidden=TRUE;
		PickerView.hidden=FALSE;
		btnSave.enabled=FALSE;
		int row;
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		[PickerView reloadAllComponents];
		row=[self GetPickerRow:appDelegate.Routine_Detailrf.Cigarrettes component:SelectedTag];
		lblData.text=@"Select Cigarrettes";
		[PickerView selectRow:row inComponent:0 animated:NO];
		[Pool release];	
	}
	else
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		appDelegate.SelectedStatus=@"Hourly";
		if(!appDelegate.objUserTextEntryViewController)
		{
			appDelegate.objUserTextEntryViewController=[[UserTextEntryViewController alloc]initWithNibName:@"TextEntry" bundle:nil];
		}					
		appDelegate.objUserTextEntryViewController.selectedIndex=cell.lblNameTwo.tag;
		appDelegate.objUserTextEntryViewController.selectedName=cell.lblName.text;
		appDelegate.objUserTextEntryViewController.TextData=cell.lblNameTwo.text;
		[self.navigationController pushViewController:appDelegate.objUserTextEntryViewController animated:YES];
		[Pool release];
	}
}

//// Call when We go for some changes on vitals Data
-(void)VitalsData:(DailyStatusTableViewCell *)cell
{
	if(cell.lblNameTwo.tag==1 || cell.lblNameTwo.tag==3 || cell.lblNameTwo.tag==5 || cell.lblNameTwo.tag==7 || cell.lblNameTwo.tag==6 || cell.lblNameTwo.tag==2 || cell.lblNameTwo.tag==4 || cell.lblNameTwo.tag==8)
	{
		SelectedTag= cell.lblNameTwo.tag;
		PickerView.hidden=FALSE;
		ToolBar.hidden=FALSE;
		btnSave.enabled=FALSE;
		int row;
		if(SelectedTag==1)
		{
			NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
			lblData.text=@"Select BP Systolic/Diastolic";
			[PickerView reloadAllComponents];
			if([appDelegate.Vitals_Detailref.BP  length]==0)
			{
				[PickerView selectRow:70 inComponent:0 animated:NO];
				[PickerView selectRow:30 inComponent:1 animated:NO];
			}
			else
			{
				NSArray *arr=[appDelegate.Vitals_Detailref.BP componentsSeparatedByString:@"/"]; 
				row=[self GetPickerRow:[arr objectAtIndex:0] component:SelectedTag];
				[PickerView selectRow:row inComponent:0 animated:NO];
				if([arr count]>1)
				{
					row=[self GetPickerRow:[arr objectAtIndex:1] component:SelectedTag];
					[PickerView selectRow:row inComponent:1 animated:NO];
				}
				else
					[PickerView selectRow:30 inComponent:1 animated:NO];
			}
			[Pool release];
		}			
		else if(SelectedTag==3)
		{
			NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
			if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Temperature"] isEqualToString:@"F"])
			{
				lblData.text=@"Select Temperature in F º";
				SelectedTag=4;
				[PickerView reloadAllComponents];
				if([appDelegate.Vitals_Detailref.TempF length]==0)
				{
					[PickerView selectRow:8 inComponent:0 animated:NO];
					[PickerView selectRow:0 inComponent:1 animated:NO];
				}
				else
				{
					NSArray *arr=[appDelegate.Vitals_Detailref.TempF componentsSeparatedByString:@"."]; 
					int row=[self GetPickerRow:[arr objectAtIndex:0] component:SelectedTag];
					[PickerView selectRow:row inComponent:0 animated:NO];						
					if([arr count]>1)
					{
						row=[[arr objectAtIndex:1]intValue];
						[PickerView selectRow:row inComponent:1 animated:NO];
					}
					else
						[PickerView selectRow:0 inComponent:1 animated:NO];					
				}
			}
			else
			{
				lblData.text=@"Select Temperature in C º";
				[PickerView reloadAllComponents];
				if([appDelegate.Vitals_Detailref.TempC length]==0)
				{
					[PickerView selectRow:4 inComponent:0 animated:NO];
					[PickerView selectRow:0 inComponent:1 animated:NO];
				}
				else
				{
					NSArray *arr=[appDelegate.Vitals_Detailref.TempC componentsSeparatedByString:@"."]; 
					int row=[self GetPickerRow:[arr objectAtIndex:0] component:SelectedTag];
					[PickerView selectRow:row inComponent:0 animated:NO];	
					if([arr count]>1)
					{
						row=[[arr objectAtIndex:1]intValue];
						[PickerView selectRow:row inComponent:1 animated:NO];
					}
					else
						[PickerView selectRow:0 inComponent:1 animated:NO];
				}
			}
			[Pool release];
		}
		else if(SelectedTag==5)
		{
			NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
			lblData.text=@"Select Pulse";
			[PickerView reloadAllComponents];
			if([appDelegate.Vitals_Detailref.Pulse length]==0)
			{
				[PickerView selectRow:40 inComponent:0 animated:NO];
			}
			else
			{
				row=[self GetPickerRow:appDelegate.Vitals_Detailref.Pulse component:SelectedTag];
				[PickerView selectRow:row inComponent:0 animated:NO];
			}
			[Pool release];
		}
		else if(SelectedTag==2)
		{
			NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
			lblData.text=@"Select Blood Sugar";
			[PickerView reloadAllComponents];
			if([appDelegate.Vitals_Detailref.BloodSugar length]==0)
			{
				row=99;
			}
			else
				row=[self GetPickerRow:appDelegate.Vitals_Detailref.BloodSugar component:SelectedTag];
			[PickerView selectRow:row inComponent:0 animated:NO];
			[Pool release];
		}
		else if(SelectedTag==4)
		{
			NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
			SelectedTag=17;
			lblData.text=@"Select Fasting Blood Sugar";
			[PickerView reloadAllComponents];
			if([appDelegate.Vitals_Detailref.Fasting length]==0)
			{
				row=99;
			}
			else					
				row=[self GetPickerRow:appDelegate.Vitals_Detailref.Fasting component:SelectedTag];
			[PickerView selectRow:row inComponent:0 animated:NO];
			[Pool release];
		} 
		else if(SelectedTag==6)
		{
			NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
			lblData.text=@"Select Respiration";
			[PickerView reloadAllComponents];
			if([appDelegate.Vitals_Detailref.Respiration length]==0)
			{
				[PickerView selectRow:15 inComponent:0 animated:NO];
			}
			else
			{
				row=[self GetPickerRow:appDelegate.Vitals_Detailref.Respiration component:SelectedTag];
				[PickerView selectRow:row inComponent:0 animated:NO];
			}
			[Pool release];
		}
		else if(SelectedTag==7)
		{
			NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
			if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Weight"] isEqualToString:@"LBs"])
			{
				lblData.text=@"Select Weight (Lbs)";
				SelectedTag=10;
				[PickerView reloadAllComponents];
				if([appDelegate.Vitals_Detailref.WeightLbs length]==0)
				{
					if([[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%d_WeightLbs",appDelegate.SelectedUserID]] length]>0)
					{
						NSString *Str1=[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%d_WeightLbs",appDelegate.SelectedUserID]];
						NSArray *arr=[Str1 componentsSeparatedByString:@"."]; 
						int row=[self GetPickerRow:[arr objectAtIndex:0] component:SelectedTag];
						[PickerView selectRow:row inComponent:0 animated:NO];
						if([arr count]>1)
						{
							NSString *STR2=[NSString stringWithFormat:@"0.%@",[arr objectAtIndex:1]];
							row=([STR2 doubleValue]/0.0625);
							[PickerView selectRow:row inComponent:1 animated:NO];
						}
						else
							[PickerView selectRow:0 inComponent:0 animated:NO];
					}
					else
					{
						[PickerView selectRow:0 inComponent:0 animated:NO];
						[PickerView selectRow:0 inComponent:1 animated:NO];
					}
				}
				else
				{
					NSArray *arr=[appDelegate.Vitals_Detailref.WeightLbs componentsSeparatedByString:@"."]; 
					int row=[self GetPickerRow:[arr objectAtIndex:0] component:SelectedTag];
					[PickerView selectRow:row inComponent:0 animated:NO];
					if([arr count]>1)
					{
						NSString *STR2=[NSString stringWithFormat:@"0.%@",[arr objectAtIndex:1]];
						row=([STR2 doubleValue]/0.0625);
						[PickerView selectRow:row inComponent:1 animated:NO];
					}
					else
						[PickerView selectRow:0 inComponent:0 animated:NO];
				}
				[Pool release];
			}
			else
			{
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				lblData.text=@"Select Weight (Kgs)";
				SelectedTag=12;
				[PickerView reloadAllComponents];
				if([appDelegate.Vitals_Detailref.WeightKgs length]==0)
				{
					if([[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%d_WeightKgs",appDelegate.SelectedUserID]] length]>0)
					{
						NSString *Str1=[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%d_WeightKgs",appDelegate.SelectedUserID]];
						NSArray *arr=[Str1 componentsSeparatedByString:@"."]; 
						int row=[self GetPickerRow:[arr objectAtIndex:0] component:SelectedTag];
						[PickerView selectRow:row inComponent:0 animated:NO];
						if([arr count]>1)
						{
							row=[[arr objectAtIndex:1]intValue];
							row=row/100;
							[PickerView selectRow:row inComponent:1 animated:NO];
						}
						else
							[PickerView selectRow:0 inComponent:1 animated:NO];
					}
					else
					{
						[PickerView selectRow:0 inComponent:0 animated:NO];
						[PickerView selectRow:0 inComponent:1 animated:NO];
					}
				}
				else
				{
					NSArray *arr=[appDelegate.Vitals_Detailref.WeightKgs componentsSeparatedByString:@"."]; 
					int row=[self GetPickerRow:[arr objectAtIndex:0] component:SelectedTag];
					[PickerView selectRow:row inComponent:0 animated:NO];
					if([arr count]>1)
					{
						row=[[arr objectAtIndex:1]intValue];
						row=row/100;
						[PickerView selectRow:row inComponent:1 animated:NO];
					}
					else
						[PickerView selectRow:0 inComponent:1 animated:NO];
					
				}
				[Pool release];
			}
		}
		else if(SelectedTag==8)
		{
			NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
			if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Height"] isEqualToString:@"Inches"])
			{
				lblData.text=@"Select Height in Feet/Inch";
				SelectedTag=18;
				[PickerView reloadAllComponents];
				if([appDelegate.Vitals_Detailref.HeightInch length]==0)
				{					
					if([[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%d_HeightFeet",appDelegate.SelectedUserID]] length]>0)
					{
						NSString *Str1=[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%d_HeightFeet",appDelegate.SelectedUserID]];
						NSArray *arr=[Str1 componentsSeparatedByString:@"' "]; 
						int row=[self GetPickerRow:[arr objectAtIndex:0] component:SelectedTag];
						[PickerView selectRow:row inComponent:0 animated:NO];
						NSString *Str=[arr objectAtIndex:1];
						Str=[Str stringByReplacingOccurrencesOfString:@"\"" withString:@""];
						//row=[self GetPickerRow:Str component:SelectedTag+1];
						row=[Str intValue];
						[PickerView selectRow:row inComponent:1 animated:NO];
					}
					else
					{
						[PickerView selectRow:0 inComponent:0 animated:NO];
						[PickerView selectRow:0 inComponent:1 animated:NO];
					}
				}
				else
				{
					NSArray *arr=[appDelegate.Vitals_Detailref.HeightInch componentsSeparatedByString:@"' "]; 
					int row=[self GetPickerRow:[arr objectAtIndex:0] component:SelectedTag];
					[PickerView selectRow:row inComponent:0 animated:NO];
					NSString *Str=[arr objectAtIndex:1];
					Str=[Str stringByReplacingOccurrencesOfString:@"\"" withString:@""];
					row=[self GetPickerRow:Str component:SelectedTag+1];
					[PickerView selectRow:row inComponent:1 animated:NO];
				}
			}
			else
			{
				lblData.text=@"Select Height in Meter";
				SelectedTag=20;
				[PickerView reloadAllComponents];
				if([appDelegate.Vitals_Detailref.HeightCms length]==0)
				{
					if([[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%d_HeightCms",appDelegate.SelectedUserID]] length]>0)
					{
						NSString *Str1=[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%d_HeightCms",appDelegate.SelectedUserID]];
						NSArray *arr=[Str1 componentsSeparatedByString:@"."]; 
						int row=[[arr objectAtIndex:0]intValue];
						[PickerView selectRow:row inComponent:0 animated:NO];
						if([arr count]>1)						
						{
							row=[[arr objectAtIndex:1]intValue];
							[PickerView selectRow:row inComponent:1 animated:NO];
						}
						else
							[PickerView selectRow:0 inComponent:1 animated:NO];
					}
					else
					{
						[PickerView selectRow:0 inComponent:0 animated:NO];
						[PickerView selectRow:0 inComponent:1 animated:NO];
					}
				}
				else
				{
					NSArray *arr=[appDelegate.Vitals_Detailref.HeightCms componentsSeparatedByString:@"."]; 
					int row=[self GetPickerRow:[arr objectAtIndex:0] component:SelectedTag];
					[PickerView selectRow:row inComponent:0 animated:NO];
					if([arr count]>1)						
					{
						row=[self GetPickerRow:[arr objectAtIndex:1] component:SelectedTag+1];
						[PickerView selectRow:row inComponent:1 animated:NO];
					}
					else
						[PickerView selectRow:0 inComponent:1 animated:NO];
				}
			}
			[Pool release];
		}			
		DatePicker.hidden=TRUE;
	}
	else if(cell.lblNameTwo.tag==9)
	{		
		if(!ObjPainViewController)
		{
			ObjPainViewController=[[PainViewController alloc]initWithNibName:@"PainViewController" bundle:nil];			
		}
		[self.navigationController pushViewController:ObjPainViewController animated:YES];
	}
	else
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		appDelegate.SelectedStatus=@"Daily";
		if(!appDelegate.objUserTextEntryViewController)
		{
			appDelegate.objUserTextEntryViewController=[[UserTextEntryViewController alloc]initWithNibName:@"TextEntry" bundle:nil];
		}	
		appDelegate.objUserTextEntryViewController.selectedIndex=cell.lblNameTwo.tag;
		appDelegate.objUserTextEntryViewController.selectedName=cell.lblName.text;
		appDelegate.objUserTextEntryViewController.TextData=cell.lblNameTwo.text;
		[self.navigationController pushViewController:appDelegate.objUserTextEntryViewController animated:YES];
		[Pool release];
	}	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

#pragma mark Alert View Delegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex==0)
	{
		int result;
		if(SelectedIndex==0)
			result=[appDelegate DeleteEntry:@"Vitals_Detail" ColumnName:@"Vitals_ID" PrimaryID:appDelegate.Vitals_Detailref.Vitals_ID]; 
		else
		{
			[appDelegate DeleteAllCategoriesData:@"exercise_Duration"  IDname:@"Routine_ID" DeleteID:appDelegate.Routine_Detailrf.Routine_ID];	
			[appDelegate DeleteAllCategoriesData:@"Feed_Detail"  IDname:@"Routine_ID" DeleteID:appDelegate.Routine_Detailrf.Routine_ID];
			result=[appDelegate DeleteEntry:@"Routine_Detail" ColumnName:@"Routine_ID" PrimaryID:appDelegate.Routine_Detailrf.Routine_ID]; 
		}		
		if(result==1)
		{
			appDelegate.isDailyReport=TRUE;
			[self.navigationController popViewControllerAnimated:YES];
		}
	}	
}

#pragma mark Favorites SettingsViewController
//// Called when click on setting Button
-(IBAction)btnSettings_clicked:(id)sender
{
	if(SelectedIndex==0)
	{
		[self btnVitals_CLicked:nil];
	}
	else
	{
		[self btnRoutines_CLicked:nil];
	}
}

/// Called when click on vitals settings
-(IBAction)btnVitals_CLicked:(id)sender
{
	appDelegate.SelectedStatus=@"Daily";
	appDelegate.objSettingsViewController=[[SettingsViewController alloc]initWithNibName:@"Settings" bundle:nil];		
	if (SettingsCon == nil)
	{
		SettingsCon = [[UINavigationController alloc] initWithRootViewController:appDelegate.objSettingsViewController];
	}
	User_Settings *Data=[appDelegate.UserSettingsArray objectAtIndex:0];
	appDelegate.SelectedItems = Data.DailyEntryDetail; 
	[self.navigationController presentModalViewController:SettingsCon animated:YES];
	[appDelegate.objSettingsViewController release];
}

/// Called when click on routine settings
-(IBAction)btnRoutines_CLicked:(id)sender
{
	appDelegate.SelectedStatus=@"Hourly";
	appDelegate.objSettingsViewController=[[SettingsViewController alloc]initWithNibName:@"Settings" bundle:nil];		
	if (SettingsCon2 == nil)
	{
		SettingsCon2 = [[UINavigationController alloc] initWithRootViewController:appDelegate.objSettingsViewController];
	}
	User_Settings *Data=[appDelegate.UserSettingsArray objectAtIndex:0];
	appDelegate.SelectedItems = Data.HourlyEntryDetail; 
	[self.navigationController presentModalViewController:SettingsCon2 animated:YES];
	[appDelegate.objSettingsViewController release];
}

#pragma mark pickerView

// returns width of column and height of row for each component. 
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	CGFloat componentWidth;
	if(SelectedTag==1 || SelectedTag==10 || SelectedTag==12  || SelectedTag==3 || SelectedTag==4 || SelectedTag==18 || SelectedTag==20 )
	{
		if (component == 0)
			componentWidth = 140.0;	// first column size is wider to hold names
		else
			componentWidth = 140.0;	
	}
	else
	{
		componentWidth=240.0;
	}// second column is narrower to show numbers
	return componentWidth;
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pV
{
	if(SelectedTag==1 || SelectedTag==10 || SelectedTag==12  || SelectedTag==3 || SelectedTag==4 || SelectedTag==18 || SelectedTag==20)
	{
		return 2;
	}
	else
	{
		return 1;
	}
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pV numberOfRowsInComponent:(NSInteger)component
{	
	if(SelectedTag==1)
	{
		if(component==1)
		{
			return [[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] count];
		}
		else
		{
			return [[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] count];
		}
	}
	if(SelectedTag==10 || SelectedTag==12 || SelectedTag==20)
	{
		if(component==1)
		{
			return [[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag+1]] count];
		}
		else
		{
			return [[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] count];
		}
	}
	if(SelectedTag==3 || SelectedTag==4)
	{
		if(component==1)
		{
			return [[data objectForKey:[NSString stringWithFormat:@"%d",15]] count];
		}
		else
		{
			return [[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]]  count];
		}		
	}
	else if(SelectedTag==18)
	{
		if(component==0)
		{
			return [[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] count];
		}
		else
		{
			return [[data objectForKey:[NSString stringWithFormat:@"%d",19]] count];
		}		
	}
	else
	{
		return [[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]]  count];
	}	
}

// these methods return either a plain UIString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse. 
// If you return back a different object, the old one will be released. the view will be centered in the row rect  

- (NSString *)pickerView:(UIPickerView *)pV titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if(SelectedTag==1 )
	{
		if(component==1) //// For BP
		{
			strRestaurantType=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:row];
			return [NSString stringWithFormat:@"%@ mmHg",strRestaurantType];
		}
		else
		{
			strRestaurantType=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:row];
			return [NSString stringWithFormat:@"%@ mmHg",strRestaurantType];
		}
	}
	else if(SelectedTag==12) ///// For Weight in  KG
	{
		if(component==1)
		{
			strRestaurantType=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag+1]] objectAtIndex:row];
			return [NSString stringWithFormat:@"%@ G",strRestaurantType];
		}
		else
		{
			strRestaurantType=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:row];
			return [NSString stringWithFormat:@"%@ KG",strRestaurantType];
		}
	}
	else if(SelectedTag==10) //// For weigth in LBS
	{
		if(component==1)
		{
			strRestaurantType=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag+1]] objectAtIndex:row];
			return [NSString stringWithFormat:@"%@ ounces",strRestaurantType];
		}
		else
		{
			strRestaurantType=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:row];
			return [NSString stringWithFormat:@"%@ Lbs",strRestaurantType];
		}
	}
	if(SelectedTag==3 || SelectedTag==4) 
	{
		if(component==1)
		{
			strRestaurantType=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",15]] objectAtIndex:row];
			return [NSString stringWithFormat:@".%@",strRestaurantType];
		}
		else
		{
			strRestaurantType=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:row];
			return [NSString stringWithFormat:@"%@",strRestaurantType];
		}
	}
	else if(SelectedTag==18) //// FOr height on Inch
	{
		if(component==1)
		{
			NSString *strRestaurantType1=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",19]] objectAtIndex:row];
			if(row==0 || row==1)
			{
				return  [NSString stringWithFormat:@"%@ Inch" ,strRestaurantType1];
			}
			return [NSString stringWithFormat:@"%@ Inches",strRestaurantType1];
		}
		else
		{
			NSString *strRestaurantType1=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",18]] objectAtIndex:row];
			return  [NSString stringWithFormat:@"%@ Feet" ,strRestaurantType1];
		}
	}	
	else if(SelectedTag==20) ///// For Height in Meter
	{
		if(component==1)
		{
			NSString *strRestaurantType1=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag+1]] objectAtIndex:row];
			return [NSString stringWithFormat:@"%@ cm",strRestaurantType1];
		}
		else
		{
			NSString *strRestaurantType1=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:row];
			return  [NSString stringWithFormat:@"%@ m" ,strRestaurantType1];
		}
	}		
	else
	{
		strRestaurantType=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:row];
		return strRestaurantType;
	}	
}

//// set Picker Selector as per seleted value...
-(int)GetPickerRow:(NSString *)String component:(NSInteger)Tag
{
	NSString *str2;
	str2=String;
	NSMutableArray *abc=[data objectForKey:[NSString stringWithFormat:@"%d",Tag]];
	int Row=0;
	for(Row=0; Row<[abc count];Row++)
	{
		NSString *str1=[abc objectAtIndex:Row];	
		NSLog(str1);
		NSLog(str2);
		NSLog(@"OK");
		
		if([str2 isEqualToString:str1])
		{			
			return Row;
		}
	}
	return 0;
}

#pragma mark TextFieldEvents

  // return NO to disallow editing.
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if(ToolBar.hidden==TRUE)
	{
		if(textField.tag==1)
		{
			TimeDatePicker.hidden=FALSE;
			PickerView.hidden=TRUE;
			btnSave.enabled=FALSE;
			ToolBar.hidden=FALSE;
			NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
			SelectedTag=7;	
			
			[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
			if([appDelegate.Routine_Detailrf.Sleep  length]==0)
			{
				[TimeDatePicker setDate:DatePicker.date animated:YES];
			}
			else
			{
				
				[TimeDatePicker setDate:[appDelegate.DateFormatter dateFromString:appDelegate.Routine_Detailrf.Sleep]  animated:YES];
			}
			lblData.text=@"Enter start time of sleep";
			[Pool release];
		}
		if(textField.tag==2)
		{
			if([appDelegate.Routine_Detailrf.Sleep  length]==0)
			{
			}
			else
			{
				TimeDatePicker.hidden=FALSE;
				PickerView.hidden=TRUE;
				btnSave.enabled=FALSE;
				ToolBar.hidden=FALSE;
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				SelectedTag=9;	
				[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
				if([appDelegate.Routine_Detailrf.WakeUpSleep  length]==0)
				{
					[TimeDatePicker setDate:DatePicker.date animated:YES];
				}
				else
				{
					//[appDelegate.DateFormatter setDateFormat:@"HH:mm"];
					[TimeDatePicker setDate:[appDelegate.DateFormatter dateFromString:appDelegate.Routine_Detailrf.WakeUpSleep]  animated:YES];
				}
				lblData.text=@"Enter time when woke up";
				[Pool release];
			}			
		}
	}
	return NO;
}

 // called when 'return' key pressed. return NO to ignore.
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	return YES;
}

- (void)dealloc
{	
	[tblView release];
	[btnSave release];
	[VitalsArray release];
	[RoutinesArray release];
	[DailySettings release];
	[PickerView release];
	[DatePicker release];
	[ToolBar release];
	[btnDone release];
	[lblData release];
	[data release];	
    [super dealloc];
}

@end
