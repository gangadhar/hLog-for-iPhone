//
//  Medicine.h
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


@interface Medicine : NSObject 
{
	NSInteger UserID;
	NSString *MedicineEntry;
	NSInteger MedicineID;
	NSString *EntryDate;
	NSString *EntryTime;
	NSString *Medicine_Insert_ID;
}

@property(nonatomic,readwrite) NSInteger UserID;
@property(nonatomic,readwrite) NSInteger MedicineID;
@property(nonatomic,retain) NSString *MedicineEntry;
@property(nonatomic,retain) NSString *EntryDate;
@property(nonatomic,retain) NSString *EntryTime;
@property(nonatomic,retain) NSString *Medicine_Insert_ID;

-(void)ClearData;
@end
