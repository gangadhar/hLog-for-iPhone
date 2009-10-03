//
//  hLogAppDelegate.h
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



#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "User_Settings.h"
#import "Menstural_Cycle.h"
#import "Vitals_Detail.h"
#import "Medicine.h"
#import "Routine_Detail.h"
// Defining Interface  with needed Protocol (if any).
// Protocols generally define inside '< >'bracates.


@class SettingsViewController;
@class SelectOptionsViewController;
@class FirstViewController;
@class RootViewController;
@class UserTextEntryViewController;
@class UserViewController;
@class ShowReportViewController;
@class SelectSettingsViewController;
@class SelectViewController;
@interface HealthTrackerAppDelegate : NSObject <UIApplicationDelegate>{
    
    UIWindow *window;
    UINavigationController *navigationController;
 IBOutlet UITextField *tf;
	UIAlertView *alert1;
	sqlite3 *database;
	
	NSMutableDictionary *AddNewUserDict;
	NSMutableArray *UserSettingsArray;
	NSMutableArray *UserArray; 
	NSMutableArray *EntryArray;
	NSMutableArray *HourlyDataArray; 
	NSMutableArray *MedicineArray;
	NSMutableArray *MensturalArray;
	NSMutableArray *WeekArray;
	NSMutableArray *DailyArray;
	NSMutableArray *VitalsMasterArray;
	NSMutableDictionary *ReportArray;
	NSDateFormatter *DateFormatter;
	NSMutableArray *ExerciseArray;
	NSMutableArray *ExerciseDurationArray;
	NSMutableArray *ExerciseArr;
	NSMutableDictionary *RegistrationDic;
	int SelectedUserID;
	int DailyTag;
	
	
//	int IsKidOrNot;
	BOOL SaveMenstural;
	int PassCodeOnOff;
	BOOL isfromRoot;
	BOOL isDailyReport;
	int isFromChart;
	BOOL iSfromAddUser;
	/////
	BOOL iSfromUsers;
	int ISfromSettings;
	BOOL isFromReport;
	BOOL isFromEditReport;
	BOOL ISfromDefaultUser;	
	
	NSString *ReportStartDate;
	NSString *ReportEndDate;
	NSString *ReportField;
	NSString *SelectedItems;
	NSString *SelectedStatus;
	NSString *UserName;
	NSString *SelectedReportField;
	CGPoint SelectedLocation;
	NSString *UserStatus;
	BOOL isfromFavourite;

	SettingsViewController *objSettingsViewController;
	SelectOptionsViewController *objSelectOptionsViewController;
	UserTextEntryViewController *objUserTextEntryViewController;
	FirstViewController *objFirstViewController;
	RootViewController *objRootViewController;
	UserViewController *objUserViewController;
	SelectSettingsViewController *SelectSettingsView;
	SelectViewController *objSelectViewController;
	
	Routine_Detail *Routine_Detailrf;
	Vitals_Detail *Vitals_Detailref;
	Medicine *MedicineRef;
	Menstural_Cycle *Mensturalref;	
	
	ShowReportViewController *objShowReportViewController;
	/////// New Changes
	NSMutableArray *Columns;	
	
	BOOL ISEdit;
	int Row;
	
	BOOL ISLiteVersion;
	///// 
	
	BOOL isForMail;
	BOOL isforReport;
	NSMutableArray *NewTableArray;
	NSMutableArray *NewDetailArray;
	NSString *StrUnit;
	NSMutableDictionary *UnitDictionary;
	BOOL IsFromMedicine;
	BOOL ISFromFirstViewController;
	NSMutableArray *HealthInsuranceArray;
	NSMutableDictionary *DetailDIC;
	NSMutableArray *PastArray;
	NSMutableArray *AllPastArray;
}


/////////  New Changes
@property(nonatomic,retain) NSMutableDictionary *DetailDIC;
@property(nonatomic,retain) NSMutableArray *AllPastArray;
@property(nonatomic,retain) NSMutableArray *PastArray;
@property(nonatomic,retain) NSMutableArray *HealthInsuranceArray;
@property(nonatomic,retain) NSMutableArray *Columns;
@property(nonatomic,retain) NSMutableArray *NewDetailArray;
@property(nonatomic,retain) NSMutableArray *NewTableArray;
@property(nonatomic,retain) NSString *StrUnit;
@property(nonatomic,retain) NSMutableDictionary *UnitDictionary;
@property(nonatomic,retain) Routine_Detail *Routine_Detailrf;
@property(nonatomic,retain) Vitals_Detail *Vitals_Detailref;
@property(nonatomic,retain) Medicine *MedicineRef;
@property(nonatomic,retain) Menstural_Cycle *Mensturalref;
@property (nonatomic,readwrite) BOOL ISEdit;
@property (nonatomic,readwrite) int Row;
@property (nonatomic,readwrite) BOOL ISLiteVersion;
@property (nonatomic,readwrite) BOOL IsFromMedicine;
@property (nonatomic,readwrite) BOOL ISFromFirstViewController;
//////////
@property(nonatomic,retain) ShowReportViewController *objShowReportViewController;
@property(nonatomic,retain) SettingsViewController *objSettingsViewController;
@property(nonatomic,retain) SelectOptionsViewController *objSelectOptionsViewController;
@property(nonatomic,retain) UserTextEntryViewController *objUserTextEntryViewController;
@property(nonatomic,retain) RootViewController *objRootViewController;
@property (nonatomic,retain) UserViewController *objUserViewController;
@property(nonatomic,retain) FirstViewController *objFirstViewController;
@property(nonatomic,retain)  SelectSettingsViewController *SelectSettingsView;
@property(nonatomic,retain)  SelectViewController *objSelectViewController;
@property(nonatomic,retain) NSDateFormatter *DateFormatter;
@property(nonatomic,retain) NSString *ReportStartDate;
@property(nonatomic,retain) NSString *ReportEndDate;
@property(nonatomic,retain) NSString *ReportField;
@property(nonatomic,retain) NSString *SelectedItems;
@property(nonatomic,retain) NSString *UserStatus;
@property(nonatomic,retain) NSString *SelectedStatus;
@property(nonatomic,retain) NSString *UserName;
@property(nonatomic,retain) NSString *SelectedReportField;
// Defining Property as per fields, tools, variables and objects.
@property (nonatomic,readwrite) CGPoint SelectedLocation;
@property(nonatomic,readwrite) int isFromChart;
@property(nonatomic,readwrite) int ISfromSettings;
@property(nonatomic,readwrite) BOOL iSfromUsers;
@property(nonatomic,readwrite) BOOL iSfromAddUser;
@property(nonatomic,readwrite) BOOL isDailyReport;
@property(nonatomic,readwrite) BOOL isfromRoot;
@property(nonatomic,readwrite) BOOL SaveMenstural;
@property(nonatomic,readwrite) BOOL isfromFavourite;
@property(nonatomic,readwrite) int SelectedUserID;
@property(nonatomic,readwrite) BOOL isFromReport;
@property(nonatomic,readwrite) int PassCodeOnOff;
@property(nonatomic,readwrite) int DailyTag;
@property(nonatomic,readwrite) BOOL isFromEditReport;

@property(nonatomic,readwrite) BOOL ISfromDefaultUser;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property(nonatomic,retain) NSMutableDictionary *AddNewUserDict;
@property(nonatomic,retain) NSMutableDictionary *ReportArray;
@property(nonatomic,retain) NSMutableArray *UserSettingsArray;
@property(nonatomic,retain) NSMutableArray  *UserArray; 
@property(nonatomic,retain) NSMutableArray  *EntryArray;
@property(nonatomic,retain) NSMutableArray *VitalsMasterArray;
@property(nonatomic,retain) NSMutableArray *WeekArray;
@property(nonatomic,retain) NSMutableArray *DailyArray;
@property(nonatomic,retain) NSMutableArray *HourlyDataArray;
@property(nonatomic,retain) NSMutableArray *MedicineArray;
@property(nonatomic,retain) NSMutableArray *MensturalArray;
@property(nonatomic,retain) NSMutableArray *ExerciseArray;
@property(nonatomic,retain) NSMutableArray *ExerciseDurationArray;
 @property (nonatomic,retain) NSMutableDictionary *RegistrationDic;
@property(nonatomic,readwrite) BOOL isforReport;
@property(nonatomic,readwrite) BOOL isForMail;
// Declaration of all Public methods that are going to implement inside implementation file, need to declare here.



-(void)MakeDictForNewUser;
-(void)createEditableCopyOfDatabaseIfNeeded;
-(int)InsertUser:(NSMutableDictionary *)UserDictionary;
-(int)UpdateUser:(NSMutableDictionary *)UserDictionary;
-(int)InsertUserSettings_Data:(NSInteger)Insert_User_Id;
-(void)SelectUserSettings:(NSInteger)Insert_User_Id; 
-(void)SelectsUsers;

-(void)VitalName:(NSInteger)Entry_ID;

-(int)UpdateUserData:(NSInteger)Insert_User_Id DailyData:(NSString *)data ColumnName:(NSString *)Name;

-(NSString *)SelectMedicine:(NSInteger)MedicineID;
-(int)InsertMedicine:(NSString *)MedicineName;
-(int)UpdateMedicine:(NSString *)MedicineName andID:(NSInteger)Medicine_ID;

-(void)SelectMedicineNames;
-(int)DeleteEntry:(NSString *)TableName ColumnName:(NSString *)PrimaryName PrimaryID:(NSInteger)ID;

-(void)selectMenstural:(NSInteger)User_ID passDate:(NSString *)Daily_Date;
-(int)InsertMenstural:(Menstural_Cycle *)Menstural;
-(int)UpdateMenstural:(Menstural_Cycle *)Menstural;
-(int)DeleteMenstura:(NSInteger)Cycle_ID;
-(int)DeleteAllCategoriesData:(NSString *)TableName IDname:(NSString *)Name DeleteID:(NSInteger)IdDelete;
-(void)termCondition;


-(BOOL)IsMedicineExist:(NSString*)MedicineName;

/////////////// New Databse Changes

-(void)SelectVitalsInfo:(NSInteger) User_ID;

-(void)SelectRoutineInfo:(NSInteger) User_ID;

-(void)RoutineName:(NSInteger)Entry_ID;
-(int)InsertMedicinedata:(Medicine *)MedicineRef1;
-(void)Medicinedata:(NSString*)EntryDate ToTime:(NSString *)EntryTime anduserid:(NSInteger)User_ID;
-(int)UpdateData:(Medicine*)MedicineRef1;

///////////////// Enter, Select and Update Vitals Data

-(int)InsertVitalsDetail:(Vitals_Detail*)Data;
-(int)UpdateVitalsDetail:(Vitals_Detail*)Data;
-(void)SelectVitalsDetail:(NSString*)PassingDate AndTime:(NSString*)PassingTime andUserID:(NSInteger)User_ID;


///////////////// Enter, Select and Update Routines Data

-(int)InsertRoutinesDetail:(Routine_Detail*)Data;
-(int)UpdateRoutinesDetail:(Routine_Detail*)Data;
-(void)SelectRoutinesDetail:(NSString*)PassingDate AndTime:(NSString*)PassingTime andUserID:(NSInteger)User_ID;
-(int)UpdateDefaultUser:(NSInteger)User_ID;

//-(void)SelectDefaultUser;
-(int)DefaultSet:(NSInteger)User_ID;


////////// Vitals and routine Calendar data

-(void)GetVitalsCalendarData:(NSString *)ColumnName StartDate:(NSString*)PassStartDate Enddate:(NSString *)PassEndDate StartTime:(NSString *)PassStartTime EndTime:(NSString*)PassEndTime andUserID:(NSInteger)User_ID andTableName:(NSString *)TableName;
-(void)SelectWeeklyDataForMemstrual:(NSString *)StartDate PassEndDate:(NSString*)EndDate andUserID:(NSInteger)User_ID1;
-(void)GetAllCalendarData:(NSString *)ColumnName andUserID:(NSInteger)User_ID andTableName:(NSString *)TableName;
-(void)SelectAllDataForMemstrual:(NSInteger)User_ID1;

-(NSString *)CheckTIme:(int)Minutes;
-(NSString *)ConvertIntoCms:(NSString *)Feets;
-(NSString*)ConvertFeets:(NSString *)INCMS;

/////////////// Exercise

-(NSString *)SelectExercise:(NSInteger)ExerciseID;
-(int)InsertExercise:(NSString *)ExerciseName;
-(int)UpdateExercise:(NSString *)ExerciseName andID:(NSInteger)Exercise_ID;
-(void)SelectExerciseNames;
-(BOOL)IsExerciseExist:(NSString*)ExerciseName;

-(int)InsertExercise_Duration:(NSString *)ExName Dur:(int)ExDuration andDate:(NSString *)Entry_Date andID:(int)Routine_ID;
-(void)selectExercise_Report:(NSString *)Entry_Date;
-(void)SelectExercise_Duration:(int)Routine_ID;


///// Create New database Fields and Tables
-(int)createTable:(NSString*)TableName;
-(int)InsertTableValue:(NSString*)TableName :(NSString*)FieldValue;
-(BOOL)IsExist:(NSString*)FieldName :(NSString*)TableName;
-(int)Update:(NSString *)FieldName andID:(NSInteger)Pk_ID :(NSString*)TableName;
-(void)AddNewFieldsinUser_Settings:(NSString*)FieldName;
-(void)UpadateUser_sttings:(NSString*)FieldName :(NSString *)Value;
-(NSString *)Select:(NSInteger)Pk_ID :(NSString*)TableName;
-(void)SelectAllData:(NSString*)TableName;
-(int)CreateFeedTable;
-(int)CreateMedicineDosageTable;

//-(void)alterFeedDetailTableQty;

-(int)InsertFeedDetail:(NSMutableDictionary *)DIC;
-(int)InsertMedicineDosageDetail:(NSMutableDictionary *)DIC;

-(void)SelectFeedDeatl:(NSInteger)Routine_ID;
-(void)SelectMedicineDeatl:(NSInteger)Medicine_ID;
-(void)AddCaleoriesField;
-(void)UpdateCaleoriesField;
-(void)SelectFeedDeatlByDate:(NSString *)Date;
-(void)SelectMedicineDeatlByDate:(NSString *)Date;
//-(void)InsertRoutineMasterDeatil;
-(void)InsertRoutineMasterDeatil:(NSString*)FieldName;
-(void)WriteFiles:(NSString *)CSVString;
-(void)AddTableintoDatabase;
-(void)AlterUser_ID:(NSString *)TableName;

//////////// New Health Care and Insurance Tables

-(int)CreateHealthCareProviderTable;
-(int)insertHealthCare:(NSString*)ProviderName :(NSString*)Number :(NSInteger)USERID;
-(int)UpdateHealthCare:(NSString*)ProviderName :(NSString*)Number :(NSInteger)USERID :(NSInteger)PrimaryID;
-(int)CreateInsuranceTable;
-(int)insertInsurance:(NSString*)Identification :(NSString*)Phone_Number :(NSInteger)USERID :(NSString*)Emergency_Number :(NSString*)Policy_Number;
-(int)UpdateInsurance:(NSString*)Identification :(NSString*)Phone_Number :(NSInteger)USERID :(NSString*)Emergency_Number :(NSString*)Policy_Number :(NSInteger)PrimaryID;

-(void)selectInsuranceInfo:(NSInteger)USERID;
-(void)selectHealthcare:(NSInteger)USERID;

-(void)AddHealthInsuranceTable;

-(void)insertBackupdataintoFeedDeatilorDropTable:(NSString*)ParameterQuery;
-(void)alterFeedDetailTable;
//////// Create , insert,select Table for past

-(int)CreatePastTable;
-(int)CreatePastRecordTable;
-(int)insertIntopast:(NSString*)PastName :(NSInteger)USERID;
-(int)UpdateIntopast:(NSString*)PastName :(NSInteger)Past_ID;
-(int)PastNameID:(NSString*)PastName;
-(int)insertPastRecord:(NSString*)PastName :(NSInteger)USERID :(NSInteger)Past_ID;
-(void)selectPastData:(NSInteger)USERID;
-(void)selectAllPastData;
@end

