//
//  SelectOptionsViewController.h
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
#import <UIKit/UIKit.h>
#import "HealthTrackerAppDelegate.h"
#import "SelectMedicineSettingsController.h"
#import "Medicine.h"
#import "UserTextEntryViewController.h"
#import "Routine_Detail.h"
#import "TwoTextEntryViewController.h"

// Defining Interface  with needed Protocol (if any).
// Protocols generally define inside '< >'bracates.
@interface SelectOptionsViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDelegate> 
{
	
	/* 
	 Tools That you have used in xib file, need to bind with its controller file.
	 This is done by Declaring tool with IBOutlet as Prefix.
	 
	 Tools That you haven't used in xib but used in controller file, need not to bind with xib,
	 such tools do not have IBOutlet as Prefix.
	 
	 Declaration of all global variables and objects also here.
	 */
	IBOutlet UIToolbar *ToolBar;
	IBOutlet UITableView *tblView;
	NSMutableDictionary *data;
	NSMutableArray *selectedArray;
	NSMutableArray *selectedArrayData;
	UIImage *selectedImage;
	UILabel *lblData;
	UIImage *unselectedImage;
	IBOutlet UIBarButtonItem *btnSave;
	NSArray *array;
	IBOutlet UIBarButtonItem *btnCancle;
	IBOutlet UIBarButtonItem *btnDone;
	HealthTrackerAppDelegate *appDelegate;
	IBOutlet UIToolbar *toolBar;
	IBOutlet UIDatePicker *DatePicker;
	NSMutableArray *arr1;
	NSString *NavText;
	NSArray *MedicineArray;
	IBOutlet UIBarButtonItem *btnSettings;
	SelectMedicineSettingsController *SelectMedicineSettings;
	UINavigationController *SettingsCon;
	IBOutlet UIBarButtonItem *btnEdit;
	BOOL ISEdit;
	NSMutableArray *arr3;
	int FirstValue[200];
	UITextField *SelectedText;
	IBOutlet UIPickerView *PickerView;
	int SelectedTag;
	NSMutableArray *ExerciseArray;
	//IBOutlet UIToolbar *ExerciseToolBar;
	//IBOutlet UIBarButtonItem *btnEditExer;
//	IBOutlet UIBarButtonItem *btnAddExercise;
	NSMutableDictionary *ExerciseValueDictionary;
	
	IBOutlet UIBarButtonItem *btnCancel;
	NSString *ExerciseNames;
	UILabel *label1;
	NSArray *arr4;
	NSString *Dru;
	NSString *EXDuration;
	NSString *Exercise;
	NSString *MedicineData;
	IBOutlet UIBarButtonItem *btnMedidcine;
	NSString *SelectedItems;
	NSString *Data1;	
	TwoTextEntryViewController *objTwoTextEntryViewController;
	int IndexpathRow;
	BOOL IsDeleteTheRow;
	IBOutlet UIToolbar *PastToolBar;
	IBOutlet UIBarButtonItem *btnPastEdit;
	IBOutlet UIBarButtonItem *btnPastAdd;
	NSMutableArray *NamePastArray;
}
-(IBAction)btnCancel_Clicked:(id)sender;

// Defining Property as per fields, tools, variables and objects.
@property(nonatomic,retain) NSString *NavText;

// Declaration of all Public methods that are going to implement inside implementation file, need to declare here.
-(NSMutableArray *)FillArray:(int)i;
-(IBAction)Cancle:(id)sender;
-(IBAction)Save:(id)sender;
-(IBAction)btnSettings_click:(id)sender;
- (void)populateSelectedArray;
-(IBAction)btnDone_Clicked:(id)sender;
-(IBAction)btnMedidcine:(id)sender;
-(IBAction)btnEdit_Click:(id)sender;
-(IBAction)btnPastEdit_Click:(id)sender;
-(IBAction)btnPastAdd_Click:(id)sender;
-(int)GetPickerRow:(NSString *)String component:(NSInteger)Tag;

-(void)BackUpdata;
-(void)SaveMedicineDetail:(int)Medicine_ID;
@end
