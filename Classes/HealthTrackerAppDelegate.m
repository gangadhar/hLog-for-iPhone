//
//  hLogAppDelegate.m
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
#import "HealthTrackerAppDelegate.h"
#import "RootViewController.h"

#define SMTP @"REPLACETHIS"
#define GMAILID @"REPLACETHIS"
#define GMAILPASSWORD @"REPLACETHIS"

#define DATABASE_NAME @"healthtracker_new.sql"

#pragma mark Synthesize Variable
// implementation of Interface here in '.m' file.
@implementation HealthTrackerAppDelegate

// Fields or variables or tools whose property has been declared must be Synthesize here...
@synthesize window,iSfromUsers,ReportArray;
@synthesize navigationController,DailyTag,SelectedStatus,iSfromAddUser,VitalsMasterArray,ISfromSettings;
@synthesize AddNewUserDict,UserSettingsArray,UserArray,EntryArray,SelectedUserID,SelectedItems,HourlyDataArray,MedicineArray,isFromChart;
@synthesize MensturalArray,SaveMenstural,PassCodeOnOff,WeekArray,DailyArray,isfromRoot,isDailyReport;//,SelectColumnName1,SelectColumnName;
@synthesize ReportStartDate,ReportEndDate,ReportField,UserName,SelectedLocation,DateFormatter,SelectedReportField,ISfromDefaultUser,ExerciseArray;
@synthesize objSettingsViewController;
@synthesize objSelectOptionsViewController;
@synthesize objRootViewController,objSelectViewController;
@synthesize objFirstViewController,isFromReport,isFromEditReport,isfromFavourite;
@synthesize objUserTextEntryViewController;
@synthesize objUserViewController,SelectSettingsView,ISFromFirstViewController;

@synthesize Routine_Detailrf,HealthInsuranceArray;
@synthesize Vitals_Detailref,DetailDIC;
@synthesize MedicineRef;
@synthesize Mensturalref;
@synthesize Columns,UserStatus,UnitDictionary;
@synthesize ISEdit,Row,objShowReportViewController,ISLiteVersion,ExerciseDurationArray,isForMail,RegistrationDic,isforReport,NewTableArray,NewDetailArray,StrUnit,IsFromMedicine,PastArray,AllPastArray;

#pragma mark Application laod Methods

- (void)applicationDidFinishLaunching:(UIApplication *)application 
{
	self.DateFormatter=[[NSDateFormatter alloc]init];
	[application setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];
	self.ISLiteVersion=FALSE;
	if(self.ISLiteVersion)
	{
		if([[NSUserDefaults standardUserDefaults] valueForKey:@"IsLiteVersion"]==nil)
		{
			[DateFormatter setDateFormat:@"MM-dd-yyyy"];
			[[NSUserDefaults standardUserDefaults] setObject:[DateFormatter stringFromDate:[NSDate date]] forKey:@"IsLiteVersion"];
			[[NSUserDefaults standardUserDefaults] synchronize];
		}
	}
	[self createEditableCopyOfDatabaseIfNeeded];

	[[NSUserDefaults standardUserDefaults] setObject:SMTP forKey:@"SMTP"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	[[NSUserDefaults standardUserDefaults] setObject:GMAILID forKey:@"FromEmail"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	[[NSUserDefaults standardUserDefaults] setObject:GMAILPASSWORD forKey:@"Password"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	if([[NSUserDefaults standardUserDefaults] valueForKey:@"Passcode"]==nil)
	{
		[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",0] forKey:@"Passcode"];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
	if([[NSUserDefaults standardUserDefaults] valueForKey:@"Weight"]==nil)
	{
		[[NSUserDefaults standardUserDefaults] setObject:@"LBs" forKey:@"Weight"];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
	if([[NSUserDefaults standardUserDefaults] valueForKey:@"Temperature"]==nil)
	{
		[[NSUserDefaults standardUserDefaults] setObject:@"F" forKey:@"Temperature"];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
	if([[NSUserDefaults standardUserDefaults] valueForKey:@"Height"]==nil)
	{
		[[NSUserDefaults standardUserDefaults] setObject:@"Inches" forKey:@"Height"];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
	self.PassCodeOnOff=[[[NSUserDefaults standardUserDefaults] valueForKey:@"Passcode"]intValue];
	if(self.PassCodeOnOff==1)
	{
		[self termCondition];
	}
	else
	{
		[window addSubview:[navigationController view]];
		[window makeKeyAndVisible];
	}
	if(!self.UnitDictionary)
		self.UnitDictionary=[[NSMutableDictionary alloc]init];	
}

- (void)applicationWillTerminate:(UIApplication *)application 
{
	// Save data if appropriate
}

#pragma mark For asking Passcode Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{	
	if(alertView.tag==2)
	{
		if(buttonIndex == 0)
		{		
			if([tf.text length]==0)
			{
				UIAlertView *alert3=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter a passcode!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				alert3.tag=3;
				[alert3 show];
				[alert3 release];
			}
		 	else if([tf.text length]==4)
			{
				NSString *Passcode=[[NSUserDefaults standardUserDefaults] valueForKey:@"PasscodeNo"];
				if([Passcode isEqualToString:tf.text])
				{
					
					[window addSubview:[navigationController view]];
					[window makeKeyAndVisible];
				}
				else
				{
					UIAlertView *alert3=[[UIAlertView alloc]initWithTitle:@"" message:@"Incorrect passcode entered. Please enter the correct passcode." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
					alert3.tag=3;
					[alert3 show];
					[alert3 release];
				}
			}
			else
			{
				UIAlertView *alert3=[[UIAlertView alloc]initWithTitle:@"" message:@"Passcode must contain four characters!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				alert3.tag=3;
				[alert3 show];
				[alert3 release];
			}
		}
		else 
		{
			exit(-1);
		}
	}
	if(alertView.tag==3)
	{
		tf.text=@"";
		[self termCondition]; 
	}
}

-(void)OK
{
	[tf resignFirstResponder];
	alert1.tag=2;
	[self alertView:alert1 clickedButtonAtIndex:0];
	[alert1 dismissWithClickedButtonIndex:0 animated:NO];	 	
}

-(BOOL)keyboardInput:(id)k shouldInsertText:(id)i isMarkedText:(int)b 
{
	char s=[i characterAtIndex:0];
	if(s!=10)
	{
		int len=[tf.text length];
		if(len<4)
		{	
			if(len==3)
			{
				[NSTimer scheduledTimerWithTimeInterval:(0.1)  target:self selector:@selector(OK) userInfo:nil repeats:NO];
			}
			return YES;
			return YES;
		}
		else
		{
			return NO;
		}
	}
	return NO;
}	

-(void)termCondition
{
	//tf=[[UITextField alloc]initWithFrame:CGRectMake(12,55, 260, 30)];
	tf.frame=CGRectMake(12, 55, 260, 30);
	tf.contentMode=UIViewContentModeCenter;
	tf.font=[UIFont systemFontOfSize:15.5];
	tf.secureTextEntry=YES; 
	tf.keyboardAppearance=UIKeyboardAppearanceAlert; 
	tf.clearButtonMode = UITextFieldViewModeWhileEditing;
	//[tf setDelegate:self];
	tf.autocorrectionType=UITextAutocorrectionTypeNo;
	tf.font=[UIFont systemFontOfSize:21];
	tf.returnKeyType=UIReturnKeyDone;
	tf.keyboardType=UIKeyboardTypeNumberPad;
	tf.borderStyle=UITextBorderStyleRoundedRect;
	tf.placeholder=@"Enter Passcode";	
	alert1=[[UIAlertView alloc]initWithTitle:tf.placeholder message:@"\n\n" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	alert1.frame=CGRectMake(10, 10, 280, 250);
	[alert1 addSubview:tf];
	[alert1 bringSubviewToFront:tf];
	CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0.0, 100.0);
	[alert1 setTransform:myTransform];
	[alert1 show];
	[tf becomeFirstResponder];	
	alert1.tag=2;
	[alert1 release];	
}

///// Get Minutes if get wrong Minutes

-(NSString *)CheckTIme:(int)Minutes
{
	if(Minutes==0)
	{
		return @"00";
	}
	else if(Minutes>0 && Minutes<15)
	{
		return @"00";
	}
	else if(Minutes>=15 && Minutes<30)
	{
		return @"15";
	}
	else if(Minutes>=30 && Minutes<45)
	{
		return @"30";
	}
	else if(Minutes>=45)
	{
		return @"45";
	}
	return @"00";
}

#pragma mark create Database Functions
///////Create Database in application

-(void)createEditableCopyOfDatabaseIfNeeded
{
	BOOL success;
	NSFileManager *fileManager=[[NSFileManager defaultManager]autorelease];
	NSError *error;
	NSArray *paths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);	
	success = [fileManager fileExistsAtPath:[[paths objectAtIndex:0] stringByAppendingPathComponent:@"healthtracker.sqlite"]];
	if(success)
	{
		if(sqlite3_open([[[paths objectAtIndex:0] stringByAppendingPathComponent:@"healthtracker.sqlite"] UTF8String],&database)!=SQLITE_OK)
		{
			sqlite3_close(database);
		}

		if([[NSUserDefaults standardUserDefaults] valueForKey:@"Version1"]==nil)
		{
			[self AddTableintoDatabase];
			[[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"Version1"];
			[[NSUserDefaults standardUserDefaults] synchronize];
		}

		if([[NSUserDefaults standardUserDefaults] valueForKey:@"Version2"]==nil)
		{
			[self AddHealthInsuranceTable];
			[[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"Version2"];
			[[NSUserDefaults standardUserDefaults] synchronize];
		}
		if([[NSUserDefaults standardUserDefaults] valueForKey:@"Version3"]==nil)
		{
			[self alterFeedDetailTable];
			[[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"Version3"];
			[[NSUserDefaults standardUserDefaults] synchronize];
		}
		return;
	}
	success=[fileManager copyItemAtPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"healthtracker.sqlite"] toPath:[[paths objectAtIndex:0] stringByAppendingPathComponent:@"healthtracker.sqlite"] error:&error];
	if(!success)
	{
		NSAssert1(0,@"Failed to create writable database file with message '%@' .",[error localizedDescription]);
	}
	else//First Time Loaded Application....
	{
		if(sqlite3_open([[[paths objectAtIndex:0] stringByAppendingPathComponent:@"healthtracker.sqlite"] UTF8String],&database)!=SQLITE_OK)
		{
			sqlite3_close(database);
		}
		
		if([[NSUserDefaults standardUserDefaults] valueForKey:@"Version1"]==nil)
		{
			[self AddTableintoDatabase];
			[[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"Version1"];
			[[NSUserDefaults standardUserDefaults] synchronize];
		}
		if([[NSUserDefaults standardUserDefaults] valueForKey:@"Version2"]==nil)
		{
			[self AddHealthInsuranceTable];
			[[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"Version2"];
			[[NSUserDefaults standardUserDefaults] synchronize];
		}
		if([[NSUserDefaults standardUserDefaults] valueForKey:@"Version3"]==nil)
		{
			[self alterFeedDetailTable];
			[[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"Version3"];
			[[NSUserDefaults standardUserDefaults] synchronize];
		}
	}	
}

//// Create Past Tables

-(void)AddHealthInsuranceTable
{
	[self SelectsUsers];
	[self CreateHealthCareProviderTable];
	[self CreateInsuranceTable];
	[self CreatePastTable];
	[self CreatePastRecordTable];
}

//// Create Mood,exercise,Mood etc table....

-(void)AddTableintoDatabase
{
	[self CreateFeedTable];
	[self CreateMedicineDosageTable];
	[self AddNewFieldsinUser_Settings:@"Exercise_Settings"];
	[self AddNewFieldsinUser_Settings:@"Mood_Settings"];
	[self AddNewFieldsinUser_Settings:@"Activity_Settings"];
	[self AddNewFieldsinUser_Settings:@"Diapering_Settings"];
	[self AddNewFieldsinUser_Settings:@"Feeding_Settings"];
	int i= [self createTable:@"Mood"];
	if(i==1)
	{
		[self InsertTableValue:@"Mood" :@"Stressed"];
		[self InsertTableValue:@"Mood" :@"Relaxed"];
		[self InsertTableValue:@"Mood" :@"Happy"];
		[self InsertTableValue:@"Mood" :@"Depressed"];
	}
	i=[self createTable:@"Activity"];
	if(i==1)
	{
		[self InsertTableValue:@"Activity" :@"Normal"];
		[self InsertTableValue:@"Activity" :@"Sluggish and Sleepy"];
		[self InsertTableValue:@"Activity" :@"Fussy"];
		[self InsertTableValue:@"Activity" :@"Inconsolable"];
	}
	i=[self createTable:@"Diapering"];
	if(i==1)
	{
		[self InsertTableValue:@"Diapering" :@"None"];
		[self InsertTableValue:@"Diapering" :@"Soiled"];
		[self InsertTableValue:@"Diapering" :@"Wet"];
	}
	i=[self createTable:@"Feeding"];
	[self createTable:@"Feed_Unit"];
	[self createTable:@"Medicine_Unit"];
	[self AlterUser_ID:@"Feed_Detail"];
	[self AlterUser_ID:@"Medicine_Detail"];
	[self AddCaleoriesField];
	[self DeleteEntry:@"Routine_Master" ColumnName:@"Routine_Id" PrimaryID:11];
	[self DeleteEntry:@"Routine_Master" ColumnName:@"Routine_Id" PrimaryID:12];
	[self DeleteEntry:@"Routine_Master" ColumnName:@"Routine_Id" PrimaryID:6];
	[self DeleteEntry:@"Routine_Master" ColumnName:@"Routine_Id" PrimaryID:7];
	[self DeleteEntry:@"Routine_Master" ColumnName:@"Routine_Id" PrimaryID:8];
	[self DeleteEntry:@"Routine_Master" ColumnName:@"Routine_Id" PrimaryID:9];
	[self DeleteEntry:@"Routine_Master" ColumnName:@"Routine_Id" PrimaryID:10];
	[self InsertRoutineMasterDeatil:@"Food Consumption"];
	[self InsertRoutineMasterDeatil:@"Calories Consumed"];
	[self InsertRoutineMasterDeatil:@"Alcohol"];
	[self InsertRoutineMasterDeatil:@"Cigarettes"];
	[self InsertRoutineMasterDeatil:@"Drugs"];
	[self InsertRoutineMasterDeatil:@"Menstruation"];
	[self InsertRoutineMasterDeatil:@"Other"];
}

///// Add New Calories field into routine Filed...

-(void)AddCaleoriesField
{
	sqlite3_stmt *statement=nil;
	const char *sql="ALTER TABLE Routine_Detail add calories Integer";
	if(sqlite3_prepare_v2(database, sql, -1, &statement, NULL)!=SQLITE_OK)
	{
	}
	else
	{		
		int success=sqlite3_step(statement);
		if(success==SQLITE_ROW)
		{
		}
		if (success == SQLITE_ERROR) 
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(statement);
		
		[self UpdateCaleoriesField];
	}
}

///// add User_ID to feed_detail and Medicine_Detail Table.

-(void)AlterUser_ID:(NSString *)TableName
{
	sqlite3_stmt *statement=nil;
	NSString *sql=[NSString  stringWithFormat:@"ALTER TABLE %@ add User_ID Integer",TableName];
	if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
	{
	}
	else
	{		
		int success=sqlite3_step(statement);
		if(success==SQLITE_ROW)
		{
		}
		if (success == SQLITE_ERROR) 
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}		
		sqlite3_finalize(statement);
	}
}

///// Set 1 to Calerious For all inserted pro=ivious record.

-(void)UpdateCaleoriesField
{
	sqlite3_stmt *statement=nil;
	const char *sql="update Routine_Detail set calories=-1";
	if(sqlite3_prepare_v2(database, sql, -1, &statement, NULL)!=SQLITE_OK)
	{
		NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
	}
	else
	{		
		int success=sqlite3_step(statement);
		if(success==SQLITE_ROW)
		{
			//lastAccessDate=[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 0)];
		}
		if (success == SQLITE_ERROR)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		sqlite3_finalize(statement);
	}
}

#pragma mark New Table Chnages

//// Create Table for Mood,Feeding Etc

-(int)createTable:(NSString*)TableName
{
	int i=0;
	sqlite3_stmt *statement=nil;
	NSString *sql=[NSString stringWithFormat:@"create table %@ (Pk_ID INTEGER PRIMARY KEY, Name Varchar(50))",TableName];
	if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
	{
		NSLog(@"Not Insert");
	}
	else
	{		
		int success=sqlite3_step(statement);
		if(success==SQLITE_ROW)
		{
		}
		if (success == SQLITE_ERROR) 
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i=1;
		sqlite3_finalize(statement);
	}
	return i;
}

//////// Add new fields to Routine_Master

-(void)InsertRoutineMasterDeatil:(NSString*)FieldName
{
	int i=0;
	@try
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	

		sql=[NSString stringWithFormat:@"insert into Routine_Master(Field_Name,Iscommom,User_ID) values(?,?,?)"];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		//Calories
		sqlite3_bind_text(statement, 1,[FieldName UTF8String] , -1, SQLITE_TRANSIENT);		
		sqlite3_bind_int(statement, 2, 1);
		sqlite3_bind_int(statement, 3, 0);
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i= sqlite3_last_insert_rowid(database);
		sqlite3_finalize(statement);
		[Pool release];
	}
	@catch (NSException *e) 
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"User Record not Inserted" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}		
}

-(void)alterFeedDetailTable
{
	sqlite3_stmt *statement=nil;
	NSString *sql=[NSString stringWithFormat:@"ALTER TABLE Feed_Detail RENAME TO tmp_Feed_Detail"]; //ALTER TABLE user_settings add Mood_Settings varchar(100); ALTER TABLE user_settings add Diapering_Settings varchar(100): ALTER TABLE user_settings add Activity_Settings varchar(100); ALTER TABLE user_settings add Feeding_Settings varchar(100)";
	if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
	{
	}
	else
	{		
		int success=sqlite3_step(statement);
		if(success==SQLITE_ROW)
		{
		}
		if (success == SQLITE_ERROR) 
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}		
		sqlite3_finalize(statement);
		[self CreateFeedTable];
		[self insertBackupdataintoFeedDeatilorDropTable:@"INSERT INTO Feed_Detail(Feed_Qty,Routine_ID,Feed_ID,Feed_Unit,Feed_Name,Entry_Date,User_ID) SELECT Feed_Qty,Routine_ID,Feed_ID,Feed_Unit,Feed_Name,Entry_Date,User_ID FROM tmp_Feed_Detail"];
		[self insertBackupdataintoFeedDeatilorDropTable:@"DROP TABLE tmp_Feed_Detail"];
	}
}

-(void)insertBackupdataintoFeedDeatilorDropTable:(NSString*)ParameterQuery
{
	//int i=0;
	@try
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		
		sql=ParameterQuery;//[NSString stringWithFormat:];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(statement);
		[Pool release];
	}
	@catch (NSException *e) 
	{
		NSLog(@"Insert Fail");
	}
}

//// Create Feed_deatil table for add Qty,Unit etc for particular Feed..

-(int)CreateFeedTable
{
	int i=0;
	sqlite3_stmt *statement=nil;
	NSString *sql=[NSString stringWithFormat:@"create table Feed_Detail (Pk_ID INTEGER PRIMARY KEY, Feed_Qty Double, Routine_ID Integer, Feed_ID Integer, Feed_Unit Varchar(15) , Feed_Name varchar(50) , Entry_Date DateTime, User_ID Integer)"];
	if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
	{
		NSLog(@"Not Insert");
	}
	else
	{		
		int success=sqlite3_step(statement);
		if(success==SQLITE_ROW)
		{
		}
		if (success == SQLITE_ERROR) 
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i=1;
		sqlite3_finalize(statement);
	}
	return i;
}

//// Create Medicine_deatil table for add Qty,Unit etc for particular Medicine..

-(int)CreateMedicineDosageTable
{
	int i=0;
	sqlite3_stmt *statement=nil;
	NSString *sql=[NSString stringWithFormat:@"create table Medicine_Detail (Pk_ID INTEGER PRIMARY KEY, Med_Qty double, Medicine_ID Integer, Med_ID Integer, Med_Unit Varchar(15) , Med_Name varchar(50) , Entry_Date DateTime, User_ID Integer)"];
	if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
	{
		NSLog(@"Not Insert");
	}
	else
	{		
		int success=sqlite3_step(statement);
		if(success==SQLITE_ROW)
		{
		}
		if (success == SQLITE_ERROR) 
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i=1;
		sqlite3_finalize(statement);
	}
	return i;
}

///// Create Health Care Provider table for insert more then one Health_Care provider Info

-(int)CreateHealthCareProviderTable
{
	int i=0;
	sqlite3_stmt *statement=nil;
	NSString *sql=[NSString stringWithFormat:@"create table Health_Care (Pk_ID INTEGER PRIMARY KEY, Provider_Name varchar(50), Provider_Number varchar(15), User_ID Integer)"];
	if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
	{
		NSLog(@"Not Insert");
	}
	else
	{		
		int success=sqlite3_step(statement);
		if(success==SQLITE_ROW)
		{
		}
		if (success == SQLITE_ERROR) 
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i=1;
		//[self SelectsUsers];
		for(int i=0;i<[self.UserArray count];i++)
		{
			NSDictionary *DIC=[self.UserArray objectAtIndex:i];
			if([[DIC valueForKey:@"PastName"] length]>0 || [[DIC valueForKey:@"PastPhoneNumber"] length]>0)
			{
				[self insertHealthCare:[DIC valueForKey:@"PastName"] :[DIC valueForKey:@"PastPhoneNumber"] :[[DIC valueForKey:@"UserID"]intValue]];
			}
		}
		sqlite3_finalize(statement);
	}
	return i;
}

///// Create Insurance table for insert more then one Insurance Info

-(int)CreateInsuranceTable
{
	int i=0;
	sqlite3_stmt *statement=nil;
	NSString *sql=[NSString stringWithFormat:@"create table Insurance (Pk_ID INTEGER PRIMARY KEY, Identification varchar(100), Policy_Number varchar(100), Phone_Number varchar(15), Emergency_Number varchar(15), User_ID Integer)"];
	if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
	{
		NSLog(@"Not Insert");
	}
	else
	{		
		int success=sqlite3_step(statement);
		if(success==SQLITE_ROW)
		{
		}
		if (success == SQLITE_ERROR) 
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i=1;
		//[self SelectsUsers];
		for(int i=0;i<[self.UserArray count];i++)
		{
			NSDictionary *DIC=[self.UserArray objectAtIndex:i];
			if([[DIC valueForKey:@"PastIdentification"] length]>0 || [[DIC valueForKey:@"PastPhone"] length]>0  || [[DIC valueForKey:@"PastEmrContact"] length]>0 || [[DIC valueForKey:@"PastPolicyNo"] length]>0 )
			{
				[self insertInsurance:[DIC valueForKey:@"PastIdentification"] :[DIC valueForKey:@"PastPhone"] :[[DIC valueForKey:@"UserID"]intValue] :[DIC valueForKey:@"PastEmrContact"] :[DIC valueForKey:@"PastPolicyNo"]];
			}
		}
		sqlite3_finalize(statement);
	}
	return i;
}

#pragma mark Add New Fields in Settings Table for Favs

//// Add New Fields..

-(void)AddNewFieldsinUser_Settings :(NSString *)FieldName
{
	sqlite3_stmt *statement=nil;
	NSString *sql=[NSString stringWithFormat:@"ALTER TABLE user_settings add %@ varchar(100)",FieldName]; //ALTER TABLE user_settings add Mood_Settings varchar(100); ALTER TABLE user_settings add Diapering_Settings varchar(100): ALTER TABLE user_settings add Activity_Settings varchar(100); ALTER TABLE user_settings add Feeding_Settings varchar(100)";
	if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
	{
	}
	else
	{		
		int success=sqlite3_step(statement);
		if(success==SQLITE_ROW)
		{
		}
		if (success == SQLITE_ERROR) 
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(statement);
		
		if([FieldName isEqualToString:@"Exercise_Settings"])
			[self UpadateUser_sttings:FieldName :@"1,2,3,4,5"];
		else if([FieldName isEqualToString:@"Mood_Settings"])
			[self UpadateUser_sttings:FieldName :@"1,2,3,4"];
		else if([FieldName isEqualToString:@"Activity_Settings"])
			[self UpadateUser_sttings:FieldName :@"1,2,3,4"];
		else if([FieldName isEqualToString:@"Diapering_Settings"])
			[self UpadateUser_sttings:FieldName :@"1,2,3"];
		else if([FieldName isEqualToString:@"Feeding_Settings"])
			[self UpadateUser_sttings:FieldName :@""];
	}
}

///// Update Fields with predefine value

-(void)UpadateUser_sttings:(NSString*)FieldName :(NSString *)Value
{
	sqlite3_stmt *statement=nil;
	NSString *sql=[NSString stringWithFormat:@"update user_settings set %@='%@'",FieldName,Value];
	if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
	{
		NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		//	UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"showLastAccessDate Error" message:[NSString stringWithFormat:@"Error: failed to prepare statement with message %s",sqlite3_errmsg(database)] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//	[alertView show];
		//	[alertView release];		
	}
	else
	{		
		int success=sqlite3_step(statement);
		if(success==SQLITE_ROW)
		{
			//lastAccessDate=[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 0)];
		}
		if (success == SQLITE_ERROR)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		sqlite3_finalize(statement);
	}
}


#pragma mark  HealthCare Provider Function

///// Upadte Health_Care Information base on Primary Key

-(int)UpdateHealthCare:(NSString*)ProviderName :(NSString*)Number :(NSInteger)USERID :(NSInteger)PrimaryID
{
	int i=0;
	@try
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		
		sql=[NSString stringWithFormat:@"update Health_Care set Provider_Name=?,Provider_Number=?,USER_ID=? where pk_id=%d",PrimaryID];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		
		sqlite3_bind_int(statement, 3, USERID);
		
		sqlite3_bind_text(statement, 1,[ProviderName UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 2,[Number UTF8String], -1, SQLITE_TRANSIENT);
		
		
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i= 1;//sqlite3_last_insert_rowid(database);
		sqlite3_finalize(statement);
		[Pool release];
	}
	@catch (NSException *e) 
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"User Record not Inserted" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	return i;
}

///// insert Health Care Information

-(int)insertHealthCare:(NSString*)ProviderName :(NSString*)Number :(NSInteger)USERID
{
	int i=0;
	@try
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		
		sql=[NSString stringWithFormat:@"insert into Health_Care(Provider_Name,Provider_Number,USER_ID) values(?,?,?)"];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		
		sqlite3_bind_int(statement, 3, USERID);
		
		sqlite3_bind_text(statement, 1,[ProviderName UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 2,[Number UTF8String], -1, SQLITE_TRANSIENT);		
		
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i= sqlite3_last_insert_rowid(database);
		sqlite3_finalize(statement);
		[Pool release];
	}
	@catch (NSException *e) 
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"User Record not Inserted" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	return i;		
}

///// Get all HealthCare Provider information base on User_ID

-(void)selectHealthcare:(NSInteger)USERID
{
	@try
	{
		if(!self.HealthInsuranceArray)
			self.HealthInsuranceArray=[[NSMutableArray alloc]init];
		else
			[self.HealthInsuranceArray removeAllObjects];
		
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		
		sql=[NSString stringWithFormat:@"Select Provider_Name,Provider_Number,User_ID,Pk_id from Health_Care where User_ID=%d",USERID];
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				NSMutableDictionary *User_Data=[[NSMutableDictionary alloc]init];
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,1)] forKey:@"PastPhoneNumber"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)] forKey:@"PastName"];
				[User_Data setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 2)] forKey:@"User_id"];
				[User_Data setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 3)] forKey:@"Pk_ID"];			
				[Pool release];
				[self.HealthInsuranceArray addObject:User_Data];
				[User_Data release];	
			}
		}
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
	}		
}

#pragma mark Insurance Methods

//// Insert Insuance records for particular User

-(int)insertInsurance:(NSString*)Identification :(NSString*)Phone_Number :(NSInteger)USERID :(NSString*)Emergency_Number :(NSString*)Policy_Number
{
	int i=0;
	@try
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		
		sql=[NSString stringWithFormat:@"insert into Insurance(Identification,Policy_Number,User_ID,Phone_Number,Emergency_Number) values(?,?,?,?,?)"];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		
		sqlite3_bind_int(statement, 3, USERID);
		
		sqlite3_bind_text(statement, 1,[Identification UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 2,[Policy_Number UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 4,[Phone_Number UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 5,[Emergency_Number UTF8String], -1, SQLITE_TRANSIENT);
		
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i= sqlite3_last_insert_rowid(database);
		sqlite3_finalize(statement);
		[Pool release];
	}
	@catch (NSException *e) 
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"User Record not Inserted" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	return i;		
}

///// Update Insurance Information

-(int)UpdateInsurance:(NSString*)Identification :(NSString*)Phone_Number :(NSInteger)USERID :(NSString*)Emergency_Number :(NSString*)Policy_Number :(NSInteger)PrimaryID
{
	int i=0;
	@try
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		
		sql=[NSString stringWithFormat:@"update Insurance set Identification=?,Policy_Number=?,User_ID=?,Phone_Number=?,Emergency_Number=? where Pk_Id=%d",PrimaryID];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		
		sqlite3_bind_int(statement, 3, USERID);
		
		sqlite3_bind_text(statement, 1,[Identification UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 2,[Policy_Number UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 4,[Phone_Number UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 5,[Emergency_Number UTF8String], -1, SQLITE_TRANSIENT);
		
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i=1;// sqlite3_last_insert_rowid(database);
		sqlite3_finalize(statement);
		[Pool release];
	}
	@catch (NSException *e) 
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"User Record not Inserted" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	return i;
}

///// Get all Insurance information base on User_ID

-(void)selectInsuranceInfo:(NSInteger)USERID
{
	@try
	{
		if(!self.HealthInsuranceArray)
			self.HealthInsuranceArray=[[NSMutableArray alloc]init];
		else
			[self.HealthInsuranceArray removeAllObjects];
		
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		
		sql=[NSString stringWithFormat:@"Select Identification,Policy_Number,User_ID,Phone_Number,Emergency_Number,Pk_id from Insurance where User_ID=%d",USERID];
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				NSMutableDictionary *User_Data=[[NSMutableDictionary alloc]init];
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,1)] forKey:@"PastPolicyNo"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)] forKey:@"PastIdentification"];
				[User_Data setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 2)] forKey:@"User_id"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,3)] forKey:@"PastPhone"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,4)] forKey:@"PastEmrContact"];
				[User_Data setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 5)] forKey:@"Pk_ID"];			
				[Pool release];
				[self.HealthInsuranceArray addObject:User_Data];
				[User_Data release];	
			}
		}
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
	}	
}

#pragma mark Mood,Feeding,Dipering etc Function

/////// Get All records base on Table name for Mood,Feeding,Dipering

-(void)SelectAllData:(NSString*)TableName
{
	@try
	{
		if(!self.NewTableArray)
			self.NewTableArray=[[NSMutableArray alloc]init];	
		
		if([self.NewTableArray count]>0)
		{
			[self.NewTableArray removeAllObjects];
		}	
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		sql=[NSString  stringWithFormat:@"Select Name,Pk_ID from %@",TableName];
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				NSMutableDictionary *Master=[[NSMutableDictionary alloc]init];
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				[Master setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 1)] forKey:@"ID"];				
				[Master setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)] forKey:@"Name"];
				[Pool release];
				[self.NewTableArray addObject:Master];
				[Master release];	
			}
		}
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
	}	
}

/// Get Field Name base on Pk_ID and Pass Table Name

-(NSString *)Select:(NSInteger)Pk_ID :(NSString*)TableName
{
	NSString *Name=@"";
	@try
	{		
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		sql=[NSString stringWithFormat:@"Select Name from %@ where Pk_ID=%d",TableName,Pk_ID];
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				
				Name= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)];			
			}
		}
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
	}	
	return Name;
}

#pragma mark New Past Table Methods
//////// Create , insert,select Table for past
-(int)CreatePastTable
{
	int i=0;
	sqlite3_stmt *statement=nil;
	NSString *sql=[NSString stringWithFormat:@"create table Past (Pk_ID INTEGER PRIMARY KEY, Past_Name varchar(50), User_ID Integer)"];
	if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
	{
		NSLog(@"Not Insert");
	}
	else
	{		
		int success=sqlite3_step(statement);
		if(success==SQLITE_ROW)
		{
		}
		if (success == SQLITE_ERROR) 
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i=1;
		
		for(int i=0;i<[self.UserArray count];i++)
		{
			NSDictionary *DIC=[self.UserArray objectAtIndex:i];
			if([[DIC valueForKey:@"Past"] length]>0)
			{
				int Past_ID=[self PastNameID:[DIC valueForKey:@"Past"]];
				if(Past_ID==0)
				{
					[self insertIntopast:[DIC valueForKey:@"Past"] :[[DIC valueForKey:@"UserID"]intValue]];
				}
			}
		}
		sqlite3_finalize(statement);
	}
	return i;
}

//// Create table for store user past records
-(int)CreatePastRecordTable
{
	int i=0;
	sqlite3_stmt *statement=nil;
	NSString *sql=[NSString stringWithFormat:@"create table Past_Record (Pk_ID INTEGER PRIMARY KEY, Past_Name varchar(50), User_ID Integer,Past_ID Integer)"];
	if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
	{
		NSLog(@"Not Insert");
	}
	else
	{		
		int success=sqlite3_step(statement);
		if(success==SQLITE_ROW)
		{
		}
		if (success == SQLITE_ERROR) 
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i=1;		
		for(int i=0;i<[self.UserArray count];i++)
		{
			NSDictionary *DIC=[self.UserArray objectAtIndex:i];
			if([[DIC valueForKey:@"Past"] length]>0)
			{
				int Past_ID=[self PastNameID:[DIC valueForKey:@"Past"]];
				[self insertPastRecord:[DIC valueForKey:@"Past"] :[[DIC valueForKey:@"UserID"]intValue] :Past_ID];
			}
		}
		sqlite3_finalize(statement);
	}
	return i;
}

////// Get Past_id base on Past_Name
-(int)PastNameID:(NSString*)PastName
{
	int i=0;
	@try
	{
		PastName=[PastName stringByReplacingOccurrencesOfString:@"'" withString:@"''"];	
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"select Pk_ID from Past where lower(Past_Name)='%@'",PastName];   /////
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}			
		int success=sqlite3_step(statement);
		sqlite3_finalize(statement);
		if(success==SQLITE_ROW)
		{		
			i=sqlite3_column_int(statement, 0);
		}
		else
		{
			i=0;
		}
		if (success == SQLITE_ERROR) 
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		return i;
	}
	@catch (NSException *e) 
	{
		
	}
	return i;
}

///////// Insert Past name into table
-(int)insertIntopast:(NSString*)PastName :(NSInteger)USERID
{
	int i=0;
	@try
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		
		sql=[NSString stringWithFormat:@"insert into Past(Past_Name,User_ID) values(?,?)"];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
	
		sqlite3_bind_int(statement, 2, USERID);
		sqlite3_bind_text(statement, 1,[PastName UTF8String] , -1, SQLITE_TRANSIENT);		
		
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i= sqlite3_last_insert_rowid(database);
		sqlite3_finalize(statement);
		[Pool release];
	}
	@catch (NSException *e) 
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"User Record not Inserted" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	return i;	
}

////// Update Past Name into table
-(int)UpdateIntopast:(NSString*)PastName :(NSInteger)Past_ID
{
	int i=0;
	@try
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		
		sql=[NSString stringWithFormat:@"update Past set Past_Name=? where Pk_ID=%d",Past_ID];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		
		sqlite3_bind_text(statement, 1,[PastName UTF8String] , -1, SQLITE_TRANSIENT);			
		int success=sqlite3_step(statement);		
		if (success == SQLITE_ERROR) 
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i= 1;
		sqlite3_finalize(statement);
		[Pool release];
	}
	@catch (NSException *e) 
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"User Record not Inserted" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	return i;	
}

////// Insert Past_Record base on user
-(int)insertPastRecord:(NSString*)PastName :(NSInteger)USERID :(NSInteger)Past_ID
{
	int i=0;
	@try
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		
		sql=[NSString stringWithFormat:@"insert into Past_record(Past_Name,User_ID,Past_ID) values(?,?,?)"];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		
		sqlite3_bind_int(statement, 2, USERID);
		sqlite3_bind_text(statement, 1,[PastName UTF8String] , -1, SQLITE_TRANSIENT);		
		sqlite3_bind_int(statement, 3, Past_ID);
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i= sqlite3_last_insert_rowid(database);
		sqlite3_finalize(statement);
		[Pool release];
	}
	@catch (NSException *e) 
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"User Record not Inserted" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	return i;	
}


///// Select user past records base on user_id
-(void)selectPastData:(NSInteger)USERID
{
	@try
	{
		if(!self.PastArray)
			self.PastArray=[[NSMutableArray alloc]init];	
		
		if([self.PastArray count]>0)
		{
			[self.PastArray removeAllObjects];
		}	
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		
		sql=[NSString stringWithFormat:@"Select Past_Name,Past_ID from Past_record where User_ID=%d",USERID];
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				NSMutableDictionary *User_Data=[[NSMutableDictionary alloc]init];
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				[User_Data setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 1)] forKey:@"PastID"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)] forKey:@"Name"];
				[Pool release];
				[self.PastArray addObject:User_Data];			
				[User_Data release];	
			}
		}
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
	}	
}


//// Get all Past_names from past table...
-(void)selectAllPastData
{
	@try
	{
		if(!self.AllPastArray)
			self.AllPastArray=[[NSMutableArray alloc]init];	
		
		if([self.AllPastArray count]>0)
		{
			[self.AllPastArray removeAllObjects];
		}	
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		
		sql=[NSString stringWithFormat:@"Select Past_Name,Pk_ID,User_ID from Past"];
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				NSMutableDictionary *User_Data=[[NSMutableDictionary alloc]init];
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				[User_Data setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 1)] forKey:@"PastID"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)] forKey:@"Name"];
				[User_Data setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 2)] forKey:@"User_ID"];
				[Pool release];
				[self.AllPastArray addObject:User_Data];			
				[User_Data release];	
			}
		}
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
	}	
}

#pragma mark New Tables Method

-(int)InsertFeedDetail:(NSMutableDictionary *)DIC
{
	int i=0;
	@try
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		
		sql=[NSString stringWithFormat:@"insert into Feed_Detail(Feed_Qty,Routine_ID,Feed_ID,Feed_Unit,Feed_Name,Entry_Date,User_ID) values(?,?,?,?,?,?,?)"];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	

		sqlite3_bind_double(statement, 1, [[DIC objectForKey:@"Feed_Qty"]doubleValue]);
		sqlite3_bind_int(statement, 2, [[DIC objectForKey:@"Routine_ID"]intValue]);
		sqlite3_bind_int(statement, 3, [[DIC objectForKey:@"Feed_ID"]intValue]);
		sqlite3_bind_text(statement, 4,[[DIC valueForKey:@"Feed_Unit"]UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 5,[[DIC valueForKey:@"Feed_Name"]UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 6,[[DIC valueForKey:@"Entry_Date"]UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_int(statement, 7, self.SelectedUserID);
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i= sqlite3_last_insert_rowid(database);
		sqlite3_finalize(statement);
		[Pool release];
	}
	@catch (NSException *e) 
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"User Record not Inserted" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	return i;	
}

-(int)InsertMedicineDosageDetail:(NSMutableDictionary *)DIC
{
	int i=0;
	@try
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		
		sql=[NSString stringWithFormat:@"insert into Medicine_Detail(Med_Qty,Medicine_ID,Med_ID,Med_Unit,Med_Name,Entry_Date,User_ID) values(?,?,?,?,?,?,?)"];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		
		sqlite3_bind_double(statement, 1,[[DIC objectForKey:@"Med_Qty"]doubleValue]);	
		sqlite3_bind_int(statement, 2, [[DIC objectForKey:@"Medicine_ID"]intValue]);
		sqlite3_bind_int(statement, 3, [[DIC objectForKey:@"Med_ID"]intValue]);
		sqlite3_bind_text(statement, 4,[[DIC valueForKey:@"Med_Unit"]UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 5,[[DIC valueForKey:@"Med_Name"]UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 6,[[DIC valueForKey:@"Entry_Date"]UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_int(statement, 7, self.SelectedUserID);
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i= sqlite3_last_insert_rowid(database);
		sqlite3_finalize(statement);
		[Pool release];
	}
	@catch (NSException *e) 
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"User Record not Inserted" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	return i;	
}

-(void)SelectFeedDeatl:(NSInteger)Routine_ID
{
	@try
	{
		if(!self.UnitDictionary)
			self.UnitDictionary=[[NSMutableDictionary alloc]init];	
		
		if([self.UnitDictionary count]>0)
		{
			[self.UnitDictionary removeAllObjects];
		}	
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		
		sql=[NSString stringWithFormat:@"Select Feed_Qty,Routine_ID,Feed_ID,Feed_Unit,Feed_Name,Pk_ID,Entry_Date from Feed_Detail where Routine_ID=%d",Routine_ID];
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				NSMutableDictionary *User_Data=[[NSMutableDictionary alloc]init];
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				[User_Data setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 1)] forKey:@"Routine_ID"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)] forKey:@"Feed_Qty"];
				[User_Data setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 2)] forKey:@"Feed_ID"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,3)] forKey:@"Feed_Unit"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,4)] forKey:@"Feed_Name"];
				[User_Data setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 5)] forKey:@"Pk_ID"];			
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,6)] forKey:@"Entry_Date"];
				[Pool release];
				[self.UnitDictionary setObject:[User_Data mutableCopy] forKey:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 2)]];			
				[User_Data release];	
			}
		}
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
	}	
}

-(void)SelectFeedDeatlByDate:(NSString *)Date
{
	@try
	{
		if(!self.UnitDictionary)
			self.UnitDictionary=[[NSMutableDictionary alloc]init];	
		
		if([self.UnitDictionary count]>0)
		{
			[self.UnitDictionary removeAllObjects];
		}	
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		
		sql=[NSString stringWithFormat:@"Select Feed_Qty,Routine_ID,Feed_ID,Feed_Unit,Feed_Name,Pk_ID,Entry_Date from Feed_Detail where Entry_Date='%@' and User_ID=%d",Date,self.SelectedUserID];
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				NSMutableDictionary *User_Data=[[NSMutableDictionary alloc]init];
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				[User_Data setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 1)] forKey:@"Routine_ID"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)] forKey:@"Feed_Qty"];
				[User_Data setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 2)] forKey:@"Feed_ID"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,3)] forKey:@"Feed_Unit"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,4)] forKey:@"Feed_Name"];
				[User_Data setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 5)] forKey:@"Pk_ID"];			
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,6)] forKey:@"Entry_Date"];
				[Pool release];
				[self.UnitDictionary setObject:[User_Data mutableCopy] forKey:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 2)]];			
				[User_Data release];	
			}
		}
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
	}	
}

-(void)SelectMedicineDeatlByDate:(NSString *)Date
{
	@try
	{
		if(!self.UnitDictionary)
			self.UnitDictionary=[[NSMutableArray alloc]init];	
		
		if([self.UnitDictionary count]>0)
		{
			[self.UnitDictionary removeAllObjects];
		}	
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		
		sql=[NSString stringWithFormat:@"Select Med_Qty,Medicine_ID,Med_ID,Med_Unit,Med_Name,Pk_ID,Entry_Date from Medicine_Detail where Entry_Date='%@'",Date];
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				NSMutableDictionary *User_Data=[[NSMutableDictionary alloc]init];
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				[User_Data setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 1)] forKey:@"Medicine_ID"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)] forKey:@"Med_Qty"];
				[User_Data setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 2)] forKey:@"Med_ID"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,3)] forKey:@"Med_Unit"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,4)] forKey:@"Med_Name"];
				[User_Data setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 5)] forKey:@"Pk_ID"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,6)] forKey:@"Entry_Date"];
				[Pool release];
				[self.UnitDictionary setObject:[User_Data mutableCopy] forKey:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 2)]];		
				[User_Data release];	
			}
		}
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
	}		
}

-(void)SelectMedicineDeatl:(NSInteger)Medicine_ID
{
	@try
	{
		if(!self.UnitDictionary)
			self.UnitDictionary=[[NSMutableArray alloc]init];	
		
		if([self.UnitDictionary count]>0)
		{
			[self.UnitDictionary removeAllObjects];
		}	
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		
		sql=[NSString stringWithFormat:@"Select Med_Qty,Medicine_ID,Med_ID,Med_Unit,Med_Name,Pk_ID,Entry_Date from Medicine_Detail where Medicine_ID=%d",Medicine_ID];
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				NSMutableDictionary *User_Data=[[NSMutableDictionary alloc]init];
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				[User_Data setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 1)] forKey:@"Medicine_ID"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)] forKey:@"Med_Qty"];
				[User_Data setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 2)] forKey:@"Med_ID"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,3)] forKey:@"Med_Unit"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,4)] forKey:@"Med_Name"];
				[User_Data setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 5)] forKey:@"Pk_ID"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,6)] forKey:@"Entry_Date"];
				[Pool release];
				[self.UnitDictionary setObject:[User_Data mutableCopy] forKey:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 2)]];		
				[User_Data release];	
			}
		}
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
	}		
}

-(int)InsertTableValue:(NSString*)TableName :(NSString*)FieldValue
{
	int i=0;
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	@try
	{		
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"insert into %@(Name) values(?)",TableName];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		sqlite3_bind_text(statement, 1,[FieldValue UTF8String] , -1, SQLITE_TRANSIENT);
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i= sqlite3_last_insert_rowid(database);
		sqlite3_finalize(statement);
	}
	@catch (NSException *e) 
	{
	}
	[Pool release];
	return i;
}

-(BOOL)IsExist:(NSString*)FieldName :(NSString*)TableName
{	
	@try
	{
		FieldName=[FieldName stringByReplacingOccurrencesOfString:@"'" withString:@"''"];	
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"select Pk_ID from %@ where lower(Name)='%@'",TableName,[FieldName lowercaseString]];   /////
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}			
		int success=sqlite3_step(statement);
		sqlite3_finalize(statement);
		if(success==SQLITE_ROW)
		{		
			return YES;
		}
		else
		{
			return NO;
		}
		if (success == SQLITE_ERROR) 
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		return NO;
	}
	@catch (NSException *e) 
	{
		
	}
	return NO;
}

-(int)Update:(NSString *)FieldName andID:(NSInteger)Pk_ID :(NSString*)TableName
{
	int i=0;
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	@try
	{
		
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"update %@ set Name=? where Pk_ID=%d",TableName,Pk_ID];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		sqlite3_bind_text(statement, 1,[FieldName UTF8String] , -1, SQLITE_TRANSIENT);
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i= 1;
		sqlite3_finalize(statement);
	}
	@catch (NSException *e) 
	{
	}
	[Pool release];
	return i;
}

#pragma mark All User Function

/// Get all users data.

-(void)SelectsUsers
{	
	@try
	{
		if(!self.UserArray)
			self.UserArray=[[NSMutableArray alloc]init];	
		
		if([self.UserArray count]>0)
		{
			[self.UserArray removeAllObjects];
		}	
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		
		sql=@"Select User_ID,BloodGroup,Diabetes_Situation,Drinking_Status,Drug_Taken,Gender,Smoking_Status,User_Name,Past_Name,Past_Health_Phone,Past_Identification,Past_PolicyNo,Past_Insurance_PN,Past_EmrContact,Past,DOB,isdefault from User_Detail";
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				NSMutableDictionary *User_Data=[[NSMutableDictionary alloc]init];
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				[User_Data setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 0)] forKey:@"UserID"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,1)] forKey:@"BloodGroup"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,2)] forKey:@"Diabetes"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,3)] forKey:@"Drinking"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,4)] forKey:@"Drug"];				
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,5)] forKey:@"Gender"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,6)] forKey:@"Smoking"];				
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,7)] forKey:@"UserName"];				
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,15)] forKey:@"DOB"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,8)] forKey:@"PastName"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,9)] forKey:@"PastPhoneNumber"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,10)] forKey:@"PastIdentification"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,12)] forKey:@"PastPhone"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,11)] forKey:@"PastPolicyNo"];
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,13)] forKey:@"PastEmrContact"];					
				[User_Data setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,14)] forKey:@"Past"];				
				[User_Data setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 16)] forKey:@"Default"];				
				[Pool release];
				[self.UserArray addObject:User_Data];			
				[User_Data release];	
			}
		}
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
	}	
	
}

///////Make Dictionary for add one time user entry
-(void)MakeDictForNewUser
{
	if(!self.AddNewUserDict)
	{
		self.AddNewUserDict=[[[NSMutableDictionary alloc]init]autorelease];
	}
	if([self.AddNewUserDict count]>0)
	{
		[self.AddNewUserDict removeAllObjects]; 
	}
	[self.AddNewUserDict setValue:@"" forKey:@"UserID"];
	[self.AddNewUserDict setValue:@"" forKey:@"UserName"];
	[self.AddNewUserDict setValue:@"Male" forKey:@"Gender"];
	[self.AddNewUserDict setValue:@"" forKey:@"BloodGroup"];
	[self.AddNewUserDict setValue:@"" forKey:@"DOB"];
	[self.AddNewUserDict setValue:@"0" forKey:@"Diabetes"];
	[self.AddNewUserDict setValue:@"" forKey:@"Smoking"];
	[self.AddNewUserDict setValue:@"" forKey:@"Drinking"];
	[self.AddNewUserDict setValue:@"0" forKey:@"Drug"];
	[self.AddNewUserDict setValue:@"" forKey:@"Past"];
	[self.AddNewUserDict setValue:@"" forKey:@"PastID"];
	[self.AddNewUserDict setValue:@"" forKey:@"PastName"];
	[self.AddNewUserDict setValue:@"" forKey:@"PastPhoneNumber"];
	[self.AddNewUserDict setValue:@"" forKey:@"PastIdentification"];
	[self.AddNewUserDict setValue:@"" forKey:@"PastPolicyNo"];
	[self.AddNewUserDict setValue:@"" forKey:@"PastPhone"];
	[self.AddNewUserDict setValue:@"" forKey:@"PastEmrContact"];
	[self.AddNewUserDict setValue:@"1" forKey:@"Default"];
	//	IsKidOrNot=0; 
}

////Insert User In User_Detail Table.

-(int)InsertUser:(NSMutableDictionary *)UserDictionary
{
	int i=0;
	@try
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"insert into User_detail(BloodGroup,Diabetes_Situation,Drinking_Status,Drug_Taken,Gender,Smoking_Status,User_Name,Past_Name,Past_Health_Phone,Past_Identification,Past_PolicyNo,Past_Insurance_PN,Past_EmrContact,Past,DOB,ISdefault) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		
		sqlite3_bind_text(statement, 1,[[UserDictionary objectForKey:@"BloodGroup"]UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 2,[[UserDictionary objectForKey:@"Diabetes"]UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 3,[[UserDictionary objectForKey:@"Drinking"]UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 4,[[UserDictionary objectForKey:@"Drug"]UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 5,[[UserDictionary objectForKey:@"Gender"]UTF8String], -1, SQLITE_TRANSIENT);			
		sqlite3_bind_text(statement, 6,[[UserDictionary objectForKey:@"Smoking"]UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 7,[[UserDictionary objectForKey:@"UserName"]UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 8,[[UserDictionary objectForKey:@"PastName"]UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 9,[[UserDictionary objectForKey:@"PastPhoneNumber"]UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 10, [[UserDictionary objectForKey:@"PastIdentification"]UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 11, [[UserDictionary objectForKey:@"PastPolicyNo"]UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 12,[[UserDictionary objectForKey:@"PastPhone"]UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 13,[[UserDictionary objectForKey:@"PastEmrContact"]UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 14, [[UserDictionary objectForKey:@"Past"]UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 15, [[UserDictionary objectForKey:@"DOB"]UTF8String], -1, SQLITE_TRANSIENT);
		
		sqlite3_bind_int(statement, 16, [[UserDictionary objectForKey:@"Default"]intValue]);
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i= sqlite3_last_insert_rowid(database);
		sqlite3_finalize(statement);
		[Pool release];
	}
	@catch (NSException *e) 
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"User Record not Inserted" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	return i;	
}

-(int)UpdateUser:(NSMutableDictionary *)UserDictionary
{
	int i=0;
	@try
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"update User_detail set BloodGroup=?,Diabetes_Situation=?,Drinking_Status=?,Drug_Taken=?,Gender=?,Smoking_Status=?,User_Name=?,Past_Name=?,Past_Health_Phone=?,Past_Identification=?,Past_PolicyNo=?,Past_Insurance_PN=?,Past_EmrContact=?,Past=?,DOB=?,isDefault=? where User_Id=%d",[[UserDictionary objectForKey:@"UserID"]intValue]];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}		
		
		sqlite3_bind_text(statement, 1,[[UserDictionary objectForKey:@"BloodGroup"]UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 2,[[UserDictionary objectForKey:@"Diabetes"]UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 3,[[UserDictionary objectForKey:@"Drinking"]UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 4, [[UserDictionary objectForKey:@"Drug"]UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 5, [[UserDictionary objectForKey:@"Gender"]UTF8String], -1, SQLITE_TRANSIENT);				
		sqlite3_bind_text(statement, 6,[[UserDictionary objectForKey:@"Smoking"]UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 7,[[UserDictionary objectForKey:@"UserName"]UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 8,[[UserDictionary objectForKey:@"PastName"]UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 9,[[UserDictionary objectForKey:@"PastPhoneNumber"]UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 10, [[UserDictionary objectForKey:@"PastIdentification"]UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 11, [[UserDictionary objectForKey:@"PastPolicyNo"]UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 12,[[UserDictionary objectForKey:@"PastPhone"]UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 13,[[UserDictionary objectForKey:@"PastEmrContact"]UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 14, [[UserDictionary objectForKey:@"Past"]UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 15, [[UserDictionary objectForKey:@"DOB"]UTF8String], -1, SQLITE_TRANSIENT);		
		sqlite3_bind_int(statement, 16, [[UserDictionary objectForKey:@"Default"]intValue]);
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(statement);
		i=1;
		[Pool release];
	}
	@catch (NSException *e) 
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"User record not Updated" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	return i;
}

-(int)DefaultSet:(NSInteger)User_ID
{
	int i=0;
	@try
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"update User_detail set isdefault=1 where user_ID=%d",User_ID];	
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(statement);
		i=1;
		[Pool release];
		//return i;
	}
	@catch (NSException *e) 
	{
	}
	return i;
	
}

-(int)UpdateDefaultUser:(NSInteger)User_ID
{
	int i=0;
	@try
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"update User_detail set isdefault=0 where user_ID<>%d",User_ID];
		
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(statement);
		i=1;
		[Pool release];
		//return i;
	}
	@catch (NSException *e) 
	{
	}
	return i;	
}

#pragma mark Functions for set user settings for vitals,Routine,exercise etc....

/////// Insert Vitals,routine,exercise etc settings when create new user.

-(int)InsertUserSettings_Data:(NSInteger)Insert_User_Id
{
	int i=0;
	@try
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"insert into User_Settings(User_Id,RoutinesDetailSettings,VitalsEntryDetail,MedicineEntryDetail,Exercise_Settings, Mood_Settings, Diapering_Settings, Activity_Settings,Feeding_Settings) values(?,?,?,?,?,?,?,?,?)"];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		
		sqlite3_bind_int(statement, 1, Insert_User_Id);
		sqlite3_bind_text(statement, 3,[@"1,2,3,4,5,6,7,8,9,10" UTF8String] , -1, SQLITE_TRANSIENT);		
		sqlite3_bind_text(statement, 2,[@"1,2,3,4,5,6,7,8,9,10,11,12" UTF8String] , -1, SQLITE_TRANSIENT);		
		sqlite3_bind_text(statement, 4,[@"" UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 5,[@"1,2,3,4,5" UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 6,[@"1,2,3,4" UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 7,[@"1,2,3" UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 8,[@"1,2,3,4" UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 9,[@"" UTF8String] , -1, SQLITE_TRANSIENT);
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i= sqlite3_last_insert_rowid(database);
		sqlite3_finalize(statement);
		[Pool release];
	}
	@catch (NSException *e) 
	{
	}
	return i;
}

////// Update user Vitals,routine,exercise etc settings 

-(int)UpdateUserData:(NSInteger)Insert_User_Id DailyData:(NSString *)data ColumnName:(NSString *)Name
{
	int i=0;
	@try
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"update User_Settings set %@='%@' where User_ID=%d",Name,data,Insert_User_Id];
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
			i=0;
		}	
		
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
			i=0;
		}
		sqlite3_finalize(statement);
		i=1;
		[Pool release];
	}
	@catch (NSException *e) 
	{
	}
	return i;
}

//// get user settings base on selected user

-(void)SelectUserSettings:(NSInteger)Insert_User_Id
{
	@try
	{
		if(!self.UserSettingsArray)
			self.UserSettingsArray=[[NSMutableArray alloc]init];	
		if([self.UserSettingsArray count]>0)
		{
			[self.UserSettingsArray removeAllObjects];
		}	
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		
		sql=[NSString stringWithFormat:@"select User_ID,VitalsEntryDetail,RoutinesDetailsettings,MedicineEntryDetail,Exercise_Settings, Mood_Settings, Diapering_Settings, Activity_Settings,Feeding_Settings from User_Settings where User_ID=%d",Insert_User_Id];
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				User_Settings *User_Data=[[User_Settings alloc]init];
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				User_Data.User_Id=sqlite3_column_int(selectstatement, 0);				
				User_Data.DailyEntryDetail=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,1)];
				User_Data.HourlyEntryDetail= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,2)];
				User_Data.MedicineEntryDetail= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,3)];
				User_Data.MoodEntryDetail= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,5)];
				User_Data.DiperingEntryDetail= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,6)];
				User_Data.ActivityEntryDetail= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,7)];
				User_Data.FeedingEntryDetail= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,8)];
				User_Data.ExerciseEntryDetail= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,4)];
				
				[Pool release];
				[self.UserSettingsArray addObject:User_Data];			
				[User_Data release];	
			}
		}
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
		NSLog(@"Fail to select user Settings");
	}	
}

#pragma mark Delete from table  Functions

-(int)DeleteAllCategoriesData:(NSString *)TableName IDname:(NSString *)Name DeleteID:(NSInteger)IdDelete
{
	int ret;
	@try
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"delete from %@ where %@=%d",TableName,Name,IdDelete];
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}
		int success=sqlite3_step(statement);
		sqlite3_finalize(statement);
		if (success == SQLITE_ERROR) 
		{
			ret=0;
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		else
		{
			ret=1;
		}
		[Pool release];
	}
	@catch (NSException *ex) 
	{
		ret=0;
	}	
	return ret;
	
}

-(int)DeleteEntry:(NSString *)TableName ColumnName:(NSString *)PrimaryName PrimaryID:(NSInteger)ID
{
	int ret;
	@try
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"delete from %@ where %@=%d",TableName,PrimaryName,ID];
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}
		int success=sqlite3_step(statement);
		sqlite3_finalize(statement);
		if (success == SQLITE_ERROR)
		{
			ret=0;
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		else
		{
			ret=1;
		}
		[Pool release];
	}
	@catch (NSException *ex) 
	{
		ret=0;
	}	
	return ret;	
}

//// insert Medicine

#pragma mark Menstrual_cycle  Functions

-(void)selectMenstural:(NSInteger)User_ID passDate:(NSString *)Daily_Date
{
	@try
	{
		if(!self.MensturalArray)
			self.MensturalArray=[[NSMutableArray alloc]init];	
		
		if([self.MensturalArray count]>0)
		{
			[self.MensturalArray removeAllObjects];
		}	
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		sql=[NSString stringWithFormat:@"select User_id,startdate,enddate,daily_date,cycle_id,Daily_StartDate,Daily_EndDate from  Menstrual_cycle where user_id=%d and Daily_StartDate <= '%@' order by Daily_Date desc limit 1",User_ID,Daily_Date];
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				Menstural_Cycle  *Master=[[Menstural_Cycle alloc]init]; 
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				Master.User_ID= sqlite3_column_int(selectstatement, 0);
				Master.Cycle_ID=sqlite3_column_int(selectstatement, 4);
				Master.StartDate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,1)]; 
				Master.EndDate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,2)]; 
				Master.Daily_Date=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,3)]; 
				Master.Daily_StartDate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,5)]; 
				Master.Daily_EndDate=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,6)]; 
				[Pool release];
				[self.MensturalArray addObject:Master];
				[Master release];	
			}
		}
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
	}		
}

-(int)InsertMenstural:(Menstural_Cycle *)Menstural
{
	int i=0;
	@try
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"insert into Menstrual_Cycle(User_Id,StartDate,EndDate,Daily_Date,Daily_EndDate,Daily_StartDate) values(?,?,?,?,?,?)"];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		sqlite3_bind_int(statement, 1, Menstural.User_ID);
		sqlite3_bind_text(statement, 3,[Menstural.EndDate UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 2,[Menstural.StartDate  UTF8String] , -1, SQLITE_TRANSIENT);
		
		sqlite3_bind_text(statement, 4,[Menstural.Daily_Date UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 5,[Menstural.Daily_EndDate UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 6,[Menstural.Daily_StartDate UTF8String] , -1, SQLITE_TRANSIENT);
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) 
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i= sqlite3_last_insert_rowid(database);
		sqlite3_finalize(statement);
		[Pool release];
	}
	@catch (NSException *e) 
	{
		
	}
	return i;
	
}

-(int)UpdateMenstural:(Menstural_Cycle *)Menstural
{
	int i=0;
	@try
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"update Menstrual_Cycle set StartDate=? ,EndDate=?, Daily_Date=?,Daily_EndDate=?,Daily_StartDate=? where Cycle_ID=%d",Menstural.Cycle_ID];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		sqlite3_bind_text(statement, 2,[Menstural.EndDate UTF8String] , -1, SQLITE_TRANSIENT);
		
		sqlite3_bind_text(statement, 1,[Menstural.StartDate  UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 3,[Menstural.Daily_Date  UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 4,[Menstural.Daily_EndDate UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 5,[Menstural.Daily_StartDate UTF8String] , -1, SQLITE_TRANSIENT);
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i=1;
		sqlite3_finalize(statement);
		[Pool release];
		//return i;
	}
	@catch (NSException *e) 
	{
	}
	return i;
}


-(int)DeleteMenstura:(NSInteger)Cycle_ID
{
	int ret;
	@try
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"delete from Menstrual_Cycle where Cycle_ID=%d",Cycle_ID];
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}
		int success=sqlite3_step(statement);
		sqlite3_finalize(statement);
		if (success == SQLITE_ERROR) {
			ret=0;
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		else
		{
			ret=1;
		}
		[Pool release];
	}
	@catch (NSException *ex) 
	{
		ret=0;
	}	
	return ret;
}

#pragma mark NEW database Changes
//////////////////////  New data base changes

///// get all vitals field name base on user_id
-(void)SelectVitalsInfo:(NSInteger) User_ID
{
	@try
	{
		if(!self.VitalsMasterArray)
			self.VitalsMasterArray=[[NSMutableArray alloc]init];	
		
		if([self.VitalsMasterArray count]>0)
		{
			[self.VitalsMasterArray removeAllObjects];
		}	
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		sql=[NSString stringWithFormat:@"select Field_Name,IsCommon,User_ID,Vitals_ID from Vitals_Master where (User_ID=0 or User_ID=%d)",User_ID];
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				NSMutableDictionary *Master=[[NSMutableDictionary alloc]init];	
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				[Master setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 2)] forKey:@"User_ID"];				
				[Master setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)] forKey:@"Name"];
				[Master setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 1)] forKey:@"IScommon"];
				[Master setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 3)] forKey:@"Vital_ID"];
				[Pool release];
				[self.VitalsMasterArray addObject:Master];
				[Master release];	
			}
		}
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
	}		
}

///// get all routine field name base on user_id
-(void)SelectRoutineInfo:(NSInteger) User_ID
{
	@try
	{
		if(!self.VitalsMasterArray)
			self.VitalsMasterArray=[[NSMutableArray alloc]init];	
		
		if([self.VitalsMasterArray count]>0)
		{
			[self.VitalsMasterArray removeAllObjects];
		}	
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		sql=[NSString stringWithFormat:@"select Field_Name,IsCommom,User_ID,Routine_ID from Routine_Master where (User_ID=0 or User_ID=%d)",User_ID];
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				NSMutableDictionary *Master=[[NSMutableDictionary alloc]init];	
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				[Master setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 2)] forKey:@"User_ID"];				
				[Master setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)] forKey:@"Name"];
				[Master setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 1)] forKey:@"IScommon"];
				[Master setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 3)] forKey:@"Vital_ID"];
				[Pool release];
				[self.VitalsMasterArray addObject:Master];
				[Master release];	
			}
		}
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
	}		
}

///// get all vitals field name base on user_id
-(void)RoutineName:(NSInteger)Entry_ID
{
	@try
	{
		if(!self.EntryArray)
			self.EntryArray=[[NSMutableArray alloc]init];	
		
		if([self.EntryArray count]>0)
		{
			[self.EntryArray removeAllObjects];
		}	
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		sql=[NSString stringWithFormat:@"Select Routine_ID,Field_Name from Routine_Master where Routine_ID=%d",Entry_ID];
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				NSMutableDictionary *Master=[[NSMutableDictionary alloc]init];	
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				[Master setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 0)] forKey:@"Vital_ID"];				
				[Master setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,1)] forKey:@"Name"];
				[Pool release];
				[self.EntryArray addObject:Master];
				[Master release];					
			}
		}
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
	}	
}

/// Select vitals field name base on field_is 

-(void)VitalName:(NSInteger)Entry_ID
{
	@try
	{
		if(!self.EntryArray)
			self.EntryArray=[[NSMutableArray alloc]init];	
		
		if([self.EntryArray count]>0)
		{
			[self.EntryArray removeAllObjects];
		}	
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		sql=[NSString stringWithFormat:@"Select Vitals_ID,Field_Name from Vitals_Master where Vitals_ID=%d",Entry_ID];
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				NSMutableDictionary *Master=[[NSMutableDictionary alloc]init];
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				[Master setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 0)] forKey:@"Vital_ID"];				
				[Master setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,1)] forKey:@"Name"];
				[Pool release];
				[self.EntryArray addObject:Master];
				[Master release];					
			}
		}
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
	}	
}



#pragma mark NEW Medicine Table

//////////////////  Medicine Table Data
-(int)InsertMedicinedata:(Medicine *)MedicineRef1
{
	int i=0;
	@try
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"insert into Medicine(User_ID,Medicine_Entry,EntryDate,EntryTime,Insert_Medicine_ID) values(?,?,?,?,?)"];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		
		sqlite3_bind_int(statement, 1, MedicineRef1.UserID);
		sqlite3_bind_text(statement, 2,[MedicineRef1.MedicineEntry  UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 3,[MedicineRef1.EntryDate UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 4,[MedicineRef1.EntryTime UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 5,[MedicineRef1.Medicine_Insert_ID UTF8String] , -1, SQLITE_TRANSIENT);
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i= sqlite3_last_insert_rowid(database);
		sqlite3_finalize(statement);
		[Pool release];
	}
	@catch (NSException *e) 
	{
	}
	return i;
}

-(void)Medicinedata:(NSString*)EntryDate ToTime:(NSString *)EntryTime anduserid:(NSInteger)User_ID
{
	@try
	{
		if(!self.EntryArray)
			self.EntryArray=[[NSMutableArray alloc]init];	
		
		if([self.EntryArray count]>0)
		{
			[self.EntryArray removeAllObjects];
		}	
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		sql=[NSString stringWithFormat:@"select User_ID,Medicine_Entry,EntryDate,EntryTime,Medicine_ID,Insert_Medicine_ID from Medicine where User_ID=%d and(EntryDate='%@' and EntryTime='%@')",User_ID,EntryDate,EntryTime];
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				Medicine *Master=[[Medicine alloc]init]; 
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				Master.UserID= sqlite3_column_int(selectstatement, 0);
				Master.MedicineEntry= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,1)];
				Master.EntryDate= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,2)];
				Master.EntryTime= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,3)];
				Master.MedicineID= sqlite3_column_int(selectstatement, 4);
				Master.Medicine_Insert_ID= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,5)];
				[Pool release];
				[self.EntryArray addObject:Master];			
				[Master release];	
			}
		}
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
	}		
}

-(int)UpdateData:(Medicine*)MedicineRef1
{
	int i=0;
	@try
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"update Medicine set User_ID=?,Medicine_Entry=?,EntryDate=?,EntryTime=?,Insert_Medicine_ID=? where Medicine_ID=%d",MedicineRef1.MedicineID];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		sqlite3_bind_int(statement, 1, MedicineRef1.UserID);
		sqlite3_bind_text(statement, 2,[MedicineRef1.MedicineEntry  UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 3,[MedicineRef1.EntryDate UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 4,[MedicineRef1.EntryTime UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 5,[MedicineRef1.Medicine_Insert_ID UTF8String] , -1, SQLITE_TRANSIENT);
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i=1;
		sqlite3_finalize(statement);
		[Pool release];
	}
	@catch (NSException *e) 
	{
	}
	return i;
}

#pragma mark NOT Medicine Functions

///// Get medicine name base on maedicin ID

-(NSString *)SelectMedicine:(NSInteger)MedicineID
{
	NSString *Name=@"";
	@try
	{
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		sql=[NSString stringWithFormat:@"Select Medicine_Name from MedicineMst where Medicine_ID=%d",MedicineID];
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				Name= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)];			
			}
		}
		sqlite3_finalize(selectstatement);
		return Name;
	}
	@catch (NSException *e) 
	{
	}	
	return Name;
}

//// get medicine id for store user medicine entry in settings table

-(void)SelectMedicineNames
{
	@try
	{
		if(!self.MedicineArray)
			self.MedicineArray=[[NSMutableArray alloc]init];	
		
		if([self.MedicineArray count]>0)
		{
			[self.MedicineArray removeAllObjects];
		}	
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		sql=@"Select Medicine_Name,Medicine_ID from MedicineMst";
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				NSMutableDictionary *Master=[[NSMutableDictionary alloc]init];
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				[Master setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 1)] forKey:@"Medicine_ID"];				
				[Master setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)] forKey:@"Medicine_Name"];
				[Pool release];
				[self.MedicineArray addObject:Master];
				[Master release];	
			}
		}
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
	}	
}

////// get medicine name as per medicine ID
-(BOOL)IsMedicineExist:(NSString*)MedicineName
{
	
	@try
	{
		MedicineName=[MedicineName stringByReplacingOccurrencesOfString:@"'" withString:@"''"];	
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"select Medicine_ID from MedicineMst where lower(Medicine_Name)='%@'",MedicineName];   /////
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		
		int success=sqlite3_step(statement);
		sqlite3_finalize(statement);
		if(success==SQLITE_ROW)
		{		
			return YES;
		}
		else
		{
			return NO;
		}
		if (success == SQLITE_ERROR) 
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		return NO;
	}
	@catch (NSException *e) 
	{
		
	}
	return NO;
}

//// Insert Madicine in medicine master table

-(int)InsertMedicine:(NSString *)MedicineName
{
	int i=0;
	@try
	{
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"insert into MedicineMst(Medicine_Name) values(?)"];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		sqlite3_bind_text(statement, 1,[MedicineName UTF8String] , -1, SQLITE_TRANSIENT);
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i= sqlite3_last_insert_rowid(database);
		sqlite3_finalize(statement);
		
		return i;
	}
	@catch (NSException *e) 
	{
	}
	return i;	
}

/// Update medicine name base on medicine ID

-(int)UpdateMedicine:(NSString *)MedicineName andID:(NSInteger)Medicine_ID
{
	int i=0;
	@try
	{
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"update MedicineMst set Medicine_Name=? where Medicine_ID=%d",Medicine_ID];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		sqlite3_bind_text(statement, 1,[MedicineName UTF8String] , -1, SQLITE_TRANSIENT);
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i= 1;
		sqlite3_finalize(statement);
		
		return i;
	}
	@catch (NSException *e) 
	{
	}
	return i;	
}
//////////////////    Vital Table

#pragma mark Vitals Table Methoda

//////////// Insert Vitals record

-(int)InsertVitalsDetail:(Vitals_Detail*)Data
{
	int i=0;
	@try
	{
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"insert into Vitals_Detail(User_ID,BP,EntryDate,EntryTime,BloodSugar,Fasting,Other_Vitals,Pulse,Respiration,TemperatureC,TemperatureF,WeightLbs,WeightKgs,HeightCms,HeightInch,Pain,Magnitude) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		sqlite3_bind_int(statement, 1, Data.User_ID1);
		sqlite3_bind_text(statement, 2,[Data.BP  UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 3,[Data.EntryDate UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 4,[Data.EntryTime UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 5,[Data.BloodSugar UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 6,[Data.Fasting UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 7,[Data.Other UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 8,[Data.Pulse UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 9,[Data.Respiration UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 10,[Data.TempC UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 11,[Data.TempF UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 12,[Data.WeightLbs UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 13,[Data.WeightKgs UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 14,[Data.HeightCms UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 15,[Data.HeightInch UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 16,[Data.Pain UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_int(statement, 17, Data.Magnitude);
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i= sqlite3_last_insert_rowid(database);
		sqlite3_finalize(statement);
		
		return i;
	}
	@catch (NSException *e) 
	{
	}
	return i;	
}

//// Update Vitals Record

-(int)UpdateVitalsDetail:(Vitals_Detail*)Data
{
	int i=0;
	@try
	{
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"update Vitals_Detail set User_ID=?,BP=?,EntryDate=?,EntryTime=?,BloodSugar=?,Fasting=?,Other_Vitals=?,Pulse=?,Respiration=?,TemperatureC=?,TemperatureF=?,WeightLbs=?,WeightKgs=?,HeightCms=?,HeightInch=?,Pain=?,Magnitude=? where Vitals_ID=%d",Data.Vitals_ID];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		sqlite3_bind_int(statement, 1, Data.User_ID1);
		sqlite3_bind_text(statement, 2,[Data.BP  UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 3,[Data.EntryDate UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 4,[Data.EntryTime UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 5,[Data.BloodSugar UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 6,[Data.Fasting UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 7,[Data.Other UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 8,[Data.Pulse UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 9,[Data.Respiration UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 10,[Data.TempC UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 11,[Data.TempF UTF8String] , -1, SQLITE_TRANSIENT);		
		sqlite3_bind_text(statement, 12,[Data.WeightLbs UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 13,[Data.WeightKgs UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 14,[Data.HeightCms UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 15,[Data.HeightInch UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 16,[Data.Pain UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_int(statement, 17, Data.Magnitude);
		int success=sqlite3_step(statement);		
		if (success == SQLITE_ERROR) 
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i=1;
		sqlite3_finalize(statement);		
		return i;
	}
	@catch (NSException *e) 
	{
	}
	return i;	
}

//// Get Vital record base on Date,Time and User

-(void)SelectVitalsDetail:(NSString*)PassingDate AndTime:(NSString*)PassingTime andUserID:(NSInteger)User_ID
{
	@try
	{
		if(!self.DailyArray)
			self.DailyArray=[[NSMutableArray alloc]init];	
		
		if([self.DailyArray count]>0)
		{
			[self.DailyArray removeAllObjects];
		}	
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		sql=[NSString stringWithFormat:@"select User_ID,BP,EntryDate,EntryTime,BloodSugar,Fasting,Other_Vitals,Pulse,Respiration,TemperatureC,TemperatureF,Vitals_ID,WeightLbs,WeightKgs,HeightCms,HeightInch,Pain,Magnitude from Vitals_Detail where User_ID=%d and(EntryDate='%@' and EntryTime='%@')",User_ID,PassingDate,PassingTime];
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				Vitals_Detail *Master=[[Vitals_Detail alloc]init]; 
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				Master.User_ID1= sqlite3_column_int(selectstatement, 0);
				Master.BP= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,1)];
				Master.EntryDate= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,2)];
				Master.EntryTime= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,3)];
				Master.BloodSugar=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,4)];
				Master.Fasting=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,5)];
				Master.Other=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,6)];
				Master.Pulse=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,7)];
				Master.Respiration=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,8)];
				Master.TempC=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,9)];
				Master.TempF=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,10)];
				Master.Vitals_ID= sqlite3_column_int(selectstatement, 11);
				Master.WeightLbs=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,12)];
				Master.WeightKgs=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,13)];				
				Master.HeightCms=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,14)];
				Master.HeightInch=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,15)];
				Master.Pain=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,16)];
				Master.Magnitude= sqlite3_column_int(selectstatement, 17);
				[Pool release];
				[DailyArray addObject:Master];			
				[Master release];	
			}
		}
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
	}	
}

#pragma mark Routines Table Methoda

///// Insert Routine Record

-(int)InsertRoutinesDetail:(Routine_Detail*)Data
{
	int i=0;
	@try
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"insert into Routine_Detail(User_ID,Activity,EntryDate,EntryTime,Alcohol,Cigarrettes,Diapering,Drugs,Exercise,Feeding,Mood,Other_Routines,Sleep, Exercise_ID,WakeUp,calories) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}			
		sqlite3_bind_int(statement, 1, Data.User_ID);
		sqlite3_bind_text(statement, 2,[Data.Activity  UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 3,[Data.EntryDate UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 4,[Data.EntryTime UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 5,[Data.Alcohol UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 6,[Data.Cigarrettes UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 7,[Data.Diapering UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 8,[Data.Drugs UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 9,[Data.Exercise UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 10,[Data.Feeding UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 11,[Data.Mood UTF8String] , -1, SQLITE_TRANSIENT);		
		sqlite3_bind_text(statement, 12,[Data.Other UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 13,[Data.Sleep UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 14,[Data.Exercise_id UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 15,[Data.WakeUpSleep UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_int(statement, 16, Data.calories);
		int success=sqlite3_step(statement);		
		if (success == SQLITE_ERROR) 
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i= sqlite3_last_insert_rowid(database);
		sqlite3_finalize(statement);
		[Pool release];
		return i;
	}
	@catch (NSException *e) 
	{
		NSLog(@"Fail Insert Routine");
	}
	return i;	
}

/// Update Routine Record

-(int)UpdateRoutinesDetail:(Routine_Detail*)Data
{
	int i=0;
	@try
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"update Routine_Detail set User_ID=?,Activity=?,EntryDate=?,EntryTime=?,Alcohol=?,Cigarrettes=?,Diapering=?,Drugs=?,Exercise=?,Feeding=?,Mood=?,Other_Routines=?,Sleep=?,Exercise_ID=?,Wakeup=?,calories=? where Routine_ID=%d",Data.Routine_ID];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		sqlite3_bind_int(statement, 1, Data.User_ID);
		sqlite3_bind_text(statement, 2,[Data.Activity  UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 3,[Data.EntryDate UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 4,[Data.EntryTime UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 5,[Data.Alcohol UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 6,[Data.Cigarrettes UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 7,[Data.Diapering UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 8,[Data.Drugs UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 9,[Data.Exercise UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 10,[Data.Feeding UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 11,[Data.Mood UTF8String] , -1, SQLITE_TRANSIENT);		
		sqlite3_bind_text(statement, 12,[Data.Other UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 13,[Data.Sleep UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 14,[Data.Exercise_id UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 15,[Data.WakeUpSleep UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_int(statement, 16, Data.calories);
		int success=sqlite3_step(statement);		
		if (success == SQLITE_ERROR) 
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i=1;
		sqlite3_finalize(statement);
		[Pool release];
		return i;
	}
	@catch (NSException *e) 
	{
		NSLog(@"Fail Update Routine");
	}
	return i;	
}

///// Get Routine record base on Date,Time and User_ID

-(void)SelectRoutinesDetail:(NSString*)PassingDate AndTime:(NSString*)PassingTime andUserID:(NSInteger)User_ID
{
	@try
	{
		if(!self.HourlyDataArray)
			self.HourlyDataArray=[[NSMutableArray alloc]init];			
		if([self.HourlyDataArray count]>0)
		{
			[self.HourlyDataArray removeAllObjects];
		}	
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		sql=[NSString stringWithFormat:@"select User_ID,Activity,EntryDate,EntryTime,Alcohol,Cigarrettes,Diapering,Drugs,Exercise,Feeding,Mood,Other_Routines,Sleep,Routine_ID,Exercise_ID,Wakeup,calories from Routine_Detail where User_ID=%d and(EntryDate='%@' and EntryTime='%@')",User_ID,PassingDate,PassingTime];
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				Routine_Detail *Master=[[Routine_Detail alloc]init]; 
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				Master.User_ID= sqlite3_column_int(selectstatement, 0);
				Master.Activity= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,1)];
				Master.EntryDate= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,2)];
				Master.EntryTime= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,3)];
				Master.Alcohol=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,4)];
				Master.Cigarrettes=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,5)];
				Master.Diapering=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,6)];
				Master.Drugs=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,7)];
				Master.Exercise=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,8)];
				Master.Feeding=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,9)];
				Master.Mood=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,10)];
				Master.Other=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,11)];
				Master.Sleep=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,12)];
				Master.Routine_ID= sqlite3_column_int(selectstatement, 13);
				Master.Exercise_id=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,14)];
				Master.WakeUpSleep=[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,15)];
				Master.calories=sqlite3_column_int(selectstatement, 16);
				[Pool release];
				[self.HourlyDataArray addObject:Master];			
				[Master release];	
			}
		}
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
	}	
}

#pragma mark ConvertingFunction

///// Convert Feets in to CMS

-(NSString *)ConvertIntoCms:(NSString *)Feets
{
	NSArray *arr=[Feets componentsSeparatedByString:@"' "]; 
	if([arr count]>1)
	{
		NSString *Str=[arr objectAtIndex:1];
		Str=[Str stringByReplacingOccurrencesOfString:@"\"" withString:@""];
		double Feet=[[arr objectAtIndex:0]intValue];
		double Inch=[Str intValue];		
		Feet=(Feet)+(Inch/12);
		Feet= Feet *0.3048;
		return [NSString stringWithFormat:@"%.2f",Feet];
	}
	return @"";
}

//// Convert Cms into Feets

-(NSString *)ConvertFeets:(NSString *)INCMS
{
	double Meters=[INCMS doubleValue];
	Meters=Meters*100;
	Meters=Meters*0.39;
	double Feet=Meters/12;
	NSArray *arr=[[NSString stringWithFormat:@"%.2f",Feet] componentsSeparatedByString:@"."]; 
	if([arr count]>1)
	{
		NSString *Data=[NSString stringWithFormat:@"0.%@",[arr objectAtIndex:1]];
		double Feets=[Data doubleValue];
		Feets=Feets*12;
		int Final=round(Feets);
		if(Final>=12)
		{
			Final=11;
		}
		return [NSString stringWithFormat:@"%@' %d\"",[arr objectAtIndex:0],Final];
	}
	return @"";
}

#pragma mark Vitals and routine Calendar data

///// Get All records for selected column for selected user for Send all data via mail

-(void)GetAllCalendarData:(NSString *)ColumnName andUserID:(NSInteger)User_ID andTableName:(NSString *)TableName
{
	NSAutoreleasePool  *Pool=[[NSAutoreleasePool alloc]init];
	@try
	{
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		NSString *Str=@"";
		int returnvalue;
		NSString *Col=@"";
		if([ColumnName isEqualToString:@"Sleep1"] || [ColumnName isEqualToString:@"Sleep"])
		{
			Col=@"Sleep";
		}
		if([Col isEqualToString:@"Sleep"])
		{
			sql=[NSString stringWithFormat:@"Select EntryDate,EntryTime,%@,WakeUp from %@ where (%@<>'' or Wakeup<>'') and User_ID=%d  order by EntryDate,EntryTime ",Col,TableName,Col,User_ID];
		}
		else if([ColumnName isEqualToString:@"Pain"])
		{
			sql=[NSString stringWithFormat:@"Select EntryDate,EntryTime,%@,Magnitude from %@ where (%@<>'' || %@!=0) and User_ID=%d  order by EntryDate,EntryTime ",ColumnName,TableName,ColumnName,@"Magnitude",User_ID];
		}
		else if([ColumnName isEqualToString:@"calories"])
		{
			sql=[NSString stringWithFormat:@"Select EntryDate,EntryTime,%@ from %@ where %@<> -1 and User_ID=%d  order by EntryDate,EntryTime ",ColumnName,TableName,ColumnName,User_ID];
		}
		else
			sql=[NSString stringWithFormat:@"Select EntryDate,EntryTime,%@ from %@ where %@<>'' and User_ID=%d  order by EntryDate,EntryTime ",ColumnName,TableName,ColumnName,User_ID];
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		NSMutableDictionary *User_Data=[[NSMutableDictionary alloc]init];
		if([ColumnName isEqualToString:@"Exercise_id"] || [ColumnName isEqualToString:@"Feeding"] || [ColumnName isEqualToString:@"Medicine_Entry"])
		{
			ExerciseArr=[[NSMutableArray alloc]init];
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				NSAutoreleasePool *Pool1=[[NSAutoreleasePool alloc]init];
				if([ColumnName isEqualToString:@"Sleep"])
				{
					Str=[NSString stringWithFormat:@"%@ %@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)],[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,1)]];
					[User_Data setObject:[NSString stringWithFormat:@"%@ / %@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,2)],[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,3)]] forKey:Str];
					if(![self.WeekArray containsObject:Str])					
						[self.WeekArray addObject:Str];		
					
				}
				else if([ColumnName isEqualToString:@"Sleep1"])
				{					
					[self.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
					NSDate *Start=[self.DateFormatter dateFromString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,2)]];
					NSDate *End=[self.DateFormatter dateFromString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,3)]];	
					int Diffetence=[End timeIntervalSinceDate:Start];
					int Minutes=Diffetence;
					Diffetence=Diffetence/3600;
					Minutes=Minutes%3600;
					Minutes=Minutes/60;					
					NSString *Mins=[NSString stringWithFormat:@"%02d:%02d",Diffetence,Minutes];					
					NSString *Str=[NSString stringWithFormat:@"%@ %@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)],[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,1)]];
					[User_Data setObject:[NSString stringWithFormat:@"%@",Mins] forKey:Str];					
					if(![self.WeekArray containsObject:Str])					
						[self.WeekArray addObject:Str];	
					
				}
				else if([ColumnName isEqualToString:@"Pain"])
				{
					Str=[NSString stringWithFormat:@"%@ %@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)],[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,1)]];
					
					//NSLog([NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,2)]);
					
					if([[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,2)] length]>0)
					{
						[User_Data setObject:[NSString stringWithFormat:@"%@ (%d)",[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,2)],sqlite3_column_int(selectstatement, 3)] forKey:Str];
					}
					else
					{
						[User_Data setObject:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 3)] forKey:Str];
					}
					if(![self.WeekArray containsObject:Str])					
						[self.WeekArray addObject:Str];
				}
				else if([ColumnName isEqualToString:@"Exercise_id"])
				{
					Str=[NSString stringWithFormat:@"%@ %@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)],[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,1)]];
					[ExerciseArr addObject:Str]; 
				}
				else if([ColumnName isEqualToString:@"calories"])
				{
					Str=[NSString stringWithFormat:@"%@ %@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)],[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,1)]];
					[User_Data setObject:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 2)] forKey:Str];
					
					if(![self.WeekArray containsObject:Str])					
						[self.WeekArray addObject:Str];	
				}
				else if([ColumnName isEqualToString:@"Feeding"] || [ColumnName isEqualToString:@"Medicine_Entry"])
				{
					Str=[NSString stringWithFormat:@"%@ %@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)],[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,1)]];
					[ExerciseArr addObject:Str];
				}
				else
				{
					Str=[NSString stringWithFormat:@"%@ %@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)],[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,1)]];
					[User_Data setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,2)] forKey:Str];
					if(![self.WeekArray containsObject:Str])					
						[self.WeekArray addObject:Str];		
				}
				[Pool1 release];				
			}
			[ReportArray setObject:User_Data forKey:ColumnName]; 
			[User_Data release];	
		}
		sqlite3_finalize(selectstatement);
		if([ColumnName isEqualToString:@"Exercise_id"])
		{
			///// Get Exercise record for User
			NSMutableDictionary *User_Data1=[[NSMutableDictionary alloc]init];
			for (int i=0;i<[ExerciseArr count];i++)
			{
				[self selectExercise_Report:[ExerciseArr objectAtIndex:i]];
				NSString *Str2=@"";
				for(int i=0;i<[ExerciseDurationArray count];i++)
				{
					NSDictionary *Dic=[ExerciseDurationArray objectAtIndex:i];
					int Dur=[[Dic valueForKey:@"Duration"]intValue];
					int	Hours=Dur%60;
					int Minutes=Dur/60;
					if(i==([ExerciseDurationArray count]-1))
					{
						Str2=[Str2 stringByAppendingString:[NSString stringWithFormat:@"%@ (%d:%d)",[Dic valueForKey:@"Exercise_ID"],Minutes,Hours]];
					}
					else
					{
						Str2=[Str2 stringByAppendingString:[NSString stringWithFormat:@"%@ (%d:%d), ",[Dic valueForKey:@"Exercise_ID"],Minutes,Hours]];
					}
				}
				[User_Data1 setObject:Str2 forKey:[ExerciseArr objectAtIndex:i]];
							
				if(![self.WeekArray containsObject:[ExerciseArr objectAtIndex:i]])					
					[self.WeekArray addObject:[ExerciseArr objectAtIndex:i]];	
			}
			[self.ReportArray setObject:User_Data1 forKey:ColumnName]; 
			[User_Data1 release];	
			[ExerciseArr release];
		}
		if([ColumnName isEqualToString:@"Medicine_Entry"])
		{
			
			/// Get Medicine Record
			NSMutableDictionary *User_Data1=[[NSMutableDictionary alloc]init];
			for (int i=0;i<[ExerciseArr count];i++)
			{
				[self SelectMedicineDeatlByDate:[ExerciseArr objectAtIndex:i]];
				NSString *Str2=@"";
				if([self.UnitDictionary count]>0)
				{
					NSArray *array=[self.UnitDictionary allKeys];
					
					for(int i=0;i<[self.UnitDictionary count];i++)
					{							
						NSDictionary *Dic=[self.UnitDictionary objectForKey:[array objectAtIndex:i]];
						if(i==([self.UnitDictionary count]-1))
						{
							Str2=[Str2 stringByAppendingString:[NSString stringWithFormat:@"%@ (%@ %@)",[Dic valueForKey:@"Med_Name"],[Dic valueForKey:@"Med_Qty"],[Dic valueForKey:@"Med_Unit"]]];								
						}
						else
						{
							Str2=[Str2 stringByAppendingString:[NSString stringWithFormat:@"%@ (%@ %@),",[Dic valueForKey:@"Med_Name"],[Dic valueForKey:@"Med_Qty"],[Dic valueForKey:@"Med_Unit"]]];								
						}
					}
				}				
				[User_Data1 setObject:Str2 forKey:[ExerciseArr objectAtIndex:i]];
				
				if(![self.WeekArray containsObject:[ExerciseArr objectAtIndex:i]])					
					[self.WeekArray addObject:[ExerciseArr objectAtIndex:i]];	
			}
			[self.ReportArray setObject:User_Data1 forKey:ColumnName]; 
			[User_Data1 release];	
			[ExerciseArr release];
		}
		if([ColumnName isEqualToString:@"Feeding"])
		{
			//// Get Feeding Record
			NSMutableDictionary *User_Data1=[[NSMutableDictionary alloc]init];
			for (int i=0;i<[ExerciseArr count];i++)
			{
				[self SelectFeedDeatlByDate:[ExerciseArr objectAtIndex:i]];
				NSString *Str2=@"";
				if([self.UnitDictionary count]>0)
				{
					NSArray *array=[self.UnitDictionary allKeys];
					
					for(int i=0;i<[self.UnitDictionary count];i++)
					{							
						NSDictionary *Dic=[self.UnitDictionary objectForKey:[array objectAtIndex:i]];
						if(i==([self.UnitDictionary count]-1))
						{
							Str2=[Str2 stringByAppendingString:[NSString stringWithFormat:@"%@ (%@ %@)",[Dic valueForKey:@"Feed_Name"],[Dic valueForKey:@"Feed_Qty"],[Dic valueForKey:@"Feed_Unit"]]];								
						}
						else
						{
							Str2=[Str2 stringByAppendingString:[NSString stringWithFormat:@"%@ (%@ %@),",[Dic valueForKey:@"Feed_Name"],[Dic valueForKey:@"Feed_Qty"],[Dic valueForKey:@"Feed_Unit"]]];								
						}
					}
				}				
				[User_Data1 setObject:Str2 forKey:[ExerciseArr objectAtIndex:i]];
				
				if(![self.WeekArray containsObject:[ExerciseArr objectAtIndex:i]])					
					[self.WeekArray addObject:[ExerciseArr objectAtIndex:i]];	
			}
			[self.ReportArray setObject:User_Data1 forKey:ColumnName]; 
			[User_Data1 release];	
			[ExerciseArr release];
		}
	}
	@catch (NSException *e) 
	{
		NSLog(ColumnName);
	}	
	[Pool release];	
}

///// Get records between two dates for selected user for calendar

-(void)GetVitalsCalendarData:(NSString *)ColumnName StartDate:(NSString*)PassStartDate Enddate:(NSString *)PassEndDate StartTime:(NSString *)PassStartTime EndTime:(NSString*)PassEndTime andUserID:(NSInteger)User_ID andTableName:(NSString *)TableName
{
	NSAutoreleasePool  *Pool=[[NSAutoreleasePool alloc]init];
	@try
	{
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		NSString *Str=@"";
		NSLog(ColumnName);
		int returnvalue;
		NSString *Col=@"";
		if([ColumnName isEqualToString:@"Sleep1"] || [ColumnName isEqualToString:@"Sleep"])
		{
			Col=@"Sleep";
		}
		if([PassStartDate isEqualToString:PassEndDate])
		{
			if([Col isEqualToString:@"Sleep"])
			{
				sql=[NSString stringWithFormat:@"Select EntryDate,EntryTime,%@,WakeUp from %@ where  ((entrydate >= '%@'  and EntryTime>='%@'  And   EntryTime <= '%@' )) and (%@<>'' or Wakeup<>'') and User_ID=%d  order by EntryDate,EntryTime ",Col,TableName,PassStartDate,PassStartTime,PassEndTime,Col,User_ID];
			}
			else if([ColumnName isEqualToString:@"Pain"])
			{
				sql=[NSString stringWithFormat:@"Select EntryDate,EntryTime,%@,Magnitude from %@ where  ((entrydate >= '%@'  and EntryTime>='%@'  And   EntryTime <= '%@' )) and (%@<>'' || %@!=0) and User_ID=%d  order by EntryDate,EntryTime ",ColumnName,TableName,PassStartDate,PassStartTime,PassEndTime,ColumnName,@"Magnitude",User_ID];
			}
			else if([ColumnName isEqualToString:@"calories"])
			{
				sql=[NSString stringWithFormat:@"Select EntryDate,EntryTime,%@ from %@ where  ((entrydate >= '%@'  and EntryTime>='%@'  And   EntryTime <= '%@' )) and %@<> -1 and User_ID=%d  order by EntryDate,EntryTime ",ColumnName,TableName,PassStartDate,PassStartTime,PassEndTime,ColumnName,User_ID];
			}
			else
				sql=[NSString stringWithFormat:@"Select EntryDate,EntryTime,%@ from %@ where  ((entrydate >= '%@'  and EntryTime>='%@'  And   EntryTime <= '%@' )) and %@<>'' and User_ID=%d  order by EntryDate,EntryTime ",ColumnName,TableName,PassStartDate,PassStartTime,PassEndTime,ColumnName,User_ID];
		}
		else
		{
			if([Col isEqualToString:@"Sleep"])
			{
				sql=[NSString stringWithFormat:@"Select EntryDate,EntryTime,%@,WakeUp from %@ where  ((entrydate >= '%@'  and EntryTime>='%@' ) OR (EntryDate = '%@' And   EntryTime <= '%@') OR (EntryDate > '%@' And EntryDate < '%@' )) and (%@<>'' or Wakeup<>'')  and User_ID=%d  order by EntryDate,EntryTime ",Col,TableName,PassStartDate,PassStartTime,PassEndDate,PassEndTime,PassStartDate,PassEndDate,Col,User_ID];	
			}
			else if([ColumnName isEqualToString:@"Pain"])
			{
				sql=[NSString stringWithFormat:@"Select EntryDate,EntryTime,%@,Magnitude from %@ where  ((entrydate >= '%@'  and EntryTime>='%@' ) OR (EntryDate = '%@' And   EntryTime <= '%@') OR (EntryDate > '%@' And EntryDate < '%@' )) and (%@<>'' || %@!=0) and User_ID=%d  order by EntryDate,EntryTime ",ColumnName,TableName,PassStartDate,PassStartTime,PassEndDate,PassEndTime,PassStartDate,PassEndDate,ColumnName,@"Magnitude",User_ID];
			}
			else if([ColumnName isEqualToString:@"calories"])
			{
				sql=[NSString stringWithFormat:@"Select EntryDate,EntryTime,%@ from %@ where  ((entrydate >= '%@'  and EntryTime>='%@' ) OR (EntryDate = '%@' And   EntryTime <= '%@') OR (EntryDate > '%@' And EntryDate < '%@' )) and %@<> -1 and User_ID=%d  order by EntryDate,EntryTime ",ColumnName,TableName,PassStartDate,PassStartTime,PassEndDate,PassEndTime,PassStartDate,PassEndDate,ColumnName,User_ID];
			}
			else
				sql=[NSString stringWithFormat:@"Select EntryDate,EntryTime,%@ from %@ where  ((entrydate >= '%@'  and EntryTime>='%@' ) OR (EntryDate = '%@' And   EntryTime <= '%@') OR (EntryDate > '%@' And EntryDate < '%@' )) and %@<>'' and User_ID=%d  order by EntryDate,EntryTime ",ColumnName,TableName,PassStartDate,PassStartTime,PassEndDate,PassEndTime,PassStartDate,PassEndDate,ColumnName,User_ID];
		}
	//	NSLog(sql);
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		NSMutableDictionary *User_Data=[[NSMutableDictionary alloc]init];
		if([ColumnName isEqualToString:@"Exercise_id"] || [ColumnName isEqualToString:@"Feeding"] || [ColumnName isEqualToString:@"Medicine_Entry"])
		{
			ExerciseArr=[[NSMutableArray alloc]init];
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				NSAutoreleasePool *Pool1=[[NSAutoreleasePool alloc]init];
				if([ColumnName isEqualToString:@"Sleep"])
				{
					Str=[NSString stringWithFormat:@"%@ %@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)],[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,1)]];
					[User_Data setObject:[NSString stringWithFormat:@"%@ / %@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,2)],[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,3)]] forKey:Str];
					
					if(![self.WeekArray containsObject:Str])					
						[self.WeekArray addObject:Str];		
					
				}
				else if([ColumnName isEqualToString:@"Sleep1"])
				{					
					[self.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
					NSDate *Start=[self.DateFormatter dateFromString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,2)]];
					NSDate *End=[self.DateFormatter dateFromString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,3)]];	
					int Diffetence=[End timeIntervalSinceDate:Start];
					int Minutes=Diffetence;
					Diffetence=Diffetence/3600;
					Minutes=Minutes%3600;
					Minutes=Minutes/60;

					NSString *Mins=[NSString stringWithFormat:@"%02d:%02d",Diffetence,Minutes];
									
					NSString *Str=[NSString stringWithFormat:@"%@ %@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)],[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,1)]];
					[User_Data setObject:[NSString stringWithFormat:@"%@",Mins] forKey:Str];
					
					if(![self.WeekArray containsObject:Str])					
						[self.WeekArray addObject:Str];	
					
					NSLog(@"%f",Diffetence);
				}
				else if([ColumnName isEqualToString:@"Pain"])
				{
					Str=[NSString stringWithFormat:@"%@ %@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)],[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,1)]];
					NSLog([NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,2)]);
					
					if([[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,2)] length]>0)
					{
						[User_Data setObject:[NSString stringWithFormat:@"%@ (%d)",[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,2)],sqlite3_column_int(selectstatement, 3)] forKey:Str];
					}
					else
					{
						[User_Data setObject:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 3)] forKey:Str];
					}
					if(![self.WeekArray containsObject:Str])					
						[self.WeekArray addObject:Str];
				}
				else if([ColumnName isEqualToString:@"Exercise_id"])
				{
					Str=[NSString stringWithFormat:@"%@ %@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)],[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,1)]];
					[ExerciseArr addObject:Str]; 
				}
				else if([ColumnName isEqualToString:@"calories"])
				{
					Str=[NSString stringWithFormat:@"%@ %@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)],[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,1)]];
					[User_Data setObject:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 2)] forKey:Str];
					
					if(![self.WeekArray containsObject:Str])					
						[self.WeekArray addObject:Str];	
				}
				else if([ColumnName isEqualToString:@"Feeding"] || [ColumnName isEqualToString:@"Medicine_Entry"])
				{
					Str=[NSString stringWithFormat:@"%@ %@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)],[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,1)]];
					[ExerciseArr addObject:Str];
				}
				else
				{
					Str=[NSString stringWithFormat:@"%@ %@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)],[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,1)]];
					[User_Data setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,2)] forKey:Str];
					
					if(![self.WeekArray containsObject:Str])					
						[self.WeekArray addObject:Str];		
				}
				[Pool1 release];				
			}
			[ReportArray setObject:User_Data forKey:ColumnName]; 
			[User_Data release];	
		}
		sqlite3_finalize(selectstatement);
		if([ColumnName isEqualToString:@"Exercise_id"])
		{
			///// Get Exercise Record
			NSMutableDictionary *User_Data1=[[NSMutableDictionary alloc]init];
			for (int i=0;i<[ExerciseArr count];i++)
			{
				[self selectExercise_Report:[ExerciseArr objectAtIndex:i]];
				NSString *Str2=@"";
				for(int i=0;i<[ExerciseDurationArray count];i++)
				{
					NSDictionary *Dic=[ExerciseDurationArray objectAtIndex:i];
					int Dur=[[Dic valueForKey:@"Duration"]intValue];
					int	Hours=Dur%60;
					int Minutes=Dur/60;
					if(i==([ExerciseDurationArray count]-1))
					{
						Str2=[Str2 stringByAppendingString:[NSString stringWithFormat:@"%@ (%d:%d)",[Dic valueForKey:@"Exercise_ID"],Minutes,Hours]];
					}
					else
					{
						Str2=[Str2 stringByAppendingString:[NSString stringWithFormat:@"%@ (%d:%d), ",[Dic valueForKey:@"Exercise_ID"],Minutes,Hours]];
					}
				}
				[User_Data1 setObject:Str2 forKey:[ExerciseArr objectAtIndex:i]];
				
				if(![self.WeekArray containsObject:[ExerciseArr objectAtIndex:i]])					
					[self.WeekArray addObject:[ExerciseArr objectAtIndex:i]];	
			}
			[self.ReportArray setObject:User_Data1 forKey:ColumnName]; 
			[User_Data1 release];	
			[ExerciseArr release];
		}
		if([ColumnName isEqualToString:@"Medicine_Entry"])
		{
			///// Get Medicine Record
			NSMutableDictionary *User_Data1=[[NSMutableDictionary alloc]init];
			for (int i=0;i<[ExerciseArr count];i++)
			{
				[self SelectMedicineDeatlByDate:[ExerciseArr objectAtIndex:i]];
				NSString *Str2=@"";
				if([self.UnitDictionary count]>0)
				{
					NSArray *array=[self.UnitDictionary allKeys];
					
					for(int i=0;i<[self.UnitDictionary count];i++)
					{							
						NSDictionary *Dic=[self.UnitDictionary objectForKey:[array objectAtIndex:i]];
						if(i==([self.UnitDictionary count]-1))
						{
							Str2=[Str2 stringByAppendingString:[NSString stringWithFormat:@"%@ (%@ %@)",[Dic valueForKey:@"Med_Name"],[Dic valueForKey:@"Med_Qty"],[Dic valueForKey:@"Med_Unit"]]];								
						}
						else
						{
							Str2=[Str2 stringByAppendingString:[NSString stringWithFormat:@"%@ (%@ %@),",[Dic valueForKey:@"Med_Name"],[Dic valueForKey:@"Med_Qty"],[Dic valueForKey:@"Med_Unit"]]];								
						}
					}
				}				
				[User_Data1 setObject:Str2 forKey:[ExerciseArr objectAtIndex:i]];
				
				if(![self.WeekArray containsObject:[ExerciseArr objectAtIndex:i]])					
					[self.WeekArray addObject:[ExerciseArr objectAtIndex:i]];	
			}
			[self.ReportArray setObject:User_Data1 forKey:ColumnName]; 
			[User_Data1 release];	
			[ExerciseArr release];
		}
		if([ColumnName isEqualToString:@"Feeding"])
		{
			///// Get Feeding Record
			NSMutableDictionary *User_Data1=[[NSMutableDictionary alloc]init];
			for (int i=0;i<[ExerciseArr count];i++)
			{
				[self SelectFeedDeatlByDate:[ExerciseArr objectAtIndex:i]];
				NSString *Str2=@"";
				if([self.UnitDictionary count]>0)
				{
					NSArray *array=[self.UnitDictionary allKeys];
					
					for(int i=0;i<[self.UnitDictionary count];i++)
					{							
						NSDictionary *Dic=[self.UnitDictionary objectForKey:[array objectAtIndex:i]];
						if(i==([self.UnitDictionary count]-1))
						{
							Str2=[Str2 stringByAppendingString:[NSString stringWithFormat:@"%@ (%@ %@)",[Dic valueForKey:@"Feed_Name"],[Dic valueForKey:@"Feed_Qty"],[Dic valueForKey:@"Feed_Unit"]]];								
						}
						else
						{
							Str2=[Str2 stringByAppendingString:[NSString stringWithFormat:@"%@ (%@ %@),",[Dic valueForKey:@"Feed_Name"],[Dic valueForKey:@"Feed_Qty"],[Dic valueForKey:@"Feed_Unit"]]];								
						}
					}
				}				
				[User_Data1 setObject:Str2 forKey:[ExerciseArr objectAtIndex:i]];
				
				if(![self.WeekArray containsObject:[ExerciseArr objectAtIndex:i]])					
					[self.WeekArray addObject:[ExerciseArr objectAtIndex:i]];	
			}
			[self.ReportArray setObject:User_Data1 forKey:ColumnName]; 
			[User_Data1 release];	
			[ExerciseArr release];
		}
	}
	@catch (NSException *e) 
	{
		NSLog(ColumnName);
	}	
	[Pool release];	
}

///// Get Exercise record for Particular DateTime
-(void)selectExercise_Report:(NSString *)Entry_Date
{
	@try
	{
		if(!self.ExerciseDurationArray)
			self.ExerciseDurationArray=[[NSMutableArray alloc]init];	
		
		if([self.ExerciseDurationArray count]>0)
		{
			[self.ExerciseDurationArray removeAllObjects];
		}	
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		sql=[NSString stringWithFormat:@"Select Exercise_Name,Exercise_Duration from Exercise_Duration where Entry_Date='%@' and User_ID=%d",Entry_Date,self.SelectedUserID];
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				NSMutableDictionary *Master=[[NSMutableDictionary alloc]init];
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				[Master setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 1)] forKey:@"Duration"];				
				[Master setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)] forKey:@"Exercise_ID"];
				[Pool release];
				[self.ExerciseDurationArray addObject:Master];
				[Master release];	
			}
		}
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
	}		
}

/////// Get all records for Menstrual record for send that via mail
-(void)SelectAllDataForMemstrual:(NSInteger)User_ID1
{
	@try
	{
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		sql=[NSString stringWithFormat:@"select User_id,startdate,enddate,daily_date,cycle_id,Daily_EndDate,Daily_StartDate from  Menstrual_cycle where user_id=%d",User_ID1];
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		
		NSMutableDictionary *User_Data=[[NSMutableDictionary alloc]init];
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{		
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				if([[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,6)] isEqualToString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,5)]])
				{
					[User_Data setObject:@"Start/End" forKey:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,6)]];
					if(![self.WeekArray containsObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,6)]])
						[self.WeekArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,6)]];
					
				}
				else					
				{
					if([[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,6)] length]>0)
					{
						[User_Data setObject:@"Start" forKey:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,6)]];
						if(![self.WeekArray containsObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,6)]])
							[self.WeekArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,6)]];
					}
					if([[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,5)] length]>0)
					{
						[User_Data setObject:@"End" forKey:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,5)]];
						
						if(![self.WeekArray containsObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,5)]])
							[self.WeekArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,5)]];
					}
				}
				[Pool release];
				
			}
		}
		[self.ReportArray setObject:User_Data forKey:@"Menstrution"]; 
		[User_Data release];	
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
	}		
}

/////// Get records between two dates for Menstrual record for send that via mail
-(void)SelectWeeklyDataForMemstrual:(NSString *)StartDate PassEndDate:(NSString*)EndDate andUserID:(NSInteger)User_ID1 
{
	@try
	{
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		sql=[NSString stringWithFormat:@"select User_id,startdate,enddate,daily_date,cycle_id,Daily_EndDate,Daily_StartDate from  Menstrual_cycle where user_id=%d and (Daily_EndDate between '%@' and '%@' or Daily_StartDate between '%@' and '%@')",User_ID1,StartDate,EndDate,StartDate,EndDate];
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		
		NSMutableDictionary *User_Data=[[NSMutableDictionary alloc]init];
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{		
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				if([[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,6)] isEqualToString:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,5)]])
				{
					[User_Data setObject:@"Start/End" forKey:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,6)]];
					if(![self.WeekArray containsObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,6)]])
						[self.WeekArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,6)]];
					
				}
				else					
				{
					if([[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,6)] length]>0)
					{
					//	NSLog([NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,6)]);
						[User_Data setObject:@"Start" forKey:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,6)]];
						if(![self.WeekArray containsObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,6)]])
							[self.WeekArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,6)]];
					}
					if([[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,5)] length]>0)
					{
						//NSLog([NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,5)]);
						[User_Data setObject:@"End" forKey:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,5)]];
						
						if(![self.WeekArray containsObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,5)]])
							[self.WeekArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,5)]];
					}
				}
				[Pool release];
				
			}
		}
		[self.ReportArray setObject:User_Data forKey:@"Menstrution"]; 
		[User_Data release];	
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
	}		
}

#pragma mark Exercise Functions

//// Get Exercise name base on exercise Name

-(NSString *)SelectExercise:(NSInteger)ExerciseID
{
	NSString *Name=@"";
	@try
	{		
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		sql=[NSString stringWithFormat:@"Select Exercise_Name from Exercise where Exercise_ID=%d",ExerciseID];
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				
				Name= [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)];			
			}
		}
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
	}	
	return Name;
}

///// Insert Exercise name into table

-(int)InsertExercise:(NSString *)ExerciseName
{
	int i=0;
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	@try
	{		
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"insert into Exercise(Exercise_Name) values(?)"];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		sqlite3_bind_text(statement, 1,[ExerciseName UTF8String] , -1, SQLITE_TRANSIENT);
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i= sqlite3_last_insert_rowid(database);
		sqlite3_finalize(statement);
	}
	@catch (NSException *e) 
	{
	}
	[Pool release];
	return i;
}
-(int)UpdateExercise:(NSString *)ExerciseName andID:(NSInteger)Exercise_ID
{
	int i=0;
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	@try
	{
		
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"update Exercise set Exercise_Name=? where Exercise_ID=%d",Exercise_ID];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		sqlite3_bind_text(statement, 1,[ExerciseName UTF8String] , -1, SQLITE_TRANSIENT);
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i= 1;
		sqlite3_finalize(statement);
	}
	@catch (NSException *e) 
	{
	}
	[Pool release];
	return i;
}

///// Return true or false for exercise already added into database

-(BOOL)IsExerciseExist:(NSString*)ExerciseName
{	
	@try
	{
		ExerciseName=[ExerciseName stringByReplacingOccurrencesOfString:@"'" withString:@"''"];	
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"select Exercise_ID from Exercise where lower(Exercise_Name)='%@'",ExerciseName];   /////
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}			
		int success=sqlite3_step(statement);
		sqlite3_finalize(statement);
		if(success==SQLITE_ROW)
		{		
			return YES;
		}
		else
		{
			return NO;
		}
		if (success == SQLITE_ERROR) 
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		return NO;
	}
	@catch (NSException *e) 
	{
		
	}
	return NO;
}

//// Get all Exercise from table

-(void)SelectExerciseNames
{
	@try
	{
		if(!self.ExerciseArray)
			self.ExerciseArray=[[NSMutableArray alloc]init];	
		
		if([self.ExerciseArray count]>0)
		{
			[self.ExerciseArray removeAllObjects];
		}	
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		sql=@"Select Exercise_Name,Exercise_ID from Exercise";
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				NSMutableDictionary *Master=[[NSMutableDictionary alloc]init];
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				[Master setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 1)] forKey:@"Exercise_ID"];				
				[Master setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)] forKey:@"Exercise_Name"];
				[Pool release];
				[self.ExerciseArray addObject:Master];
				[Master release];	
			}
		}
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
	}		
}

#pragma mark Exercise Duration Functions

///////  Insert Exercise Name,Duration base on Datetime and selected user

-(int)InsertExercise_Duration:(NSString *)ExName Dur:(int)ExDuration andDate:(NSString *)Entry_Date andID:(int)Routine_ID
{
	int i=0;
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	@try
	{		
		sqlite3_stmt *statement=nil;
		NSString  *sql=nil;	
		sql=[NSString stringWithFormat:@"insert into Exercise_duration(Exercise_Name,Entry_Date,Exercise_Duration,Routine_ID,User_ID) values(?,?,?,?,?)"];
		
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL)!=SQLITE_OK)
		{
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}	
		sqlite3_bind_text(statement, 1,[ExName UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement, 2,[Entry_Date UTF8String] , -1, SQLITE_TRANSIENT);
		sqlite3_bind_int(statement, 3, ExDuration);
		sqlite3_bind_int(statement, 4, Routine_ID);
		sqlite3_bind_int(statement, 5, SelectedUserID);
		int success=sqlite3_step(statement);
		
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		i= sqlite3_last_insert_rowid(database);
		sqlite3_finalize(statement);
	}
	@catch (NSException *e) 
	{
	}
	[Pool release];
	return i;
}

///// Get All exercise name and Duration base on Routine_ID
-(void)SelectExercise_Duration:(int)Routine_ID
{
	@try
	{
		if(!self.ExerciseDurationArray)
			self.ExerciseDurationArray=[[NSMutableArray alloc]init];	
		
		if([self.ExerciseDurationArray count]>0)
		{
			[self.ExerciseDurationArray removeAllObjects];
		}	
		sqlite3_stmt *selectstatement=nil;	
		NSString *sql;
		int returnvalue;
		sql=[NSString stringWithFormat:@"Select Exercise_Name,Exercise_Duration from Exercise_Duration where Routine_id=%d",Routine_ID];
		returnvalue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstatement, NULL);
		if(returnvalue==1)
		{
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}
		if(returnvalue==SQLITE_OK)
		{		
			while(sqlite3_step(selectstatement)==SQLITE_ROW)
			{	
				NSMutableDictionary *Master=[[NSMutableDictionary alloc]init];
				NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
				[Master setValue:[NSString stringWithFormat:@"%d",sqlite3_column_int(selectstatement, 1)] forKey:@"Duration"];				
				[Master setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstatement,0)] forKey:@"Exercise_ID"];
				[Pool release];
				[self.ExerciseDurationArray addObject:Master];
				[Master release];	
			}
		}
		sqlite3_finalize(selectstatement);
	}
	@catch (NSException *e) 
	{
	}			
//	return @"";
}

#pragma mark Write .csv file for sending to mail

-(void)WriteFiles:(NSString *)CSVString
{
	CSVString=[NSString stringWithFormat:@"%@'s Data\n\n%@",self.UserName,CSVString];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *saveDirectory = [paths objectAtIndex:0];
	NSString *saveFileName = @"myPDF.csv";
	NSString *newFilePath = [saveDirectory stringByAppendingPathComponent:saveFileName];
	NSLog(CSVString);
	//	const char *filename = [newFilePath UTF8String];
	[[NSString stringWithFormat:@"%@",CSVString] writeToFile:newFilePath atomically:YES];
}

- (void)dealloc 
{
	[navigationController release];
	[window release];
	[SelectedStatus release];
	[AddNewUserDict release];
	[UserSettingsArray release];
	[UserArray release];
	[EntryArray release];
	[SelectedItems release];
	[HourlyDataArray release];
	[MedicineArray release];
	[MensturalArray release];
	[tf release];
	[alert1 release];
	[WeekArray release];
	[DailyArray release];
	[VitalsMasterArray release];
	[ReportStartDate release];
	[ReportEndDate release];
	[ReportField release];
	
	[super dealloc];
}

@end
