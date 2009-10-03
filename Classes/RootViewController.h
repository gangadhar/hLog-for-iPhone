//
//  RootViewController.h
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
//#import "RootViewCell.h"
#import "AddNewUserController.h"
#import "HealthTrackerAppDelegate.h"
#import "FirstViewController.h"

// Defining Interface  with needed Protocol (if any).
// Protocols generally define inside '< >'bracates.
@interface RootViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
{
	
	/* 
	 Tools That you have used in xib file, need to bind with its controller file.
	 This is done by Declaring tool with IBOutlet as Prefix.
	 
	 Tools That you haven't used in xib but used in controller file, need not to bind with xib,
	 such tools do not have IBOutlet as Prefix.
	 
	 Declaration of all global variables and objects also here.
	 */
	
	IBOutlet UITableView *tblView;
	IBOutlet UIBarButtonItem *btnAdd;

	HealthTrackerAppDelegate *appDelegate;
	UINavigationController *SettingsCon;

	BOOL IsEdit;
	int ROW;
	AddNewUserController *objAddUser;
	UILabel *lblUser;
	NSMutableArray  *selectedArray;
	UIImage *selectedImage;
	UIImage *unselectedImage;
	NSMutableArray *arr1;
	IBOutlet UIBarButtonItem *btnSave;
	IBOutlet UIToolbar *ToolBar;
	IBOutlet UIBarButtonItem *btnChengeUser;
}


// Declaration of all Public methods that are going to implement inside implementation file, need to declare here.

-(IBAction)addProfile:(id)sender;
-(IBAction)btnSave_Click:(id)sender;
- (void)populateSelectedArray;
-(IBAction)btnChengeUser:(id)sender;
@end
