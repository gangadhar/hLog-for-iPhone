//
//  AddNewUserController.m
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
#import "AddNewUserController.h"
#import "AddUserButtonTableViewCell.h"
#import "NewSwitchTableViewCell.h"
#import "AddUserSegmentTableCell.h"
#import "DailyStatusTableViewCell.h"

@implementation AddNewUserController
@synthesize SelectedIndexRow,Name,BackUpDict;
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	PickerView.hidden=TRUE;
	ToolBar.hidden=TRUE;
	DatePicker.hidden=TRUE;
	btnSave.enabled=TRUE;
}

#pragma mark View Methods
// Called after the view has been loaded. For view controllers created in code, this is after -loadView. For view controllers unarchived from a nib, this is after the view is set.
- (void)viewDidLoad {
	
	tblView.delegate=self;
	tblView.dataSource=self;
	PickerView.delegate=self;
	self.navigationItem.leftBarButtonItem=btnCancle;	
	if(!data)
	{
		data=[[NSMutableDictionary alloc]init];
	}
	
	for(int i = 6; i <15; i++)
	{
		if(i!=9) {	
			[data setValue:[self FillArray:i] forKey:[NSString stringWithFormat:@"%d",i]];		
		}
	}
	self.navigationItem.rightBarButtonItem=btnSave;
	ToolBar.tintColor=[UIColor blackColor];
	ToolBar.hidden=TRUE;	
	PickerView.frame=CGRectMake(0, 200, 320, 216);
	DatePicker.frame=CGRectMake(0, 200, 320, 216);
	
	ToolBar.frame=CGRectMake(0, 220, 320, 44);
	lblData=[[UILabel alloc]init];
	lblData.frame=CGRectMake(3,13 , 250, 20);
	lblData.font=[UIFont systemFontOfSize:15];
	lblData.textColor=[UIColor whiteColor];
	lblData.backgroundColor=[UIColor clearColor];
	
	appDelegate=[[UIApplication sharedApplication]delegate];
	[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy"];	
	[DatePicker setDate:[NSDate date] animated:YES];
	[ToolBar addSubview:lblData];
	DatePicker.maximumDate=[NSDate date];
	
	
	label1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 220, 30)];
	[label1 setFont:[UIFont boldSystemFontOfSize:15.0]];
	[label1 setBackgroundColor:[UIColor clearColor]];
	[label1 setTextAlignment:UITextAlignmentCenter];
 	[label1 setTextColor:[UIColor whiteColor]];
	
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Back";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];	
    [super viewDidLoad];
}

// Called when the view is about to made visible. Default does nothing
- (void)viewWillAppear:(BOOL)animated
{
	[tblView scrollRectToVisible:CGRectMake(0, 0, 320, 50)  animated:YES];
	PickerView.hidden=TRUE;
	DatePicker.hidden=TRUE;
	ToolBar.hidden=TRUE;
	btnSave.enabled=TRUE;		
	
	[label1 setText:Name];
	self.navigationItem.titleView=label1;
	appDelegate.SelectedStatus=@"Users"; 
	[tblView reloadData];
}


#pragma mark Fill Picker Data 
///// Add All picker data
-(NSMutableArray *)FillArray:(int)i
{   
	NSMutableArray *TypeArray;	
	TypeArray=[[[NSMutableArray alloc]init]autorelease];
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	
	switch (i) {
		case 6://// For Blood Group
			[TypeArray addObject:@"O+"];
			[TypeArray addObject:@"O-"];
			[TypeArray addObject:@"A+"];
			[TypeArray addObject:@"A-"];
			[TypeArray addObject:@"B+"];
			[TypeArray addObject:@"B-"];
			[TypeArray addObject:@"AB+"];
			[TypeArray addObject:@"AB-"];
			break;
		case 11:/// For Smoking
			[TypeArray addObject:@"Daily"];
			[TypeArray addObject:@"1-2 times a week"];		
			
			[TypeArray addObject:@"None at all"];	
			[TypeArray addObject:@"Other"];	
			break;
		case 12:///For Drinking
			[TypeArray addObject:@"Daily"];
			[TypeArray addObject:@"1-2 times a week"];	
			[TypeArray addObject:@"Social drinker"];	
			[TypeArray addObject:@"None at all"];	
			[TypeArray addObject:@"Other"];	
			break;
		case 14://// For Past
			[TypeArray addObject:@"None"];
			[TypeArray addObject:@"Heart Attack"];
			[TypeArray addObject:@"Stroke"];
			[TypeArray addObject:@"Other"];	
			break;
		default:
			break;
	}
	[Pool release];
	return TypeArray;
}

#pragma mark Button Click Methods

////////// Call when user pressed Cancel button for Hide picker
-(IBAction)btnRemove_Clicked:(id)sender
{
	tblView.userInteractionEnabled=TRUE;
	PickerView.hidden=TRUE;
	ToolBar.hidden=TRUE;
	DatePicker.hidden=TRUE;
	btnSave.enabled=TRUE;
}

//// Call when user pressed Cancel button

-(IBAction)btnCancle_clicked:(id)sender
{
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	NSLog(@" BackUpDict User ID %@",[self.BackUpDict  valueForKey:@"UserID"]);
	NSLog(@"User ID %@",[appDelegate.AddNewUserDict valueForKey:@"UserID"]);
	appDelegate.AddNewUserDict=[self.BackUpDict mutableCopy];
	NSLog(@" BackUpDict1 User ID %@",[self.BackUpDict  valueForKey:@"UserID"]);
	NSLog(@"User ID1 %@",[appDelegate.AddNewUserDict valueForKey:@"UserID"]);
	[Pool release];
	[self.navigationController popViewControllerAnimated:YES];
}

//// Called when Date changed in Picker
-(IBAction)DateChanged:(id)sender
{
	[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy"];
	[BtnSelected setTitle:[NSString stringWithFormat:@"  %@",[appDelegate.DateFormatter stringFromDate:DatePicker.date]] forState:UIControlStateNormal];
	[appDelegate.AddNewUserDict setValue:[appDelegate.DateFormatter stringFromDate:DatePicker.date] forKey:@"DOB"];
}

//// //An event when user clicks on Done button.
-(IBAction)BtnDone_clicked:(id)sender
{
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	if(SelectedTag !=9) 
	{
		switch (SelectedTag) 
		{
			case 5: ///// For Gender
				strRestaurantType=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:[PickerView selectedRowInComponent:0]];
				[appDelegate.AddNewUserDict setValue:strRestaurantType forKey:@"Gender"];
				break;
			case 6: //// For Blood Group
				strRestaurantType=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:[PickerView selectedRowInComponent:0]];
				[appDelegate.AddNewUserDict setValue:strRestaurantType forKey:@"BloodGroup"];
				break;
			case 9: //// For DOB
				strRestaurantType=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:[PickerView selectedRowInComponent:0]];
				[appDelegate.AddNewUserDict setValue:strRestaurantType forKey:@"DOB"];
				break;
			case 10: //// For Diabetes
				strRestaurantType=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:[PickerView selectedRowInComponent:0]];
				[appDelegate.AddNewUserDict setValue:strRestaurantType forKey:@"Diabetes"];
				break;
			case 11: //// For Smoking
				strRestaurantType=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:[PickerView selectedRowInComponent:0]];
				if([strRestaurantType isEqualToString:@"Other"])
				{					
					if(!appDelegate.objUserTextEntryViewController)
					{
						appDelegate.objUserTextEntryViewController=[[UserTextEntryViewController alloc]initWithNibName:@"TextEntry" bundle:nil];
					}
					appDelegate.objUserTextEntryViewController.selectedIndex=11;
					
					appDelegate.objUserTextEntryViewController.selectedName=@"Smoking";
					BOOL Check=[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] containsObject:[appDelegate.AddNewUserDict valueForKey:@"Smoking"]];
					if(Check)
					{
						appDelegate.objUserTextEntryViewController.TextData=@"";	
					}
					else
						appDelegate.objUserTextEntryViewController.TextData=[appDelegate.AddNewUserDict valueForKey:@"Smoking"];
					[self.navigationController pushViewController:appDelegate.objUserTextEntryViewController animated:YES];
				}
				else
					[appDelegate.AddNewUserDict setValue:strRestaurantType forKey:@"Smoking"];
				break;
			case 12: ///// For Drinking
				strRestaurantType=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:[PickerView selectedRowInComponent:0]];
				if([strRestaurantType isEqualToString:@"Other"])
				{
					if(!appDelegate.objUserTextEntryViewController)
					{
						appDelegate.objUserTextEntryViewController=[[UserTextEntryViewController alloc]initWithNibName:@"TextEntry" bundle:nil];
					}
					appDelegate.objUserTextEntryViewController.selectedIndex=12;
					
					appDelegate.objUserTextEntryViewController.selectedName=@"Drinking";
					BOOL Check=[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] containsObject:[appDelegate.AddNewUserDict valueForKey:@"Drinking"]];
					if(Check)
					{
						appDelegate.objUserTextEntryViewController.TextData=@"";	
					}
					else
						appDelegate.objUserTextEntryViewController.TextData=[appDelegate.AddNewUserDict valueForKey:@"Drinking"];
					[self.navigationController pushViewController:appDelegate.objUserTextEntryViewController animated:YES];
				}
				else
					[appDelegate.AddNewUserDict setValue:strRestaurantType forKey:@"Drinking"];
				break;
			case 13: /// For Drug in take
				strRestaurantType=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:[PickerView selectedRowInComponent:0]];
				[appDelegate.AddNewUserDict setValue:strRestaurantType forKey:@"Drug"];
				break;
			default:
				break;
		}
	}
	else
	{
		[self DateChanged:nil];
		
	}
	PickerView.hidden=TRUE;
	ToolBar.hidden=TRUE;
	DatePicker.hidden=TRUE;
	[tblView reloadData];
	btnSave.enabled=TRUE;
	[Pool release];
}

/////// //An event when user clicks on Save button.
-(IBAction)btnSave_clicked:(id)sender
{
	ISFromSave=1;	
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	PickerView.hidden=TRUE;
	DatePicker.hidden=TRUE;
	ToolBar.hidden=TRUE;
	if(self.SelectedIndexRow!=2 && self.SelectedIndexRow!=3) //// when insert or update Personal Info and Medical History
	{
		if([[appDelegate.AddNewUserDict valueForKey:@"UserName"] length]>0 )
		{
			int insert;
			if([[appDelegate.AddNewUserDict valueForKey:@"UserID"]intValue] == 0)
			{
				insert= [appDelegate InsertUser:appDelegate.AddNewUserDict];
				[appDelegate.AddNewUserDict setValue:[NSString stringWithFormat:@"%d",insert]  forKey:@"UserID"];
				[appDelegate DeleteAllCategoriesData:@"Past_Record"  IDname:@"User_ID" DeleteID:[[appDelegate.AddNewUserDict valueForKey:@"UserID"]intValue]];
				[[NSUserDefaults standardUserDefaults] setValue:@"" forKey:[NSString stringWithFormat:@"%d_WeightLbs",insert]];
				[[NSUserDefaults standardUserDefaults] synchronize];
				
				[[NSUserDefaults standardUserDefaults] setValue:@"" forKey:[NSString stringWithFormat:@"%d_WeightKgs",insert]];
				[[NSUserDefaults standardUserDefaults] synchronize];
				
				
				[[NSUserDefaults standardUserDefaults] setValue:@"" forKey:[NSString stringWithFormat:@"%d_HeightFeet",insert]];
				[[NSUserDefaults standardUserDefaults] synchronize];
				
				[[NSUserDefaults standardUserDefaults] setValue:@"" forKey:[NSString stringWithFormat:@"%d_HeightCms",insert]];
				[[NSUserDefaults standardUserDefaults] synchronize];
				
				[appDelegate InsertUserSettings_Data:insert]; 
			}
			else
			{
				insert=[appDelegate UpdateUser:appDelegate.AddNewUserDict];
				[appDelegate DeleteAllCategoriesData:@"Past_Record"  IDname:@"User_ID" DeleteID:[[appDelegate.AddNewUserDict valueForKey:@"UserID"]intValue]];
				if([[appDelegate.AddNewUserDict valueForKey:@"Past"]length]>0)
				{
					NSArray *arr=[[appDelegate.AddNewUserDict valueForKey:@"Past"] componentsSeparatedByString:@", "];
					NSArray *arr1=[[appDelegate.AddNewUserDict valueForKey:@"PastID"] componentsSeparatedByString:@", "];
					for(int i=0;i<[arr count];i++)
					{
						[appDelegate insertPastRecord:[arr objectAtIndex:i] :[[appDelegate.AddNewUserDict valueForKey:@"UserID"]intValue] :[[arr1 objectAtIndex:i]intValue]];
					}
				}

			}
			if(insert>0)
			{
				[appDelegate SelectsUsers];
				if([appDelegate.UserArray count]==0 || [appDelegate.UserArray count]==1)
				{
					appDelegate.SelectedUserID=[[appDelegate.AddNewUserDict objectForKey:@"UserID"]intValue]; 
					[appDelegate.AddNewUserDict setValue:@"1"  forKey:@"Default"];
					[appDelegate DefaultSet:[[appDelegate.AddNewUserDict objectForKey:@"UserID"]intValue]];
				}
				if([[appDelegate.AddNewUserDict valueForKey:@"Default"]intValue] == 1)
				{				
					appDelegate.SelectedUserID=[[appDelegate.AddNewUserDict objectForKey:@"UserID"]intValue]; 
					[appDelegate UpdateDefaultUser: [[appDelegate.AddNewUserDict valueForKey:@"UserID"]intValue]];
				}
				self.BackUpDict=[appDelegate.AddNewUserDict mutableCopy];
				[self.navigationController popViewControllerAnimated:YES];
			}
			else
			{
				UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alertView show];
				[alertView release];
			}
		}
		else
		{		
			NSString *nfield=@"\n";
			UIButton *btn=[[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
			btn.enabled=FALSE;
			UILabel *lblData1=[[UILabel alloc]init];
			btn.frame=CGRectMake(9, 43, 265, 30);
			lblData1.frame=CGRectMake(10, 0, 240, 27);
			lblData1.text=@"- Name";		
			lblData1.numberOfLines=0;
			lblData1.textAlignment=UITextAlignmentLeft;
			[btn addSubview:lblData1];
			UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Required field" message:nfield delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alertView addSubview:btn];
			[lblData1 release];
			[btn release];
			[alertView show];
			[alertView release];
		}
	}
	else
	{
		if(self.SelectedIndexRow==2) //// Called when it is Health Provider
		{
			if([[appDelegate.DetailDIC valueForKey:@"PastPhoneNumber"] length]>0 || [[appDelegate.DetailDIC objectForKey:@"PastName"] length]>0)
			{
				if([[appDelegate.DetailDIC valueForKey:@"Pk_ID"]intValue] == 0)
				{
					[appDelegate insertHealthCare:[appDelegate.DetailDIC objectForKey:@"PastName"] :[appDelegate.DetailDIC valueForKey:@"PastPhoneNumber"] :[[appDelegate.DetailDIC valueForKey:@"User_id"]intValue]];
				}
				else
				{
					[appDelegate UpdateHealthCare:[appDelegate.DetailDIC objectForKey:@"PastName"] :[appDelegate.DetailDIC valueForKey:@"PastPhoneNumber"] :[[appDelegate.DetailDIC valueForKey:@"User_id"]intValue] :[[appDelegate.DetailDIC valueForKey:@"Pk_ID"]intValue]];
				}
				self.BackUpDict=[appDelegate.AddNewUserDict mutableCopy];
				[self.navigationController popViewControllerAnimated:YES];
			}
			else
			{
				UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter the data in at least one field!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alert1 show];
				[alert1 release];
			}
		}
		else  //// Called when it is Insurance
		{
			if([[appDelegate.DetailDIC valueForKey:@"PastPolicyNo"] length]>0 || [[appDelegate.DetailDIC objectForKey:@"PastIdentification"] length]>0 || [[appDelegate.DetailDIC objectForKey:@"PastPhone"] length]>0 || [[appDelegate.DetailDIC objectForKey:@"PastEmrContact"] length]>0)
			{
				if([[appDelegate.DetailDIC valueForKey:@"Pk_ID"]intValue] == 0)
				{
					[appDelegate insertInsurance:[appDelegate.DetailDIC objectForKey:@"PastIdentification"] :[appDelegate.DetailDIC valueForKey:@"PastPhone"] :[[appDelegate.DetailDIC valueForKey:@"User_id"]intValue] :[appDelegate.DetailDIC valueForKey:@"PastEmrContact"] :[appDelegate.DetailDIC valueForKey:@"PastPolicyNo"]];
				}
				else
				{
					[appDelegate UpdateInsurance:[appDelegate.DetailDIC objectForKey:@"PastIdentification"] :[appDelegate.DetailDIC valueForKey:@"PastPhone"] :[[appDelegate.DetailDIC valueForKey:@"User_id"]intValue] :[appDelegate.DetailDIC valueForKey:@"PastEmrContact"] :[appDelegate.DetailDIC valueForKey:@"PastPolicyNo"] :[[appDelegate.DetailDIC valueForKey:@"Pk_ID"]intValue]];					
				}
				self.BackUpDict=[appDelegate.AddNewUserDict mutableCopy];
				[self.navigationController popViewControllerAnimated:YES];
			}
			else
			{
				UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter the data in at least one field!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alert1 show];
				[alert1 release];
			}
		}
	}
	[Pool release];
}

///// Called when User will pressed Default button
-(IBAction)ClickedDeafult:(id)sender
{
	UISwitch *switchCon=(UISwitch *)sender;
	
	if(switchCon.on==NO)
	{
		[appDelegate.AddNewUserDict setObject:@"0"  forKey:@"Default"];
	}
	else
	{
		[appDelegate.AddNewUserDict setObject:@"1"  forKey:@"Default"];
	}
}

// Called when User will Pressed Male/Female Button 

-(IBAction)MaleFemale:(id)sender
{
	UISegmentedControl *switchCon=(UISegmentedControl *)sender;
	if(switchCon.selectedSegmentIndex==0)
	{
		[appDelegate.AddNewUserDict setValue:@"Male"  forKey:@"Gender"];
	}
	else
	{
		[appDelegate.AddNewUserDict setValue:@"Female"  forKey:@"Gender"];
	}
}

//An event when user clicks on Is Kid Toogle button.
-(IBAction)Clicked:(id)sender
{
	UISwitch *switchCon=(UISwitch *)sender;
	if(switchCon.tag==13) //// For Drug Intake
	{
		if(switchCon.on==NO)
		{
			[appDelegate.AddNewUserDict setValue:@"0"  forKey:@"Drug"];
		}
		else
		{
			[appDelegate.AddNewUserDict setValue:@"1"  forKey:@"Drug"];
		}
	}
	else //// For Diabetes
	{
		if(switchCon.on==NO)
		{
			[appDelegate.AddNewUserDict setValue:@"0"  forKey:@"Diabetes"];
		}
		else
		{
			[appDelegate.AddNewUserDict setValue:@"1"  forKey:@"Diabetes"];
		}
	}
	[tblView reloadData];
}

//// Call when click on any cell which contain picker.

-(IBAction)ClickButton:(id)sender
{
	//(@"Add 1");
	BtnSelected=(UIButton *)sender;
	SelectedTag=BtnSelected.tag;
	DatePicker.hidden=TRUE;
	PickerView.hidden=TRUE;
	ToolBar.hidden=TRUE;
	btnSave.enabled=FALSE; 
	//// Here used tag for load picker Value
	// 6 - Boold group
	/// 9 - DOB
	/// 11 - Smoking
	///12 - Drinking
	
	if(SelectedTag!=9) 
	{
		PickerView.hidden=FALSE;
		ToolBar.hidden=FALSE;
		[PickerView reloadAllComponents];
	}
	if(SelectedTag==6)
	{
		lblData.text=@"Select Blood Group";
		int row=[self GetPickerRow:[appDelegate.AddNewUserDict valueForKey:@"BloodGroup"] component:SelectedTag];
		[PickerView selectRow:row inComponent:0 animated:NO];
	}
	if(SelectedTag==9)
	{
		DatePicker.hidden=FALSE;
		if([[appDelegate.AddNewUserDict valueForKey:@"DOB"] length]==0)
		{
			[DatePicker setDate:[NSDate date] animated:NO];
		}
		else
		{
			[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy"];
			[DatePicker setDate:[appDelegate.DateFormatter dateFromString:[appDelegate.AddNewUserDict valueForKey:@"DOB"] ]];
			
		}
		ToolBar.hidden=FALSE;
		lblData.text=@"Select DOB";
	}
	if(SelectedTag==11)
	{
		lblData.text=@"Select Smoking";
		int row;
		if([[appDelegate.AddNewUserDict valueForKey:@"Smoking"] length]==0)
		{
			row=0;
		}
		else
		{
			BOOL Check=[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] containsObject:[appDelegate.AddNewUserDict valueForKey:@"Smoking"]];
			if(Check)
				row=[self GetPickerRow:[appDelegate.AddNewUserDict valueForKey:@"Smoking"] component:SelectedTag];
			else
				row=3;
		}
		[PickerView selectRow:row inComponent:0 animated:NO];
	}
	if(SelectedTag==12)
	{
		lblData.text=@"Select Drinking";
		int row;
		if([[appDelegate.AddNewUserDict valueForKey:@"Drinking"] length]==0)
		{
			row=0;
		}
		else
		{
			BOOL Check=[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] containsObject:[appDelegate.AddNewUserDict valueForKey:@"Drinking"]];
			if(Check)
				row=[self GetPickerRow:[appDelegate.AddNewUserDict valueForKey:@"Drinking"] component:SelectedTag];
			else
				row=4;
			
		}
		[PickerView selectRow:row inComponent:0 animated:NO];
	}
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

#pragma mark AlertView Delegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(alertView.tag==1)
	{
		[self.navigationController popViewControllerAnimated:YES];
	}
}

#pragma mark Table view methods
/// Return Height Base on text
-(CGFloat)findHeightForCell:(NSString *)text
{
	CGFloat		result = 40.0f;
	CGFloat		width = 0;
	if(SelectedIndexRow==3)
	{
		width=132;
	}
	else
		width = 175;
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
	if(SelectedIndexRow==0)
	{
		if(indexPath.row==0)
		{
			return [self findHeightForCell:[appDelegate.AddNewUserDict valueForKey:@"UserName"]]; 
		}
		else
		{
			return 40;
		}
	}
	else if(SelectedIndexRow==1)
	{
		if(indexPath.row==4)
		{
			return [self findHeightForCell:[appDelegate.AddNewUserDict valueForKey:@"Past"]]; 
		}
		else
		{
			return 40;
		}
	}
	else if(SelectedIndexRow==2)
	{
		if(indexPath.row==0)
		{
			return [self findHeightForCell:[appDelegate.AddNewUserDict objectForKey:@"PastName"]]; 
		}
		else
		{
			return [self findHeightForCell:[appDelegate.AddNewUserDict objectForKey:@"PastPhoneNumber"]]; 
		}
	}
	else if(SelectedIndexRow==3)
	{
		if(indexPath.row==0)
		{
			return [self findHeightForCell:[appDelegate.AddNewUserDict objectForKey:@"PastIdentification"]]; 
		}
		else if(indexPath.row==1)
		{
			return [self findHeightForCell:[appDelegate.AddNewUserDict objectForKey:@"PastPolicyNo"]]; 
		}
		else if(indexPath.row==2)
		{
			return [self findHeightForCell:[appDelegate.AddNewUserDict objectForKey:@"PastPhone"]]; 
		}
		else if(indexPath.row==3)
		{
			return [self findHeightForCell:[appDelegate.AddNewUserDict objectForKey:@"PastEmrContact"]]; 
		}
	}	
	return 40;	
}

// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	if(SelectedIndexRow==0)
	{
		if([appDelegate.UserStatus isEqualToString:@"User Profile"] && appDelegate.iSfromUsers==FALSE)
		{
			return 4;
		}
		else
			return 5;
	}
	else if(SelectedIndexRow==1)
	{
		return 5;
	}
	else if(SelectedIndexRow==2)
	{
		return 2;
	}
	else if(SelectedIndexRow==3)
	{
		return 4;
	}
	return 0;	
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.SelectedIndexRow==0)
	{		
		///// For Personal Info
		static NSString *CellIdentifier1 = @"Cell1";
		static NSString *CellIdentifier = @"Cell";
		static NSString *CellIdentifier4 = @"Cell4";
		static NSString *CellIdentifier6 = @"Cell6";
		AddNewUserTableCell *cell1;
		AddUserButtonTableViewCell *cell;
		AddUserSegmentTableCell  *cell4;
		NewSwitchTableViewCell *cell6; 		
		switch (indexPath.row)
		{
			case 0:
				cell1 = (AddNewUserTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
				if (cell1 == nil) {
					cell1 = [[[AddNewUserTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier1] autorelease];
				}
				cell1.lblName.text=@"Name";
				cell1.txtDeatils.text=[appDelegate.AddNewUserDict valueForKey:@"UserName"];
				cell1.btnCall.hidden=TRUE;
				cell1.txtDeatils.tag=1;
				
				cell1.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
				return cell1;
				
			case 1:
				cell = (AddUserButtonTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
				if (cell == nil) {
					cell = [[[AddUserButtonTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
					[cell.BtnSelect addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
				}
				
				
				cell.lblName.text=@"Date of Birth";
				if([[appDelegate.AddNewUserDict valueForKey:@"DOB"] length]==0)
					[cell.BtnSelect setTitle:@"  Please Choose"  forState:UIControlStateNormal];
				else
					[cell.BtnSelect setTitle:[NSString stringWithFormat:@"  %@",[appDelegate.AddNewUserDict valueForKey:@"DOB"]] forState:UIControlStateNormal];
				cell.BtnSelect.tag=9;
				return cell;
				
			case 2:
				cell4 = (AddUserSegmentTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
				if (cell4 == nil) {
					cell4 = [[[AddUserSegmentTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier4] autorelease];
					[cell4.BtnSelect  addTarget:self action:@selector(MaleFemale:) forControlEvents:UIControlEventValueChanged];
				}
				
				
				cell4.lblName.text=@"Gender";
				cell4.BtnSelect.tag=5;
				[cell4.BtnSelect setTitle:@"Male"  forSegmentAtIndex:0];
				
				[cell4.BtnSelect setTitle:@"Female"  forSegmentAtIndex:1];
				
				if([[appDelegate.AddNewUserDict valueForKey:@"Gender"] length]==4)
					cell4.BtnSelect.selectedSegmentIndex=0;
				else
					cell4.BtnSelect.selectedSegmentIndex=1;
				return cell4;
			case 3:
				cell = (AddUserButtonTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
				if (cell == nil) {
					cell = [[[AddUserButtonTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
					[cell.BtnSelect addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
				}
				
				
				cell.lblName.text=@"Blood Group";
				if([[appDelegate.AddNewUserDict valueForKey:@"BloodGroup"] length]==0)
					[cell.BtnSelect setTitle:@"  Please Choose"  forState:UIControlStateNormal];
				else
					[cell.BtnSelect setTitle:[NSString stringWithFormat:@"  %@",[appDelegate.AddNewUserDict valueForKey:@"BloodGroup"]] forState:UIControlStateNormal];
				cell.BtnSelect.tag=6;
				return cell;
			case 4:
				cell6 = (NewSwitchTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier6];
				if (cell6 == nil) {
					cell6 = [[[NewSwitchTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier6] autorelease];
					[cell6.SwIsKid addTarget:self action:@selector(ClickedDeafult:) forControlEvents:UIControlEventValueChanged];
				}
				
				
				cell6.lblName.text=@"Default User?";
				if([[appDelegate.AddNewUserDict valueForKey:@"Default"] intValue]==0)
					[cell6.SwIsKid setOn:FALSE];
				else
					[cell6.SwIsKid setOn:TRUE];
				cell6.SwIsKid.tag=20;
				return cell6;
			default:
				break;
		}
	}
	else if(self.SelectedIndexRow==1)
	{
		//// For Medical Information
		
		static NSString *CellIdentifier2 = @"Cell2";
		static NSString *CellIdentifier5 = @"Cell5";
		static NSString *CellIdentifier9 = @"Cell9";
		AddUserButtonTableViewCell *cell2;
		NewSwitchTableViewCell *cell5; 		
		AddNewUserTableCell *cell9;
		switch (indexPath.row) 
		{
			case 0:
				cell5 = (NewSwitchTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier5];
				if (cell5 == nil) {
					cell5 = [[[NewSwitchTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier5] autorelease];
					[cell5.SwIsKid addTarget:self action:@selector(Clicked:) forControlEvents:UIControlEventValueChanged];
				}
				cell5.lblName.text=@"Diabetes";
				if([[appDelegate.AddNewUserDict valueForKey:@"Diabetes"] intValue]==0)
					[cell5.SwIsKid setOn:FALSE];
				else
					[cell5.SwIsKid setOn:TRUE];
				cell5.SwIsKid.tag=10;
				return cell5;
			case 1:
				cell2 = (AddUserButtonTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
				if (cell2 == nil) {
					cell2 = [[[AddUserButtonTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier2] autorelease];
					[cell2.BtnSelect addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
				}
				
				
				cell2.lblName.text=@"Smoking";
				if([[appDelegate.AddNewUserDict valueForKey:@"Smoking"] length]==0)
					[cell2.BtnSelect setTitle:@"  Please Choose"  forState:UIControlStateNormal];
				else
					[cell2.BtnSelect setTitle:[NSString stringWithFormat:@"  %@",[appDelegate.AddNewUserDict valueForKey:@"Smoking"]] forState:UIControlStateNormal];
				cell2.BtnSelect.tag=11;
				return cell2;
			case 2:
				cell2 = (AddUserButtonTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
				if (cell2 == nil) {
					cell2 = [[[AddUserButtonTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier2] autorelease];
					[cell2.BtnSelect addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
				}
				
				
				cell2.lblName.text=@"Drinking";
				if([[appDelegate.AddNewUserDict valueForKey:@"Drinking"] length]==0)
					[cell2.BtnSelect setTitle:@"  Please Choose"  forState:UIControlStateNormal];
				else
					[cell2.BtnSelect setTitle:[NSString stringWithFormat:@"  %@",[appDelegate.AddNewUserDict valueForKey:@"Drinking"]] forState:UIControlStateNormal];
				cell2.BtnSelect.tag=12;
				return cell2;
			case 3:
				cell5 = (NewSwitchTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier5];
				if (cell5 == nil) {
					cell5 = [[[NewSwitchTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier5] autorelease];
					[cell5.SwIsKid addTarget:self action:@selector(Clicked:) forControlEvents:UIControlEventValueChanged];
				}
				cell5.lblName.text=@"Drug Intake";
				if([[appDelegate.AddNewUserDict valueForKey:@"Drug"] intValue]==0)
					[cell5.SwIsKid setOn:FALSE];
				else
					[cell5.SwIsKid setOn:TRUE];
				cell5.SwIsKid.tag=13;
				return cell5;
			case 4:
				cell9 = (AddNewUserTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier9];
				if (cell9 == nil) {
					cell9 = [[[AddNewUserTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier9] autorelease];
				}
				cell9.lblName.text=@"Past";
				cell9.txtDeatils.text=[appDelegate.AddNewUserDict valueForKey:@"Past"];
				cell9.btnCall.hidden=TRUE;
				cell9.txtDeatils.tag=14;				
				cell9.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
				return cell9;				
		}
	}
	else if(self.SelectedIndexRow==2)
	{
		//// For Health Care Providers
		
		static NSString *CellIdentifier7 = @"Cell7";
		
		AddNewUserTableCell *cell7 = (AddNewUserTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier7];
		if (cell7 == nil) {
			cell7 = [[[AddNewUserTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier7] autorelease];
			[cell7.btnCall addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
		}
		cell7.btnCall.hidden=TRUE;
		switch (indexPath.row) {
			case 0:
				cell7.lblName.text=@"Name";
				cell7.txtDeatils.text=[appDelegate.DetailDIC valueForKey:@"PastName"];
				cell7.txtDeatils.tag=16;
				break;
			case 1:
				cell7.lblName.text=@"Phone Number";
				cell7.txtDeatils.text=[self numberFormate:@"" :@"PastPhoneNumber"];
				cell7.txtDeatils.tag=17;
				cell7.btnCall.hidden=FALSE;
				cell7.btnCall.tag=1;
				break;
			default:
				break;
		}
		cell7.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
		return cell7;
	}
	else if(self.SelectedIndexRow==3)
	{
		//// For Insurance Information
		
		static NSString *CellIdentifier8= @"Cell8";
		
		DailyStatusTableViewCell *cell8 = (DailyStatusTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier8];
		if (cell8 == nil) {
			cell8 = [[[DailyStatusTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier8] autorelease];
			[cell8.btnCall addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
		}
		cell8.btnCall.hidden=TRUE;
		cell8.btnCall.tag=indexPath.row;
		switch (indexPath.row) {
			case 0:
				cell8.lblName.text=@"Identification";
				cell8.lblNameTwo.text=[appDelegate.DetailDIC valueForKey:@"PastIdentification"];
				cell8.lblNameTwo.tag=18;
				break;
			case 1:
				cell8.lblName.text=@"Policy Number";
				cell8.lblNameTwo.text=[appDelegate.DetailDIC valueForKey:@"PastPolicyNo"];
				cell8.lblNameTwo.tag=19;
				break;
			case 2:
				cell8.lblName.text=@"Phone Number";
			//	cell8.lblNameTwo.text=[appDelegate.DetailDIC valueForKey:@"PastPhone"];
				cell8.lblNameTwo.text=[self numberFormate:@"" :@"PastPhone"];
				cell8.lblNameTwo.tag=20;
				cell8.btnCall.hidden=FALSE;
				break;
			case 3:
				cell8.lblName.text=@"Emergency Contact";
				//cell8.lblNameTwo.text=[appDelegate.DetailDIC valueForKey:@"PastEmrContact"];
				cell8.lblNameTwo.text=[self numberFormate:@"" :@"PastEmrContact"];
				cell8.lblNameTwo.tag=21;
				cell8.btnCall.hidden=FALSE;
				break;
			default:
				break;
		}
		cell8.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
		return cell8;
		
	}
	return @"";
}

-(IBAction)call:(id)sender
{
	int tag=((UIButton*)sender).tag;
	NSString *phoneNumber=@"";
	if(tag==1)
	{
		phoneNumber=[appDelegate.DetailDIC valueForKey:@"PastPhoneNumber"];
	}
	else if(tag==2)
	{
		phoneNumber=[appDelegate.DetailDIC valueForKey:@"PastPhone"];
	}
	else if(tag==3)
	{
		phoneNumber=[appDelegate.DetailDIC valueForKey:@"PastEmrContact"];
	}
	if([phoneNumber length]==0)
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter number first." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else
	{
		NSString *telno1 =[phoneNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
		NSString *telno2 =[telno1 stringByReplacingOccurrencesOfString:@")" withString:@""];
		telno1 =[telno2 stringByReplacingOccurrencesOfString:@"-" withString:@""];
		telno2 =[telno1 stringByReplacingOccurrencesOfString:@" " withString:@""];
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",telno2]]];
	}
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[tblView deselectRowAtIndexPath:indexPath animated:YES];
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	ISFromSave=2;
	appDelegate.SelectedStatus=@"Users"; 
	if(SelectedIndexRow==0)
	{
		//// For Personal Information
		if(indexPath.row==0)
		{
			AddNewUserTableCell *cell=(AddNewUserTableCell *)[tableView cellForRowAtIndexPath:indexPath];
			if(!appDelegate.objUserTextEntryViewController)
			{
				appDelegate.objUserTextEntryViewController=[[UserTextEntryViewController alloc]initWithNibName:@"TextEntry" bundle:nil];
			}
			appDelegate.objUserTextEntryViewController.selectedIndex=cell.txtDeatils.tag;
			appDelegate.objUserTextEntryViewController.selectedName=cell.lblName.text;
			appDelegate.objUserTextEntryViewController.TextData=cell.txtDeatils.text;
			[self.navigationController pushViewController:appDelegate.objUserTextEntryViewController animated:YES];
		}
	}
	else if(SelectedIndexRow==1)
	{
		//// For Medical History
		if(indexPath.row==4)
		{
			NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
			if(!appDelegate.objSelectOptionsViewController)
			{
				appDelegate.objSelectOptionsViewController=[[SelectOptionsViewController alloc]initWithNibName:@"SelectOptions" bundle:nil];
			}
			appDelegate.isfromFavourite=TRUE;
			appDelegate.DailyTag=14; 
			appDelegate.objSelectOptionsViewController.NavText=@"Past";
			appDelegate.SelectedStatus=@"Hourly";
			
			appDelegate.IsFromMedicine=FALSE;
			
			[self.navigationController pushViewController:appDelegate.objSelectOptionsViewController animated:YES];
			[Pool release];		
			
		}
	}
	else if(SelectedIndexRow==2)
	{		
		//// For Health Care
		AddNewUserTableCell  *cell=(AddNewUserTableCell *)[tableView cellForRowAtIndexPath:indexPath];
		if(!appDelegate.objUserTextEntryViewController)
		{
			appDelegate.objUserTextEntryViewController=[[UserTextEntryViewController alloc]initWithNibName:@"TextEntry" bundle:nil];
		}
		appDelegate.objUserTextEntryViewController.selectedIndex=cell.txtDeatils.tag;
		NSString *Data=cell.lblName.text;
		Data=[Data stringByReplacingOccurrencesOfString:@"Number" withString:@"No."];
		appDelegate.objUserTextEntryViewController.selectedName=Data;
		if(indexPath.row==1)
		{
			appDelegate.objUserTextEntryViewController.TextData=[appDelegate.DetailDIC valueForKey:@"PastPhoneNumber"];
		}
		else
			appDelegate.objUserTextEntryViewController.TextData=cell.txtDeatils.text;
		[self.navigationController pushViewController:appDelegate.objUserTextEntryViewController animated:YES];
	}
	else if(SelectedIndexRow==3)
	{		
		//// For Insurance
		DailyStatusTableViewCell *cell=(DailyStatusTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
		if(!appDelegate.objUserTextEntryViewController)
		{
			appDelegate.objUserTextEntryViewController=[[UserTextEntryViewController alloc]initWithNibName:@"TextEntry" bundle:nil];
		}
		appDelegate.objUserTextEntryViewController.selectedIndex=cell.lblNameTwo.tag;
		NSString *Data=cell.lblName.text;
		Data=[Data stringByReplacingOccurrencesOfString:@"Number" withString:@"No."];
		appDelegate.objUserTextEntryViewController.selectedName=Data;
		if(indexPath.row==2)
		{
			appDelegate.objUserTextEntryViewController.TextData=[appDelegate.DetailDIC valueForKey:@"PastPhone"];
		}
		else if(indexPath.row==3)
		{
			appDelegate.objUserTextEntryViewController.TextData=[appDelegate.DetailDIC valueForKey:@"PastEmrContact"];
		}
		else
			appDelegate.objUserTextEntryViewController.TextData=cell.lblNameTwo.text;
		[self.navigationController pushViewController:appDelegate.objUserTextEntryViewController animated:YES];
	}
	[Pool release];
}

-(NSString*)numberFormate:(NSString*)pHoneNumber :(NSString*)valueForKey
{
	if([[appDelegate.DetailDIC valueForKey:valueForKey] length]==10)
	{
		NSRange range;
		range.length=3;
		range.location=0;
		NSString *Value=[[NSString stringWithFormat:@"%@",[appDelegate.DetailDIC valueForKey:valueForKey]]substringWithRange:range];
		NSMutableArray *PhoneArray=[[NSMutableArray alloc]init];
		[PhoneArray addObject:Value];
		range.length=3;
		range.location=3;
		Value=[[NSString stringWithFormat:@"%@",[appDelegate.DetailDIC valueForKey:valueForKey]]substringWithRange:range];
		[PhoneArray addObject:Value];
		range.length=4;
		range.location=6;
		Value=[[NSString stringWithFormat:@"%@",[appDelegate.DetailDIC valueForKey:valueForKey]]substringWithRange:range];
		[PhoneArray addObject:Value];
		Value=[NSString stringWithFormat:@"%@-%@-%@",[PhoneArray objectAtIndex:0],[PhoneArray objectAtIndex:1],[PhoneArray objectAtIndex:2]];
		[PhoneArray release];
		return Value;
	}
	else if ([[appDelegate.DetailDIC valueForKey:valueForKey] length]==11)
	{
		NSRange range;
		range.length=1;
		range.location=0;
		NSString *Value=[[NSString stringWithFormat:@"%@",[appDelegate.DetailDIC valueForKey:valueForKey]]substringWithRange:range];
		NSMutableArray *PhoneArray=[[NSMutableArray alloc]init];
		[PhoneArray addObject:Value];
		range.length=3;
		range.location=1;
		Value=[[NSString stringWithFormat:@"%@",[appDelegate.DetailDIC valueForKey:valueForKey]]substringWithRange:range];
		[PhoneArray addObject:Value];
		range.length=3;
		range.location=4;
		Value=[[NSString stringWithFormat:@"%@",[appDelegate.DetailDIC valueForKey:valueForKey]]substringWithRange:range];
		[PhoneArray addObject:Value];
		range.length=4;
		range.location=7;
		Value=[[NSString stringWithFormat:@"%@",[appDelegate.DetailDIC valueForKey:valueForKey]]substringWithRange:range];
		[PhoneArray addObject:Value];
		Value=[NSString stringWithFormat:@"%@-%@-%@-%@",[PhoneArray objectAtIndex:0],[PhoneArray objectAtIndex:1],[PhoneArray objectAtIndex:2],[PhoneArray objectAtIndex:3]];
		[PhoneArray release];
		 return Value;
	}
	else
	{
		 return [appDelegate.DetailDIC valueForKey:valueForKey];
	}
	return @"";
}

#pragma mark pickerView

//// set Picker Selector as per seleted value... 

-(int)GetPickerRow:(NSString *)String component:(NSInteger)Tag
{
	NSString *str2;
	
	str2=String;
	
	NSMutableArray *abc=[data valueForKey:[NSString stringWithFormat:@"%d",Tag]];
	int Row=0;
	for(Row=0; Row<[abc count];Row++)
	{
		NSString *str1=[abc objectAtIndex:Row];
		
		if([str1 isEqualToString:str2])
		{
			
			return Row;
		}
	}
	return 0;
}

// returns width of column and height of row for each component. 

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	CGFloat componentWidth;
	
		componentWidth=240.0;
	// second column is narrower to show numbers
	return componentWidth;
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pV
{
	return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pV numberOfRowsInComponent:(NSInteger)component
{	
	return [[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] count];
}

// these methods return either a plain UIString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse. 
// If you return back a different object, the old one will be released. the view will be centered in the row rect  

- (NSString *)pickerView:(UIPickerView *)pV titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSString *strRestaurantType1=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",SelectedTag]] objectAtIndex:row];
	return strRestaurantType1;
}


- (void)didReceiveMemoryWarning 
{	
	
	//UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Memory" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	//	//alert.tag=5;
	//	[alert show];
	//	[alert release];
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc 
{	
	[tblView release];
	[PickerView release];
	[data release];	
	[SelectedText release];
	[BtnSelected release];
	[BtnDone release];
	[btnSave release];
	[DatePicker release];
	[ToolBar release];
	[appDelegate release];
	[lblData release];
	//	[UserTextEntryView release];
    [super dealloc];
}



@end
