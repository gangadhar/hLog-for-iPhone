//
//  SelectMedicineSettingsController.m
//  hLog
//  Created by Bhoomi on 3/12/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//


// Import All needed header files bellow.
#import "SelectMedicineSettingsController.h"
#import "SettingTableViewCell.h"


@implementation SelectMedicineSettingsController
// Called after the view has been loaded. For view controllers created in code, this is after -loadView. For view controllers unarchived from a nib, this is after the view is set.
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	self.navigationItem.rightBarButtonItem=btnSave;
	self.navigationItem.leftBarButtonItem=btnCancle;
	selectedImage = [UIImage imageNamed:@"checked.png"];
	unselectedImage = [UIImage imageNamed:@"unchecked.png"];
	appDelegate=[[UIApplication sharedApplication]delegate];
	tblSettings.delegate=self;
	tblSettings.dataSource=self;
	label1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 220, 30)];
	[label1 setFont:[UIFont boldSystemFontOfSize:14.0]];
	[label1 setBackgroundColor:[UIColor clearColor]];
	[label1 setTextAlignment:UITextAlignmentCenter];
 	[label1 setTextColor:[UIColor whiteColor]];
	[label1 setText:@"Medicine Settings"];
	self.navigationItem.titleView=label1;
	
	self.navigationController.navigationBar.barStyle= UIBarStyleBlackOpaque;  
    [super viewDidLoad];
}	

// Called when the view is about to made visible. Default does nothing
- (void)viewWillAppear:(BOOL)animated
{
	[tblSettings scrollRectToVisible:CGRectMake(0, 0, 320, 50)  animated:YES];
	if(!selectedArrayData)
		selectedArrayData=[[NSMutableArray alloc ]init];
	else
		[selectedArrayData removeAllObjects];
	
	///// Here we use tage for different views
	/// 20 - Medicine
	/// 2 - Exercise
	/// 3 - Mood
	/// 4 - Activity
	/// 5 - Dipering
	/// 6 - Food Consuption
	
	if(appDelegate.DailyTag==20) /// For Medicine
	{		
		[appDelegate SelectMedicineNames];  
		[label1 setText:@"Medicine Settings"];
		if([appDelegate.MedicineArray count]==0)
			btnSave.enabled=FALSE;
		else
			btnSave.enabled=TRUE;	
	}
	else
	{
		if(appDelegate.DailyTag==2) /// For Exercise
		{
			[appDelegate SelectExerciseNames];
			[label1 setText:@"Exercise Settings"];
			if([appDelegate.ExerciseArray count]==0)
				btnSave.enabled=FALSE;
			else
				btnSave.enabled=TRUE;	
		}
		else if(appDelegate.DailyTag==3) /// For Mood
		{
			[appDelegate SelectAllData:@"Mood"];
			[label1 setText:@"Mood Settings"];
			if([appDelegate.NewTableArray count]==0)
				btnSave.enabled=FALSE;
			else
				btnSave.enabled=TRUE;	
		}
		else if(appDelegate.DailyTag==4) /// For Activity
		{
			[appDelegate SelectAllData:@"Activity"];
			[label1 setText:@"Activity Settings"];
			if([appDelegate.NewTableArray count]==0)
				btnSave.enabled=FALSE;
			else
				btnSave.enabled=TRUE;	
		} 
		else if(appDelegate.DailyTag==5) /// For Diapering
		{
			[appDelegate SelectAllData:@"Diapering"];
			[label1 setText:@"Diapering Settings"];
			if([appDelegate.NewTableArray count]==0)
				btnSave.enabled=FALSE;
			else
				btnSave.enabled=TRUE;	
		}
		else if(appDelegate.DailyTag==6) /// For Feeding
		{
			[appDelegate SelectAllData:@"Feeding"];
			[label1 setText:@"Food Consumption Settings"];
			if([appDelegate.NewTableArray count]==0)
				btnSave.enabled=FALSE;
			else
				btnSave.enabled=TRUE;	
		}
	}
	[self populateSelectedArray];
	[tblSettings reloadData];
}

//// Check which Item is selected or not for showing in table

- (void)populateSelectedArray
{
	///// Here we use tage for different views
	/// 20 - Medicine
	/// 2 - Exercise
	/// 3 - Mood
	/// 4 - Activity
	/// 5 - Dipering
	/// 6 - Food Consuption
	
	if(!selectedArray)
		selectedArray=[[NSMutableArray alloc ]init];
	if([selectedArray count]>0)
	{
		[selectedArray removeAllObjects];
	}
	if(appDelegate.DailyTag==20) /// For Medicine
	{
		if([appDelegate.ReportField isEqualToString:@""])
		{
			for (int i=0; i < [appDelegate.MedicineArray count]; i++)
				[selectedArray addObject:[NSNumber numberWithBool:NO]];
		}
		else
		{
			NSArray *arr2=[appDelegate.ReportField componentsSeparatedByString:@","];
			for(int i=0;i<[appDelegate.MedicineArray count];i++)
			{
				NSDictionary *Dict=[appDelegate.MedicineArray objectAtIndex:i];
				BOOL result = [arr2 containsObject:[Dict valueForKey:@"Medicine_ID"]]; 
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
	}
	else
	{
		if(appDelegate.DailyTag==2) /// For Exercise
		{
			if([appDelegate.ReportField isEqualToString:@""])
			{
				for (int i=0; i < [appDelegate.ExerciseArray count]; i++)
					[selectedArray addObject:[NSNumber numberWithBool:NO]];
			}
			else
			{
				NSArray *arr2=[appDelegate.ReportField componentsSeparatedByString:@","];
				for(int i=0;i<[appDelegate.ExerciseArray count];i++)
				{
					NSDictionary *Dict=[appDelegate.ExerciseArray objectAtIndex:i];
					BOOL result = [arr2 containsObject:[Dict valueForKey:@"Exercise_ID"]]; 
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
		}
		else if(appDelegate.DailyTag==3) /// For Mood
		{
			if([appDelegate.ReportField isEqualToString:@""])
			{
				for (int i=0; i < [appDelegate.NewTableArray count]; i++)
					[selectedArray addObject:[NSNumber numberWithBool:NO]];
			}
			else
			{
				NSArray *arr2=[appDelegate.ReportField componentsSeparatedByString:@","];
				for(int i=0;i<[appDelegate.NewTableArray count];i++)
				{
					NSDictionary *Dict=[appDelegate.NewTableArray objectAtIndex:i];
					BOOL result = [arr2 containsObject:[Dict valueForKey:@"ID"]]; 
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
		}
		else if(appDelegate.DailyTag==4) /// For Activity
		{
			if([appDelegate.ReportField isEqualToString:@""])
			{
				for (int i=0; i < [appDelegate.NewTableArray count]; i++)
					[selectedArray addObject:[NSNumber numberWithBool:NO]];
			}
			else
			{
				NSArray *arr2=[appDelegate.ReportField componentsSeparatedByString:@","];
				for(int i=0;i<[appDelegate.NewTableArray count];i++)
				{
					NSDictionary *Dict=[appDelegate.NewTableArray objectAtIndex:i];
					BOOL result = [arr2 containsObject:[Dict valueForKey:@"ID"]]; 
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
		}
		else if(appDelegate.DailyTag==5) /// For Diapering
		{
			if([appDelegate.ReportField isEqualToString:@""])
			{
				for (int i=0; i < [appDelegate.NewTableArray count]; i++)
					[selectedArray addObject:[NSNumber numberWithBool:NO]];
			}
			else
			{
				NSArray *arr2=[appDelegate.ReportField componentsSeparatedByString:@","];
				for(int i=0;i<[appDelegate.NewTableArray count];i++)
				{
					NSDictionary *Dict=[appDelegate.NewTableArray objectAtIndex:i];
					BOOL result = [arr2 containsObject:[Dict valueForKey:@"ID"]]; 
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
		}
		else if(appDelegate.DailyTag==6) /// For Food Consumed
		{
			if([appDelegate.ReportField isEqualToString:@""])
			{
				for (int i=0; i < [appDelegate.NewTableArray count]; i++)
					[selectedArray addObject:[NSNumber numberWithBool:NO]];
			}
			else
			{
				NSArray *arr2=[appDelegate.ReportField componentsSeparatedByString:@","];
				for(int i=0;i<[appDelegate.NewTableArray count];i++)
				{
					NSDictionary *Dict=[appDelegate.NewTableArray objectAtIndex:i];
					BOOL result = [arr2 containsObject:[Dict valueForKey:@"ID"]]; 
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
		}
	}
}

#pragma mark TableView Delegate Mothods
/// Return Height Base on text
-(CGFloat)findHeightForCell:(NSString *)text
{
	CGFloat		result = 40.0f;
	CGFloat		width = 0;
	width = 225;
	// fudge factor
	if (text)
	{
		CGSize		textSize = { width, 20000.0f };		// width and height of text area
		CGSize		size = [text sizeWithFont:[UIFont boldSystemFontOfSize:15.0f] constrainedToSize:textSize lineBreakMode:UILineBreakModeCharacterWrap];
		
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
	NSDictionary *Dict;
	if(appDelegate.DailyTag==20) /// For Medicine
	{
		Dict=[appDelegate.MedicineArray objectAtIndex:indexPath.row];
		NameValue=[Dict valueForKey:@"Medicine_Name"];
	}
	else if(appDelegate.DailyTag==2) /// For Exercise
	{
		Dict=[appDelegate.ExerciseArray objectAtIndex:indexPath.row];
		NameValue=[Dict valueForKey:@"Exercise_Name"];
	}
	else  /// For Mood, Food Consumed, Diapering and Activity
	{ 
		Dict=[appDelegate.NewTableArray objectAtIndex:indexPath.row];
		NameValue=[Dict valueForKey:@"Name"];
	}	
	return [self findHeightForCell:[Dict valueForKey:NameValue]]; 
}

// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if(appDelegate.DailyTag==20)
		return [appDelegate.MedicineArray count];
	else if(appDelegate.DailyTag==2)
		return [appDelegate.ExerciseArray count];
	else {
		return [appDelegate.NewTableArray count];
	}
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell1";
	SettingTableViewCell  *cell =(SettingTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) 
	{
		cell = [[[SettingTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}	
	NSNumber *selected = [selectedArray objectAtIndex:[indexPath row]];
	cell.btnDelete.image = ([selected boolValue]) ? selectedImage : unselectedImage;
	cell.txtAmount.hidden=TRUE;
	NSDictionary *Dict;
	if(appDelegate.DailyTag==20)
	{
		Dict=[appDelegate.MedicineArray objectAtIndex:indexPath.row];
		NameValue=[Dict valueForKey:@"Medicine_Name"];
	}
	else if(appDelegate.DailyTag==2)
	{
		Dict=[appDelegate.ExerciseArray objectAtIndex:indexPath.row];
		NameValue=[Dict valueForKey:@"Exercise_Name"];
	}
	else 
	{
		Dict=[appDelegate.NewTableArray objectAtIndex:indexPath.row];
		NameValue=[Dict valueForKey:@"Name"];
	}
	cell.lblName.text=NameValue; 
    return cell;
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	BOOL selected = [[selectedArray objectAtIndex:[indexPath row]] boolValue];
	[selectedArray replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithBool:!selected]];
	[tableView reloadData];
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

#pragma mark Button Click Methods

//An event when user clicks on Cancel button.
-(IBAction)Cancle:(id)sender
{
	[self.navigationController dismissModalViewControllerAnimated:YES];
}

//// Select all cell.....
-(IBAction)checkAll:(id)sender
{
	for(int i=0; i<[selectedArray count]; i++)
	{
		[selectedArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",1]];
	}
	[tblSettings reloadData];
}

//// Deselect all cell.....
-(IBAction)uncheckAll:(id)sender
{
	for(int i=0; i<[selectedArray count]; i++)
	{
		[selectedArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",0]];
	}
	[tblSettings reloadData];
}


//An event when user clicks on Save button.
-(IBAction)Save:(id)sender
{
	
	///// Here we use tage for different views
	/// 20 - Medicine
	/// 2 - Exercise
	/// 3 - Mood
	/// 4 - Activity
	/// 5 - Dipering
	/// 6 - Food Consuption
	
	
	appDelegate.ReportField=@"";
	if(!arr1)
		arr1=[[NSMutableArray alloc]init];
	if([arr1 count]>0)
	{
		[arr1 removeAllObjects];
	}	
	if(appDelegate.DailyTag==20) /// For Medicine
	{
		for(int i=0;i<[appDelegate.MedicineArray count];i++)
		{
			if([[selectedArray objectAtIndex:i]intValue]==1)
			{
				NSDictionary *Dict=[appDelegate.MedicineArray objectAtIndex:i];
				[arr1 addObject:[Dict valueForKey:@"Medicine_ID"]];
			}		
		}
		//[appDelegate.UnitDictionary removeAllObjects];
	}
	else if(appDelegate.DailyTag==2)/// For Exercise
	{
		for(int i=0;i<[appDelegate.ExerciseArray count];i++)
		{
			if([[selectedArray objectAtIndex:i]intValue]==1)
			{
				NSDictionary *Dict=[appDelegate.ExerciseArray objectAtIndex:i];
				[arr1 addObject:[Dict valueForKey:@"Exercise_ID"]];
			}		
		}
	}
	else if(appDelegate.DailyTag==6) /// For Food Consuption
	{
		for(int i=0;i<[appDelegate.NewTableArray count];i++)
		{
			if([[selectedArray objectAtIndex:i]intValue]==1)
			{
				NSDictionary *Dict=[appDelegate.NewTableArray objectAtIndex:i];
				[arr1 addObject:[Dict valueForKey:@"ID"]];
			}		
		}
		//[appDelegate.UnitDictionary removeAllObjects];
	}
	else /// For Moos, Dipering and Activity
	{
		for(int i=0;i<[appDelegate.NewTableArray count];i++)
		{
			if([[selectedArray objectAtIndex:i]intValue]==1)
			{
				NSDictionary *Dict=[appDelegate.NewTableArray objectAtIndex:i];
				[arr1 addObject:[Dict valueForKey:@"ID"]];
			}		
		}
	}
	if([arr1 count]>0)
	{
		for(int i=0;i<[arr1 count];i++)
		{
			if(i==([arr1 count]-1))
			{
				appDelegate.ReportField=[appDelegate.ReportField stringByAppendingString:[NSString stringWithFormat:@"%@",[arr1 objectAtIndex:i]]];
			}
			else
			{
				appDelegate.ReportField=[appDelegate.ReportField stringByAppendingString:[NSString stringWithFormat:@"%@,",[arr1 objectAtIndex:i]]];
			}
		}
	}
	int Update;	
	appDelegate.SelectedItems=@""; 
	//// Update setting for showing in entry List
	if(appDelegate.DailyTag==20)
	{
		Update=[appDelegate UpdateUserData:appDelegate.SelectedUserID DailyData:appDelegate.ReportField ColumnName:@"MedicineEntryDetail"];
	}
	else if(appDelegate.DailyTag==2)
	{
		Update=[appDelegate UpdateUserData:appDelegate.SelectedUserID DailyData:appDelegate.ReportField ColumnName:@"Exercise_Settings"];
	}
	else if(appDelegate.DailyTag==3)
	{
		Update=[appDelegate UpdateUserData:appDelegate.SelectedUserID DailyData:appDelegate.ReportField ColumnName:@"Mood_Settings"];
	}
	else if(appDelegate.DailyTag==4)
	{
		Update=[appDelegate UpdateUserData:appDelegate.SelectedUserID DailyData:appDelegate.ReportField ColumnName:@"Activity_Settings"];
	}
	else if(appDelegate.DailyTag==5)
	{
		Update=[appDelegate UpdateUserData:appDelegate.SelectedUserID DailyData:appDelegate.ReportField ColumnName:@"Diapering_Settings"];
	}
	else if(appDelegate.DailyTag==6)
	{
		Update=[appDelegate UpdateUserData:appDelegate.SelectedUserID DailyData:appDelegate.ReportField ColumnName:@"Feeding_Settings"];
	}
	appDelegate.isfromFavourite=TRUE;
	if(Update==1)
	{
		[self.navigationController dismissModalViewControllerAnimated:YES];
	}
	else
	{
		[self.navigationController dismissModalViewControllerAnimated:YES];
	}	
}

#pragma mark AlertView Delegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(alertView.tag==1)
	{
		[self.navigationController dismissModalViewControllerAnimated:YES];
	}
}

- (void)dealloc 
{	
	[tblSettings release];
	[btnSave release];
	[btnCancle release];
	[selectedArray release];
	[selectedImage release];
	[unselectedImage release];
	[arr release];
	[appDelegate release];
	[selectedArrayData release];	
	[arr1 release];	
    [super dealloc];
}


@end