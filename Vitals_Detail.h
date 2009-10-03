//
//  Vitals_Detail.h
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


@interface Vitals_Detail : NSObject {

	NSString *EntryDate;
	NSString *BP;
	NSString *BloodSugar;
	NSString *Fasting;
	NSString *Other;
	NSString *Pulse;
	NSString *Respiration;
	NSString *TempF;
	NSString *TempC;
	
	NSString *EntryTime;

	NSInteger Vitals_ID;
	NSInteger User_ID1;
	NSString *WeightKgs;
	NSString *WeightLbs;
	
	NSString *HeightInch;
	NSString *Pain;
	NSString *HeightCms;
	int Magnitude;
}
@property(nonatomic,retain ) NSString *HeightInch;
@property(nonatomic,retain ) NSString *HeightCms;
@property(nonatomic,retain )NSString *EntryDate;
@property(nonatomic,retain )NSString *EntryTime;
@property(nonatomic,retain )NSString *BP;
@property(nonatomic,retain )NSString *BloodSugar;
@property(nonatomic,retain )NSString *Fasting;
@property(nonatomic,retain )NSString *Other;
@property(nonatomic,retain )NSString *Pulse;
@property(nonatomic,retain )NSString *Respiration;
@property(nonatomic,retain )NSString *TempC;
@property(nonatomic,retain )NSString *TempF; 
@property(nonatomic,retain )NSString *WeightKgs;
@property(nonatomic,retain )NSString *WeightLbs;
@property(nonatomic,readwrite) NSInteger Vitals_ID;
@property(nonatomic,retain )NSString *Pain;
@property(nonatomic,readwrite) NSInteger User_ID1;
@property (nonatomic,readwrite)int Magnitude;

-(void)ClearData;
@end
