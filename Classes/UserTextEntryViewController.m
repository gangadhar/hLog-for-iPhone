//
//  UserTextEntryViewController.m
//  hLog
//  Created by Bhoomi on 3/9/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

// Import All needed header files bellow.
#import "UserTextEntryViewController.h"


@implementation UserTextEntryViewController

// Fields or variables or tools whose property has been declared must be Synthesize here...
@synthesize selectedName,selectedIndex,TextData; 
@synthesize Data1,MED_ID;

#pragma mark View Methods

// Called when the view has been fully transitioned onto the screen. Default does nothing
-(void)viewDidAppear:(BOOL)animated
{
	if([appDelegate.SelectedStatus isEqualToString:@"Users"])
	{
		
		if(self.selectedIndex==17 || self.selectedIndex== 20 || self.selectedIndex ==21 || self.selectedIndex==11  || self.selectedIndex== 12 || self.selectedIndex ==14)
		{
			[txtField becomeFirstResponder];
		}
		else
		{
			[txtView becomeFirstResponder];
		}
	}
	else if([appDelegate.SelectedStatus isEqualToString:@"Feed_Data"] || [appDelegate.SelectedStatus isEqualToString:@"Medicine_Data"]  ||  [appDelegate.SelectedStatus isEqualToString:@"Past"])
	{
		[txtField becomeFirstResponder];
	}
	else if([appDelegate.SelectedStatus isEqualToString:@"Hourly"] && self.selectedIndex==7)
	{
		[txtField becomeFirstResponder];
	}
	else
	{
		[txtView becomeFirstResponder];
	}
}

// Called when the view is dismissed, covered or otherwise hidden. Default does nothing
-(void)viewWillDisappear:(BOOL)animated
{
	if([appDelegate.SelectedStatus isEqualToString:@"Users"])
	{
		
		if(self.selectedIndex==17 || self.selectedIndex== 20 || self.selectedIndex ==21 ||self.selectedIndex==11  || self.selectedIndex== 12 || selectedIndex ==14)
		{
			[txtField resignFirstResponder];
		}
		else
		{
			[txtView resignFirstResponder];
		}
	}
	else if([appDelegate.SelectedStatus isEqualToString:@"Feed_Data"] || [appDelegate.SelectedStatus isEqualToString:@"Medicine_Data"]  ||  [appDelegate.SelectedStatus isEqualToString:@"Past"])
	{
		[txtField resignFirstResponder];
	}
	else if([appDelegate.SelectedStatus isEqualToString:@"Hourly"] && self.selectedIndex==7)
	{
		[txtField resignFirstResponder];
	}
	else
	{
		[txtView resignFirstResponder];
	}
	
}

 // Called when the view is about to made visible. Default does nothing
- (void)viewWillAppear:(BOOL)animated
{
	if([appDelegate.SelectedStatus isEqualToString:@"Users"])
	{		
		if(self.selectedIndex==17  || self.selectedIndex== 20 || self.selectedIndex ==21 || self.selectedIndex==11  || self.selectedIndex== 12 || self.selectedIndex ==14)
		{
			if(self.selectedIndex==17  || self.selectedIndex== 20 || self.selectedIndex ==21)
				txtField.keyboardType=UIKeyboardTypeNumberPad;
			else
				txtField.keyboardType=UIKeyboardTypeDefault;
			txtField.placeholder=self.selectedName;
			txtField.secureTextEntry=FALSE;
			txtField.hidden=FALSE;
			Cell2.hidden=FALSE;
			txtView.hidden=TRUE;
			Cell1.hidden=TRUE;
			txtField.text=self.TextData;
			[self.view bringSubviewToFront:Cell2];
			[self.view bringSubviewToFront:txtField];
		}
		else
		{
			
			txtView.keyboardType=UIKeyboardTypeDefault;
			txtField.hidden=TRUE;
			Cell2.hidden=TRUE;
			txtView.hidden=FALSE;
			Cell1.hidden=FALSE;
			txtView.text=self.TextData;
		}
	}
	else if([appDelegate.SelectedStatus isEqualToString:@"Feed_Data"] || [appDelegate.SelectedStatus isEqualToString:@"Medicine_Data"] ||  [appDelegate.SelectedStatus isEqualToString:@"Past"])
	{
		txtField.keyboardType=UIKeyboardTypeDefault;
		txtField.placeholder=self.selectedName;
		txtField.secureTextEntry=FALSE;
		txtField.hidden=FALSE;
		Cell2.hidden=FALSE;
		txtView.hidden=TRUE;
		Cell1.hidden=TRUE;
		txtField.text=self.TextData;
		[self.view bringSubviewToFront:Cell2];
		[self.view bringSubviewToFront:txtField];
	}
	else if([appDelegate.SelectedStatus isEqualToString:@"Hourly"] && selectedIndex==7)
	{
		txtField.keyboardType=UIKeyboardTypeNumberPad;
		txtField.placeholder=self.selectedName;
		txtField.secureTextEntry=FALSE;
		txtField.hidden=FALSE;
		Cell2.hidden=FALSE;
		txtView.hidden=TRUE;
		Cell1.hidden=TRUE;
		txtField.text=self.TextData;
		[self.view bringSubviewToFront:Cell2];
		[self.view bringSubviewToFront:txtField];
	}
	else
	{
		txtView.keyboardType=UIKeyboardTypeDefault;
		txtField.hidden=TRUE;
		Cell2.hidden=TRUE;
		txtView.hidden=FALSE;
		Cell1.hidden=FALSE;
		txtView.text=self.TextData;
	}
	[label1 setText:self.selectedName];
	self.navigationItem.titleView=label1;	
}
// Called after the view has been loaded. For view controllers created in code, this is after -loadView. For view controllers unarchived from a nib, this is after the view is set.
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	txtView.text=@"";
	appDelegate=[[UIApplication sharedApplication]delegate];
	self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
	self.navigationItem.leftBarButtonItem=btnCancel;
	self.navigationItem.rightBarButtonItem=btnDone;
	txtView.delegate=self;
	txtField.delegate=self;
	txtView.returnKeyType=UIReturnKeyDone;
	txtView.autocorrectionType=UITextAutocorrectionTypeNo;
	label1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 220, 30)];
	[label1 setFont:[UIFont boldSystemFontOfSize:15.0]];
	[label1 setBackgroundColor:[UIColor clearColor]];
	[label1 setTextAlignment:UITextAlignmentCenter];
 	[label1 setTextColor:[UIColor whiteColor]];
	Cell2.frame=CGRectMake(8, 74, 305, 50);
	txtField.frame=CGRectMake(15, 75, 290, 45);
	txtField.font=[UIFont systemFontOfSize:19];
	txtView.keyboardAppearance=UIKeyboardAppearanceAlert; 
	txtField.keyboardAppearance=UIKeyboardAppearanceAlert; 
	txtView.autocorrectionType=UITextAutocorrectionTypeNo;
	txtField.autocorrectionType=UITextAutocorrectionTypeNo;
    [super viewDidLoad];
}

/// Call for chaarcter limit for particular limit

-(BOOL)keyboardInput:(id)k shouldInsertText:(id)i isMarkedText:(int)b 
{
	char s=[i characterAtIndex:0];
	if(s!=10)
	{
		if([appDelegate.SelectedStatus isEqualToString:@"Users"]) 
		{
			if(self.selectedIndex==17 || self.selectedIndex== 20 || self.selectedIndex ==21)
			{
				int len=[txtField.text length];
				if(self.selectedIndex==17 || self.selectedIndex== 20 || self.selectedIndex ==21) //// For Phone number, emr contact
				{
					if(len<11)
					{	
						return YES;
					}
					else
					{
						return NO;
					}
				}
			}
			else if(self.selectedIndex==11  || self.selectedIndex== 12 || self.selectedIndex ==14)
			{
				int len=[txtField.text length];
				
				if(len<25)
				{	
					return YES;
				}
				else
				{
					return NO;
				}
				
			}
			else
			{
				int len=[txtView.text length];
				if(self.selectedIndex==1 || self.selectedIndex==16)
				{
					if(len<100)
					{	
						return YES;
					}
					else
					{
						return NO;
					}
				}
				else if(self.selectedIndex==23 || self.selectedIndex==24 || self.selectedIndex==18)
				{
					if(len<50)
					{	
						return YES;
					}
					else
					{
						return NO;
					}
				}
				
				else if(self.selectedIndex==19)
				{
					if(len<25)
					{	
						return YES;
					}
					else
					{
						return NO;
					}
				}
				else if(self.selectedIndex==22 )
				{
					if(len<50)
					{	
						return YES;
					}
					else
					{
						return NO;
					}
				}
			}
		}
		else if([appDelegate.SelectedStatus isEqualToString:@"Feed_Data"]) //// check length for feed unit
		{
			int len=[txtField.text length];
			if(len<10)
			{	
				return YES;
			}
			else
			{
				return NO;
			}
			
		}
		else if([appDelegate.SelectedStatus isEqualToString:@"Medicine_Data"]) //// check length for medicine  unit
		{
			int len=[txtField.text length];			
				if(len<10)
				{	
					return YES;
				}
				else
				{
					return NO;
				}			
		}
		else if([appDelegate.SelectedStatus isEqualToString:@"Past"]) //// check length for past name
		{
			int len=[txtField.text length];			
			if(len<50)
			{	
				return YES;
			}
			else
			{
				return NO;
			}
		}
		if([appDelegate.SelectedStatus isEqualToString:@"Daily"]) //// check length for Daily data
		{
			int len=[txtView.text length];
			if(self.selectedIndex==10) /// For Other info
			{
				if(len<100)
				{	
					return YES;
				}
				else
				{
					return NO;
				}
			}
		}
		if([appDelegate.SelectedStatus isEqualToString:@"Contact"]) ////  Check for Email Address
		{
			if([txtView.text length]>0)
			{
				NSArray *arr=[txtView.text componentsSeparatedByString:@"@"];
				if([arr count]>1)
					ISEmail=TRUE;
				else
					ISEmail=FALSE;
			}
			else
				ISEmail=FALSE;
			if(s!=64)
				return YES;
			if(s==64 && ISEmail==FALSE)
			{
				ISEmail=TRUE;
				return YES;
			}
			else
				return NO;				
		}
		if([appDelegate.SelectedStatus isEqualToString:@"Hourly"]) //// Hor enter Hourly data
		{
			if(self.selectedIndex==7)
			{
				int len=[txtField.text length];
				if(len<5)
				{	
					return YES;
				}
				else
				{
					return NO;
				}
			}
			else
			{
				int len=[txtView.text length];
				if(self.selectedIndex==6 || self.selectedIndex==26 || self.selectedIndex==27)
				{
					if(len<50)
					{	
						return YES;
					}
					else
					{
						return NO;
					}
				}
				else if(self.selectedIndex==8 || self.selectedIndex== 12 || self.selectedIndex ==10)
				{
					if(len<100)
					{	
						return YES;
					}
					else
					{
						return NO;
					}
				}
			}
			
		}		
		else
		{
			int len=[txtView.text length];
			if(len<25)
			{	
				return YES;
			}
			else
			{
				return NO;
			}
		}
	}
	else
	{
		[self StoreData];
		return NO;
	}
	return YES;
}

//// Set Data to Dictionaly or array for store value
-(void)StoreData
{
	NSAutoreleasePool *POOL=[[NSAutoreleasePool alloc]init];
	NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@" "];
	
	if([appDelegate.SelectedStatus isEqualToString:@"Users"])
	{
		if(self.selectedIndex==17 || self.selectedIndex== 20 || self.selectedIndex ==21 || self.selectedIndex==12 || self.selectedIndex==11 || self.selectedIndex ==14)
		{
			txtField.text=[txtField.text stringByTrimmingCharactersInSet:set];
			if(self.selectedIndex==17) /// For health provider number
			{
				[appDelegate.DetailDIC setValue:txtField.text forKey:@"PastPhoneNumber"];
			}
			else if(self.selectedIndex==20) /// For insurance phone
			{
				[appDelegate.DetailDIC setValue:txtField.text forKey:@"PastPhone"];
			}
			else if(self.selectedIndex==21) /// For Insurance Emr Contact
			{
				[appDelegate.DetailDIC setValue:txtField.text forKey:@"PastEmrContact"];
			}
			else if(self.selectedIndex==11) /// For other smoking
			{
				[appDelegate.AddNewUserDict setValue:txtField.text forKey:@"Smoking"];
			}
			else if(self.selectedIndex==12) /// For other Drinking
			{
				[appDelegate.AddNewUserDict setValue:txtField.text forKey:@"Drinking"];
			}
			else if(self.selectedIndex==14)
			{
				[appDelegate.AddNewUserDict setValue:txtField.text forKey:@"Past"];
			}
		}
		else
		{
			txtView.text =[txtView.text stringByTrimmingCharactersInSet:set];
			if(self.selectedIndex==1)
			{
				[appDelegate.AddNewUserDict setValue:txtView.text forKey:@"UserName"];
			}
			else if(self.selectedIndex==16) /// For Health care provider name 
			{
				[appDelegate.DetailDIC setValue:txtView.text forKey:@"PastName"];
			}
			
			else if(self.selectedIndex==18) /// For Insurance Identifiction 
			{
				[appDelegate.DetailDIC setValue:txtView.text forKey:@"PastIdentification"];
			}
			else if(self.selectedIndex==19) /// For Insurance Policy Number 
			{
				[appDelegate.DetailDIC setValue:txtView.text forKey:@"PastPolicyNo"];
			}
		}
	}
	else if([appDelegate.SelectedStatus isEqualToString:@"Daily"]) //// store daily data
	{
		txtView.text =[txtView.text stringByTrimmingCharactersInSet:set];
		if(self.selectedIndex==10) /// For insert Other info
		{
			appDelegate.Vitals_Detailref.Other=txtView.text;
		}
	}
	else if([appDelegate.SelectedStatus isEqualToString:@"Medicine"]) /// For enter medicine name
	{
		txtView.text =[txtView.text stringByTrimmingCharactersInSet:set];
		if([txtView.text length]>0)
		{			
			[txtView resignFirstResponder];
			if(self.MED_ID>0) /// Is for upadate
			{
				BOOL ISMedicineExist=[appDelegate IsMedicineExist:[txtView.text lowercaseString]];  /// Check for existance
				if(ISMedicineExist==FALSE)
					[appDelegate UpdateMedicine:txtView.text andID:self.MED_ID];
				else
				{
					if(![txtView.text isEqualToString:self.TextData])
					{
						[self ShowAlert:@"medicine"];
						return;
					}
				}
			}
			else /// Is for insert
			{
				BOOL ISMedicineExist=[appDelegate IsMedicineExist:[txtView.text lowercaseString]];  /// Check for existance
				if(ISMedicineExist==FALSE)
				{
					 
					int lastID=	[appDelegate InsertMedicine:txtView.text];  /// Insert Medicine
					if(lastID>0)
					{
						//// Update setting for that user
						[appDelegate SelectUserSettings:appDelegate.SelectedUserID];
						if([appDelegate.UserSettingsArray count]==1)
						{
							User_Settings *Data=[appDelegate.UserSettingsArray objectAtIndex:0];
							if([Data.MedicineEntryDetail length]>0)
							{
								NSString *SelectedItems=Data.MedicineEntryDetail;
								SelectedItems=[NSString stringWithFormat:@"%@,%d",SelectedItems,lastID];								
								[appDelegate UpdateUserData:appDelegate.SelectedUserID DailyData:SelectedItems ColumnName:@"MedicineEntryDetail"];
							}
							else
							{
								NSString *SelectedItems;
								SelectedItems=[NSString stringWithFormat:@"%d",lastID];								
								[appDelegate UpdateUserData:appDelegate.SelectedUserID DailyData:SelectedItems ColumnName:@"MedicineEntryDetail"];
							}
						}
					}
				}
				else
				{
					if(![txtView.text isEqualToString:self.TextData])
					{
						[self ShowAlert:@"medicine"];
						[POOL release];
						return;
					}
				}
				appDelegate.DailyTag=20;
				[self.navigationController popViewControllerAnimated:YES];
				return;
			}
		}
	}
	else if([appDelegate.SelectedStatus isEqualToString:@"Exercise"]) //// Insert Exercise
	{
		txtView.text =[txtView.text stringByTrimmingCharactersInSet:set];
		if([txtView.text length]>0)
		{			
			txtView.text=[txtView.text stringByReplacingOccurrencesOfString:@" (" withString:@"("];
			if(self.MED_ID>0) /// It for edit exercise
			{
				BOOL ISMedicineExist=[appDelegate IsExerciseExist:[txtView.text lowercaseString]];  /// Check for existance
				if(ISMedicineExist==FALSE)
					[appDelegate UpdateExercise:txtView.text  andID:self.MED_ID]; /// Upadte Exercise
				else
				{
					if(![txtView.text isEqualToString:self.TextData])
					{
						[self ShowAlert:@"exercise"];
						[POOL release];
						return;
					}
				}
			}
			else /// It for insert exercise
			{
				BOOL ISMedicineExist=[appDelegate IsExerciseExist:[txtView.text lowercaseString]];   /// Check for existance
				if(ISMedicineExist==FALSE)
				{
					int lastID=[appDelegate InsertExercise:txtView.text];  //// Insert exercise
					if(lastID>0)
					{
						//// Update setting for that user
						[appDelegate SelectUserSettings:appDelegate.SelectedUserID];						
						if([appDelegate.UserSettingsArray count]==1)
						{
							User_Settings *Data=[appDelegate.UserSettingsArray objectAtIndex:0];
							if([Data.ExerciseEntryDetail length]>0)
							{
								NSString *SelectedItems=Data.ExerciseEntryDetail;
								SelectedItems=[NSString stringWithFormat:@"%@,%d",SelectedItems,lastID];								
								[appDelegate UpdateUserData:appDelegate.SelectedUserID DailyData:SelectedItems ColumnName:@"Exercise_Settings"];
							}
							else
							{
								NSString *SelectedItems;
								SelectedItems=[NSString stringWithFormat:@"%d",lastID];								
								[appDelegate UpdateUserData:appDelegate.SelectedUserID DailyData:SelectedItems ColumnName:@"Exercise_Settings"];
							}
						}						
					}
				}
				else
				{
					if(![txtView.text isEqualToString:self.TextData])
					{
						[self ShowAlert:@"exercise"];
						[POOL release];
						return;
					}
				}
			}
			appDelegate.DailyTag=2;
			[self.navigationController popViewControllerAnimated:YES];
		}	
	}
	else if([appDelegate.SelectedStatus isEqualToString:@"Mood"]) /// Insert or update Mood
	{
		txtView.text =[txtView.text stringByTrimmingCharactersInSet:set];
		if([txtView.text length]>0)
		{			
			txtView.text=[txtView.text stringByReplacingOccurrencesOfString:@"," withString:@", "];
			if(self.MED_ID>0) /// For update mood
			{
				BOOL ISMedicineExist=[appDelegate IsExist:txtView.text :@"Mood"];  /// Check for existance
				if(ISMedicineExist==FALSE)
					[appDelegate Update:txtView.text andID:self.MED_ID :@"Mood"]; //// Update Mood
				else
				{
					if(![txtView.text isEqualToString:self.TextData])
					{
						[self ShowAlert:@"mood"];
						[POOL release];
						return;
					}
				}				
			}
			else //// For insert mood
			{
				BOOL ISMedicineExist=[appDelegate IsExist:txtView.text :@"Mood"];  /// Check for existance
				if(ISMedicineExist==FALSE)
				{
					//// Update setting for that user
					int lastID= [appDelegate InsertTableValue:@"Mood" :txtView.text];  /// Insert Mood
					if(lastID>0)
					{
						[appDelegate SelectUserSettings:appDelegate.SelectedUserID];
						if([appDelegate.UserSettingsArray count]==1)
						{
							User_Settings *Data=[appDelegate.UserSettingsArray objectAtIndex:0];
							if([Data.MoodEntryDetail length]>0)
							{
								NSString *SelectedItems=Data.MoodEntryDetail;
								SelectedItems=[NSString stringWithFormat:@"%@,%d",SelectedItems,lastID];								
								[appDelegate UpdateUserData:appDelegate.SelectedUserID DailyData:SelectedItems ColumnName:@"Mood_Settings"];
							}
							else
							{
								NSString *SelectedItems;
								SelectedItems=[NSString stringWithFormat:@"%d",lastID];								
								[appDelegate UpdateUserData:appDelegate.SelectedUserID DailyData:SelectedItems ColumnName:@"Mood_Settings"];
							}
						}
					}
				}
				else
				{
					if(![txtView.text isEqualToString:self.TextData])
					{
						[self ShowAlert:@"mood"];
						[POOL release];
						return;
					}
				}
			}
			appDelegate.DailyTag=3;
			[self.navigationController popViewControllerAnimated:YES];
		}	
	}
	else if([appDelegate.SelectedStatus isEqualToString:@"Activity"]) /// for update or insert Activity
	{
		txtView.text =[txtView.text stringByTrimmingCharactersInSet:set];
		if([txtView.text length]>0)
		{			
			txtView.text=[txtView.text stringByReplacingOccurrencesOfString:@"," withString:@", "];
			if(self.MED_ID>0) //// Is for update
			{
				BOOL ISMedicineExist=[appDelegate IsExist:txtView.text :@"Activity"];  /// Check for existance
				if(ISMedicineExist==FALSE)
					[appDelegate Update:txtView.text andID:self.MED_ID :@"Activity"]; //// Update Activity
				else
				{
					if(![txtView.text isEqualToString:self.TextData])
					{
						[self ShowAlert:@"activity"];
						[POOL release];
						return;
					}
				}
			}
			else /// is for Insert
			{
				BOOL ISMedicineExist=[appDelegate IsExist:txtView.text :@"Activity"];/// Check for existance
				if(ISMedicineExist==FALSE)
				{
					int lastID=[appDelegate InsertTableValue:@"Activity" :txtView.text];    ///// Insert Activity
					if(lastID>0)
					{
						//// Update setting for that user 
						
						[appDelegate SelectUserSettings:appDelegate.SelectedUserID];
						if([appDelegate.UserSettingsArray count]==1)
						{
							User_Settings *Data=[appDelegate.UserSettingsArray objectAtIndex:0];
							if([Data.ActivityEntryDetail length]>0)
							{
								NSString *SelectedItems=Data.ActivityEntryDetail;
								SelectedItems=[NSString stringWithFormat:@"%@,%d",SelectedItems,lastID];								
								[appDelegate UpdateUserData:appDelegate.SelectedUserID DailyData:SelectedItems ColumnName:@"Activity_Settings"];
							}
							else
							{
								NSString *SelectedItems;
								SelectedItems=[NSString stringWithFormat:@"%d",lastID];								
								[appDelegate UpdateUserData:appDelegate.SelectedUserID DailyData:SelectedItems ColumnName:@"Activity_Settings"];
							}
						}
					}
				}
				else
				{
					if(![txtView.text isEqualToString:self.TextData])
					{
						[self ShowAlert:@"activity"];
						[POOL release];
						return;
					}
				}
			}
			appDelegate.DailyTag=4;
			[self.navigationController popViewControllerAnimated:YES];
		}	
	}
	else if([appDelegate.SelectedStatus isEqualToString:@"Diapering"]) //// for insert or update Diapering
	{
		txtView.text =[txtView.text stringByTrimmingCharactersInSet:set];
		if([txtView.text length]>0)
		{			
			txtView.text=[txtView.text stringByReplacingOccurrencesOfString:@"," withString:@", "];
			if(self.MED_ID>0) //// Is for update
			{
				BOOL ISMedicineExist=[appDelegate IsExist:txtView.text :@"Diapering"];  /// Check for existance
				if(ISMedicineExist==FALSE)
					[appDelegate Update:txtView.text andID:self.MED_ID :@"Diapering"]; //// Update Diapering
				else
				{
					if(![txtView.text isEqualToString:self.TextData])
					{
						[self ShowAlert:@"diapering"];
						[POOL release];
						return;
					}
				}
			}
			else /// Is for insert
			{
				BOOL ISMedicineExist=[appDelegate IsExist:txtView.text :@"Diapering"];  /// Check for existance
				if(ISMedicineExist==FALSE)
				{
					int lastID=[appDelegate InsertTableValue:@"Diapering" :txtView.text];   //// Insert Diapering
					if(lastID>0)
					{
						//// Update setting for that user
						
						[appDelegate SelectUserSettings:appDelegate.SelectedUserID];
						if([appDelegate.UserSettingsArray count]==1)
						{
							User_Settings *Data=[appDelegate.UserSettingsArray objectAtIndex:0];
							if([Data.DiperingEntryDetail length]>0)
							{
								NSString *SelectedItems=Data.DiperingEntryDetail;
								SelectedItems=[NSString stringWithFormat:@"%@,%d",SelectedItems,lastID];								
								[appDelegate UpdateUserData:appDelegate.SelectedUserID DailyData:SelectedItems ColumnName:@"Diapering_Settings"];
							}
							else
							{
								NSString *SelectedItems;
								SelectedItems=[NSString stringWithFormat:@"%d",lastID];								
								[appDelegate UpdateUserData:appDelegate.SelectedUserID DailyData:SelectedItems ColumnName:@"Diapering_Settings"];
							}
						}
					}
				}
				else
				{
					if(![txtView.text isEqualToString:self.TextData])
					{
						[self ShowAlert:@"diapering"];
						[POOL release];
						return;
					}
				}
			}
			appDelegate.DailyTag=5;
			[self.navigationController popViewControllerAnimated:YES];
		}	
	}
	
	else if([appDelegate.SelectedStatus isEqualToString:@"Feeding"]) //// For insert or update food consumed
	{
		txtView.text =[txtView.text stringByTrimmingCharactersInSet:set];
		if([txtView.text length]>0)
		{			
			txtView.text=[txtView.text stringByReplacingOccurrencesOfString:@"," withString:@", "];
			if(self.MED_ID>0) /// is for update
			{
				BOOL ISMedicineExist=[appDelegate IsExist:txtView.text :@"Feeding"];  /// Check for existance
				if(ISMedicineExist==FALSE)
					[appDelegate Update:txtView.text andID:self.MED_ID :@"Feeding"]; //// Update Food consumed
				else
				{
					if(![txtView.text isEqualToString:self.TextData])
					{
						[self ShowAlert:@"Feeding"];
						[POOL release];
						return;
					}
				}
			}
			else /// is for insert
			{
				BOOL ISMedicineExist=[appDelegate IsExist:txtView.text :@"Feeding"];  /// Check for existance
				if(ISMedicineExist==FALSE)
				{
					int lastID=[appDelegate InsertTableValue:@"Feeding" :txtView.text];  //// insert Food consumed
					if(lastID>0)
					{
						//// Update setting for that user
						
						[appDelegate SelectUserSettings:appDelegate.SelectedUserID];
						if([appDelegate.UserSettingsArray count]==1)
						{
							User_Settings *Data=[appDelegate.UserSettingsArray objectAtIndex:0];
							if([Data.FeedingEntryDetail length]>0)
							{
								NSString *SelectedItems=Data.FeedingEntryDetail;
								SelectedItems=[NSString stringWithFormat:@"%@,%d",SelectedItems,lastID];								
								[appDelegate UpdateUserData:appDelegate.SelectedUserID DailyData:SelectedItems ColumnName:@"Feeding_Settings"];
							}
							else
							{
								NSString *SelectedItems;
								SelectedItems=[NSString stringWithFormat:@"%d",lastID];								
								[appDelegate UpdateUserData:appDelegate.SelectedUserID DailyData:SelectedItems ColumnName:@"Feeding_Settings"];
							}
						}
					}
				}
				else
				{
					if(![txtView.text isEqualToString:self.TextData])
					{
						[self ShowAlert:@"Feeding"];
						[POOL release];
						return;
					}
				}
			}
			appDelegate.DailyTag=6;
			[self.navigationController popViewControllerAnimated:YES];
		}	
	}
	else if([appDelegate.SelectedStatus isEqualToString:@"Past"]) /// Add past
	{
		txtField.text =[txtField.text stringByTrimmingCharactersInSet:set];
		if([txtField.text length]>0)
		{			
			txtField.text=[txtField.text stringByReplacingOccurrencesOfString:@"," withString:@", "];
			if(self.MED_ID>0) //// check is for Add or edit
			{
				int ISMedicineExist=[appDelegate PastNameID:txtField.text];   /// Check for existance
				
				if(ISMedicineExist==0)
					[appDelegate UpdateIntopast:txtField.text :self.MED_ID]; /// update past
				else
				{
					if(![txtField.text isEqualToString:self.TextData])
					{
						[self ShowAlert:@"Past"];
						[POOL release];
						return;
					}
				}				
			}
			else /// Is for Insert
			{
				int ISMedicineExist=[appDelegate PastNameID:txtField.text];
				if(ISMedicineExist==0)
				{
					int lastID= [appDelegate insertIntopast:txtField.text :[[appDelegate.AddNewUserDict valueForKey:@"UserID"]intValue]];  /// Insert Past
					if(lastID>0)
					{
						NSLog(@"Insert Successfully");
					}
				}
				else
				{
					if(![txtField.text isEqualToString:self.TextData])
					{
						[self ShowAlert:@"Past"];
						[POOL release];
						return;
					}
				}
			}
			appDelegate.DailyTag=14;
			[self.navigationController popViewControllerAnimated:YES];
		}	
	}
	else if([appDelegate.SelectedStatus isEqualToString:@"Feed_Data"]) ///// Store Feed unit data
	{
		txtField.text =[txtField.text stringByTrimmingCharactersInSet:set];
		if([txtField.text length]>0)
		{			
			txtField.text=[txtField.text stringByReplacingOccurrencesOfString:@"," withString:@", "];
			BOOL ISMedicineExist=[appDelegate IsExist:txtField.text :@"Feed_Unit"]; /// Check for existance
			if(ISMedicineExist==FALSE) //// If yes then Insert in to table
			{
				[appDelegate InsertTableValue:@"Feed_Unit" :txtField.text]; 
			}
			else /// If no then show message
			{
				if(![txtField.text isEqualToString:self.TextData])
				{
					[self ShowAlert:@"Feed Unit"];
					[POOL release];
					return;
				}
			}
			appDelegate.StrUnit=[txtField.text retain];
			[self.navigationController popViewControllerAnimated:YES];
		}	
	}
	else if([appDelegate.SelectedStatus isEqualToString:@"Medicine_Data"]) ///// Store Medicine unit data
	{
		txtField.text =[txtField.text stringByTrimmingCharactersInSet:set];
		if([txtField.text length]>0)
		{			
			txtField.text=[txtField.text stringByReplacingOccurrencesOfString:@"," withString:@", "];
			BOOL ISMedicineExist=[appDelegate IsExist:txtField.text :@"Medicine_Unit"]; /// Check for existance
			if(ISMedicineExist==FALSE) //// If yes then Insert in to table
			{
				[appDelegate InsertTableValue:@"Medicine_Unit" :txtField.text]; 
			}
			else /// If no then show message
			{
				if(![txtField.text isEqualToString:self.TextData])
				{
					[self ShowAlert:@"Medicine Unit"];
					[POOL release];
					return;
				}
			}
			appDelegate.StrUnit=[txtField.text retain];
			[self.navigationController popViewControllerAnimated:YES];
		}	
	}
	else if([appDelegate.SelectedStatus isEqualToString:@"Contact"])  ///// Store Contact for send mail
	{
		txtView.text =[txtView.text stringByTrimmingCharactersInSet:set];
		if([txtView.text length]>0)
		{
			BOOL ISValidEmail=FALSE;
			NSArray *Arr=[txtView.text componentsSeparatedByString:@"@"];
			if([Arr count]>1 && [[Arr objectAtIndex:0]length]!=0)
			{
				NSArray *arr2=[[Arr objectAtIndex:1]  componentsSeparatedByString:@"."];
				if([arr2 count]>1)
				{
					ISValidEmail=TRUE;
				}
			} 
			if(ISValidEmail) /// If valid email then enter
			{
				if(self.selectedIndex==-1)
				{
					[appDelegate.NewTableArray addObject:txtView.text];
				}
				else
				{
					[appDelegate.NewTableArray replaceObjectAtIndex:self.selectedIndex withObject:txtView.text];
				}
			}
			else
			{
				UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter a valid email address." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alert show];
				[alert release];
				return;
			}
		}
		else
		{
			return;
		}
	}
	
	else
	{		
		if(self.selectedIndex==7)
		{
			appDelegate.Routine_Detailrf.calories=[txtField.text intValue];
		}
		else
		{
			if(self.selectedIndex==8)
			{
				appDelegate.Routine_Detailrf.Alcohol=txtView.text;
			}
			else if(self.selectedIndex==10)
			{
				appDelegate.Routine_Detailrf.Drugs=txtView.text;
			}
			else if(self.selectedIndex==12)
			{
				appDelegate.Routine_Detailrf.Other=txtView.text;
			}
			else if(self.selectedIndex==26)
			{
				appDelegate.Routine_Detailrf.Activity=txtView.text;
				if(appDelegate.isFromEditReport==TRUE)
					[self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex:3] animated:YES];
				else
					[self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex:1] animated:YES];
				[POOL release];
				return;
				
			}
			else if(self.selectedIndex==27)
			{
				appDelegate.Routine_Detailrf.Mood=txtView.text;
				if(appDelegate.isFromEditReport==TRUE)
					[self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex:3] animated:YES];
				else
					[self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex:1] animated:YES];
				
				[POOL release];
				return;
				
			}
		}
	}
	
	[POOL release];
	[self.navigationController popViewControllerAnimated:YES];
}

/////  For Showning Message
-(void)ShowAlert:(NSString *)Message
{
	UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:@"" message:[NSString  stringWithFormat:@"This %@ is already existing in the list!",Message] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	Alert.tag=1;
	[Alert show];
	[Alert release];
}

-(BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	//[self playSound];
	if ([string length] == 0) return YES;	// the backspace key sends in a zero length string, accept that
	
	if([appDelegate.SelectedStatus isEqualToString:@"Users"]) 
	{
		if(self.selectedIndex==17 || self.selectedIndex== 20 || self.selectedIndex ==21)
		{
			int len=[txtField.text length];
			if(self.selectedIndex==17 || self.selectedIndex== 20 || self.selectedIndex ==21) //// For Phone number, emr contact
			{
				if(len<11)
				{	
					NSCharacterSet *invalidNumberSet = [NSCharacterSet characterSetWithCharactersInString:@"[]{}#%^*+=_\\|~<>€£¥•,?!'/:;()$&@\"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRTSTUVWXYZ.-"];	// numbersAndPunct
					NSString* string1=@"";
					for(int i=0;i< [string length];i++)
					{
						NSRange range;
						range.location=i;
						range.length=1;
						NSScanner *scanner1 = [NSScanner scannerWithString:[[NSString stringWithFormat:@"%@",string]substringWithRange:range]];
						NSString  *scannerResult1;
						if([scanner1 scanUpToCharactersFromSet:invalidNumberSet intoString:&scannerResult1]) 
						{
							string1=[NSString stringWithFormat:@"%@%@",string1,[[NSString stringWithFormat:@"%@",string]substringWithRange:range]];
						}
					}
					//NSLog(string1);
					
					if([string length]==[string1 length])
						return YES;
					else
						return NO;
				}
				else
				{
					return NO;
				}
			}
		}
		else if(self.selectedIndex==11  || self.selectedIndex== 12 || self.selectedIndex ==14)
		{
			int len=[txtField.text length];
			
			if(len<25)
			{	
				return YES;
			}
			else
			{
				return NO;
			}
			
		}
	}
	else if([appDelegate.SelectedStatus isEqualToString:@"Feed_Data"]) //// check length for feed unit
	{
		int len=[txtField.text length];
		if(len<10)
		{	
			return YES;
		}
		else
		{
			return NO;
		}		
	}
	else if([appDelegate.SelectedStatus isEqualToString:@"Medicine_Data"]) //// check length for medicine  unit
	{
		int len=[txtField.text length];			
		if(len<10)
		{	
			return YES;
		}
		else
		{
			return NO;
		}			
	}
	else if([appDelegate.SelectedStatus isEqualToString:@"Past"]) //// check length for past name
	{
		int len=[txtField.text length];			
		if(len<50)
		{	
			return YES;
		}
		else
		{
			return NO;
		}
	}
	
	else if([appDelegate.SelectedStatus isEqualToString:@"Hourly"]) //// Hor enter Hourly data
	{
		if(self.selectedIndex==7)
		{
			int len=[txtField.text length];
			if(len<5)
			{	
				NSCharacterSet *invalidNumberSet = [NSCharacterSet characterSetWithCharactersInString:@"[]{}#%^*+=_\\|~<>€£¥•,?!'/:;()$&@\"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRTSTUVWXYZ.-"];	// numbersAndPunct
				NSString* string1=@"";
				for(int i=0;i< [string length];i++)
				{
					NSRange range;
					range.location=i;
					range.length=1;
					NSScanner *scanner1 = [NSScanner scannerWithString:[[NSString stringWithFormat:@"%@",string]substringWithRange:range]];
					NSString  *scannerResult1;
					if([scanner1 scanUpToCharactersFromSet:invalidNumberSet intoString:&scannerResult1]) 
					{
						string1=[NSString stringWithFormat:@"%@%@",string1,[[NSString stringWithFormat:@"%@",string]substringWithRange:range]];
						//NSLog(string1);
					}
				}
				//NSLog(string1);
				
				if([string length]==[string1 length])
					return YES;
				else
					return NO;
			}
			else
			{
				return NO;
			}
		}
	}
	return YES;
}

#pragma mark Button Click Events

//An event when user clicks on Done butto//n.
-(IBAction)Done:(id)sender
{	
	[self StoreData];	
}

//An event when user clicks on Cancel button.
-(IBAction)Cancel:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
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


- (void)dealloc {
	
	[txtView release];
	[btnCancel release];
	[btnDone release];
	[self.selectedName release];
	[appDelegate release];
	[self.TextData release];
	
    [super dealloc];
}


@end
