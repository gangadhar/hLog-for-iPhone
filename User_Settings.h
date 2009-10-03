//
//  User_Settings.h
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



#import <Foundation/Foundation.h>


@interface User_Settings : NSObject 
{
	NSInteger User_Id;
	NSString *DailyEntryDetail;
	NSString *HourlyEntryDetail;
	NSString *MedicineEntryDetail;
	NSString *ExerciseEntryDetail;
	NSString *MoodEntryDetail;
	NSString *DiperingEntryDetail;
	NSString *FeedingEntryDetail;
	NSString *ActivityEntryDetail;
}

@property(nonatomic,readwrite) NSInteger User_Id;
@property (nonatomic,retain) NSString *DailyEntryDetail;
@property (nonatomic,retain) NSString *HourlyEntryDetail;
@property (nonatomic,retain) NSString *MedicineEntryDetail;
@property (nonatomic,retain) NSString *ExerciseEntryDetail;
@property (nonatomic,retain) NSString *MoodEntryDetail;
@property (nonatomic,retain) NSString *DiperingEntryDetail;
@property (nonatomic,retain) NSString *FeedingEntryDetail;
@property (nonatomic,retain) NSString *ActivityEntryDetail;
@end
