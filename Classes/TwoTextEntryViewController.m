//
//  TwoTextEntryViewController.m
//  hLog
//
//  Created by MAC02 on 7/30/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import "TwoTextEntryViewController.h"


@implementation TwoTextEntryViewController
@synthesize Index,HeaderLabel,SelectedIndex,strUnit,strQty;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

#pragma mark Button Click Events

-(IBAction)btnDone:(id)sender
{
	PickerView.hidden=TRUE;
	ToolBar.hidden=TRUE;
	if([appDelegate.NewTableArray count]==[PickerView selectedRowInComponent:0])
	{
		if(!appDelegate.objUserTextEntryViewController)
		{
			appDelegate.objUserTextEntryViewController=[[UserTextEntryViewController alloc]initWithNibName:@"TextEntry" bundle:nil];
		}	
		if([appDelegate.SelectedStatus isEqualToString:@"Feed_Data"])
		{
			appDelegate.objUserTextEntryViewController.selectedIndex=100;
			appDelegate.objUserTextEntryViewController.selectedName=@"Food Consumption Unit";
		}
		else if([appDelegate.SelectedStatus isEqualToString:@"Medicine_Data"])
		{
			appDelegate.objUserTextEntryViewController.selectedIndex=101;
			appDelegate.objUserTextEntryViewController.selectedName=@"Medicine Unit";
		}
		appDelegate.objUserTextEntryViewController.TextData=@"";		
		[self.navigationController pushViewController:appDelegate.objUserTextEntryViewController animated:YES];	
		
	}
	else
	{
		NSDictionary *DIC=[appDelegate.NewTableArray objectAtIndex:[PickerView selectedRowInComponent:0]];
		txtUnit.text=[DIC valueForKey:@"Name"];
	}
}


//// Called when click on Save Button
-(IBAction)btnSave:(id)sender
{
	if([txtQty.text length]>0 && [txtUnit.text length]>0)
	{
		[self StoreData];
		[self.navigationController popViewControllerAnimated:YES];
	}
}

//// Called when click on Cancel Button
-(IBAction)btnCancel:(id)sender
{
	if(self.Index==0)
	{
		[[NSNotificationCenter defaultCenter] postNotificationName:@"RemoveTick" object:nil];
	}
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark View Methods

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    appDelegate=[[UIApplication sharedApplication]delegate];	
	self.navigationItem.leftBarButtonItem=btnCancel;
	self.navigationItem.rightBarButtonItem=btnSave;
	txtQty.font=[UIFont systemFontOfSize:18];
	txtUnit.font=[UIFont systemFontOfSize:18];
	txtQty.keyboardAppearance=UIKeyboardAppearanceAlert; 
	txtQty.keyboardType=UIKeyboardTypeNumberPad;
	txtUnit.keyboardType=UIKeyboardTypeDefault;
	txtUnit.keyboardAppearance=UIKeyboardAppearanceAlert; 
	txtQty.autocorrectionType=UITextAutocorrectionTypeNo;
	txtUnit.autocorrectionType=UITextAutocorrectionTypeNo;
	PickerView.delegate=self;
	txtQty.delegate=self;
	txtUnit.delegate=self;
	txtQty.tag=1;
	txtUnit.tag=2;
	PickerView.frame=CGRectMake(0, 200, 320, 216);
	ToolBar.frame=CGRectMake(0, 200, 320, 44);
	ToolBar.tintColor=[UIColor blackColor];
	label1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 220, 30)];
	[label1 setFont:[UIFont boldSystemFontOfSize:15.0]];
	[label1 setBackgroundColor:[UIColor clearColor]];
	[label1 setTextAlignment:UITextAlignmentCenter];
 	[label1 setTextColor:[UIColor whiteColor]];
	txtQty.placeholder=@"Enter Quantity";
	txtUnit.placeholder=@"Enter Unit of Measure (ml, tsp, etc)";
	self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
	UILabel *lblData=[[UILabel alloc]init];
	lblData.frame=CGRectMake(3,13 , 250, 20);
	lblData.font=[UIFont systemFontOfSize:15];
	lblData.textColor=[UIColor whiteColor];
	lblData.backgroundColor=[UIColor clearColor];
	lblData.text=@"Select Unit of Measure";
	[ToolBar addSubview:lblData];
	[lblData release];
	[super viewDidLoad];
}

// Called when the view has been fully transitioned onto the screen. Default does nothing
-(void)viewDidAppear:(BOOL)animated
{	
	[txtQty becomeFirstResponder];
}

// Called when the view is dismissed, covered or otherwise hidden. Default does nothing
-(void)viewWillDisappear:(BOOL)animated
{
	[txtQty resignFirstResponder];	
}

// Called when the view is about to made visible. Default does nothing
- (void)viewWillAppear:(BOOL)animated
{
	txtQty.text=self.strQty;
	txtUnit.text=appDelegate.StrUnit;
	PickerView.hidden=TRUE;
	ToolBar.hidden=TRUE;
	self.navigationItem.hidesBackButton=TRUE;
	if([appDelegate.SelectedStatus isEqualToString:@"Feed_Data"])
	{
		[appDelegate SelectAllData:@"Feed_Unit"];
			txtQty.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
	}
	else
	{
		[appDelegate SelectAllData:@"Medicine_Unit"];
			txtQty.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
	}
	[label1 setText:self.HeaderLabel];
	self.navigationItem.titleView=label1;	
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if(SelectedText)
		[SelectedText resignFirstResponder];
	SelectedText=textField;
	PickerView.hidden=TRUE;
	ToolBar.hidden=TRUE;
	if(textField==txtUnit)
	{		
		PickerView.hidden=FALSE;
		ToolBar.hidden=FALSE;
		[PickerView reloadAllComponents];
		return NO;
	}
	return YES;
}

#pragma mark Text Field Delegate Methods

 // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
- (void)textFieldDidEndEditing:(UITextField *)textField
{
	if(SelectedText.tag==1)
		self.strQty=textField.text;
}

// called when 'return' key pressed. return NO to ignore.
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	return YES;
}

-(BOOL)keyboardInput:(id)k shouldInsertText:(id)i isMarkedText:(int)b 
{
	char s=[i characterAtIndex:0];
	if(s!=10)
	{
		int len=[txtQty.text length];
		if([appDelegate.SelectedStatus isEqualToString:@"Feed_Data"])
		{
			if(s==46 || (s>47 && s<58))
			{
				if(len<6)
				{	
					if(len<30)
					{
						BOOL ISEmail=FALSE;
						if([txtQty.text length]>0)
						{
							NSArray *arr=[txtQty.text componentsSeparatedByString:@"."];
							if([arr count]>1)
								ISEmail=TRUE;
							else
								ISEmail=FALSE;
						}
						else
							ISEmail=FALSE;
						if(s!=46)
							return YES;
						if(s==46 && ISEmail==FALSE)
						{
							ISEmail=TRUE;
							return YES;
						}
						else
							return NO;				
					}
					else
						return NO;
					return YES;
				}
				else
				{
					return NO;
				}
			}
		}
		else
		{
			if(s==46 || (s>47 && s<58))
			{
				if(len<6)
				{	
					if(len<30)
					{
						BOOL ISEmail=FALSE;
						if([txtQty.text length]>0)
						{
							NSArray *arr=[txtQty.text componentsSeparatedByString:@"."];
							if([arr count]>1)
								ISEmail=TRUE;
							else
								ISEmail=FALSE;
						}
						else
							ISEmail=FALSE;
						if(s!=46)
							return YES;
						if(s==46 && ISEmail==FALSE)
						{
							ISEmail=TRUE;
							return YES;
						}
						else
							return NO;				
					}
					else
						return NO;
					return YES;
				}
				else
				{
					return NO;
				}
			}
		}
	}
	return NO;
}


//////// Store text data into variable
-(void)StoreData
{
	if([appDelegate.SelectedStatus isEqualToString:@"Feed_Data"])
	{
		if(!DIC1)
			DIC1=[[[NSMutableDictionary alloc]init]retain];
		else
			[DIC1 removeAllObjects];
		[DIC1 setValue:txtQty.text forKey:@"Feed_Qty"];
		[DIC1 setValue:txtUnit.text forKey:@"Feed_Unit"];
		[DIC1 setValue:[NSString stringWithFormat:@"%d",self.SelectedIndex] forKey:@"Feed_ID"];
		[DIC1 setValue:self.strUnit forKey:@"Feed_Name"];
		[appDelegate.UnitDictionary setObject:[DIC1 mutableCopy] forKey:[NSString stringWithFormat:@"%d",self.SelectedIndex]];
	//	[DIC release];
	}
	else
	{
		if(!DIC1)
			DIC1=[[[NSMutableDictionary alloc]init]retain];
		else
			[DIC1 removeAllObjects];
		[DIC1 setValue:txtQty.text forKey:@"Med_Qty"];
		[DIC1 setValue:txtUnit.text forKey:@"Med_Unit"];
		[DIC1 setValue:[NSString stringWithFormat:@"%d",self.SelectedIndex] forKey:@"Med_ID"];
		[DIC1 setValue:self.strUnit forKey:@"Med_Name"];
		[appDelegate.UnitDictionary setObject:[DIC1 mutableCopy] forKey:[NSString stringWithFormat:@"%d",self.SelectedIndex]];
	//	[DIC release];
	}
}

#pragma mark Picker View Methods

// returns width of column and height of row for each component. 

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	
	return 240.0;
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pV
{
	return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pV numberOfRowsInComponent:(NSInteger)component
{	
	return [appDelegate.NewTableArray count]+1;
}

// these methods return either a plain UIString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse. 
// If you return back a different object, the old one will be released. the view will be centered in the row rect  

- (NSString *)pickerView:(UIPickerView *)pV titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if([appDelegate.NewTableArray count]==row)
	{
		return @"Add New";
	}
	else
	{
		NSDictionary *DIC=[appDelegate.NewTableArray objectAtIndex:row];
		return [DIC valueForKey:@"Name"];
	}
}	

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
