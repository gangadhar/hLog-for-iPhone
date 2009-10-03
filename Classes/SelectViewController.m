//
//  SelectViewController.m
//  HealthTracker
//
//  Created by MAC02 on 8/27/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import "SelectViewController.h"


@implementation SelectViewController
@synthesize EmailArray,SelectedIndexRow,USER_ID;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

#pragma mark View Methods

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

	tblView.delegate=self;
	tblView.dataSource=self; 
	appDelegate=[[UIApplication sharedApplication]delegate];
	tblView.rowHeight=50;
	self.navigationController.navigationBar.barStyle= UIBarStyleBlackOpaque; 
	
	[super viewDidLoad];
}

- (void)viewDidDisappear:(BOOL)animated
{
	//[appDelegate.AddNewUserDict setValue:[NSString stringWithFormat:@"%d",self.USER_ID] forKey:@"UserID"];
}

// Called when the view is about to made visible. Default does nothing
- (void)viewWillAppear:(BOOL)animated
{	
	if(appDelegate.ISFromFirstViewController==TRUE)
	{
		tblView.editing=YES;
		tblView.allowsSelectionDuringEditing=TRUE;
		if(self.SelectedIndexRow==2)
		{
			self.navigationItem.title=@"Health Care Provider";
			[appDelegate selectHealthcare:self.USER_ID];
		}
		else
		{
			self.navigationItem.title=@"Insurance Information";
			[appDelegate selectInsuranceInfo:self.USER_ID];
		}
		self.navigationItem.rightBarButtonItem=nil;
	}
	[tblView reloadData];
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark Table View Delegate Methods
// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {	
	
	return 1;	
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if(appDelegate.ISFromFirstViewController==TRUE)
	{
		return [appDelegate.HealthInsuranceArray count]+1;
	}
	return 0;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	if(appDelegate.ISFromFirstViewController==TRUE)
	{
		static NSString *CellIdentifier1 = @"Cell1";
		
		UITableViewCell *cell1 =[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
		if (cell1 == nil) {
			cell1 = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier1] autorelease];
		}	
		if(indexPath.row==[appDelegate.HealthInsuranceArray count])
		{
			cell1.text=@"Add New";
		}
		else
		{
			NSDictionary *DIC=[appDelegate.HealthInsuranceArray objectAtIndex:indexPath.row];
			if(self.SelectedIndexRow==2)
				cell1.text=[DIC valueForKey:@"PastName"];
			else
				cell1.text=[DIC valueForKey:@"PastIdentification"];
		}
		return cell1;	
	}
	return nil;
}

// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete) 
	{
	//	[appDelegate.HealthInsuranceArray removeObjectAtIndex:indexPath.row];
		NSDictionary *DIC=[appDelegate.HealthInsuranceArray objectAtIndex:indexPath.row];		
		if(self.SelectedIndexRow==2)
		{
			[appDelegate DeleteAllCategoriesData:@"Health_Care" IDname:@"Pk_Id" DeleteID:[[DIC valueForKey:@"Pk_ID"]intValue]];
			[appDelegate selectHealthcare:self.USER_ID];
		}
		else
		{
			[appDelegate DeleteAllCategoriesData:@"Insurance" IDname:@"Pk_Id" DeleteID:[[DIC valueForKey:@"Pk_ID"]intValue]];
			[appDelegate selectInsuranceInfo:self.USER_ID];
		}		
		[appDelegate.AddNewUserDict setValue:[NSString stringWithFormat:@"%d",self.USER_ID] forKey:@"UserID"];
		[tblView reloadData];
	}
	if(editingStyle==UITableViewCellEditingStyleInsert)
	{
		if(appDelegate.ISFromFirstViewController==TRUE)
		{			
			if(!AddNewUser)
			{
				AddNewUser=[[AddNewUserController alloc]initWithNibName:@"AddNewUser" bundle:nil];
			}
			AddNewUser.SelectedIndexRow=self.SelectedIndexRow;
			AddNewUser.BackUpDict=[appDelegate.AddNewUserDict mutableCopy];
			if(self.SelectedIndexRow==2)
			{
				AddNewUser.Name=@"Health Care Providers";
			}
			else
			{
				AddNewUser.Name=@"Insurance Information";
			}
			if(indexPath.row==[appDelegate.HealthInsuranceArray count])
			{
				if(!appDelegate.DetailDIC)
					appDelegate.DetailDIC=[[NSMutableDictionary alloc]init];
				if([appDelegate.DetailDIC count]>0)
					[appDelegate.DetailDIC removeAllObjects];
				if(self.SelectedIndexRow==2)
				{
					[appDelegate.DetailDIC setValue:@"" forKey:@"PastPhoneNumber"];
					[appDelegate.DetailDIC setValue:@"" forKey:@"PastName"];
					[appDelegate.DetailDIC setValue:[NSString stringWithFormat:@"%d",self.USER_ID] forKey:@"User_id"];
					[appDelegate.DetailDIC setValue:@"0" forKey:@"Pk_ID"];		
				}
				else
				{
					[appDelegate.DetailDIC setValue:@"" forKey:@"PastPolicyNo"];
					[appDelegate.DetailDIC setValue:@"" forKey:@"PastIdentification"];
					[appDelegate.DetailDIC setValue:[NSString stringWithFormat:@"%d",self.USER_ID] forKey:@"User_id"];
					[appDelegate.DetailDIC setValue:@"" forKey:@"PastPhone"];
					[appDelegate.DetailDIC setValue:@"" forKey:@"PastEmrContact"];
					[appDelegate.DetailDIC setValue:@"0" forKey:@"Pk_ID"];				
				}
			}
			else
			{
				appDelegate.DetailDIC=[appDelegate.HealthInsuranceArray objectAtIndex:indexPath.row];
			}
			[self.navigationController pushViewController:AddNewUser animated:YES];
		}
	}
}

// Allows customization of the editingStyle for a particular cell located at 'indexPath'. If not implemented, all editable cells will have UITableViewCellEditingStyleDelete set for them when the table has editing property set to YES.

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(appDelegate.ISFromFirstViewController==TRUE)
	{
		if(indexPath.row==[appDelegate.HealthInsuranceArray count])
		{
			return UITableViewCellEditingStyleInsert;
		}
		else
			return UITableViewCellEditingStyleDelete;
	}
	return UITableViewCellEditingStyleNone;
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	[tblView deselectRowAtIndexPath:indexPath animated:YES];
	if(appDelegate.ISFromFirstViewController==TRUE)
	{
		if(!AddNewUser)
		{
			AddNewUser=[[AddNewUserController alloc]initWithNibName:@"AddNewUser" bundle:nil];
		}
		AddNewUser.BackUpDict=[appDelegate.AddNewUserDict mutableCopy];
		AddNewUser.SelectedIndexRow=self.SelectedIndexRow;
		if(self.SelectedIndexRow==2)
		{
			AddNewUser.Name=@"Health Care Providers";
		}
		else
		{
			AddNewUser.Name=@"Insurance Information";
		}
		if(indexPath.row==[appDelegate.HealthInsuranceArray count])
		{
			if(!appDelegate.DetailDIC)
				appDelegate.DetailDIC=[[NSMutableDictionary alloc]init];
			if([appDelegate.DetailDIC count]>0)
				[appDelegate.DetailDIC removeAllObjects];
			if(self.SelectedIndexRow==2)
			{
				[appDelegate.DetailDIC setValue:@"" forKey:@"PastPhoneNumber"];
				[appDelegate.DetailDIC setValue:@"" forKey:@"PastName"];
				[appDelegate.DetailDIC setValue:[NSString stringWithFormat:@"%d",self.USER_ID] forKey:@"User_id"];
				[appDelegate.DetailDIC setValue:@"0" forKey:@"Pk_ID"];		
			}
			else
			{
				[appDelegate.DetailDIC setValue:@"" forKey:@"PastPolicyNo"];
				[appDelegate.DetailDIC setValue:@"" forKey:@"PastIdentification"];
				[appDelegate.DetailDIC setValue:[NSString stringWithFormat:@"%d",self.USER_ID] forKey:@"User_id"];
				[appDelegate.DetailDIC setValue:@"" forKey:@"PastPhone"];
				[appDelegate.DetailDIC setValue:@"" forKey:@"PastEmrContact"];
				[appDelegate.DetailDIC setValue:@"0" forKey:@"Pk_ID"];				
			}
		}
		else
		{
			appDelegate.DetailDIC=[appDelegate.HealthInsuranceArray objectAtIndex:indexPath.row];
		}
		[self.navigationController pushViewController:AddNewUser animated:YES];
	}
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}


@end
