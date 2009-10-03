//
//  Vitals_Detail.m
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



#import "Vitals_Detail.h"


@implementation Vitals_Detail
@synthesize EntryDate,EntryTime,Vitals_ID, User_ID1,BP,BloodSugar,Fasting,Other,TempC,TempF,Pulse,Respiration,WeightKgs,WeightLbs,HeightCms,HeightInch;
@synthesize Pain,Magnitude;
-(id)init
{
	HeightCms=@"";
	HeightInch=@"";
	Vitals_ID=0;
	User_ID1=0;
	EntryDate=@"";
	EntryTime=@"";	
	BP=@"";
	BloodSugar=@"";
	Fasting=@"";
	Other=@"";
	TempC=@"";
	TempF=@"";
	Pulse=@"";
	Respiration=@"";
	WeightKgs=@"";
	WeightLbs=@"";
	Pain=@"";
	Magnitude=0;
	return self;
}

-(void)ClearData
{
	HeightCms=@"";
	HeightInch=@"";
	Vitals_ID=0;
	User_ID1=0;
	EntryDate=@"";
	EntryTime=@"";	
	BP=@"";
	BloodSugar=@"";
	Fasting=@"";
	Other=@"";
	TempC=@"";
	TempF=@"";
	Pulse=@"";
	Respiration=@"";
	WeightKgs=@"";
	WeightLbs=@"";
	Pain=@"";
	Magnitude=0;
}

- (void)dealloc 
{	
	[EntryDate release];
	[EntryTime release];
	[BP release];
	[BloodSugar release];
	[Fasting release];
	[Other release];
	[TempC release];
	[TempF release];
	[Pulse release];
	[Respiration release];
	[WeightKgs release];
	[WeightLbs release];
	[super dealloc];
}
@end
