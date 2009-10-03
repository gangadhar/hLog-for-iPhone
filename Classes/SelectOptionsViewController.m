//
//  SelectOptionsViewController.m
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
#import "SelectOptionsViewController.h"
#import "SettingTableViewCell.h"
#import "User_Settings.h"
#import "AddUserButtonTableViewCell.h"

@implementation SelectOptionsViewController

// Fields or variables or tools whose property has been declared must be Synthesize here...
@synthesize NavText;

-(NSMutableArray *)FillArray:(int)i
{
	NSMutableArray *TypeArray;
	TypeArray=[[[NSMutableArray alloc]init]autorelease];
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	if(i==6)
	{		
		for(int i=0;i<=56;i=i+15)
		{
			[TypeArray addObject:[NSString stringWithFormat:@"%d",i]];
		}
	}	
	else if(i==7)
	{
		for(int i=0;i<60;i++)
		{
			[TypeArray addObject:[NSString stringWithFormat:@"%d",i]];
		}
	}	
	[Pool release];
	return TypeArray;
}

#pragma mark Button Click Methods

////////// Called whenuser will click on set DateTime Combo in Medicine
-(IBAction)ClickButton:(id)sender
{
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];	
	DatePicker.hidden=FALSE;
	ToolBar.hidden=FALSE;
	lblData.text=@"Select Date and Time";
	[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
	SelectedTag=0; 
	if([appDelegate.MedicineRef.EntryDate length]==0)
	{
		[DatePicker setDate:[NSDate date] animated:YES];
	}
	else
	{
		[DatePicker setDate:[appDelegate.DateFormatter dateFromString: [NSString stringWithFormat:@"%@ %@",appDelegate.MedicineRef.EntryDate,appDelegate.MedicineRef.EntryTime]]];
	}	
	[Pool release];
}

///// Save Medicine Deatils
-(void)SaveMedicineDetail:(int)Medicine_ID
{
	NSArray *array3=[appDelegate.UnitDictionary allKeys];
	for(int i=0;i<[array3 count];i++)
	{
		if([appDelegate.UnitDictionary objectForKey:[array3 objectAtIndex:i]]!=nil)
		{
			NSMutableDictionary *DIC=[[appDelegate.UnitDictionary objectForKey:[array3 objectAtIndex:i]]mutableCopy];			
			[DIC setValue:[NSString stringWithFormat:@"%d",Medicine_ID] forKey:@"Medicine_ID"];
			[DIC setValue:[NSString stringWithFormat:@"%@ %@",appDelegate.MedicineRef.EntryDate,appDelegate.MedicineRef.EntryTime] forKey:@"Entry_Date"];
			[appDelegate InsertMedicineDosageDetail:DIC];
			[DIC release];
		}
	}
}

//// Call when user will click on Edit Button
-(IBAction)btnEdit_Click:(id)sender
{
	if(ISEdit==TRUE)
	{
		ISEdit=FALSE;
		btnEdit.style=UIBarButtonItemStyleBordered;
		btnEdit.title=@"Edit ";
	}
	else
	{
		btnEdit.style=UIBarButtonItemStyleDone;
		btnEdit.title=@"Done";
		ISEdit=TRUE;
	}
	[tblView reloadData];
}

/// Called when user will in Past and Click Edit Button
-(IBAction)btnPastEdit_Click:(id)sender
{
	if(ISEdit==TRUE)
	{
		ISEdit=FALSE;
		btnPastEdit.style=UIBarButtonItemStyleBordered;
		btnPastEdit.title=@"Edit ";
	}
	else
	{
		btnPastEdit.style=UIBarButtonItemStyleDone;
		btnPastEdit.title=@"Done";
		ISEdit=TRUE;
	}
	[tblView reloadData];
}

///// Called when user will in Past and Click Add new Past Info
-(IBAction)btnPastAdd_Click:(id)sender
{
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	if(!appDelegate.objUserTextEntryViewController)
	{
		appDelegate.objUserTextEntryViewController=[[UserTextEntryViewController alloc]initWithNibName:@"TextEntry" bundle:nil];
	}
	[self BackUpdata];
	if(appDelegate.DailyTag==14)
	{
		appDelegate.SelectedStatus=@"Past";
		appDelegate.objUserTextEntryViewController.selectedIndex=14;
		appDelegate.objUserTextEntryViewController.selectedName=@"Past";	
		appDelegate.objUserTextEntryViewController.TextData=@"";
		appDelegate.objUserTextEntryViewController.MED_ID=0;
	}	
	appDelegate.isfromFavourite=FALSE;
	[self.navigationController pushViewController:appDelegate.objUserTextEntryViewController animated:YES];
	[Pool release];
	
}

//// Use for add new Medicine,Feeding,Mood,Dipering etc....
-(IBAction)btnMedidcine:(id)sender
{	
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	if(!appDelegate.objUserTextEntryViewController)
	{
		appDelegate.objUserTextEntryViewController=[[UserTextEntryViewController alloc]initWithNibName:@"TextEntry" bundle:nil];
	}
	[self BackUpdata];
	if(appDelegate.DailyTag==20)
	{
		appDelegate.SelectedStatus=@"Medicine";
		//appDelegate.objDailyHourlyTextEntryViewController.Vitals_Detailref=self.Vitals_Detailref;
		appDelegate.objUserTextEntryViewController.selectedIndex=20;
		appDelegate.objUserTextEntryViewController.selectedName=@"Medicine";
		appDelegate.objUserTextEntryViewController.TextData=@"";
		appDelegate.objUserTextEntryViewController.MED_ID=0;
	}
	else if(appDelegate.DailyTag==2)
	{
		appDelegate.SelectedStatus=@"Exercise";
		appDelegate.objUserTextEntryViewController.selectedIndex=2;
		appDelegate.objUserTextEntryViewController.selectedName=@"Exercise";
		appDelegate.objUserTextEntryViewController.TextData=@"";
		appDelegate.objUserTextEntryViewController.MED_ID=0;
	}
    else if(appDelegate.DailyTag==3)
	{
		appDelegate.SelectedStatus=@"Mood";
		appDelegate.objUserTextEntryViewController.selectedIndex=3;
		appDelegate.objUserTextEntryViewController.selectedName=@"Mood";
		appDelegate.objUserTextEntryViewController.TextData=@"";
		appDelegate.objUserTextEntryViewController.MED_ID=0;
	}
	else if(appDelegate.DailyTag==4)
	{
		appDelegate.SelectedStatus=@"Activity";
		//appDelegate.objDailyHourlyTextEntryViewController.Vitals_Detailref=self.Vitals_Detailref;
		appDelegate.objUserTextEntryViewController.selectedIndex=4;
		appDelegate.objUserTextEntryViewController.selectedName=@"Activity";
		appDelegate.objUserTextEntryViewController.TextData=@"";
		appDelegate.objUserTextEntryViewController.MED_ID=0;
	}
	else if(appDelegate.DailyTag==5)
	{
		appDelegate.SelectedStatus=@"Diapering";
		appDelegate.objUserTextEntryViewController.selectedIndex=5;
		appDelegate.objUserTextEntryViewController.selectedName=@"Diapering";
		appDelegate.objUserTextEntryViewController.TextData=@"";
		appDelegate.objUserTextEntryViewController.MED_ID=0;
	}
	else if(appDelegate.DailyTag==6)
	{
		appDelegate.SelectedStatus=@"Feeding";
		appDelegate.objUserTextEntryViewController.selectedIndex=6;
		appDelegate.objUserTextEntryViewController.selectedName=@"Food Consumed";
		appDelegate.objUserTextEntryViewController.TextData=@"";
		appDelegate.objUserTextEntryViewController.MED_ID=0;
	}
	else if(appDelegate.DailyTag==14)
	{
		appDelegate.SelectedStatus=@"Past";
		appDelegate.objUserTextEntryViewController.selectedIndex=14;
		appDelegate.objUserTextEntryViewController.selectedName=@"Past";	
		appDelegate.objUserTextEntryViewController.TextData=@"";
		appDelegate.objUserTextEntryViewController.MED_ID=0;
	}
	
	appDelegate.isfromFavourite=FALSE;
	[self.navigationController pushViewController:appDelegate.objUserTextEntryViewController animated:YES];
	[Pool release];
}

//// Called when user will click on cancel and Picker will open
-(IBAction)btnCancel_Clicked:(id)sender
{	
	tblView.userInteractionEnabled=TRUE;
	PickerView.hidden=TRUE;
	ToolBar.hidden=TRUE;
	DatePicker.hidden=TRUE;
	btnSave.enabled=TRUE;
}

/////// Use for store data which get from Picker
-(IBAction)btnDone_Clicked:(id)sender
{
	btnSave.enabled=TRUE;
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	tblView.userInteractionEnabled=TRUE;
	ToolBar.hidden=TRUE;
	PickerView.hidden=TRUE;
	DatePicker.hidden=TRUE;
	if(SelectedTag==0)
	{
		DatePicker.hidden=TRUE;
		ToolBar.hidden=TRUE;
		[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
		NSString *Date=[appDelegate.DateFormatter stringFromDate: DatePicker.date];
		array=[Date componentsSeparatedByString:@" "];
		NSString *DateTime=[array objectAtIndex:1];
		Date=[array objectAtIndex:0];
		if(!([Date isEqualToString:appDelegate.MedicineRef.EntryDate] && [DateTime isEqualToString:appDelegate.MedicineRef.EntryTime]))
		{
			NSArray *array2=[DateTime componentsSeparatedByString:@":"];
			NSString *Mins=[array2 objectAtIndex:1];
			DateTime=[NSString stringWithFormat:@"%@:%@",[array2 objectAtIndex:0],Mins];
			appDelegate.DailyTag=20;
			[appDelegate Medicinedata:Date  ToTime:DateTime anduserid:appDelegate.SelectedUserID]; 
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
				appDelegate.MedicineRef.EntryDate= Date;
				appDelegate.MedicineRef.EntryTime=DateTime;
				appDelegate. MedicineRef.UserID=appDelegate.SelectedUserID;
				appDelegate.SelectedItems=@"";
				[appDelegate.UnitDictionary removeAllObjects];
			}
			[self populateSelectedArray];
			[tblView reloadData];
		}
	}
	else
	{
		PickerView.hidden=TRUE;
		ToolBar.hidden=TRUE;
		NSString *strRestaurantTypeSecond=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",6]] objectAtIndex:[PickerView selectedRowInComponent:1]];
		NSString *strRestaurantType=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",7]] objectAtIndex:[PickerView selectedRowInComponent:0]];
		[ExerciseValueDictionary setValue:[NSString stringWithFormat:@"%@:%@",strRestaurantType,strRestaurantTypeSecond] forKey:[NSString stringWithFormat:@"%d",SelectedTag-1]];
		[tblView reloadData];
	}	
	[Pool release];	
}

-(IBAction)btnSettings_click:(id)sender
{	
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	if(!SelectMedicineSettings)
	{
		SelectMedicineSettings=[[SelectMedicineSettingsController alloc]initWithNibName:@"MedicineSettings" bundle:nil];
	}		
	if (SettingsCon == nil)
	{
		SettingsCon = [[UINavigationController alloc] initWithRootViewController:SelectMedicineSettings];
	}	
	User_Settings *Data=[appDelegate.UserSettingsArray objectAtIndex:0];
	if(appDelegate.DailyTag==20)
	{
		appDelegate.ReportField = Data.MedicineEntryDetail; 
	}
	else if(appDelegate.DailyTag==2)
	{
		appDelegate.ReportField = Data.ExerciseEntryDetail; 
	}
	else if(appDelegate.DailyTag==3)
	{
		appDelegate.ReportField = Data.MoodEntryDetail; 
	}
	else if(appDelegate.DailyTag==4)
	{
		appDelegate.ReportField = Data.ActivityEntryDetail; 
	}
	else if(appDelegate.DailyTag==5)
	{
		appDelegate.ReportField = Data.DiperingEntryDetail; 
	}
	else if(appDelegate.DailyTag==6)
	{
		appDelegate.ReportField = Data.FeedingEntryDetail; 
	}
	[self.navigationController presentModalViewController:SettingsCon animated:YES];
	[Pool release];
}

//An event when user clicks on Cancel button.
-(IBAction)Cancle:(id)sender
{
	ISEdit=FALSE;
	btnEdit.style=UIBarButtonItemStyleBordered;
	btnEdit.title=@"Edit ";
	btnPastEdit.style=UIBarButtonItemStyleBordered;
	btnPastEdit.title=@"Edit ";
	[SelectedText resignFirstResponder];
	[ExerciseValueDictionary removeAllObjects];
	[self.navigationController popViewControllerAnimated:YES];	
}

//An event when user clicks on Save button.
-(IBAction)Save:(id)sender
{
	[self BackUpdata];
	if(appDelegate.DailyTag==2)
	{
		appDelegate.Routine_Detailrf.Exercise=SelectedItems;
		appDelegate.Routine_Detailrf.Exercise_id=Data1;
		appDelegate.Routine_Detailrf.Exercise_Duration=EXDuration;
		appDelegate.Routine_Detailrf.Exercise_Dru_ID=Exercise;
	}
	else if(appDelegate.DailyTag==3)
	{
		appDelegate.Routine_Detailrf.Mood=SelectedItems;
	}
	else if(appDelegate.DailyTag==4)
	{
		appDelegate.Routine_Detailrf.Activity=SelectedItems;
	}
	else if(appDelegate.DailyTag==5)
	{
		appDelegate.Routine_Detailrf.Diapering=SelectedItems;
	}
	else if(appDelegate.DailyTag==6)
	{
		appDelegate.Routine_Detailrf.Feeding=SelectedItems;
	}
	else if(appDelegate.DailyTag==14)
	{
		[appDelegate.AddNewUserDict setValue:MedicineData forKey:@"Past"];
		[appDelegate.AddNewUserDict setValue:SelectedItems forKey:@"PastID"];
	}
	else if(appDelegate.DailyTag==20)
	{
		appDelegate.MedicineRef.MedicineEntry=MedicineData;
		appDelegate.MedicineRef.Medicine_Insert_ID=SelectedItems;
		int result;
		if(appDelegate.MedicineRef.MedicineID==0)\
		{
			result= [appDelegate InsertMedicinedata:appDelegate.MedicineRef]; 
			if(result>0 && [appDelegate.UnitDictionary count]>0)
			{
				[self SaveMedicineDetail:result];
			}
		}
		else
		{
			result=	[appDelegate UpdateData:appDelegate.MedicineRef]; 
			[appDelegate DeleteAllCategoriesData:@"Medicine_Detail"  IDname:@"Medicine_ID" DeleteID:appDelegate.MedicineRef.MedicineID];
			if(result>0 && [appDelegate.UnitDictionary count]>0)
			{
				[self SaveMedicineDetail:appDelegate.MedicineRef.MedicineID];
			}
		}
		appDelegate.isDailyReport=TRUE;
	}
	ISEdit=FALSE;
	btnEdit.style=UIBarButtonItemStyleBordered;
	btnEdit.title=@"Edit ";
	btnPastEdit.style=UIBarButtonItemStyleBordered;
	btnPastEdit.title=@"Edit ";
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Views appear Mehods
// Called after the view has been loaded. For view controllers created in code, this is after -loadView. For view controllers unarchived from a nib, this is after the view is set.
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	tblView.delegate=self;
	tblView.dataSource=self;
	selectedImage = [UIImage imageNamed:@"checked.png"];
	unselectedImage = [UIImage imageNamed:@"unchecked.png"];
	self.navigationItem.leftBarButtonItem=btnCancle;
	self.navigationItem.rightBarButtonItem=btnSave;
	appDelegate=[[UIApplication sharedApplication]delegate];
	if(!data)
	{
		data=[[NSMutableDictionary alloc]init];
	}
	for(int i = 6; i <=7; i++)
	{
		NSMutableArray *fillPicker=[self FillArray:i];		
		
		[data setObject:fillPicker forKey:[NSString stringWithFormat:@"%d",i]];		
	}
	[DatePicker setDate:[NSDate date] animated:YES];	DatePicker.maximumDate=[NSDate date];
	toolBar.barStyle=UIBarStyleBlackOpaque;
	PastToolBar.barStyle=UIBarStyleBlackOpaque;
	btnEdit.style=UIBarButtonItemStyleBordered;
	btnPastEdit.style=UIBarButtonItemStyleBordered;
	[self.view addSubview:PickerView];
	[self.view addSubview:DatePicker];
	PickerView.delegate=self;
	DatePicker.frame=CGRectMake(0, 200, 320, 216);
	PickerView.frame=CGRectMake(0, 200, 320, 216);
	ToolBar.frame=CGRectMake(0, 220, 320, 44);
	ToolBar.tintColor=[UIColor blackColor];
	lblData=[[UILabel alloc]init];
	lblData.frame=CGRectMake(3,13 , 250, 20);
	lblData.font=[UIFont systemFontOfSize:15];
	lblData.textColor=[UIColor whiteColor];
	lblData.backgroundColor=[UIColor clearColor];
	[ToolBar addSubview:lblData];	
	
	label1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 220, 30)];
	[label1 setFont:[UIFont boldSystemFontOfSize:13.5]];
	[label1 setBackgroundColor:[UIColor clearColor]];
	[label1 setTextAlignment:UITextAlignmentCenter];
 	[label1 setTextColor:[UIColor whiteColor]];	
	
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Back";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];	
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RemoveObjectAtIndex) name:@"RemoveTick" object:nil];
	
    [super viewDidLoad];
}

 // Called when the view has been fully transitioned onto the screen. Default does nothing
-(void)viewDidAppear:(BOOL)animated
{
	self.view.frame=CGRectMake(0, 0, 320, 416);
//	toolBar.hidden=FALSE;
	tblView.frame=CGRectMake(0, 0, 320, 376);
	ToolBar.frame=CGRectMake(0, 156, 320, 44);		
	if(appDelegate.DailyTag==20)
	{
		toolBar.frame=CGRectMake(0, 372, 320, 44);		
	}
	DatePicker.frame=CGRectMake(0, 200, 320, 216);
	PickerView.frame=CGRectMake(0, 200, 320, 216);

	[self.view bringSubviewToFront:toolBar]; 
	[self.view bringSubviewToFront:ToolBar];
	[self.view bringSubviewToFront:PastToolBar];
	[self.view bringSubviewToFront:DatePicker];
	[self.view bringSubviewToFront:PickerView];
}

// Called when the view is about to made visible. Default does nothing
- (void)viewWillAppear:(BOOL)animated
{
	tblView.userInteractionEnabled=TRUE;
	btnSave.enabled=TRUE;
	[DatePicker setDate:[NSDate date] animated:YES];
	ToolBar.hidden=TRUE;
	DatePicker.hidden=TRUE;
	if(appDelegate.isFromChart==TRUE)
	{
		[tblView scrollRectToVisible:CGRectMake(0, 0, 320, 50)  animated:YES];
		appDelegate.isFromChart=FALSE;
	}
	PickerView.hidden=TRUE;
	toolBar.frame=CGRectMake(0, 372, 320, 44);
	PastToolBar.frame=CGRectMake(0, 372, 320, 44);
	toolBar.hidden=FALSE;
	[label1 setText:[NSString stringWithFormat:@"Select %@",NavText]];
	self.navigationItem.titleView=label1;
	selectedArrayData=nil;
	if(!selectedArrayData)
		selectedArrayData=[[NSMutableArray alloc ]init];
	else
		[selectedArrayData removeAllObjects];
	PastToolBar.hidden=TRUE;
	
	///// Here we use tage for different views
	/// 20 - Medicine
	/// 2 - Exercise
	/// 14 - Past
	/// 3 - Mood
	/// 4 - Activity
	/// 5 - Dipering
	/// 6 - Food Consuption
	
	if(appDelegate.DailyTag==20)
	{
		[appDelegate SelectUserSettings:appDelegate.SelectedUserID];
		appDelegate.IsFromMedicine=TRUE;
		if([appDelegate.UserSettingsArray count]==1)
		{
			User_Settings *Data=[appDelegate.UserSettingsArray objectAtIndex:0];
			if([Data.MedicineEntryDetail length]>0)
			{
				MedicineArray = [[Data.MedicineEntryDetail componentsSeparatedByString:@","]retain]; 
			}
			else
			{
				if(MedicineArray)
				{
					MedicineArray=nil;
				}
			}
		}
		for(int i=0;i<[MedicineArray count];i++)
		{
			[selectedArrayData addObject:[appDelegate SelectMedicine:[[MedicineArray objectAtIndex:i]intValue]]]; 
		}
		tblView.frame=CGRectMake(0, 0, 320, 376);
		[btnMedidcine setTitle:@"Add Medicine"];
	}	
	else if(appDelegate.DailyTag==2)
	{		
		tblView.frame=CGRectMake(0, 0, 320, 376);
		
		if(!ExerciseArray)
			ExerciseArray=[[NSMutableArray alloc ]init];
		else
			[ExerciseArray removeAllObjects];
		[appDelegate SelectExerciseNames];
		
		[appDelegate SelectUserSettings:appDelegate.SelectedUserID];
		if([appDelegate.UserSettingsArray count]==1)
		{
			User_Settings *Data=[appDelegate.UserSettingsArray objectAtIndex:0];
			if([Data.ExerciseEntryDetail length]>0)
			{
				MedicineArray = [[Data.ExerciseEntryDetail componentsSeparatedByString:@","]retain]; 
			}
			else
			{
				if(MedicineArray)
				{
					MedicineArray=nil;
				}
			}
		}
		for(int i=0;i<[appDelegate.ExerciseArray count];i++)
		{
			NSDictionary *Dic=[appDelegate.ExerciseArray objectAtIndex:i];
			if([MedicineArray containsObject:[Dic valueForKey:@"Exercise_ID"]])
			{
				[selectedArrayData addObject:[Dic valueForKey:@"Exercise_Name"]];
				[ExerciseArray addObject:[Dic valueForKey:@"Exercise_ID"]];
			}
		}
		[btnMedidcine setTitle:@"Add Exercise"];		
	}
	else if(appDelegate.DailyTag==14)
	{
		toolBar.hidden=TRUE;
		PastToolBar.hidden=FALSE;
		if(!NamePastArray)
			NamePastArray=[[NSMutableArray alloc]init];
		if([NamePastArray count]>0)
			[NamePastArray removeAllObjects];
		[appDelegate selectAllPastData];
		appDelegate.IsFromMedicine=FALSE;
		for(int i=0;i<[appDelegate.AllPastArray count];i++)
		{
			NSDictionary *DIC=[appDelegate.AllPastArray objectAtIndex:i];
			[selectedArrayData addObject:[DIC valueForKey:@"Name"]];
			[NamePastArray addObject:[DIC valueForKey:@"PastID"]];
		}
		tblView.frame=CGRectMake(0, 0, 320, 376);
		[btnMedidcine setTitle:@"Add Past"];		
	}
	else
	{
		tblView.frame=CGRectMake(0, 0, 320, 376);
		[appDelegate SelectUserSettings:appDelegate.SelectedUserID];
		if([appDelegate.UserSettingsArray count]==1)
		{			
			User_Settings *Data=[appDelegate.UserSettingsArray objectAtIndex:0];
			if(appDelegate.DailyTag==3)
			{
				[btnMedidcine setTitle:@"Add Mood"];
				if([Data.MoodEntryDetail length]>0)
				{					
					MedicineArray = [[Data.MoodEntryDetail componentsSeparatedByString:@","]retain]; 
				}
				else
				{
					if(MedicineArray)
					{
						MedicineArray=nil;
					}
				}
			}
			else if(appDelegate.DailyTag==4)
			{
				[btnMedidcine setTitle:@"Add Activity"];
				if([Data.ActivityEntryDetail length]>0)
				{
					MedicineArray = [[Data.ActivityEntryDetail componentsSeparatedByString:@","]retain]; 
				}
				else
				{
					if(MedicineArray)
					{
						MedicineArray=nil;
					}
				}
			}
			else if(appDelegate.DailyTag==5)
			{
				[btnMedidcine setTitle:@"Add Diapering"];
				if([Data.DiperingEntryDetail length]>0)
				{
					MedicineArray = [[Data.DiperingEntryDetail componentsSeparatedByString:@","]retain]; 
				}
				else
				{
					if(MedicineArray)
					{
						MedicineArray=nil;
					}
				}
			}
			else if(appDelegate.DailyTag==6)
			{
				[btnMedidcine setTitle:@"Add Food Consumed"];
				if([Data.FeedingEntryDetail length]>0)
				{
					MedicineArray = [[Data.FeedingEntryDetail componentsSeparatedByString:@","]retain]; 
				}
				else
				{
					if(MedicineArray)
					{
						MedicineArray=nil;
					}
				}
			}
		}
		for(int i=0;i<[MedicineArray count];i++)
		{
			if(appDelegate.DailyTag==3)
			{
				[selectedArrayData addObject:[appDelegate Select:[[MedicineArray objectAtIndex:i]intValue] :@"Mood"]]; 
			}
			else if(appDelegate.DailyTag==4)
			{
				[selectedArrayData addObject:[appDelegate Select:[[MedicineArray objectAtIndex:i]intValue] :@"Activity"]]; 
			}
			else if(appDelegate.DailyTag==5)
			{
				[selectedArrayData addObject:[appDelegate Select:[[MedicineArray objectAtIndex:i]intValue] :@"Diapering"]]; 
			}
			else if(appDelegate.DailyTag==6)
			{
				[selectedArrayData addObject:[appDelegate Select:[[MedicineArray objectAtIndex:i]intValue] :@"Feeding"]]; 
			}
		}		
	}	
	[self populateSelectedArray];
}

#pragma mark Mehods for Backupdata and RemoveIndex
-(void)RemoveObjectAtIndex
{
	if(IsDeleteTheRow)
	{
		BOOL selected=FALSE;
		appDelegate.isfromFavourite=FALSE;
		[selectedArray replaceObjectAtIndex:IndexpathRow withObject:[NSNumber numberWithBool:selected]];
	}
}

//// Save Selected values...

-(void)BackUpdata
{
	SelectedItems=@"";
	Data1=@"";	
	EXDuration=@"";
	Exercise=@"";
	[SelectedText resignFirstResponder];
	if(!arr1)
		arr1=[[NSMutableArray alloc]init];
	if([arr1 count]>0)
	{
		[arr1 removeAllObjects];
	}
	if(!arr3)
		arr3=[[NSMutableArray alloc]init];
	if([arr3 count]>0)
	{
		[arr3 removeAllObjects];
	}
	MedicineData=@"";	
	if(appDelegate.DailyTag==20)
	{
		appDelegate.isDailyReport=TRUE;
		for(int i=0;i<[selectedArrayData count];i++)
		{
			if([[selectedArray objectAtIndex:i]intValue]==1)
			{
				[arr1 addObject:[MedicineArray objectAtIndex:i]];
				[arr3 addObject:[selectedArrayData objectAtIndex:i]];
			}
		}
		if([arr1 count]>0)
		{
			for(int i=0;i<[arr1 count];i++)
			{
				if(i==([arr1 count]-1))
				{
					SelectedItems=[SelectedItems stringByAppendingString:[NSString stringWithFormat:@"%@",[arr1 objectAtIndex:i]]];
					MedicineData=[MedicineData stringByAppendingString:[NSString stringWithFormat:@"%@",[arr3 objectAtIndex:i]]];
				}
				else
				{
					SelectedItems=[SelectedItems stringByAppendingString:[NSString stringWithFormat:@"%@, ",[arr1 objectAtIndex:i]]];
					MedicineData=[MedicineData stringByAppendingString:[NSString stringWithFormat:@"%@  \n",[arr3 objectAtIndex:i]]];
				}
			}
		}		
		appDelegate.SelectedItems=SelectedItems;
	}
	else if(appDelegate.DailyTag==14)
	{
		appDelegate.isDailyReport=TRUE;
		for(int i=0;i<[selectedArrayData count];i++)
		{
			if([[selectedArray objectAtIndex:i]intValue]==1)
			{
				[arr1 addObject:[NamePastArray objectAtIndex:i]];
				[arr3 addObject:[selectedArrayData objectAtIndex:i]];
			}
		}
		if([arr1 count]>0)
		{
			for(int i=0;i<[arr1 count];i++)
			{
				if(i==([arr1 count]-1))
				{
					SelectedItems=[SelectedItems stringByAppendingString:[NSString stringWithFormat:@"%@",[arr1 objectAtIndex:i]]];
					MedicineData=[MedicineData stringByAppendingString:[NSString stringWithFormat:@"%@",[arr3 objectAtIndex:i]]];
				}
				else
				{
					SelectedItems=[SelectedItems stringByAppendingString:[NSString stringWithFormat:@"%@, ",[arr1 objectAtIndex:i]]];
					MedicineData=[MedicineData stringByAppendingString:[NSString stringWithFormat:@"%@, ",[arr3 objectAtIndex:i]]];
				}
			}
		}		
		appDelegate.SelectedItems=SelectedItems;
	}
	else if(appDelegate.DailyTag==2)
	{
		for(int i=0;i<[selectedArrayData count];i++)
		{
			if([[selectedArray objectAtIndex:i]intValue]==1)
			{
				[arr3 addObject:[ExerciseArray objectAtIndex:i]];
				[arr1 addObject:[selectedArrayData objectAtIndex:i]];
			}	
		}
		
		if([arr1 count]>0)
		{
			for(int i=0;i<[arr1 count];i++)
			{
				int Indes=[selectedArrayData indexOfObject:[arr1 objectAtIndex:i]];
				Dru=[ExerciseValueDictionary valueForKey:[NSString stringWithFormat:@"%d",Indes]];
				arr4=[Dru componentsSeparatedByString:@":"];
				int Min=[[arr4 objectAtIndex:0]intValue];
				Min=Min*60;
				Min=Min+[[arr4 objectAtIndex:1]intValue];
				if(i==([arr1 count]-1))
				{
					SelectedItems=[SelectedItems stringByAppendingString:[NSString stringWithFormat:@"%@ (%@)",[arr1 objectAtIndex:i],[ExerciseValueDictionary valueForKey:[NSString stringWithFormat:@"%d",Indes]]]];
					Data1=[Data1 stringByAppendingString:[NSString stringWithFormat:@"%@",[arr3 objectAtIndex:i]]];
					EXDuration=[EXDuration stringByAppendingString:[NSString stringWithFormat:@"%d",Min]];
					Exercise=[Exercise stringByAppendingString:[NSString stringWithFormat:@"%@",[arr1 objectAtIndex:i]]];
				}
				else
				{
					SelectedItems=[SelectedItems stringByAppendingString:[NSString stringWithFormat:@"%@ (%@), ",[arr1 objectAtIndex:i],[ExerciseValueDictionary valueForKey:[NSString stringWithFormat:@"%d",Indes]]]];
					Data1=[Data1 stringByAppendingString:[NSString stringWithFormat:@"%@, ",[arr3 objectAtIndex:i]]];
					EXDuration=[EXDuration stringByAppendingString:[NSString stringWithFormat:@"%d, ",Min]];
					Exercise=[Exercise stringByAppendingString:[NSString stringWithFormat:@"%@, ",[arr1 objectAtIndex:i]]];
				}
			}
		}	
		appDelegate.SelectedItems=SelectedItems;
		ExerciseNames=Data1;
	}
	else if(appDelegate.DailyTag==6)
	{
		for(int i=0;i<[selectedArrayData count];i++)
		{
			if([[selectedArray objectAtIndex:i]intValue]==1)
			{				
				[arr1 addObject:[MedicineArray objectAtIndex:i]];
			}	
		}
		if([arr1 count]>0)
		{
			int j=0;
			for(int i=0;i<[arr1 count];i++)
			{
				if([appDelegate.UnitDictionary objectForKey:[arr1 objectAtIndex:i]]!=nil)
				{
					NSDictionary *DIC=[appDelegate.UnitDictionary objectForKey:[arr1 objectAtIndex:i]];
					if(i==(([arr1 count]-1)-j))
					{
						
						SelectedItems=[SelectedItems stringByAppendingString:[NSString stringWithFormat:@"%@ (%@ %@)",[DIC valueForKey:@"Feed_Name"],[DIC valueForKey:@"Feed_Qty"],[DIC valueForKey:@"Feed_Unit"]]];
					}
					else
					{
						SelectedItems=[SelectedItems stringByAppendingString:[NSString stringWithFormat:@"%@ (%@ %@),",[DIC valueForKey:@"Feed_Name"],[DIC valueForKey:@"Feed_Qty"],[DIC valueForKey:@"Feed_Unit"]]];
					}
				}
				else
				{
					j++;
				}
			}
		}
		appDelegate.SelectedItems=SelectedItems;
	}
	else
	{
		for(int i=0;i<[selectedArrayData count];i++)
		{
			if([[selectedArray objectAtIndex:i]intValue]==1)
			{
				[arr1 addObject:[selectedArrayData objectAtIndex:i]];
			}			
		}		
		if([arr1 count]>0)
		{
			for(int i=0;i<[arr1 count];i++)
			{
				if(i==([arr1 count]-1))
				{
					SelectedItems=[SelectedItems stringByAppendingString:[NSString stringWithFormat:@"%@",[arr1 objectAtIndex:i]]];
				}
				else
				{
					SelectedItems=[SelectedItems stringByAppendingString:[NSString stringWithFormat:@"%@, ",[arr1 objectAtIndex:i]]];
				}
			}
		}
		appDelegate.SelectedItems=SelectedItems;
	}
}

//// Check which Item is selected or not for showing in table

- (void)populateSelectedArray
{	
	///// Here we use tage for different views
	/// 20 - Medicine
	/// 2 - Exercise
	/// 14 - Past
	/// 3 - Mood
	/// 4 - Activity
	/// 5 - Dipering
	/// 6 - Food Consuption
	
	
	if(appDelegate.isfromFavourite==TRUE)
	{
		ExerciseNames=@"";		
		if([appDelegate.SelectedStatus isEqualToString:@"Hourly"])
		{
			if(appDelegate.DailyTag==2)
			{
				if(!ExerciseValueDictionary)
					ExerciseValueDictionary=[[NSMutableDictionary alloc ]init];
				else
					[ExerciseValueDictionary removeAllObjects];
				
				appDelegate.SelectedItems=@"";
				appDelegate.SelectedItems=appDelegate.Routine_Detailrf.Exercise_id; 
				ExerciseNames=appDelegate.Routine_Detailrf.Exercise;
			}
			else if(appDelegate.DailyTag==3)
			{
				appDelegate.SelectedItems=appDelegate.Routine_Detailrf.Mood; 
			}
			else if(appDelegate.DailyTag==4)
			{
				appDelegate.SelectedItems=appDelegate.Routine_Detailrf.Activity; 
			}
			else if(appDelegate.DailyTag==5)
			{
				appDelegate.SelectedItems=appDelegate.Routine_Detailrf.Diapering; 
			}
			else if(appDelegate.DailyTag==6)
			{
				appDelegate.SelectedItems=appDelegate.Routine_Detailrf.Feeding; 
			}
			else if(appDelegate.DailyTag==14)
			{
				appDelegate.SelectedItems=[appDelegate.AddNewUserDict valueForKey:@"PastID"]; 
			}
		}	
		if(!selectedArray)
			selectedArray=[[NSMutableArray alloc ]init];
		else
			[selectedArray removeAllObjects];
	}	
	
	if(appDelegate.DailyTag==20) // For Medicine
	{
		if(appDelegate.isfromFavourite==TRUE)
		{	
			NSArray *array3=[appDelegate.UnitDictionary allKeys];
			for(int i=0;i<[selectedArrayData count];i++)
			{
				NSString *str=[MedicineArray objectAtIndex:i];
				if([array3 containsObject:str])
				{
					if([appDelegate.UnitDictionary objectForKey:str]!=nil)
					{
						[selectedArray addObject:[NSNumber numberWithBool:YES]];
					}
					else
					{
						[selectedArray addObject:[NSNumber numberWithBool:NO]];
					}
				}
				else
				{
					[selectedArray addObject:[NSNumber numberWithBool:NO]];
				}
			}
		}
		
		else
		{
			int count=[selectedArray count];
			for (int i=count; i < [selectedArrayData count]; i++)
			{
				[selectedArray addObject:[NSNumber numberWithBool:NO]];
			}
		}
	}
	else if(appDelegate.DailyTag==14) //// For Past
	{
		if(appDelegate.isfromFavourite==TRUE)
		{
			if([appDelegate.SelectedItems isEqualToString:@""])
			{
				for (int i=0; i < [selectedArrayData count]; i++)
					[selectedArray addObject:[NSNumber numberWithBool:NO]];
			}
			else
			{
				NSArray *arr2=[appDelegate.SelectedItems componentsSeparatedByString:@", "];
				for(int i=0;i<[NamePastArray count];i++)
				{
					BOOL result = [arr2 containsObject:[NamePastArray objectAtIndex:i]]; 
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
			int count=[selectedArray count];
			for (int i=count; i < [selectedArrayData count]; i++)
			{
				[selectedArray addObject:[NSNumber numberWithBool:NO]];
			}
		}
	}
	else if(appDelegate.DailyTag==2) ///// For Exercise
	{
		if(appDelegate.isfromFavourite==TRUE)
		{
			if([appDelegate.SelectedItems isEqualToString:@""])
			{
				for (int i=0; i < [selectedArrayData count]; i++)
					[selectedArray addObject:[NSNumber numberWithBool:NO]];
			}
			else
			{				
				NSArray *arr2=[appDelegate.SelectedItems componentsSeparatedByString:@", "];				
				NSArray *arr5=[ExerciseNames componentsSeparatedByString:@" ("];				
				for(int i=0;i<[arr2 count];i++)
				{					
					NSArray *arr6=[[arr5 objectAtIndex:i+1] componentsSeparatedByString:@")"];
					int INdex=[ExerciseArray indexOfObject:[arr2 objectAtIndex:i]];
					NSString *Value=[arr6 objectAtIndex:0];
					Value=[Value stringByReplacingOccurrencesOfString:@")"  withString:@""];
					[ExerciseValueDictionary setValue:Value forKey:[NSString stringWithFormat:@"%d",INdex]];
				}
				arr2=[appDelegate.SelectedItems componentsSeparatedByString:@", "];
				for(int i=0;i<[ExerciseArray count];i++)
				{
					BOOL result = [arr2 containsObject:[ExerciseArray objectAtIndex:i]]; 
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
			int count=[selectedArray count];
			for (int i=count; i < [selectedArrayData count]; i++)
			{
				[selectedArray addObject:[NSNumber numberWithBool:NO]];
			}
		}		
	}
	else if(appDelegate.DailyTag==6) /// For Food Consuption
	{
		if(appDelegate.isfromFavourite==TRUE)		
		{
			NSArray *array3=[appDelegate.UnitDictionary allKeys];
			for(int i=0;i<[selectedArrayData count];i++)
			{
				NSString *str=[MedicineArray objectAtIndex:i];
				if([array3 containsObject:str])
				{
					if([appDelegate.UnitDictionary objectForKey:str]!=nil)
					{
						[selectedArray addObject:[NSNumber numberWithBool:YES]];
					}
					else
					{
						[selectedArray addObject:[NSNumber numberWithBool:NO]];
					}
				}
				else
				{
					[selectedArray addObject:[NSNumber numberWithBool:NO]];
				}
			}
		}
		else
		{
			int count=[selectedArray count];
			for (int i=count; i < [selectedArrayData count]; i++)
			{
				[selectedArray addObject:[NSNumber numberWithBool:NO]];
			}
		}
	}
	else //// For Mood,Dipering And Activity
	{
		if(appDelegate.isfromFavourite==TRUE)		
		{
			if([appDelegate.SelectedItems isEqualToString:@""])
			{
				for (int i=0; i < [selectedArrayData count]; i++)
					[selectedArray addObject:[NSNumber numberWithBool:NO]];
			}
			else
			{
				NSArray *arr2=[appDelegate.SelectedItems componentsSeparatedByString:@", "];
				for(int i=0;i<[selectedArrayData count];i++)
				{
					BOOL result = [arr2 containsObject:[selectedArrayData objectAtIndex:i]]; 
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
			int count=[selectedArray count];
			for (int i=count; i < [selectedArrayData count]; i++)
			{
				[selectedArray addObject:[NSNumber numberWithBool:NO]];
			}
		}
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

#pragma mark TableView Delegate Mehods
/// Return Height Base on text
-(CGFloat)findHeightForCell:(NSString *)text :(CGFloat)WIDTH
{
	CGFloat		result = 40.0f;
	CGFloat		width = 0;
	
	
	width = WIDTH;
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
	if((appDelegate.DailyTag==20 && indexPath.section==1) || appDelegate.DailyTag==6)
		return [self  findHeightForCell:[selectedArrayData objectAtIndex:indexPath.row] :130]+5;
	else
		return 40;	
}

// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if(appDelegate.DailyTag==20)
		return 2;
	else
		return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{	
	if(appDelegate.DailyTag==20 && section==0)		
	{		
		return 1;
	}
	else if(appDelegate.DailyTag==4 || appDelegate.DailyTag==3)
	{
		return [selectedArrayData count];
	}
	else
	{
		return [selectedArrayData count];
	}
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    	
   
	if(appDelegate.DailyTag==20 && indexPath.section==0)
	{
		///// For Date Ans time cell in Medicine
		static NSString *CellIdentifier1 = @"Cell";
		AddUserButtonTableViewCell  *cell1 = (AddUserButtonTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
		if (cell1 == nil) 
		{
			cell1 = [[[AddUserButtonTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier1] autorelease];
			[cell1.BtnSelect addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
		}
		
		cell1.lblName.frame =  CGRectMake(2, 5, 140, 30);
		cell1.BtnSelect.frame =  CGRectMake(150, 5, 140, 30 );
		cell1.lblName.text=@"Date & Time";
		[cell1.BtnSelect setTitle:[NSString stringWithFormat:@"  %@ %@",appDelegate.MedicineRef.EntryDate,appDelegate.MedicineRef.EntryTime] forState:UIControlStateNormal];
		return cell1;
	}	
	else 	
	{
		 static NSString *CellIdentifier = @"Cell1";		
		SettingTableViewCell  *cell =(SettingTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) 
		{
			cell = [[[SettingTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
			cell.txtAmount.delegate=self;
		}	
		cell.txtAmount.tag=indexPath.row+1;	
		cell.txtAmount.hidden=TRUE;
		cell.accessoryType=UITableViewCellAccessoryNone;
		cell.btnDelete.hidden=FALSE;
		NSNumber *selected = [selectedArray objectAtIndex:[indexPath row]];
		cell.btnDelete.image = ([selected boolValue]) ? selectedImage : unselectedImage;
		cell.lblName.text=[selectedArrayData objectAtIndex:indexPath.row]; 
		if(appDelegate.DailyTag==2) /// For Exercise 
		{
			cell.txtAmount.enabled=TRUE;
			
			cell.txtAmount.frame = CGRectMake(180, 8, 70, 25);
			
			if([[ExerciseValueDictionary valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]]length]==0)
			{
				cell.txtAmount.text=@"";
			}
			else
				cell.txtAmount.text=[NSString stringWithFormat:@"%@",[ExerciseValueDictionary valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]]];					
			if(([selected boolValue])==TRUE)
			{
				cell.txtAmount.hidden=FALSE;
			}
			else
			{
				cell.txtAmount.hidden=TRUE;
			}				
		}
		else if(appDelegate.DailyTag==20) /// For Medicine set Qty and Unit
		{
			if([appDelegate.UnitDictionary objectForKey:[MedicineArray objectAtIndex:indexPath.row]]!=nil)
			{
				cell.txtAmount.frame = CGRectMake(140, cell.frame.size.height/2-11, 118, 25);
				cell.txtAmount.hidden=FALSE;
				cell.txtAmount.enabled=TRUE;
				NSDictionary *DIC=[appDelegate.UnitDictionary objectForKey:[MedicineArray objectAtIndex:indexPath.row]];
				cell.txtAmount.text=[NSString stringWithFormat:@"%@ %@",[DIC valueForKey:@"Med_Qty"],[DIC valueForKey:@"Med_Unit"]];
			}
			else
			{
				cell.txtAmount.hidden=TRUE;
				cell.txtAmount.enabled=FALSE;
			}
		}
		else if(appDelegate.DailyTag==6) /// For Food Consuption set Qty and Unit
		{
			if([appDelegate.UnitDictionary objectForKey:[MedicineArray objectAtIndex:indexPath.row]]!=nil)
			{
				cell.txtAmount.frame = CGRectMake(140, cell.frame.size.height/2-11, 118, 25);
				cell.txtAmount.hidden=FALSE;
				cell.txtAmount.enabled=TRUE;
				NSDictionary *DIC=[appDelegate.UnitDictionary objectForKey:[MedicineArray objectAtIndex:indexPath.row]];
				NSString *STR=[DIC valueForKey:@"Feed_Qty"];
				//NSLog(STR);
				STR=[DIC valueForKey:@"Feed_Unit"];
				cell.txtAmount.text=[NSString stringWithFormat:@"%@ %@",[DIC valueForKey:@"Feed_Qty"],[DIC valueForKey:@"Feed_Unit"]];
			}
			else
			{
				cell.txtAmount.hidden=TRUE;
				cell.txtAmount.enabled=FALSE;
			}
		}
		else
		{
			cell.txtAmount.hidden=TRUE;
		}		
		if(ISEdit==TRUE)
		{
			cell.txtAmount.hidden=TRUE;
			cell.btnDelete.hidden=TRUE;
			cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
		}
		return cell;
	}
	return nil;
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	[SelectedText resignFirstResponder];
	
	if(appDelegate.DailyTag==20 && indexPath.section==0)
	{
		[self ClickButton:nil];
	}
	else if(ISEdit==TRUE)
	{		
		//// Called when User will click on Edit Button.
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		if(!appDelegate.objUserTextEntryViewController)
		{
			appDelegate.objUserTextEntryViewController=[[UserTextEntryViewController alloc]initWithNibName:@"TextEntry" bundle:nil];
		}	
		[self BackUpdata];
		if(appDelegate.DailyTag==20) //// For Medicine
		{
			appDelegate.SelectedStatus=@"Medicine";
			appDelegate.objUserTextEntryViewController.MED_ID=[[MedicineArray objectAtIndex:indexPath.row]intValue];
			appDelegate.objUserTextEntryViewController.selectedIndex=20;
			appDelegate.objUserTextEntryViewController.selectedName=@"Medicine";
		}
		else if(appDelegate.DailyTag==2) //// For Exercise
		{
			appDelegate.SelectedStatus=@"Exercise";
			appDelegate.objUserTextEntryViewController.MED_ID=[[ExerciseArray objectAtIndex:indexPath.row]intValue];
			appDelegate.objUserTextEntryViewController.selectedIndex=2;
			appDelegate.objUserTextEntryViewController.selectedName=@"Exercise";
		}	
		if(appDelegate.DailyTag==3) //// For Mood
		{
			appDelegate.SelectedStatus=@"Mood";
			appDelegate.objUserTextEntryViewController.selectedIndex=3;
			appDelegate.objUserTextEntryViewController.selectedName=@"Mood";			
			appDelegate.objUserTextEntryViewController.MED_ID=[[MedicineArray objectAtIndex:indexPath.row]intValue];
		}
		if(appDelegate.DailyTag==4) //// For Activity
		{
			appDelegate.SelectedStatus=@"Activity";
			appDelegate.objUserTextEntryViewController.selectedIndex=4;
			appDelegate.objUserTextEntryViewController.selectedName=@"Activity";			
			appDelegate.objUserTextEntryViewController.MED_ID=[[MedicineArray objectAtIndex:indexPath.row]intValue];
		}
		
		if(appDelegate.DailyTag==5) //// For Diapering
		{
			appDelegate.SelectedStatus=@"Diapering";
			appDelegate.objUserTextEntryViewController.selectedIndex=5;
			appDelegate.objUserTextEntryViewController.selectedName=@"Diapering";			
			appDelegate.objUserTextEntryViewController.MED_ID=[[MedicineArray objectAtIndex:indexPath.row]intValue];
		}
		
		if(appDelegate.DailyTag==6)  //// For Feeding
		{
			appDelegate.SelectedStatus=@"Feeding";
			appDelegate.objUserTextEntryViewController.selectedIndex=6;
			appDelegate.objUserTextEntryViewController.selectedName=@"Food Consumed";			
			appDelegate.objUserTextEntryViewController.MED_ID=[[MedicineArray objectAtIndex:indexPath.row]intValue];
		}
		
		if(appDelegate.DailyTag==14) //// For Past
		{
			appDelegate.SelectedStatus=@"Past";
			appDelegate.objUserTextEntryViewController.selectedIndex=14;
			appDelegate.objUserTextEntryViewController.selectedName=@"Past";			
			appDelegate.objUserTextEntryViewController.MED_ID=[[NamePastArray objectAtIndex:indexPath.row]intValue];
		}
		
		appDelegate.isfromFavourite=FALSE;
		appDelegate.objUserTextEntryViewController.TextData=[selectedArrayData objectAtIndex:indexPath.row];		
		[self.navigationController pushViewController:appDelegate.objUserTextEntryViewController animated:YES];	
		[Pool release];
	}
	else
	{
		IndexpathRow=indexPath.row;
		if(appDelegate.DailyTag==6) //// For Food Consumed
		{
			/// Called when User in Food Consumption and select or deselect it
			BOOL selected = [[selectedArray objectAtIndex:[indexPath row]] boolValue];
			if(selected==FALSE)
			{
				//// Called when it is select
				IsDeleteTheRow=TRUE;
				if(!objTwoTextEntryViewController)
					objTwoTextEntryViewController=[[TwoTextEntryViewController alloc]initWithNibName:@"TwoTextEntryViewController" bundle:nil];
				[selectedArray replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithBool:!selected]];
				appDelegate.SelectedStatus=@"Feed_Data";
				objTwoTextEntryViewController.HeaderLabel=@"Food Consumption";
				objTwoTextEntryViewController.strQty=@"";
				appDelegate.StrUnit=@"";
				objTwoTextEntryViewController.strUnit=[selectedArrayData objectAtIndex:indexPath.row];
				objTwoTextEntryViewController.SelectedIndex=[[MedicineArray objectAtIndex:indexPath.row]intValue];
				objTwoTextEntryViewController.Index=0;
				[self.navigationController pushViewController:objTwoTextEntryViewController animated:YES];
			}
			else
			{
				//// Called when it is deselect
				if([appDelegate.UnitDictionary valueForKey:[MedicineArray objectAtIndex:indexPath.row]]!=nil)
				{
					UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Are you sure want to deselect?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
					Alert.tag=5;
					[Alert show];
					[Alert release];
				}
				else
				{
					BOOL selected=NO;
					[selectedArray replaceObjectAtIndex:IndexpathRow withObject:[NSNumber numberWithBool:selected]];
					[tblView reloadData];
					return;
				}
				
			}			
		}
		else if(appDelegate.DailyTag==20) //// For Medicine
		{
			/// Called when User in Medicine and select or deselect it
			BOOL selected = [[selectedArray objectAtIndex:[indexPath row]] boolValue];			
			if(selected==FALSE)
			{
				//// Called when it is select
				IsDeleteTheRow=TRUE;
				if(!objTwoTextEntryViewController)
					objTwoTextEntryViewController=[[TwoTextEntryViewController alloc]initWithNibName:@"TwoTextEntryViewController" bundle:nil];
				[selectedArray replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithBool:!selected]];
				objTwoTextEntryViewController.HeaderLabel=@"Medicine";
				appDelegate.SelectedStatus=@"Medicine_Data";
				objTwoTextEntryViewController.strQty=@"";
				appDelegate.StrUnit=@"";
				[self BackUpdata];
				objTwoTextEntryViewController.strUnit=[selectedArrayData objectAtIndex:indexPath.row];
				objTwoTextEntryViewController.SelectedIndex=[[MedicineArray objectAtIndex:indexPath.row]intValue];
				objTwoTextEntryViewController.Index=0;
				[self.navigationController pushViewController:objTwoTextEntryViewController animated:YES];
			}
			else
			{
				//// Called when it is deselect
				if([appDelegate.UnitDictionary valueForKey:[MedicineArray objectAtIndex:indexPath.row]]!=nil)
				{
					UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Are you sure want to deselect?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
					Alert.tag=6;
					[Alert show];
					[Alert release];
				}
				else
				{
					BOOL selected=NO;
					[selectedArray replaceObjectAtIndex:IndexpathRow withObject:[NSNumber numberWithBool:selected]];
					[tblView reloadData];
					return;
				}
			}				
		}
		/////  Called when Click on Mood, Dipering or Activity
		else if(appDelegate.DailyTag==4 || appDelegate.DailyTag==3)
		{			
			BOOL selected = [[selectedArray objectAtIndex:[indexPath row]] boolValue];
			[selectedArray replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithBool:!selected]];
			for(int i=0;i<[selectedArray count];i++)
			{
				if(i!=indexPath.row)
				{
					[selectedArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",0]];
				}
			}				
			[tableView reloadData];
		}		
		else
		{
			NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
			if(appDelegate.DailyTag==3 || appDelegate.DailyTag==5)
			{
				BOOL selected = [[selectedArray objectAtIndex:[indexPath row]] boolValue];
				[selectedArray replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithBool:!selected]];
				for(int i=0;i<[selectedArray count];i++)
				{
					if(i!=indexPath.row)
					{
						[selectedArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",0]];
					}
				}
				[tableView reloadData];
			}
			else if(appDelegate.DailyTag==2)
			{
				if(PickerView.hidden==TRUE)
				{					
					BOOL selected = [[selectedArray objectAtIndex:[indexPath row]] boolValue];
					[selectedArray replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithBool:!selected]];
					[tableView reloadData];
					
					if(selected==FALSE)
					{
						tableView.userInteractionEnabled=FALSE;
						PickerView.hidden=FALSE;
						SelectedTag=indexPath.row+1; 
						ToolBar.hidden=FALSE;
						btnSave.enabled=FALSE;
						lblData.text=@"Select Exercise Duration";
						[PickerView reloadAllComponents];
						if([[ExerciseValueDictionary valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]] length]>0)
						{
							NSArray *arr=[[ExerciseValueDictionary valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]] componentsSeparatedByString:@":"]; 
							int row=[self GetPickerRow:[arr objectAtIndex:0] component:7];
							[PickerView selectRow:row inComponent:0 animated:NO];
							row=[self GetPickerRow:[arr objectAtIndex:1] component:6];
							[PickerView selectRow:row inComponent:1 animated:NO];
						}
						else
						{
							[PickerView selectRow:0 inComponent:0 animated:NO];
							[PickerView selectRow:0 inComponent:1 animated:NO];
						}
					}
				}	
				[Pool release];
			}
			else
			{
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				BOOL selected = [[selectedArray objectAtIndex:[indexPath row]] boolValue];
				[selectedArray replaceObjectAtIndex:[indexPath row] withObject:[NSNumber numberWithBool:!selected]];
				[tableView reloadData];
				[Pool release];
			}
		}
	}
}

#pragma mark Alert View Delegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(alertView.tag==5)
	{
		if(buttonIndex==1)
		{
			BOOL selected=NO;
			[selectedArray replaceObjectAtIndex:IndexpathRow withObject:[NSNumber numberWithBool:selected]];
			NSMutableArray *RemoveObj=[[NSMutableArray alloc]init];
			[RemoveObj addObject:[MedicineArray objectAtIndex:IndexpathRow]];
			[appDelegate.UnitDictionary removeObjectsForKeys:[RemoveObj mutableCopy]];
			[RemoveObj release];
			[tblView reloadData];		
		}
	}
	if(alertView.tag==6)
	{
		if(buttonIndex==1)
		{
			BOOL selected=NO;
			[selectedArray replaceObjectAtIndex:IndexpathRow withObject:[NSNumber numberWithBool:selected]];
			NSMutableArray *RemoveObj=[[NSMutableArray alloc]init];
			[RemoveObj addObject:[MedicineArray objectAtIndex:IndexpathRow]];
			[appDelegate.UnitDictionary removeObjectsForKeys:[RemoveObj mutableCopy]];
			[RemoveObj release];
			[tblView reloadData];		
		}
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


#pragma mark TextField Methods

 // return NO to disallow editing.

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	SelectedTag=textField.tag;
	if(appDelegate.DailyTag==2)
	{		
		/// Called when User in Exercise and Change the value
		SelectedText=textField;
		PickerView.hidden=FALSE;
		ToolBar.hidden=FALSE;
		lblData.text=@"Select Exercise Duration";
		[PickerView reloadAllComponents];
		if([[ExerciseValueDictionary valueForKey:[NSString stringWithFormat:@"%d",SelectedTag-1]] length]>0)
		{
			NSArray *arr=[[ExerciseValueDictionary valueForKey:[NSString stringWithFormat:@"%d",SelectedTag-1]] componentsSeparatedByString:@":"]; 
			int row=[self GetPickerRow:[arr objectAtIndex:0] component:7];
			[PickerView selectRow:row inComponent:0 animated:NO];
			row=[self GetPickerRow:[arr objectAtIndex:1] component:6];
			[PickerView selectRow:row inComponent:1 animated:NO];
		}
		else
		{
			[PickerView selectRow:0 inComponent:0 animated:NO];
			[PickerView selectRow:0 inComponent:1 animated:NO];
		}
		return NO;
	}
	if(appDelegate.DailyTag==6)
	{
		/// Called when User in Food Consumption and Change the value
		IsDeleteTheRow=FALSE;
		if(!objTwoTextEntryViewController)
			objTwoTextEntryViewController=[[TwoTextEntryViewController alloc]initWithNibName:@"TwoTextEntryViewController" bundle:nil];
		appDelegate.SelectedStatus=@"Feed_Data";
		objTwoTextEntryViewController.HeaderLabel=@"Feed";
		NSDictionary *DIC=[appDelegate.UnitDictionary objectForKey:[MedicineArray objectAtIndex:SelectedTag-1]];
		objTwoTextEntryViewController.strQty=[DIC valueForKey:@"Feed_Qty"];
		appDelegate.StrUnit=[DIC valueForKey:@"Feed_Unit"];
		objTwoTextEntryViewController.strUnit=[selectedArrayData objectAtIndex:SelectedTag-1];
		objTwoTextEntryViewController.SelectedIndex=[[MedicineArray objectAtIndex:SelectedTag-1]intValue];
		objTwoTextEntryViewController.Index=0;
		[self.navigationController pushViewController:objTwoTextEntryViewController animated:YES];		
	}
	else if(appDelegate.DailyTag==20)
	{
		/// Called when User in Medicine and Change the value
		IsDeleteTheRow=FALSE;
		if(!objTwoTextEntryViewController)
			objTwoTextEntryViewController=[[TwoTextEntryViewController alloc]initWithNibName:@"TwoTextEntryViewController" bundle:nil];
		objTwoTextEntryViewController.HeaderLabel=@"Medicine";
		appDelegate.SelectedStatus=@"Medicine_Data";
		NSDictionary *DIC=[appDelegate.UnitDictionary objectForKey:[MedicineArray objectAtIndex:SelectedTag-1]];
		objTwoTextEntryViewController.strQty=[DIC valueForKey:@"Med_Qty"];
		appDelegate.StrUnit=[DIC valueForKey:@"Med_Unit"];
		[self BackUpdata];
		objTwoTextEntryViewController.strUnit=[selectedArrayData objectAtIndex:SelectedTag-1];
		objTwoTextEntryViewController.SelectedIndex=[[MedicineArray objectAtIndex:SelectedTag-1]intValue];
		objTwoTextEntryViewController.Index=0;
		[self.navigationController pushViewController:objTwoTextEntryViewController animated:YES];		
	}
	return NO;
}


-(BOOL)keyboardInput:(id)k shouldInsertText:(id)i isMarkedText:(int)b 
{	
	int len=[SelectedText.text length];	
	if(len<2)
	{	
		return YES;
	}
	else
	{
		return NO;
	}	
	return NO;	
}

 // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
- (void)textFieldDidEndEditing:(UITextField *)textField
{
	[ExerciseValueDictionary setValue:textField.text forKey:[NSString stringWithFormat:@"%d",SelectedTag-1]];
}

// called on finger up if user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	[SelectedText resignFirstResponder];
}


  // called when 'return' key pressed. return NO to ignore.
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[SelectedText resignFirstResponder];
	SelectedTag=textField.tag;
	SelectedText=textField;
	return YES;
}


#pragma mark pickerView


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
		if([str1 isEqualToString:str2])
		{			
			return Row;
		}
	}
	return 0;
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pV
{	
	return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pV numberOfRowsInComponent:(NSInteger)component
{	
	if(component==0)
	{
		return [[data objectForKey:[NSString stringWithFormat:@"%d",7]]  count];
	}
	else
		return [[data objectForKey:[NSString stringWithFormat:@"%d",6]]  count];
}

// these methods return either a plain UIString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse. 
// If you return back a different object, the old one will be released. the view will be centered in the row rect  

- (NSString *)pickerView:(UIPickerView *)pV titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if(component==0)
	{
		NSString *strRestaurantType1=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",7]] objectAtIndex:row];
		if([strRestaurantType1 isEqualToString:@"1"])
		{
			return [NSString stringWithFormat:@"%@ Hr",strRestaurantType1];
			
		}
		else
			return [NSString stringWithFormat:@"%@ Hrs",strRestaurantType1];
	}
	else
	{
		NSString *strRestaurantType1=(NSString *)[[data objectForKey:[NSString stringWithFormat:@"%d",6]] objectAtIndex:row];
		return [NSString stringWithFormat:@"%@ Min",strRestaurantType1];
	}
}

- (void)dealloc
{	
	[tblView release];
	[data release];
	[selectedArray release];
	[selectedArrayData release];
	[selectedImage release];
	[unselectedImage release];
	[btnSave release];
	[btnCancle release];
	[appDelegate release];
	[toolBar release];
	[arr1 release];
	[NavText release];
	[MedicineArray release];
	[btnSettings release];
	[SelectMedicineSettings release];
	[SettingsCon release];
    [super dealloc];
}
@end
