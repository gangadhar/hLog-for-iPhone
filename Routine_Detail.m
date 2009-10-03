//
//  Routine_Detail.m
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



#import "Routine_Detail.h"


@implementation Routine_Detail
@synthesize Routine_ID,Activity,Alcohol,Cigarrettes,Diapering,Drugs,EntryDate,EntryTime,Exercise,Feeding,Mood,Other,Sleep,User_ID,Exercise_id,WakeUpSleep;  
@synthesize Exercise_Dru_ID,Exercise_Duration,calories;
-(id)init
{
	calories=-1;
	Routine_ID=0;
	User_ID=0;
	Activity=@"";
	Alcohol=@"";
	Cigarrettes=@"";
	Diapering=@"";
	Drugs=@"";
	EntryDate=@"";
	EntryTime=@"";
	Exercise=@"";
	Feeding=@"";
	Mood=@"";
	Other=@"";
	Sleep=@"";
	Exercise_id=@"";
	WakeUpSleep=@"";
	Exercise_Duration=@"";
	Exercise_Dru_ID=@"";
	return self;
}


-(void)ClearData
{
	Routine_ID=0;
	calories=-1;
	User_ID=0;
	Activity=@"";
	Alcohol=@"";
	Cigarrettes=@"";
	Diapering=@"";
	Drugs=@"";
	EntryDate=@"";
	EntryTime=@"";
	Exercise=@"";
	Feeding=@"";
	Mood=@"";
	Other=@"";
	WakeUpSleep=@"";
	Sleep=@"";
	Exercise_id=@"";
	Exercise_Duration=@"";
	Exercise_Dru_ID=@"";
}


- (void)dealloc {
	
	[EntryDate release];
	[EntryTime release];
	[Activity release];
	[Alcohol release];
	[Cigarrettes release];
	[Diapering release];
	[Drugs release];
	[Exercise release];
	[Feeding release];
	[Mood release];
	[Other release];
	[Sleep release];
	[Exercise_Duration release];
	[super dealloc];
}

@end
