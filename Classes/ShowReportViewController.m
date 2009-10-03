//
//  ShowReportViewController.m
//  hLog
//
//  Created by Bhoomi on 4/1/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import "ShowReportViewController.h"
#import "CalendarTableViewCell.h"
#import "Menstural_Cycle.h"
#import "CalendarTableViewCell1.h"

#define Field_Array [NSArray arrayWithObjects: @"BP",@"Blood Sugar",@"Temperature",@"Fasting Blood Sugar", @"Pulse",@"Respiration",@"Weight",@"Height",@"Pain",@"Other-Vitals",@"Sleep Times",@"Sleep Duration",@"Exercise",@"Mood",@"Activity",@"Diapering", @"Food Consumption",@"Calories Consumed",@"Calories Consumed",@"Alcohol",@"Cigarettes",@"Drugs",@"Menstruation",@"Other-Routines",@"Medicine",nil]
#define Field_Table_Array [NSArray arrayWithObjects: @"BP",@"BloodSugar",@"TemperatureF",@"Fasting", @"Pulse",@"Respiration",@"WeightKgs",@"HeightCms",@"Pain",@"Other_Vitals",@"Sleep",@"Sleep1", @"Exercise_id",@"Mood",@"Activity",@"Diapering", @"Feeding",@"calories",@"Alcohol",@"Cigarrettes",@"Drugs",@"Menstrution",@"Other_Routines",@"Medicine_Entry",nil]

@implementation ShowReportViewController

-(void)LoadReport
{
	NSAutoreleasePool  *Pool=[[NSAutoreleasePool alloc]init];
	@try 
	{
		NSArray *Start=[appDelegate.ReportStartDate componentsSeparatedByString:@" "];
		NSArray *End=[appDelegate.ReportEndDate componentsSeparatedByString:@" "];
		if(!appDelegate.ReportArray)
		{
			appDelegate.ReportArray=[[NSMutableDictionary alloc]init];
		}
		else if([appDelegate.ReportArray count]>0)
		{
			[appDelegate.ReportArray removeAllObjects];
		}		
		if(!appDelegate.WeekArray)
		{
			appDelegate.WeekArray=[[NSMutableArray alloc]init];
		}
		else if([appDelegate.WeekArray count]>0)
		{
			[appDelegate.WeekArray removeAllObjects];
		}
		NSString *Coulmnname=@"";
		NSArray *arr2=[appDelegate.SelectedReportField componentsSeparatedByString:@", "]; 
		for(int i=0;i<[arr2 count];i++)
		{
			NSString *Str=[arr2 objectAtIndex:i];
			Index=[Field_Table_Array indexOfObject:Str];
			Coulmnname=[Field_Table_Array objectAtIndex:Index];
			if(Index==6)
			{
				if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Weight"] isEqualToString:@"LBs"])
				{
					Coulmnname=@"WeightLbs";
				}
				else
				{
					Coulmnname=@"WeightKgs";
				}				
			}			
			if(Index==7)
			{
				if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Height"] isEqualToString:@"Inches"])
				{
					Coulmnname=@"HeightInch";
				}
				else
				{
					Coulmnname=@"HeightCms";
				}				
			}			
			if(Index==2)
			{
				if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Temperature"] isEqualToString:@"F"])
				{
					Coulmnname=@"TemperatureF";
				}
				else
				{
					Coulmnname=@"TemperatureC";
				}
			}			
			NSString *TableName=@"Vitals_Detail";
			if(Index>9)
			{
				TableName=@"Routine_Detail";
			}
			if(Index==23)
			{
				TableName=@"Medicine";
			}
			NSLog(@"%d",Index);
			if(Index==21)
			{			
				[appDelegate SelectWeeklyDataForMemstrual:[NSString stringWithFormat:@"%@ %@",[Start objectAtIndex:0],[Start objectAtIndex:1]]  PassEndDate:[NSString stringWithFormat:@"%@ %@",[End objectAtIndex:0],[End objectAtIndex:1]] andUserID:appDelegate.SelectedUserID]; 
			}			
			else
			{
				[appDelegate GetVitalsCalendarData:Coulmnname StartDate:[Start objectAtIndex:0]  Enddate:[End objectAtIndex:0] StartTime:[Start objectAtIndex:1] EndTime:[End objectAtIndex:1] andUserID:appDelegate.SelectedUserID andTableName:TableName];
			}
		}	
	}
	@catch (NSException * e)
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Catch" message:[NSString stringWithFormat:@"%@",e] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}	
	[Pool release];
}

#pragma mark View Methods

// Called after the view has been loaded. For view controllers created in code, this is after -loadView. For view controllers unarchived from a nib, this is after the view is set.
- (void)viewDidLoad
{
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	self.navigationItem.title=@"Report";
	lblDateTime.backgroundColor=[UIColor colorWithRed:0.8705  green:0.9058 blue:0.9725 alpha:1.0]; 
	lblDateTime.font=[UIFont boldSystemFontOfSize:12];
	lblDateTime.textAlignment=UITextAlignmentCenter;
	tblView.delegate=self;
	tblView.dataSource=self;
	tblView1.delegate=self;
	tblView1.dataSource=self;
	ScrollView.delegate=self;
	//	ScrollView1.delegate=self;
	ScrollView2.delegate=self;
	
	self.navigationItem.rightBarButtonItem=btnEdit;
	appDelegate=[[UIApplication sharedApplication]delegate];	
	viewHeader.backgroundColor=[UIColor colorWithRed:0.8705  green:0.9058 blue:0.9725 alpha:1.0];
	//ScrollView1.scrollEnabled=FALSE;
	ScrollView2.scrollEnabled=FALSE;
	tblView1.scrollEnabled=FALSE;
	ScrollView.bounces=NO;
	//ScrollView1.bounces=NO;
	[ScrollView2 addSubview:viewHeader];
	//////////////////////////////////	
	lblDateTime.frame=CGRectMake(0, 0, 109, 44);
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Back";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];	
	UIView *view=[[UIView alloc]init];
	view.frame=CGRectMake(50,0, 230, 30);
	lblHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
	[lblHeader setFont:[UIFont boldSystemFontOfSize:12.0]];
	[lblHeader setBackgroundColor:[UIColor clearColor]];
	[lblHeader setTextAlignment:UITextAlignmentCenter];
 	[lblHeader setTextColor:[UIColor colorWithRed:0.3607  green:0.5333 blue:0.9019 alpha:1.0]];
	[lblHeader setText:@""];
	[view addSubview:lblHeader];	
	lblFooter = [[UILabel alloc] initWithFrame:CGRectMake(23, 0, 130, 30)];
	[lblFooter setFont:[UIFont boldSystemFontOfSize:15.0]];
	[lblFooter setBackgroundColor:[UIColor clearColor]];
	[lblFooter setTextAlignment:UITextAlignmentCenter];
 	[lblFooter setTextColor:[UIColor whiteColor]];
	[lblFooter setText:@"Reports"];
	[view addSubview:lblFooter];	
	self.navigationItem.titleView=view;
	tblView.tableHeaderView=nil;
	[view release];
	[Pool release];
    [super viewDidLoad];
}


// Called when the view is about to made visible. Default does nothing
- (void)viewWillAppear:(BOOL)animated
{
	isRotate=FALSE;
	tblView.userInteractionEnabled=TRUE;
	NSArray *arr2=[appDelegate.ReportField componentsSeparatedByString:@", "];
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	if(appDelegate.isDailyReport==TRUE)
	{
		[self LoadReport];
		//bubbleSort(appDelegate.WeekArray);
		if(!tmpArray)
			tmpArray=[[NSMutableArray alloc]init];
		else
			[tmpArray removeAllObjects];
		[tmpArray addObjectsFromArray:[appDelegate.WeekArray mutableCopy]];
		[appDelegate.WeekArray removeAllObjects];
		//////// Set Date Array In acceding Order
		for(int i=0;i<[tmpArray count];i++)
		{
			NSString *str=[tmpArray objectAtIndex:i];
			[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
			
			NSDate *tmpDate=[appDelegate.DateFormatter dateFromString:str];
			[appDelegate.DateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
			
			str=[appDelegate.DateFormatter stringFromDate:tmpDate];
			[appDelegate.WeekArray addObject:[str mutableCopy]];
		}
		NSSortDescriptor *lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
		[appDelegate.WeekArray sortUsingDescriptors:[NSArray arrayWithObject:lastNameDescriptor]];
		
		[tmpArray removeAllObjects];
		[tmpArray addObjectsFromArray:[appDelegate.WeekArray mutableCopy]];
		[appDelegate.WeekArray removeAllObjects];
		for(int i=0;i<[tmpArray count];i++)
		{
			NSString *str=[tmpArray objectAtIndex:i];
			[appDelegate.DateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
			
			NSDate *tmpDate=[appDelegate.DateFormatter dateFromString:str];
			[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
			
			str=[appDelegate.DateFormatter stringFromDate:tmpDate];
			[appDelegate.WeekArray addObject:[str mutableCopy]];
		}
		
		///// Set frame base on records
		TotlaDataCount=[appDelegate.WeekArray count];
		ISFinish=FALSE;
		DisplanyCount=25;		
		if(TotlaDataCount>25)
		{
			height=25*50;
		}
		else
		{
			height=TotlaDataCount*50;
		}
		if(height>320)
		{
			height=TotlaDataCount*50;
		}
		else
			height=460;
		if([arr2 count]<3)
		{
			viewHeader.frame=CGRectMake(0, 0, 400, 55);
			ScrollView2.contentSize=CGSizeMake( 210, 48) ;
			Width=400;
		}
		else
		{
			viewHeader.frame=CGRectMake(0, 0, (([arr2 count]+1)*90)+10, 55);
			ScrollView2.contentSize=CGSizeMake( ([arr2 count]+1)*90+20, 48) ;
			Width=(([arr2 count]+1)*90)+20;
		}
		tblView.frame=CGRectMake(110, 0, 2180, height);
		tblView1.frame=CGRectMake(0, 44, 110, height);
		NSArray *tmpArray1=[appDelegate.SelectedReportField componentsSeparatedByString:@", "];
		Count=[tmpArray1 count];
		if(!arr3)
			arr3=[[NSMutableArray alloc]init];
		else
			[arr3 removeAllObjects];
		[arr3 addObjectsFromArray:tmpArray1];
		[arr3 retain];
		[arr3 retain];
		[tblView1 reloadData];
		[tblView reloadData];
	}
	if([arr2 count]<3)
	{
		ScrollView.contentSize=CGSizeMake( 210, height+50);
	}
	else
	{
		ScrollView.contentSize=CGSizeMake( Width, height+50);
	}
	tblView.frame=CGRectMake(110, 0, 2180, height);
	tblView1.frame=CGRectMake(0, 0, 110, height);
	tblView.bounces=NO;
	tblView.scrollEnabled=TRUE;
	[ScrollView bringSubviewToFront:tblView];
	if(appDelegate.isFromReport==TRUE)
	{
		///// Set Header Label base on selection Label
		NSArray *subView=[viewHeader subviews];
		for(int i=0; i<[subView count]; i++)
			[[subView objectAtIndex:i] removeFromSuperview];
		appDelegate.ISEdit=FALSE;
		btnEdit.style=UIBarButtonItemStyleBordered;
		btnEdit.title=@"Edit ";
		appDelegate.isFromReport=FALSE;
		lblFooter.frame=CGRectMake(23, 0, 130, 30);
		lblHeader.text=@"";
		self.navigationItem.rightBarButtonItem=btnEdit;
		NSArray *arr2=[appDelegate.ReportField componentsSeparatedByString:@", "];
		int X=0;
		for(int i=0;i<[arr2 count];i++)
		{
			UILabel *lbl1=[[UILabel alloc]init];
			lbl1.font=[UIFont boldSystemFontOfSize:12];
			lbl1.textAlignment=UITextAlignmentCenter;
			lbl1.numberOfLines=0;			
			if(i==0)
			{
				lbl1.frame =  CGRectMake(0, 0, 80, 50);
			}
			else
			{
				X=X+90;
				lbl1.frame =  CGRectMake(X, 0, 80, 50);
			}			
			lbl1.text=[arr2 objectAtIndex:i];
			lbl1.backgroundColor=[UIColor clearColor];
			[viewHeader insertSubview:lbl1 atIndex:i];
			[viewHeader bringSubviewToFront:lbl1];
			[lbl1 release];
		}
	}
	isRotate=TRUE;
	isPortrait=TRUE;
	[Pool release];
	[self scrollViewDidScroll:ScrollView];
	if([appDelegate.WeekArray count]==0)
	{
		appDelegate.ISEdit=FALSE;
		btnEdit.style=UIBarButtonItemStyleBordered;
		btnEdit.title=@"Edit ";
		lblFooter.frame=CGRectMake(23, 0, 130, 30);
		lblHeader.text=@"";
		self.navigationItem.rightBarButtonItem=nil;
	}
	
	[tblView1 reloadData];
}

 // Called when the view is dismissed, covered or otherwise hidden. Default does nothing
- (void)viewWillDisappear:(BOOL)animated
{
	[[UIDevice currentDevice] setOrientation:UIInterfaceOrientationPortrait];
}


 // any offset changes
/// Set Frame of tableview and Scrollview according ROtation
- (void)scrollViewDidScroll:(UIScrollView *)scrollViewTest;               // any offset changes
{	
	if(isRotate)
	{
		isRotate=FALSE;		
		if(isPortrait)
			ScrollView2.frame=CGRectMake(110, 0, ScrollView.frame.size.width,44);
		else
		{
			ScrollView2.frame=CGRectMake(110, 0, ScrollView.frame.size.width,48);
		}
		tblView1.contentOffset=ScrollView.contentOffset;
		ScrollView2.contentOffset=CGPointMake(ScrollView.contentOffset.x,0);
		isRotate=FALSE;		
		return;
	}
	else
	{
		tblView1.contentOffset=CGPointMake(0, ScrollView.contentOffset.y);
		if(scrollViewTest==ScrollView) 
		{
			ScrollView2.contentOffset=CGPointMake(ScrollView.contentOffset.x,0);
		}		
		if(ScrollView.contentOffset.y > 0) 
		{
			ScrollView2.frame=ScrollView2.frame;
		}
		if(scrollViewTest==ScrollView && ScrollView2.contentOffset.x > 110)
			ScrollView2.frame=CGRectMake(110, 0, ScrollView.frame.size.width,44);
	}
	[self.view bringSubviewToFront:tblView1];
}

// Override to allow rotation. Default returns YES only for UIDeviceOrientationPortrait
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if(interfaceOrientation==UIInterfaceOrientationPortrait)
	{
		self.view.frame=CGRectMake(0, 0, 320, 416);
		tblView.frame=CGRectMake(110, 0, 2180, height);
		tblView1.frame=CGRectMake(0, 45, 110, height);
		isRotate=TRUE;
		isPortrait=TRUE;
		[self scrollViewDidScroll:ScrollView];
		[tblView1 reloadData];
		return (interfaceOrientation == UIInterfaceOrientationPortrait);
	}
	else if(interfaceOrientation==UIInterfaceOrientationLandscapeLeft)
	{
		self.view.frame=CGRectMake(0, 0, 480, 276);
		tblView1.frame=CGRectMake(0, 45, 110, height);
		tblView.frame=CGRectMake(110, 0, 2180, height);
		ScrollView.contentSize=CGSizeMake( Width, height+50);
		isRotate=TRUE;
		isPortrait=FALSE;
		[self scrollViewDidScroll:ScrollView];
		[tblView1 reloadData];
		return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
	}
	else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight)
	{
		self.view.frame=CGRectMake(0, 0, 480, 276);
		tblView1.frame=CGRectMake(0, 45, 110, height);
		tblView.frame=CGRectMake(110, 0, 2180, height);		
		ScrollView.contentSize=CGSizeMake( Width, height+50);
		isRotate=TRUE;
		isPortrait=FALSE;
		[self scrollViewDidScroll:ScrollView];
		[tblView1 reloadData];
		return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
	}	
	return NO;	
}

#pragma mark Table view methods
/// Return Height Base on text
-(CGFloat)findHeightForCell:(NSString *)text
{
	CGFloat		result = 40.0f;
	CGFloat		width = 0;
	
	width = 77;
	if (text)
	{
		CGSize		textSize = { width, 20000.0f };		// width and height of text area
		CGSize		size = [text sizeWithFont:[UIFont boldSystemFontOfSize:12.5f] constrainedToSize:textSize lineBreakMode:UILineBreakModeCharacterWrap];
		
		size.height += 25.0f;			// top and bottom margin
		result = MAX(size.height, 40.0f);	// at least one row		
	}
	else
	{
		return 40;
	}
	return result;	
}
// Variable height support
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(!ISFinish)
	{
		if(indexPath.row==DisplanyCount)
		{	
			return 45;
		}
		else
		{			
			CGFloat Maxheight=40;
			for(int i=0;i<Count;i++)
			{
				FieldName=[arr3 objectAtIndex:i];
				NSDictionary *Dict=[appDelegate.ReportArray valueForKey:FieldName];
				CGFloat TmpHeight;
				TmpHeight=[self findHeightForCell:[Dict valueForKey:[appDelegate.WeekArray objectAtIndex:indexPath.row]]];
				
				if(TmpHeight>Maxheight)
				{
					Maxheight=TmpHeight;
				}		
			}
			height=height+Maxheight;
			ScrollView.contentSize=CGSizeMake( Width, height+50);
			return Maxheight;
		}
	}
	else if(ISFinish)
	{
		CGFloat Maxheight=40;		
		for(int i=0;i<Count;i++)
		{
			FieldName=[arr3 objectAtIndex:i];
			NSDictionary *Dict=[appDelegate.ReportArray valueForKey:FieldName];
			CGFloat TmpHeight;
			TmpHeight=[self findHeightForCell:[Dict valueForKey:[appDelegate.WeekArray objectAtIndex:indexPath.row]]];
			
			if(TmpHeight>Maxheight)
			{
				Maxheight=TmpHeight;
			}
		}
		height=height+Maxheight;
		ScrollView.contentSize=CGSizeMake( Width, height+50);
		return Maxheight;
	}
	return 40;
}

// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{	
	if(TotlaDataCount==0)
		return 0;	
	if(TotlaDataCount>DisplanyCount)
	{
		ISFinish=FALSE;
		height=50;
		return DisplanyCount+1;
	}
	else
	{
		ISFinish=TRUE;
		height=0;
		return [appDelegate.WeekArray count];
	}
	//return 0;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{	
	tblView.frame=CGRectMake(110, 0, 2180, height);
	tblView1.frame=CGRectMake(0, 45, 110, height);
	if(tableView==tblView)
	{
		if(ISFinish==FALSE)
		{
			/////// Called when more then 25 records
			if(indexPath.row==DisplanyCount)
			{			
				static NSString *CellIdentifier1 = @"Cell1";
				UITableViewCell *cell1 =(UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
				if (cell1 == nil) {
					cell1 = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier1] autorelease];
				}	
				cell1.accessoryType=UITableViewCellAccessoryNone;
				cell1.text=@"Show More 25";
				return cell1;			
			}
			else
			{
				static NSString *CellIdentifier = @"Cell";			
				CalendarTableViewCell *cell = (CalendarTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
				if (cell == nil) {
					cell = [[[CalendarTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
				}
				strLabel=(NSString*)[appDelegate.WeekArray objectAtIndex:indexPath.row];
				Str1=@"";
				[appDelegate.Columns removeAllObjects];
				cell.tag=indexPath.row;
				for(int i=0;i<Count;i++)
				{
					FieldName=[arr3 objectAtIndex:i];
					NSDictionary *Dict;
					[cell addColumn:90*(i+1)];
					
					/// Set data for Manstural Cycle
					if([FieldName isEqualToString:@"Menstruation"])
					{
						Dict=[appDelegate.ReportArray valueForKey:FieldName];
						if([[Dict valueForKey:[NSString stringWithFormat:@"%@",strLabel]] length]>0)
						{
							Str1=@"Start Date";
						}
						else if([[Dict valueForKey:[NSString stringWithFormat:@"%@",strLabel]] length]>0)
						{
							Str1=@"End Date";
						}
						else
							Str1=@"";
					}
					else
					{
						if([FieldName isEqualToString:@"WeightKgs"])
						{
							if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Weight"] isEqualToString:@"LBs"])
							{								
								FieldName=@"WeightLbs";
							}
							else
							{								
								FieldName=@"WeightKgs";
							}
						}
						if([FieldName isEqualToString:@"HeightCms"])
						{
							if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Height"] isEqualToString:@"Inches"])
							{
								FieldName=@"HeightInch";
							}
							else
							{
								FieldName=@"HeightCms";
							}
						}
						if([FieldName isEqualToString:@"TemperatureF"])
						{
							if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Temperature"] isEqualToString:@"F"])
							{
								FieldName=@"TemperatureF";
							}
							else
							{
								FieldName=@"TemperatureC";
							}
						}
						Dict=[appDelegate.ReportArray valueForKey:FieldName];
						Str1=[Dict valueForKey:strLabel];
						if([Str1 length]>0)
						{
							if(([FieldName isEqualToString:@"WeightKgs"] || [FieldName isEqualToString:@"WeightLbs"]))
							{
								if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Weight"] isEqualToString:@"LBs"])
								{
									Str1=[NSString stringWithFormat:@"%@ Lbs",Str1];
								}
								else
								{
									Str1=[NSString stringWithFormat:@"%@ Kgs",Str1];
								}
							}
							if([FieldName isEqualToString:@"HeightCms"] || [FieldName isEqualToString:@"HeightInch"])
							{
								if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Height"] isEqualToString:@"Inches"])
								{
									Str1=[NSString stringWithFormat:@"%@ Feet",Str1];
								}
								else
								{
									Str1=[NSString stringWithFormat:@"%@ Meter",Str1];
								}
							}
							if([FieldName isEqualToString:@"TemperatureF"] || [FieldName isEqualToString:@"TemperatureC"])
							{
								if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Temperature"] isEqualToString:@"F"])
								{
									Str1=[NSString stringWithFormat:@"%@ º F",Str1];
								}
								else
								{
									Str1=[NSString stringWithFormat:@"%@ º C",Str1];
								}
							}
							if([FieldName isEqualToString:@"BP"])
							{
								Str1=[NSString stringWithFormat:@"%@ mmHg",Str1];
							}
						}
					}				
					switch(i)
					{
						case 0:
							cell.Hour1.text=Str1;
							cell.Hour2.text=@"";
							cell.Hour3.text=@"";
							cell.Hour4.text=@"";
							cell.Hour5.text=@"";
							cell.Hour6.text=@"";
							cell.Hour7.text=@"";
							cell.Hour8.text=@"";
							cell.Hour9.text=@"";
							cell.Hour10.text=@"";
							cell.Hour11.text=@"";
							cell.Hour12.text=@"";
							cell.Hour13.text=@"";
							cell.Hour14.text=@"";
							cell.Hour15.text=@"";
							cell.Hour16.text=@"";
							cell.Hour17.text=@"";
							cell.Hour18.text=@"";
							cell.Hour19.text=@"";
							cell.Hour20.text=@"";
							cell.Hour21.text=@"";
							cell.Hour22.text=@"";
							cell.Hour23.text=@"";
							cell.Hour24.text=@"";
							break;
						case 1:
							cell.Hour2.text=Str1;
							break;
						case 2:
							cell.Hour3.text=Str1;
							break;
						case 3:
							cell.Hour4.text=Str1;
							break;
						case 4:
							cell.Hour5.text=Str1;
							break;
						case 5:
							cell.Hour6.text=Str1;
							break;
						case 6:
							cell.Hour7.text=Str1;
							break;
						case 7:
							cell.Hour8.text=Str1;
							break;
						case 8:
							cell.Hour9.text=Str1;
							break;
						case 9:
							cell.Hour10.text=Str1;
							break;						
						case 10:
							cell.Hour11.text=Str1;
							break;							
						case 11:
							cell.Hour12.text=Str1;
							break;
						case 12:
							cell.Hour13.text=Str1;
							break;
						case 13:
							cell.Hour14.text=Str1;
							break;
						case 14:
							cell.Hour15.text=Str1;
							break;
						case 15:
							cell.Hour16.text=Str1;
							break;
						case 16:
							cell.Hour17.text=Str1;
							break;
						case 17:
							cell.Hour18.text=Str1;
							break;
						case 18:
							cell.Hour19.text=Str1;
							break;
						case 19:
							cell.Hour20.text=Str1;
							break;
						case 20:
							cell.Hour21.text=Str1;
							break;
						case 21:
							cell.Hour22.text=Str1;
							break;
						case 22:
							cell.Hour23.text=Str1;
							break;
						case 23:
							cell.Hour24.text=Str1;
							break;
						default:
							break;							
					}
				}
				return cell;
			}
		}
		else
		{
			///// Called when less then 25 records
			static NSString *CellIdentifier2 = @"Cell2";		
			CalendarTableViewCell *cell2 = (CalendarTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
			if (cell2 == nil) {
				cell2 = [[[CalendarTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier2] autorelease];
			}	
			strLabel=(NSString*)[appDelegate.WeekArray objectAtIndex:indexPath.row];
			Str1=@"";
			[appDelegate.Columns removeAllObjects];
			for(int i=0;i<23;i++)
			{
				[cell2 addColumn:90*(i+1)];
			}
			NSLog(@"OK");
			cell2.tag=indexPath.row;
			for(int i=0;i<Count;i++)
			{
				FieldName=[arr3 objectAtIndex:i];
				NSDictionary *Dict;
				//// Set Menstrual Records
				if([FieldName isEqualToString:@"Menstruation"])
				{
					Dict=[appDelegate.ReportArray valueForKey:FieldName];
					if([[Dict valueForKey:[NSString stringWithFormat:@"%@",strLabel]] length]>0)
					{
						Dict=[appDelegate.ReportArray valueForKey:FieldName];
						Str1=[Dict valueForKey:strLabel];		
					}
					else if([[Dict valueForKey:[NSString stringWithFormat:@"%@",strLabel]] length]>0)
					{
						Dict=[appDelegate.ReportArray valueForKey:FieldName];
						Str1=[Dict valueForKey:strLabel];		
					}
					else
						Str1=@"";
				}
				else
				{
					if([FieldName isEqualToString:@"WeightKgs"])
					{
						if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Weight"] isEqualToString:@"LBs"])
						{							
							FieldName=@"WeightLbs";
						}
						else
						{							
							FieldName=@"WeightKgs";
						}
					}
					if([FieldName isEqualToString:@"HeightCms"])
					{
						if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Height"] isEqualToString:@"Inches"])
						{
							FieldName=@"HeightInch";
						}
						else
						{
							FieldName=@"HeightCms";
						}
					}
					if([FieldName isEqualToString:@"TemperatureF"])
					{						
						if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Temperature"] isEqualToString:@"F"])
						{
							FieldName=@"TemperatureF";
						}
						else
						{
							FieldName=@"TemperatureC";
						}
					}
					Dict=[appDelegate.ReportArray valueForKey:FieldName];
					Str1=[Dict valueForKey:strLabel];	
					if([Str1 length]>0)
					{
						if(([FieldName isEqualToString:@"WeightKgs"] || [FieldName isEqualToString:@"WeightLbs"]))
						{
							if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Weight"] isEqualToString:@"LBs"])
							{
								Str1=[NSString stringWithFormat:@"%@ Lbs",Str1];
							}
							else
							{
								Str1=[NSString stringWithFormat:@"%@ Kgs",Str1];
							}
						}
						if([FieldName isEqualToString:@"HeightCms"] || [FieldName isEqualToString:@"HeightInch"])
						{
							if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Height"] isEqualToString:@"Inches"])
							{
								Str1=[NSString stringWithFormat:@"%@ Feet",Str1];
							}
							else
							{
								Str1=[NSString stringWithFormat:@"%@ Meter",Str1];
							}
						}
						if([FieldName isEqualToString:@"TemperatureF"] || [FieldName isEqualToString:@"TemperatureC"])
						{
							if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Temperature"] isEqualToString:@"F"])
							{
								Str1=[NSString stringWithFormat:@"%@ º F",Str1];
							}
							else
							{
								Str1=[NSString stringWithFormat:@"%@ º C",Str1];
							}
						}
						if([FieldName isEqualToString:@"BP"])
						{
							Str1=[NSString stringWithFormat:@"%@ mmHg",Str1];
						}
					}
				}
				switch(i)
				{
					case 0:
						cell2.Hour1.text=Str1;
						cell2.Hour2.text=@"";
						cell2.Hour3.text=@"";
						cell2.Hour4.text=@"";
						cell2.Hour5.text=@"";
						cell2.Hour6.text=@"";
						cell2.Hour7.text=@"";
						cell2.Hour8.text=@"";
						cell2.Hour9.text=@"";
						cell2.Hour10.text=@"";
						cell2.Hour11.text=@"";
						cell2.Hour12.text=@"";
						cell2.Hour13.text=@"";
						cell2.Hour14.text=@"";
						cell2.Hour15.text=@"";
						cell2.Hour16.text=@"";
						cell2.Hour17.text=@"";
						cell2.Hour18.text=@"";
						cell2.Hour19.text=@"";
						cell2.Hour20.text=@"";
						cell2.Hour21.text=@"";
						cell2.Hour22.text=@"";
						cell2.Hour23.text=@"";
						break;
					case 1:
						cell2.Hour2.text=Str1;
						break;
					case 2:
						cell2.Hour3.text=Str1;
						break;
					case 3:
						cell2.Hour4.text=Str1;
						break;
					case 4:
						cell2.Hour5.text=Str1;
						break;
					case 5:
						cell2.Hour6.text=Str1;
						break;
					case 6:
						cell2.Hour7.text=Str1;
						break;
					case 7:
						cell2.Hour8.text=Str1;
						break;
					case 8:
						cell2.Hour9.text=Str1;
						break;
					case 9:
						cell2.Hour10.text=Str1;
						break;						
					case 10:
						cell2.Hour11.text=Str1;
						break;						
					case 11:
						cell2.Hour12.text=Str1;
						break;
					case 12:
						cell2.Hour13.text=Str1;
						break;
					case 13:
						cell2.Hour14.text=Str1;
						break;
					case 14:
						cell2.Hour15.text=Str1;
						break;
					case 15:
						cell2.Hour16.text=Str1;
						break;
					case 16:
						cell2.Hour17.text=Str1;
						break;
					case 17:
						cell2.Hour18.text=Str1;
						break;
					case 18:
						cell2.Hour19.text=Str1;
						break;
					case 19:
						cell2.Hour20.text=Str1;
						break;
					case 20:
						cell2.Hour21.text=Str1;
						break;
					case 21:
						cell2.Hour22.text=Str1;
						break;
					case 22:
						cell2.Hour23.text=Str1;
						break;
					case 23:
						cell2.Hour24.text=Str1;
						break;
					default:
						break;						
				}
			}
			return cell2;
		}		
	}
	else
	{
		if(ISFinish==FALSE)
		{
			if(indexPath.row==DisplanyCount)
			{			
				static NSString *CellIdentifier6 = @"Cell6";
				UITableViewCell *cell6 =(UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier6];
				if (cell6 == nil) {
					cell6 = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier6] autorelease];
				}	
				cell6.accessoryType=UITableViewCellAccessoryNone;
				cell6.textAlignment = UITextAlignmentCenter;
				cell6.text=@"";
				[cell6.contentView setBackgroundColor:[UIColor colorWithRed:0.8705  green:0.9058 blue:0.9725 alpha:1.0]]; 
				return cell6;			
			}
			else
			{
				static NSString *CellIdentifier5 = @"Cell5";				
				CalendarTableViewCell1 *cell5 = (CalendarTableViewCell1*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier5];
				if (cell5 == nil) {
					cell5 = [[[CalendarTableViewCell1 alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier5] autorelease];
				}
				cell5.lblName.hidden=FALSE;
				[cell5.contentView setBackgroundColor:[UIColor colorWithRed:0.8705  green:0.9058 blue:0.9725 alpha:1.0]]; 
				cell5.lblName.text=(NSString*)[appDelegate.WeekArray objectAtIndex:indexPath.row];
				return cell5;
			}
		}
		else
		{
			static NSString *CellIdentifier8 = @"Cell8";			
			CalendarTableViewCell1 *cell8 = (CalendarTableViewCell1*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier8];
			if (cell8 == nil) {
				cell8 = [[[CalendarTableViewCell1 alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier8] autorelease];
			}
			cell8.lblName.hidden=FALSE;
			cell8.lblName.text=(NSString*)[appDelegate.WeekArray objectAtIndex:indexPath.row];
			[cell8.contentView setBackgroundColor:[UIColor colorWithRed:0.8705  green:0.9058 blue:0.9725 alpha:1.0]]; 
			return cell8;			
		}	
	}
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	[tblView deselectRowAtIndexPath:indexPath animated:YES];
	if(tableView==tblView1)
	{
		return;
	}
	if(appDelegate.ISEdit==FALSE)
	{
		if(indexPath.row==DisplanyCount)
		{
			//// Called when user will press show more 25 records
			[NSTimer scheduledTimerWithTimeInterval:(0.1) target:self selector:@selector(Click_Next) userInfo:nil repeats:NO];
		}	
	}
}

///////// Called when User will press Show more 25 records

-(void)Click_Next
{
	DisplanyCount=DisplanyCount+25;	
	if(TotlaDataCount>DisplanyCount)
	{
		height=DisplanyCount*50;
	}
	else
	{
		height=TotlaDataCount*50;
	}
	ScrollView.contentSize=CGSizeMake( Width, height);
	//ScrollView1.contentSize=CGSizeMake( 110, height);
	[tblView1 reloadData];
	[tblView reloadData];
}

//// Called when user will tab any label for edit it
-(void)Click_Edit:(UILabel *)lbl
{
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	appDelegate.isDailyReport=FALSE;
	appDelegate.isFromChart=TRUE;
	appDelegate.isFromEditReport=TRUE;
	appDelegate.isfromRoot=TRUE;
	int x=appDelegate.SelectedLocation.x;
	int Z=x/90;
	if(Z!=-1)
	{
		NSArray *tmpArray1=[appDelegate.SelectedReportField componentsSeparatedByString:@", "];
		if([tmpArray1 count]>Z)
		{
		Index=[Field_Table_Array  indexOfObject:[tmpArray1 objectAtIndex:Z]];
		if([[tmpArray1 objectAtIndex:Z] isEqualToString:@"WeightKgs"])
		{
			Index=6;
		}
		if([[tmpArray1 objectAtIndex:Z] isEqualToString:@"HeightCms"])
		{
			Index=7;
		}
		if([[tmpArray1 objectAtIndex:Z] isEqualToString:@"TemperatureF"])
		{
			Index=2;
		}		
		{
			Date=[appDelegate.WeekArray objectAtIndex:appDelegate.Row];
			appDelegate.isfromFavourite=TRUE;
			{
				NSArray *Arr4=[Date componentsSeparatedByString:@" "];
				Date=[Arr4 objectAtIndex:0];
				DateTime=@"";
				if([Arr4 count]>1)
				{
					DateTime=[Arr4 objectAtIndex:1];
				}
				tblView.userInteractionEnabled=TRUE;
				if(Index==23)
				{
					//////// Edit Medicine Entry
					[[UIDevice currentDevice] setOrientation:UIInterfaceOrientationPortrait];
					if(!appDelegate.objSelectOptionsViewController)
					{
						appDelegate.objSelectOptionsViewController=[[SelectOptionsViewController alloc]initWithNibName:@"SelectOptions" bundle:nil];
					}
					appDelegate.DailyTag=20; 
					appDelegate.isFromChart=TRUE; 
					appDelegate.objSelectOptionsViewController.NavText=@"Medicine";
					appDelegate.SelectedStatus=@"Medicine";
					
					[appDelegate Medicinedata:Date  ToTime:DateTime anduserid:appDelegate.SelectedUserID]; 
					if([appDelegate.EntryArray count]>0)
					{
						appDelegate.MedicineRef =[appDelegate.EntryArray objectAtIndex:0];
						appDelegate.SelectedItems=appDelegate.MedicineRef.Medicine_Insert_ID;
						[appDelegate SelectMedicineDeatl:appDelegate.MedicineRef.MedicineID];
					}
					else
					{
						if(!appDelegate.MedicineRef)
						{
							appDelegate.MedicineRef=[[Medicine alloc]init];
						}
						else
						{
							[appDelegate.MedicineRef ClearData];
						}
						appDelegate.MedicineRef.EntryDate=Date;
						appDelegate.MedicineRef.EntryTime=[NSString stringWithFormat:@"%@",DateTime];
						appDelegate.MedicineRef.UserID=appDelegate.SelectedUserID;
						appDelegate.SelectedItems=@"";
						[appDelegate.UnitDictionary removeAllObjects];
					}					
					[self.navigationController pushViewController:appDelegate.objSelectOptionsViewController animated:YES];
				}
				else if(Index>9)
				{
					////// Edit Routine Entry
					[[UIDevice currentDevice] setOrientation:UIInterfaceOrientationPortrait];
					if(!appDelegate.objUserViewController)
					{
						appDelegate.objUserViewController=[[UserViewController alloc]initWithNibName:@"UserSelect" bundle:nil];
					}				
					[appDelegate SelectRoutinesDetail:Date  AndTime:DateTime andUserID:appDelegate.SelectedUserID];
					[appDelegate selectMenstural:appDelegate.SelectedUserID  passDate:[NSString stringWithFormat:@"%@ %@",Date,DateTime]];
					if([appDelegate.HourlyDataArray count]>0)
					{
						appDelegate.Routine_Detailrf =[appDelegate.HourlyDataArray objectAtIndex:0];
						[appDelegate SelectExercise_Duration:appDelegate.Routine_Detailrf.Routine_ID];
						//		NSArray *arr3=[appDelegate.Routine_Detailrf.Exercise componentsSeparatedByString:@", "];					
						appDelegate.Routine_Detailrf.Exercise=@"";
						for(int i=0;i<[appDelegate.ExerciseDurationArray count];i++)
						{
							NSDictionary *Dic=[appDelegate.ExerciseDurationArray objectAtIndex:i];
							int Dur=[[Dic valueForKey:@"Duration"]intValue];
							int	Hours=Dur%60;
							int Minutes=Dur/60;
							if(i==([appDelegate.ExerciseDurationArray count]-1))
							{
								appDelegate.Routine_Detailrf.Exercise_Duration=[appDelegate.Routine_Detailrf.Exercise_Duration stringByAppendingString:[NSString stringWithFormat:@"%@",[Dic valueForKey:@"Duration"]]];
								appDelegate.Routine_Detailrf.Exercise_Dru_ID=[appDelegate.Routine_Detailrf.Exercise_Dru_ID stringByAppendingString:[NSString stringWithFormat:@"%@",[Dic valueForKey:@"Exercise_ID"]]];
								appDelegate.Routine_Detailrf.Exercise=[appDelegate.Routine_Detailrf.Exercise stringByAppendingString:[NSString stringWithFormat:@"%@ (%d:%d)",[Dic valueForKey:@"Exercise_ID"],Minutes,Hours]];
							}
							else
							{
								appDelegate.Routine_Detailrf.Exercise_Duration=[appDelegate.Routine_Detailrf.Exercise_Duration stringByAppendingString:[NSString stringWithFormat:@"%@, ",[Dic valueForKey:@"Duration"]]];
								appDelegate.Routine_Detailrf.Exercise_Dru_ID=[appDelegate.Routine_Detailrf.Exercise_Dru_ID stringByAppendingString:[NSString stringWithFormat:@"%@, ",[Dic valueForKey:@"Exercise_ID"]]];
								appDelegate.Routine_Detailrf.Exercise=[appDelegate.Routine_Detailrf.Exercise stringByAppendingString:[NSString stringWithFormat:@"%@ (%d:%d), ",[Dic valueForKey:@"Exercise_ID"],Minutes,Hours]];
							}
						}
						[appDelegate SelectFeedDeatl:appDelegate.Routine_Detailrf.Routine_ID];
						if([appDelegate.UnitDictionary count]>0)
						{
							NSArray *array=[appDelegate.UnitDictionary allKeys];
							appDelegate.Routine_Detailrf.Feeding=@"";
							for(int i=0;i<[appDelegate.UnitDictionary count];i++)
							{							
								NSDictionary *Dic=[appDelegate.UnitDictionary objectForKey:[array objectAtIndex:i]];
								if(i==([appDelegate.UnitDictionary count]-1))
								{
									appDelegate.Routine_Detailrf.Feeding=[appDelegate.Routine_Detailrf.Feeding stringByAppendingString:[NSString stringWithFormat:@"%@ (%@ %@)",[Dic valueForKey:@"Feed_Name"],[Dic valueForKey:@"Feed_Qty"],[Dic valueForKey:@"Feed_Unit"]]];								
								}
								else
								{
									appDelegate.Routine_Detailrf.Feeding=[appDelegate.Routine_Detailrf.Feeding stringByAppendingString:[NSString stringWithFormat:@"%@ (%@ %@),",[Dic valueForKey:@"Feed_Name"],[Dic valueForKey:@"Feed_Qty"],[Dic valueForKey:@"Feed_Unit"]]];								
								}
							}
						}						
					}
					else
					{
						if(!appDelegate.Routine_Detailrf)
						{
							appDelegate.Routine_Detailrf=[[Routine_Detail alloc]init];
						}
						else
						{
							[appDelegate.Routine_Detailrf ClearData];
						}
						appDelegate.Routine_Detailrf.User_ID=appDelegate.SelectedUserID;
						appDelegate.Routine_Detailrf.EntryDate=Date;
						appDelegate.Routine_Detailrf.EntryTime=[NSString stringWithFormat:@"%@",DateTime];		
						[appDelegate.UnitDictionary removeAllObjects];
					}
					if([appDelegate.MensturalArray count]>0)
					{
						appDelegate.Mensturalref=[appDelegate.MensturalArray objectAtIndex:0];
						int difference=1;
						if([appDelegate.Mensturalref.Daily_EndDate length]!=0)
						{
							[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
							NSDate *Date1=[appDelegate.DateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@",appDelegate.Routine_Detailrf.EntryDate,appDelegate.Routine_Detailrf.EntryTime]];
							NSDate *Date2=[appDelegate.DateFormatter dateFromString:appDelegate.Mensturalref.Daily_EndDate];
							difference=[Date1 timeIntervalSinceDate:Date2]; 
						}
						//	if([appDelegate.Mensturalref.EndDate length]>0 && difference>0)
						appDelegate.objUserViewController.isEndDisabled=FALSE;
						if(([appDelegate.Mensturalref.Daily_Date isEqualToString:[NSString stringWithFormat:@"%@",appDelegate.Routine_Detailrf.EntryDate]]))
						{
							appDelegate.SaveMenstural=TRUE;
							appDelegate.objUserViewController.SelectedIndex=1;
							[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
							appDelegate.objUserViewController.UserDate=[appDelegate.DateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@",appDelegate.Routine_Detailrf.EntryDate,appDelegate.Routine_Detailrf.EntryTime]];
							
							[self.navigationController pushViewController:appDelegate.objUserViewController animated:YES];
							[Pool release];
							return;
						}
						if([appDelegate.Mensturalref.Daily_EndDate isEqualToString:[NSString stringWithFormat:@"%@ %@",appDelegate.Routine_Detailrf.EntryDate,appDelegate.Routine_Detailrf.EntryTime]])
						{
							appDelegate.objUserViewController.isEndDisabled=TRUE;
						}
						if([appDelegate.Mensturalref.Daily_EndDate length]==0)
						{
							appDelegate.objUserViewController.isEndDisabled=TRUE;
						}
						//if([appDelegate.Mensturalref.EndDate length]>0 && (![appDelegate.Mensturalref.Daily_EndDate isEqualToString:[NSString stringWithFormat:@"%@ %@",appDelegate.Routine_Detailrf.EntryDate,appDelegate.Routine_Detailrf.EntryTime]]))
						if([appDelegate.Mensturalref.EndDate length]>0 && difference>0)
						{
														
							[appDelegate.Mensturalref ClearData];
							appDelegate.Mensturalref.User_ID=appDelegate.SelectedUserID;
							appDelegate.Mensturalref.Daily_Date=Date;
							appDelegate.SaveMenstural=FALSE; 
						}
						else
							appDelegate.SaveMenstural=TRUE;
					}
					else
					{
						if(!appDelegate.Mensturalref)
						{
							appDelegate.Mensturalref=[[Menstural_Cycle alloc]init];
						}
						else
						{
							[appDelegate.Mensturalref ClearData];
						}
						appDelegate.Mensturalref.User_ID=appDelegate.SelectedUserID;
						appDelegate.Mensturalref.Daily_Date=Date;
						appDelegate.SaveMenstural=FALSE; 
					}
					
					appDelegate.objUserViewController.SelectedIndex=1;
					[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
					appDelegate.objUserViewController.UserDate=[appDelegate.DateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@",appDelegate.Routine_Detailrf.EntryDate,appDelegate.Routine_Detailrf.EntryTime]];
					
					[self.navigationController pushViewController:appDelegate.objUserViewController animated:YES];					
				}
				else
				{
					//// Edit Vitals Entry
					[[UIDevice currentDevice] setOrientation:UIInterfaceOrientationPortrait];
					if(!appDelegate.objUserViewController)
					{
						appDelegate.objUserViewController=[[UserViewController alloc]initWithNibName:@"UserSelect" bundle:nil];
					}					
					[appDelegate SelectVitalsDetail:Date  AndTime:DateTime andUserID:appDelegate.SelectedUserID];					
					if([appDelegate.DailyArray count]>0)
					{
						appDelegate.Vitals_Detailref =[appDelegate.DailyArray objectAtIndex:0];
					}
					else
					{
						if(!appDelegate.Vitals_Detailref)
						{
							appDelegate.Vitals_Detailref=[[Vitals_Detail alloc]init];
						}
						else
						{
							[appDelegate.Vitals_Detailref ClearData];
						}
						appDelegate.Vitals_Detailref.User_ID1=appDelegate.SelectedUserID;
						appDelegate.Vitals_Detailref.EntryDate=Date;
						appDelegate.Vitals_Detailref.EntryTime=[NSString stringWithFormat:@"%@",DateTime];						
					}
					appDelegate.objUserViewController.SelectedIndex=0;
					[appDelegate.DateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
					appDelegate.objUserViewController.UserDate=[appDelegate.DateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@",appDelegate.Vitals_Detailref.EntryDate,appDelegate.Vitals_Detailref.EntryTime]];
					
					[self.navigationController pushViewController:appDelegate.objUserViewController animated:YES];				
				}				
			}
		}
		}
	}
	tblView.userInteractionEnabled=TRUE;	
	[Pool release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Button Click Events.
//// Called When Click Edit Button

-(IBAction)btnEdit_Click:(id)sender
{
	if(appDelegate.ISEdit==TRUE)
	{
		appDelegate.ISEdit=FALSE;
		btnEdit.style=UIBarButtonItemStyleBordered;
		btnEdit.title=@"Edit ";
		lblFooter.frame=CGRectMake(23, 0, 130, 30);
		lblHeader.text=@"";
	}
	else
	{
		btnEdit.style=UIBarButtonItemStyleDone;
		btnEdit.title=@"Done";
		appDelegate.ISEdit=TRUE;
		lblHeader.frame=CGRectMake(23, -2, 130, 15);
		lblFooter.frame=CGRectMake(23, 13, 130, 15);
		lblHeader.text=@"Tap on the cell to edit";
	}
}

- (void)dealloc
{	
	[tblView release];
	[viewHeader release];
    [super dealloc];
}

@end