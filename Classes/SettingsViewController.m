//
//  SettingsViewController.m
//  hLog
//  Created by Bhoomi on 3/3/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

// Import All needed header files bellow.
#import "SettingsViewController.h"
#import "SettingTableViewCell.h"


@implementation SettingsViewController

#pragma mark Button Click Methods

//An event when user clicks on Cancel button.
-(IBAction)Cancle:(id)sender
{
	[self.navigationController dismissModalViewControllerAnimated:YES];
}

//An event when user clicks on Save button.
-(IBAction)Save:(id)sender
{
	appDelegate.SelectedItems=@"";
	if(!arr1)
		arr1=[[NSMutableArray alloc]init];
	if([arr1 count]>0)
	{
		[arr1 removeAllObjects];
	}
	
	for(int i=0;i<[appDelegate.VitalsMasterArray count];i++)
	{
		if([[selectedArray objectAtIndex:i]intValue]==1)
		{
			NSDictionary *Dict=[appDelegate.VitalsMasterArray objectAtIndex:i];
			[arr1 addObject:[Dict valueForKey:@"Vital_ID"]];			
		}		
	}
	if([arr1 count]>0)
	{
		for(int i=0;i<[arr1 count];i++)
		{
			if(i==([arr1 count]-1))
			{
				appDelegate.SelectedItems=[appDelegate.SelectedItems stringByAppendingString:[NSString stringWithFormat:@"%@",[arr1 objectAtIndex:i]]];
			}
			else
			{
				appDelegate.SelectedItems=[appDelegate.SelectedItems stringByAppendingString:[NSString stringWithFormat:@"%@,",[arr1 objectAtIndex:i]]];
			}
		}
	}
	int Update;
	if([appDelegate.SelectedStatus isEqualToString:@"Daily"])
	{
		Update=[appDelegate UpdateUserData:appDelegate.SelectedUserID DailyData:appDelegate.SelectedItems ColumnName:@"VitalsEntryDetail"];
	}
	else
	{
		Update=[appDelegate UpdateUserData:appDelegate.SelectedUserID DailyData:appDelegate.SelectedItems ColumnName:@"RoutinesDetailSettings"];
	}
	if(Update==1)
	{

		[self.navigationController dismissModalViewControllerAnimated:YES];
	}
	else
	{
		[self.navigationController dismissModalViewControllerAnimated:YES];
	}
	
}

/////// Select all cell
-(IBAction)btnCheck:(id)sender {
	BOOL selected = [[selectedArray objectAtIndex:[appDelegate.VitalsMasterArray count]+1] boolValue];
	[selectedArray replaceObjectAtIndex:[appDelegate.VitalsMasterArray count]+1 withObject:[NSNumber numberWithBool:!selected]];
	
	for(int i=0;i<[selectedArray count];i++)
	{
		if(i!=[appDelegate.VitalsMasterArray count])
		{
			[selectedArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",1]];
		}
		else
			[selectedArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",0]];
	}
	[tblSettings reloadData];
}

/// Deselect All Cell

-(IBAction)btnUncheck:(id)sender {
	BOOL selected = [[selectedArray objectAtIndex:[appDelegate.VitalsMasterArray count]] boolValue];
	[selectedArray replaceObjectAtIndex:[appDelegate.VitalsMasterArray count] withObject:[NSNumber numberWithBool:!selected]];
	
	for(int i=0;i<[selectedArray count];i++)
	{
		if(i!=[appDelegate.VitalsMasterArray count])
		{
			[selectedArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",0]];
		}
		else
			[selectedArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",1]];
	}
	[tblSettings reloadData];
	
}

#pragma mark Alert View Delegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(alertView.tag==1)
	{
		[self.navigationController dismissModalViewControllerAnimated:YES];
	}
}

//// Check which Item is selected or not for showing in table

- (void)populateSelectedArray
{
	if(!selectedArray)
		selectedArray=[[NSMutableArray alloc ]init];
	if([selectedArray count]>0)
	{
		[selectedArray removeAllObjects];
	}
	if([appDelegate.SelectedItems isEqualToString:@""])
	{
		for (int i=0; i < [appDelegate.VitalsMasterArray count]+2; i++)
		{
			if(i==[appDelegate.VitalsMasterArray count])
			{
				[selectedArray addObject:[NSNumber numberWithBool:YES]];
				
			}
			else
				[selectedArray addObject:[NSNumber numberWithBool:NO]];
		}
	}
	else
	{
		
		NSArray *arr2=[appDelegate.SelectedItems componentsSeparatedByString:@","];
		int ISFlag=0;
		for(int i=0;i<[appDelegate.VitalsMasterArray count];i++)
		{

			NSDictionary *Dict=[appDelegate.VitalsMasterArray objectAtIndex:i];
			BOOL result = [arr2 containsObject:[Dict valueForKey:@"Vital_ID"]];
			
			if(result==TRUE)
			{
				if(ISFlag==0)
					ISFlag=1;
				[selectedArray addObject:[NSNumber numberWithBool:YES]];
			}
			else
			{
				ISFlag=2;
				[selectedArray addObject:[NSNumber numberWithBool:NO]];
			}
		}
		[selectedArray addObject:[NSNumber numberWithBool:NO]];
		if(ISFlag==1)
		{
			[selectedArray addObject:[NSNumber numberWithBool:YES]];
		}
		else
			[selectedArray addObject:[NSNumber numberWithBool:NO]];
	}
}
#pragma mark View Methods
// Called after the view has been loaded. For view controllers created in code, this is after -loadView. For view controllers unarchived from a nib, this is after the view is set.
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	self.navigationItem.title=@"Settings";
	self.navigationItem.rightBarButtonItem=btnSave;
	self.navigationItem.leftBarButtonItem=btnCancle;
	selectedImage = [UIImage imageNamed:@"checked.png"];
	unselectedImage = [UIImage imageNamed:@"unchecked.png"];
	appDelegate=[[UIApplication sharedApplication]delegate];
	tblSettings.delegate=self;
	tblSettings.dataSource=self;
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
	
	if([appDelegate.SelectedStatus isEqualToString:@"Daily"])
	{
		[appDelegate SelectVitalsInfo:appDelegate.SelectedUserID]; 
		IncrementCount=1;
	}
	else 
	{
		[appDelegate SelectRoutineInfo:appDelegate.SelectedUserID]; 		
	}
	
	[self populateSelectedArray];
	[tblSettings reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark TableView Delegate Methods
// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [appDelegate.VitalsMasterArray count];
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
	cell.txtAmount.hidden=TRUE;
	if(indexPath.row==[appDelegate.VitalsMasterArray count]) //// For Uncheck all 
	{
		NSNumber *selected = [selectedArray objectAtIndex:[indexPath row]];
		cell.btnDelete.image = ([selected boolValue]) ? selectedImage : unselectedImage;
		cell.lblName.text=@"Uncheck All";
	}
	else if(indexPath.row==[appDelegate.VitalsMasterArray count]+1)  //// For check all 
	{
		NSNumber *selected = [selectedArray objectAtIndex:[indexPath row]];
		cell.btnDelete.image = ([selected boolValue]) ? selectedImage : unselectedImage;
		cell.lblName.text=@"Check All";
	}
	else
	{
		NSNumber *selected = [selectedArray objectAtIndex:[indexPath row]];
		cell.btnDelete.image = ([selected boolValue]) ? selectedImage : unselectedImage;		
		NSDictionary *Dict=[appDelegate.VitalsMasterArray objectAtIndex:indexPath.row];
		cell.lblName.text=[Dict valueForKey:@"Name"];
		cell.accessoryType=UITableViewCellAccessoryNone;
		cell.btnDelete.hidden=FALSE;
	}
	//	}
    return cell;
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	
	
	if(indexPath.row==[appDelegate.VitalsMasterArray count])
	{
		BOOL selected = [[selectedArray objectAtIndex:[indexPath row]] boolValue];
		[selectedArray replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithBool:!selected]];
		
		for(int i=0;i<[selectedArray count];i++)
		{
			if(i!=[appDelegate.VitalsMasterArray count])
			{
				[selectedArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",0]];
			}
			else
				[selectedArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",1]];
		}
		
	}
	else if(indexPath.row==[appDelegate.VitalsMasterArray count]+1)
	{
		BOOL selected = [[selectedArray objectAtIndex:[indexPath row]] boolValue];
		[selectedArray replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithBool:!selected]];
		
		for(int i=0;i<[selectedArray count];i++)
		{
			if(i!=[appDelegate.VitalsMasterArray count])
			{
				[selectedArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",1]];
			}
			else
				[selectedArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",0]];
		}
	}
	else
	{
		BOOL selected = [[selectedArray objectAtIndex:[indexPath row]] boolValue];
		[selectedArray replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithBool:!selected]];
		int ISfLag=0;
		for(int i=0;i<[selectedArray count]-2;i++)
		{
			BOOL selected = [[selectedArray objectAtIndex:i] boolValue];
			if(selected==TRUE && i!=[appDelegate.VitalsMasterArray count])
			{
				if(ISfLag==0)
					ISfLag=1;
			}
			else if(i!=[appDelegate.VitalsMasterArray count])
			{
				ISfLag=2;
			}
		}
		
		int ISfLag1=0;
		for(int i=0;i<[selectedArray count]-2;i++)
		{
			BOOL selected = [[selectedArray objectAtIndex:i] boolValue];
			if(selected==FALSE && i!=[appDelegate.VitalsMasterArray count])
			{
				if(ISfLag1==0)
					ISfLag1=1;
			}
			else if(i!=[appDelegate.VitalsMasterArray count])
			{
				ISfLag1=2;
			}
		}
		
		
		if(ISfLag1==1)
		{
			[selectedArray replaceObjectAtIndex:[appDelegate.VitalsMasterArray count] withObject:[NSString stringWithFormat:@"%d",1]];
		}
		else
		{
			[selectedArray replaceObjectAtIndex:[appDelegate.VitalsMasterArray count] withObject:[NSString stringWithFormat:@"%d",0]];
		}
		if(ISfLag==1)
		{
			[selectedArray replaceObjectAtIndex:[appDelegate.VitalsMasterArray count]+1 withObject:[NSString stringWithFormat:@"%d",1]];
		}
		else
		{
			[selectedArray replaceObjectAtIndex:[appDelegate.VitalsMasterArray count]+1 withObject:[NSString stringWithFormat:@"%d",0]];
		}
	}
	[tableView reloadData];
}

- (void)dealloc {
	
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

