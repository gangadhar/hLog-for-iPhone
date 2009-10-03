//
//  RootViewController.m
//
//
//  Copyright (c) 2009 4th Main Software Inc. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//




// Import All needed header files bellow.
#import "RootViewController.h"
#import "HealthTrackerAppDelegate.h"
#import "SettingTableViewCell.h"

@implementation RootViewController

#pragma mark View

// Called after the view has been loaded. For view controllers created in code, this is after -loadView. For view controllers unarchived from a nib, this is after the view is set.
- (void)viewDidLoad
{	
	self.navigationItem.leftBarButtonItem=nil;
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Back";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];
	selectedImage = [UIImage imageNamed:@"checked.png"];
	unselectedImage = [UIImage imageNamed:@"unchecked.png"];
	tblView.delegate=self;
	tblView.dataSource=self;
	tblView.rowHeight=50;
	appDelegate=[[UIApplication sharedApplication]delegate];
	lblUser=[[UILabel alloc]init];
	lblUser.backgroundColor=[UIColor clearColor];
	lblUser.frame=CGRectMake(110, 200, 120, 50);
	lblUser.textColor=[UIColor lightGrayColor];
	lblUser.font=[UIFont boldSystemFontOfSize:20];
	lblUser.textAlignment=UITextAlignmentCenter;
	[tblView addSubview:lblUser];
	ToolBar.tintColor=[UIColor blackColor];

    [super viewDidLoad];
}

// Called when the view is about to made visible. Default does nothing
- (void)viewWillAppear:(BOOL)animated 
{	
	[tblView scrollRectToVisible:CGRectMake(0, 0, 320, 50)  animated:YES];
	
	[appDelegate SelectsUsers];
	self.navigationItem.title=@"Users";
	self.navigationItem.rightBarButtonItem=btnAdd;
	if([appDelegate.UserArray count]>0)
	{
		lblUser.text=@"";
	}
	else
	{
		lblUser.text=@"No Users";
		[tblView bringSubviewToFront:lblUser];
	}
	[tblView reloadData];	
	[super viewWillAppear:animated];
}

 // Called when the view has been fully transitioned onto the screen. Default does nothing
- (void)viewDidAppear:(BOOL)animated {
	
	self.view.frame=CGRectMake(0, 0, 320, 416);
	tblView.allowsSelectionDuringEditing=TRUE;
    [super viewDidAppear:animated];
}

// Called when the view is dismissed, covered or otherwise hidden. Default does nothing
- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

#pragma mark memorywarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


#pragma mark Table view methods
// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [appDelegate.UserArray count] ;
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
	
	for(int i=0;i<[appDelegate.UserArray count];i++)
	{
		
		NSDictionary *Dict=[appDelegate.UserArray objectAtIndex:i];
		if(appDelegate.SelectedUserID == [[Dict valueForKey:@"UserID"]intValue])
		{
			[selectedArray addObject:[NSNumber numberWithBool:YES]];
		}
		else
		{
			
			[selectedArray addObject:[NSNumber numberWithBool:NO]];
		}
	}	
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(appDelegate.ISfromDefaultUser==TRUE)
	{
		static NSString *CellIdentifier = @"Cell";
		UITableViewCell *cell =(UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		}	
		cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
		cell.indentationLevel = 0;
		cell.font=[UIFont boldSystemFontOfSize:15];
		cell.textColor= [UIColor colorWithRed:0.317 green:0.4 blue:0.56 alpha:1.0];
		NSDictionary *Dict=[appDelegate.UserArray objectAtIndex:indexPath.row];
		cell.text=[Dict valueForKey:@"UserName"];
		return cell;
	}
	else
	{
		static NSString *CellIdentifier1 = @"Cell1";
		SettingTableViewCell *cell1 =(SettingTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
		if (cell1 == nil) {
			cell1 = [[[SettingTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier1] autorelease];
		}	
		cell1.accessoryType=UITableViewCellAccessoryNone;
		NSNumber *selected = [selectedArray objectAtIndex:[indexPath row]];
		cell1.btnDelete.image = ([selected boolValue]) ? selectedImage : unselectedImage;
		cell1.txtAmount.hidden=TRUE;
		NSDictionary *Dict=[appDelegate.UserArray objectAtIndex:indexPath.row];
		cell1.lblName.text=[Dict valueForKey:@"UserName"];
		return cell1;
	}
}


// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tblView deselectRowAtIndexPath:indexPath animated:YES];
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	if(appDelegate.ISfromDefaultUser==TRUE)
	{
		appDelegate.AddNewUserDict =[appDelegate.UserArray objectAtIndex:indexPath.row];
		appDelegate.UserStatus=@"Edit User";
		appDelegate.iSfromAddUser=TRUE; 
		appDelegate.isForMail=FALSE;
		if(!appDelegate.objFirstViewController)
		{
			appDelegate.objFirstViewController=[[FirstViewController alloc]initWithNibName:@"First_View" bundle:nil];
		}
		[appDelegate selectPastData:[[appDelegate.AddNewUserDict valueForKey:@"UserID"]intValue]];
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

		[self.navigationController pushViewController:appDelegate.objFirstViewController animated:YES];
	}
	else
	{
		for(int i=0;i<[selectedArray count];i++)
		{
			[selectedArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",0]];
		}
		[selectedArray replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"%d",1]];
		[tableView reloadData];
	}
	[Pool release];
}

// When the editing state changes, these methods will be called again to allow the accessory to be hidden when editing, if required.
- (UITableViewCellAccessoryType)tableView:(UITableView *)tv accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
	if(appDelegate.ISfromDefaultUser==TRUE)
		return (self.editing) ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDetailDisclosureButton;
	else
		return (self.editing) ? UITableViewCellAccessoryNone : UITableViewCellAccessoryNone;	
	
	if(appDelegate.SaveMenstural==TRUE)
		return (self.editing) ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDetailDisclosureButton;
	else
		return (self.editing) ? UITableViewCellAccessoryNone : UITableViewCellAccessoryNone;
	
}

// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{    
	UITableViewCell  *cell=(UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
	cell.accessoryType=UITableViewCellAccessoryNone;
    if (editingStyle == UITableViewCellEditingStyleDelete) 
	{	
		ROW=indexPath.row;
		UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"Are you sure to delete this user?" delegate:self cancelButtonTitle:@"No" destructiveButtonTitle:@"Delete User" otherButtonTitles:nil];
		action.actionSheetStyle=UIActionSheetStyleDefault;
		[action showInView:self.view.superview.superview];
		[action release];
	}   
}

// When the editing state changes, these methods will be called again to allow the accessory to be hidden when editing, if required.
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath 
{ 	
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	appDelegate.AddNewUserDict =[appDelegate.UserArray objectAtIndex:indexPath.row];
	appDelegate.UserStatus=@"Edit User";
	appDelegate.isForMail=FALSE;
	appDelegate.iSfromAddUser=TRUE; 
	if(!appDelegate.objFirstViewController)
	{
		appDelegate.objFirstViewController=[[FirstViewController alloc]initWithNibName:@"First_View" bundle:nil];
	}
	[self.navigationController pushViewController:appDelegate.objFirstViewController animated:YES];
	[Pool release];
}

#pragma mark ActionSheet Delegate Method
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex==0)
	{
		///// Delete the user and also his/her all data with entered in app....
		NSDictionary *Dict=[appDelegate.UserArray objectAtIndex:ROW];
		appDelegate.SelectedUserID=[[Dict objectForKey:@"UserID"]intValue];
		[appDelegate DeleteAllCategoriesData:@"Vitals_Detail"  IDname:@"User_ID" DeleteID:appDelegate.SelectedUserID]; 
		[appDelegate DeleteAllCategoriesData:@"Routine_Detail"  IDname:@"User_ID" DeleteID:appDelegate.SelectedUserID]; 
		[appDelegate DeleteAllCategoriesData:@"User_Settings"  IDname:@"User_ID" DeleteID:appDelegate.SelectedUserID]; 
		[appDelegate DeleteAllCategoriesData:@"Menstrual_Cycle"  IDname:@"User_ID" DeleteID:appDelegate.SelectedUserID]; 
		[appDelegate DeleteAllCategoriesData:@"User_Detail"  IDname:@"User_ID" DeleteID:appDelegate.SelectedUserID]; 
		[appDelegate DeleteAllCategoriesData:@"Medicine"  IDname:@"User_ID" DeleteID:appDelegate.SelectedUserID];
		
		[appDelegate DeleteAllCategoriesData:@"exercise_Duration"  IDname:@"User_ID" DeleteID:appDelegate.SelectedUserID];	
		[appDelegate DeleteAllCategoriesData:@"Feed_Detail"  IDname:@"User_ID" DeleteID:appDelegate.SelectedUserID];
		[appDelegate DeleteEntry:@"Medicine_Detail" ColumnName:@"User_ID" PrimaryID:appDelegate.SelectedUserID]; 
		
		[appDelegate DeleteAllCategoriesData:@"Health_Care"  IDname:@"User_ID" DeleteID:appDelegate.SelectedUserID];	
		[appDelegate DeleteAllCategoriesData:@"Insurance"  IDname:@"User_ID" DeleteID:appDelegate.SelectedUserID];
		
		[appDelegate SelectsUsers];
		if([appDelegate.UserArray count]>0)
		{
			lblUser.text=@"";
		}
		else
		{
			lblUser.text=@"No Users";
			[tblView bringSubviewToFront:lblUser];
		}
		[tblView reloadData];
	}	
}

#pragma mark Button Click methods

//// Call when click on change defult user 

-(IBAction)btnChengeUser:(id)sender
{
	appDelegate.ISfromDefaultUser=FALSE;
	[self populateSelectedArray];
	self.navigationItem.rightBarButtonItem=btnSave;
	self.navigationItem.hidesBackButton=TRUE;
	btnChengeUser.enabled=FALSE;	
	[tblView reloadData];	
}

//// Call when click on add new user button

-(IBAction)btnSave_Click:(id)sender
{
	if(!arr1)
		arr1=[[NSMutableArray alloc]init];
	if([arr1 count]>0)
	{
		[arr1 removeAllObjects];
	}
	
	for(int i=0;i<[appDelegate.UserArray count];i++)
	{
		if([[selectedArray objectAtIndex:i]intValue]==1)
		{
			NSDictionary *Dict=[appDelegate.UserArray objectAtIndex:i];
			[arr1 addObject:[Dict valueForKey:@"UserID"]];
			appDelegate.UserName=[Dict valueForKey:@"UserName"];
		}		
	}	
	[appDelegate DefaultSet:[[arr1 objectAtIndex:0]intValue]];
	[appDelegate UpdateDefaultUser:[[arr1 objectAtIndex:0]intValue]];
	appDelegate.SelectedUserID=[[arr1 objectAtIndex:0]intValue];
	appDelegate.ISfromDefaultUser=TRUE;
	self.navigationItem.rightBarButtonItem=btnAdd;
	self.navigationItem.hidesBackButton=FALSE;
	btnChengeUser.enabled=TRUE;	
	[appDelegate SelectsUsers];
	[tblView reloadData];
}

//// Call when user pressed Add button
-(IBAction)addProfile:(id)sender;
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

- (void)dealloc
{
	[btnAdd release];	
	[tblView release];
	[SettingsCon release];	
	[super dealloc];
}

@end

