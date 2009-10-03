//
//  ReportselectionViewController.m
//  HealthTracker
//  Created by Bhoomi on 3/3/09.
//  Copyright 2009 Elan. All rights reserved.
//

// Import All needed header files bellow.
#import "ReportselectionViewController.h"
#import "AddUserButtonTableViewCell.h"
#import "ToogleTableViewCell.h"

#define Daily_Array [NSArray arrayWithObjects: @"No of Hours of Sleep",@"Mood",@"Weight(Kgs)",@"Weight(Pounds)",nil]
#define Daily_Table_Array [NSArray arrayWithObjects:@"NoofHoursofSleep",@"Mood",@"Weight_KGS",@"Weight_Pound",nil]


#define Hourly_Kid_Array [NSArray arrayWithObjects: @"Mood",@"BP(Systolic)",@"BP(Diastolic)",@"Temperature",@"Acticity Level",@"Diapering",@"Cigarettes Smoked",@"Heart Rate",nil]
#define Hourly_Kid_Table_Array [NSArray arrayWithObjects: @"Mood",@"BP_Entry",@"BP_Entry",@"Temperature",@"kid_ActicityLevel",@"kid_Diapering",@"CigarateSmoked",@"Street_Drugs_Consumed",@"HeartRate",nil]


#define Hourly_Array [NSArray arrayWithObjects: @"Mood",@"BP(Systolic)",@"BP(Diastolic)",@"Temperature",@"Cigarettes Smoked",@"Heart Rate",nil]
#define Hourly_Table_Array [NSArray arrayWithObjects: @"Mood",@"BP_Entry",@"BP_Entry",@"Temperature",@"CigarateSmoked",@"HeartRate",nil]
@implementation ReportselectionViewController


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	self.navigationItem.title=@"Chart Details";
	tblView.delegate=self;
	tblView.dataSource=self;
	self.navigationItem.rightBarButtonItem=btnReport;
	ToolBar.tintColor=[UIColor blackColor];
	ToolBar.hidden=TRUE;
	PickerView.frame=CGRectMake(0, 200, 320, 216);
	PickerView.delegate=self;
	ToolBar.frame=CGRectMake(0, 220, 320, 44);
	lblData=[[UILabel alloc]init];
	lblData.frame=CGRectMake(10,15 , 200, 20);
	lblData.textColor=[UIColor whiteColor];
	lblData.backgroundColor=[UIColor clearColor];
	[ToolBar addSubview:lblData];
	appdelegate=[[UIApplication sharedApplication]delegate];
	DateFormatter=[[NSDateFormatter alloc]init];
    [DateFormatter setDateFormat:@"MM-dd-yyyy"];
	[super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
	PickerView.hidden=TRUE;
	ToolBar.hidden=TRUE;
	[tblView reloadData];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	PickerView.hidden=TRUE;
	ToolBar.hidden=TRUE;
}

//An event when user clicks on Report button.
-(IBAction)btnReport_clicked:(id)sender
{
	if([appdelegate.SelectColumnName length]>0)
	{
		UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
		temporaryBarButtonItem.title = @"Back";
		self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
		[temporaryBarButtonItem release];
		if(!ReportView)
		{
			ReportView=[[ReportViewController alloc]initWithNibName:@"Report" bundle:nil];
		}
		[self.navigationController pushViewController:ReportView animated:YES];
	}
	else
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Select" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

-(IBAction)btnDone_Clicked:(id)sender
{
	NSString *strRestaurantTypeSecond=@"";
	PickerView.hidden=TRUE;
	ToolBar.hidden=TRUE;
	if(SelectedTag==0)
	{
		strRestaurantTypeSecond=(NSString *)[Daily_Array objectAtIndex:[PickerView selectedRowInComponent:0]];
		appdelegate.SelectColumnName= (NSString *)[Daily_Table_Array objectAtIndex:[PickerView selectedRowInComponent:0]];
		appdelegate.SelectColumnName1= (NSString *)[Daily_Array objectAtIndex:[PickerView selectedRowInComponent:0]];
	}
	else if(SelectedTag==1)
	{
		if(appdelegate.IsKidOrNot==0)
		{
			strRestaurantTypeSecond=(NSString *)[Hourly_Array  objectAtIndex:[PickerView selectedRowInComponent:0]];
			appdelegate.SelectColumnName= (NSString *)[Hourly_Table_Array objectAtIndex:[PickerView selectedRowInComponent:0]];
			appdelegate.SelectColumnName1= (NSString *)[Hourly_Array objectAtIndex:[PickerView selectedRowInComponent:0]];
		}
		else
		{
			strRestaurantTypeSecond=(NSString *)[Hourly_Kid_Array  objectAtIndex:[PickerView selectedRowInComponent:0]];
			appdelegate.SelectColumnName= (NSString *)[Hourly_Kid_Table_Array objectAtIndex:[PickerView selectedRowInComponent:0]];
			appdelegate.SelectColumnName1= (NSString *)[Hourly_Kid_Array objectAtIndex:[PickerView selectedRowInComponent:0]];
		}
	}
	[btnSelected setTitle:[NSString stringWithFormat:@"  %@" ,strRestaurantTypeSecond] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if(section==0)
		return 1;
	else if(section==1)
		return 1;
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
	if(indexPath.section==1)
	{
		
		static NSString *CellIdentifier = @"Cell";
		AddUserButtonTableViewCell *cell;
		cell = (AddUserButtonTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[AddUserButtonTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
			
			[cell.BtnSelect addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];

		}
		cell.lblName.text=@"Select Field";
		btnSelected=cell.BtnSelect;
		[cell.BtnSelect setTitle:[NSString stringWithFormat:@"  %@",appdelegate.SelectColumnName1] forState:UIControlStateNormal];
		return cell;
	}
	else
	{
		static NSString *CellIdentifier1 = @"Cell1";
		ToogleTableViewCell *cell1;
		cell1 = (ToogleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
		if (cell1 == nil) {
			cell1 = [[[ToogleTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier1] autorelease];
		
			[cell1.SegMent addTarget:self action:@selector(SegmentClick:) forControlEvents:UIControlEventValueChanged];

		}
		cell1.btnNext.hidden=TRUE;
		cell1.SegMent.selectedSegmentIndex=appdelegate.isFromChart;
		cell1.btnPrev.hidden=TRUE; 
		Segment=cell1.SegMent; 
		return cell1;
	}
}		

-(IBAction)ClickButton:(id)sender
{
	if(Segment.selectedSegmentIndex==0)
	{
		appdelegate.isDailyReport=TRUE;
		SelectedTag=0;
		PickerView.hidden=FALSE;
		ToolBar.hidden=FALSE;
		appdelegate.isFromChart=0;
		[PickerView reloadAllComponents]; 
	}
	else if(Segment.selectedSegmentIndex==1)
	{
		appdelegate.isDailyReport=FALSE;
		SelectedTag=1;
		PickerView.hidden=FALSE;
		ToolBar.hidden=FALSE;
		appdelegate.isFromChart=1;
		[PickerView reloadAllComponents]; 
	}
	else
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Select" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	
}

-(IBAction)SegmentClick:(id)sender
{
	[btnSelected setTitle:@"  Select options" forState:UIControlStateNormal];
}

#pragma mark pickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pV
{
		return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pV numberOfRowsInComponent:(NSInteger)component
{	
	
	if(SelectedTag==0)
	{
		return [Daily_Array count];
	}
	else if(SelectedTag==1)
	{
		if(appdelegate.IsKidOrNot==0)
		{
			
			return [Hourly_Array count];
		}
		else
		{
			
			return [Hourly_Kid_Array count];
		}
	}
	return 0;
}

- (NSString *)pickerView:(UIPickerView *)pV titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if(SelectedTag==0)
	{		
		return [Daily_Array objectAtIndex:row];
	}
	else if(SelectedTag==1)
	{
		if(appdelegate.IsKidOrNot==0)
		{
			NSString *strRestaurantType=(NSString *)[Hourly_Array objectAtIndex:row];
			return  [NSString stringWithFormat:@"%@" ,strRestaurantType];
		}
		else
		{
			NSString *strRestaurantType=(NSString *)[Hourly_Kid_Array objectAtIndex:row];
			return  [NSString stringWithFormat:@"%@" ,strRestaurantType];
		}
	}
	return @"";	
}

- (void)dealloc {
	
	[tblView release];
	[btnReport release];
	[ReportView release];
	[PickerView release];
	[ToolBar release];
	[btnDone release];
	[lblData release];
	[Segment release];

	[btnSelected release];
	[DateFormatter release];
	
    [super dealloc];
}

@end
