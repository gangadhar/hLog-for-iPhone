//
//  Routine_Detail.h
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


@interface Routine_Detail : NSObject {

	NSInteger User_ID;
	NSInteger Routine_ID;
	NSString *Activity;
	NSString *Alcohol;
	NSString *Cigarrettes;
	NSString *Diapering;
	NSString *Drugs;
	NSString *EntryTime;
	NSString *EntryDate;
	NSString *Exercise;
	NSString *Feeding;
	NSString *Exercise_id;
	NSString *Mood;
	NSString *Other;
	NSString *Sleep;
	NSString *WakeUpSleep;
	NSString *Exercise_Duration;
	NSString *Exercise_Dru_ID;
	NSInteger calories;
}

@property(nonatomic,retain)NSString *Activity;
@property(nonatomic,retain)NSString *Alcohol;
@property(nonatomic,retain)NSString *Cigarrettes;
@property(nonatomic,retain)NSString *Diapering;
@property(nonatomic,retain)NSString *Drugs;
@property(nonatomic,retain)NSString *EntryTime;
@property(nonatomic,retain)NSString *EntryDate;
@property(nonatomic,retain)NSString *Exercise;
@property(nonatomic,retain)NSString *Exercise_id;
@property(nonatomic,retain)NSString *Feeding;
@property(nonatomic,retain)NSString *Mood;
@property(nonatomic,retain)NSString *Other;
@property(nonatomic,retain)NSString *Sleep;
@property(nonatomic,retain)NSString *Exercise_Duration;
@property(nonatomic,retain)NSString *WakeUpSleep;
@property(nonatomic,readwrite) NSInteger User_ID;
@property(nonatomic,retain)NSString *Exercise_Dru_ID;
@property(nonatomic,readwrite) NSInteger Routine_ID;
@property(nonatomic,readwrite) NSInteger calories;
-(void)ClearData;

@end
