//
//  UnitsViewController.m
//  hLog
//
//  Created by Bhoomi on 3/30/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import "UnitsViewController.h"
#import "AddUserSegmentTableCell.h" 
#import "NewSwitchTableViewCell.h"
@implementation UnitsViewController

#pragma mark View Methods
// Called after the view has been loaded. For view controllers created in code, this is after -loadView. For view controllers unarchived from a nib, this is after the view is set.
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {	
	
	tblView.delegate=self;
	tblView.dataSource=self;
	tblView.rowHeight=40;
	tf=[[UITextField alloc]initWithFrame:CGRectMake(12,55, 260, 30)];
	appDelegate=[[UIApplication sharedApplication]delegate];
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Back";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];
    [super viewDidLoad];
}

// Called when the view is about to made visible. Default does nothing
- (void)viewWillAppear:(BOOL)animated
{	
	if(appDelegate.ISfromSettings==2)
		self.navigationItem.title=@"Passcode Settings";
	else
		self.navigationItem.title=@"Units";
	[tblView reloadData];
}

#pragma mark Table view methods
// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if(appDelegate.ISfromSettings==2)
	{
		return 2;
	}
	else
		return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if(appDelegate.ISfromSettings==2)
	{
		return 1;
	}
	else
		return 3;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	if(appDelegate.ISfromSettings==1)
	{
		static NSString *CellIdentifier = @"Cell";		
		AddUserSegmentTableCell *cell = (AddUserSegmentTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[AddUserSegmentTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		//	cell.hidesAccessoryWhenEditing = NO;
			[cell.BtnSelect  addTarget:self action:@selector(UnitCheck:) forControlEvents:UIControlEventValueChanged];
		}
		
		switch (indexPath.row) {
			case 0:
				cell.lblName.text=@"Weight";
				[cell.BtnSelect setTitle:@"Lbs"  forSegmentAtIndex:0];
				[cell.BtnSelect setTitle:@"Kgs"  forSegmentAtIndex:1];
				cell.BtnSelect.tag=indexPath.row;
				if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Weight"] isEqualToString:@"LBs"])
				{
					cell.BtnSelect.selectedSegmentIndex=0;
				}
				else
				{
					cell.BtnSelect.selectedSegmentIndex=1;
				}
				break;
			case 1:
				cell.lblName.text=@"Temperature";
				[cell.BtnSelect setTitle:@"º F"  forSegmentAtIndex:0];
				[cell.BtnSelect setTitle:@"º C"  forSegmentAtIndex:1];
				cell.BtnSelect.tag=indexPath.row;
				if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Temperature"] isEqualToString:@"F"])
				{
					cell.BtnSelect.selectedSegmentIndex=0;
				}
				else
				{
					cell.BtnSelect.selectedSegmentIndex=1;
				}
				break;
			case 2:
				cell.lblName.text=@"Height";
				[cell.BtnSelect setTitle:@"Feet"  forSegmentAtIndex:0];
				[cell.BtnSelect setTitle:@"Meter"  forSegmentAtIndex:1];
				cell.BtnSelect.tag=indexPath.row;
				if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Height"] isEqualToString:@"Inches"])
				{
					cell.BtnSelect.selectedSegmentIndex=0;
				}
				else
				{
					cell.BtnSelect.selectedSegmentIndex=1;
				}
				break;
			default:
				break;
		}
		cell.accessoryType=UITableViewCellAccessoryNone;
		return cell;
	}
	else
	{
		if(indexPath.section==0)
		{
			static NSString *CellIdentifier2 = @"Cell2";			
			NewSwitchTableViewCell *cell2 = (NewSwitchTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
			if (cell2 == nil) {
				cell2 = [[[NewSwitchTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier2] autorelease];
				[cell2.SwIsKid addTarget:self action:@selector(Clicked:) forControlEvents:UIControlEventValueChanged];		
			}
			cell2.lblName.text=@"Turn Passcode ON/OFF";	
			if([[[NSUserDefaults standardUserDefaults] valueForKey:@"Passcode"]intValue]==0)
			{
				[cell2.SwIsKid setOn:FALSE]; 
			}
			else
			{
				[cell2.SwIsKid setOn:TRUE]; 
			}			
			return cell2;
		}
		else
		{
			static NSString *CellIdentifier1 = @"Cell1";
			UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
			if (cell1 == nil) {
				cell1 = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier1] autorelease];
			}
			cell1.indentationLevel = 3.5;
			cell1.text = @"Change Passcode";
			cell1.textColor=[UIColor colorWithRed:0.317 green:0.4 blue:0.56 alpha:1.0];
			return cell1;
		}		
	}
	return @"";
}

//// Called When User click Set Unit
-(IBAction)UnitCheck:(id)sender
{
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	UISegmentedControl *SW=(UISegmentedControl*)sender;
	int SelectedTag=SW.tag;
	if(SelectedTag==0) ///// For Weigth
	{
		if(SW.selectedSegmentIndex==0)
		{
			[[NSUserDefaults standardUserDefaults] setObject:@"LBs" forKey:@"Weight"];
			[[NSUserDefaults standardUserDefaults] synchronize];
		}
		else
		{
			[[NSUserDefaults standardUserDefaults] setObject:@"Kgs" forKey:@"Weight"];
			[[NSUserDefaults standardUserDefaults] synchronize];
		}
	}
	else if(SelectedTag==1)  ///// For Temperature
	{
		if(SW.selectedSegmentIndex==0)
		{
			[[NSUserDefaults standardUserDefaults] setObject:@"F" forKey:@"Temperature"];
			[[NSUserDefaults standardUserDefaults] synchronize];
		}
		else
		{
			[[NSUserDefaults standardUserDefaults] setObject:@"C" forKey:@"Temperature"];
			[[NSUserDefaults standardUserDefaults] synchronize];
		}
	}
	else if(SelectedTag==2)  ///// For Height
	{
		if(SW.selectedSegmentIndex==0)
		{
			[[NSUserDefaults standardUserDefaults] setObject:@"Inches" forKey:@"Height"];
			[[NSUserDefaults standardUserDefaults] synchronize];
		}
		else
		{
			[[NSUserDefaults standardUserDefaults] setObject:@"Cms" forKey:@"Height"];
			[[NSUserDefaults standardUserDefaults] synchronize];
		}
	}
	[Pool release];
}


// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tblView deselectRowAtIndexPath:indexPath animated:YES];
	if(appDelegate.ISfromSettings==2)
	{
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		if(indexPath.section==1)
		{
			
			if([[NSUserDefaults standardUserDefaults] valueForKey:@"PasscodeNo"]!=nil)
			{
				if(!PasscodeSettingsView)
				{
					PasscodeSettingsView=[[EnterPasscodeViewController alloc]initWithNibName:@"Passcode" bundle:nil];
				}
				PasscodeSettingsView.Flag=YES;
				[self.navigationController pushViewController:PasscodeSettingsView animated:YES];
			}
			else
			{
				UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Set a passcode first!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				alert.tag=2;
				[alert show];
				[alert release];
			}
		}
		[Pool release];
	}
}

#pragma mark Button Click methods
-(IBAction)Clicked:(id)sender
{
	NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
	UISwitch *switchCon=(UISwitch *)sender;
	if(switchCon.on==NO)
	{
		[self termCondition];
	}
	else
	{	
		if(!PasscodeSettingsView)
		{
			PasscodeSettingsView=[[EnterPasscodeViewController alloc]initWithNibName:@"Passcode" bundle:nil];
		}
		PasscodeSettingsView.Flag=NO;
		[self.navigationController pushViewController:PasscodeSettingsView animated:YES];
	}
	[Pool release];
}

#pragma mark Call When Off passcode
//// Pop up alert view with Textbox
-(void)termCondition
{
	tf.contentMode=UIViewContentModeCenter;
	tf.font=[UIFont systemFontOfSize:15.5];
	tf.secureTextEntry=YES;
	tf.text=@"";
	[tf setDelegate:self];
	tf.autocorrectionType=UITextAutocorrectionTypeNo;
	tf.font=[UIFont systemFontOfSize:21];
	tf.returnKeyType=UIReturnKeyDone;
	tf.clearButtonMode = UITextFieldViewModeWhileEditing;
	tf.keyboardType=UIKeyboardTypeNumberPad;
	tf.borderStyle=UITextBorderStyleRoundedRect;
	tf.placeholder=@"Enter Passcode";	
	tf.keyboardAppearance=UIKeyboardAppearanceAlert; 
	alert1=[[UIAlertView alloc]initWithTitle:tf.placeholder message:@"\n\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok",nil];
	alert1.frame=CGRectMake(10, 10, 280, 250);
	[alert1 addSubview:tf];
	[alert1 bringSubviewToFront:tf];
	CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0.0, 100.0);
	[alert1 setTransform:myTransform];
	[alert1 show];
	alert1.tag=1;
	[tf becomeFirstResponder];	
	[alert1 release];	
}

/// Called when pressed OK
-(void)OK
{
	[tf resignFirstResponder];
	alert1.tag=1;
	[self alertView:alert1 clickedButtonAtIndex:1];
	[alert1 dismissWithClickedButtonIndex:1 animated:NO];	 	
}

#pragma mark AlertView Delegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	
	if(alertView.tag==1)
	{
		if(buttonIndex == 1)
		{		
			NSString *Passcode=[[NSUserDefaults standardUserDefaults] valueForKey:@"PasscodeNo"];
			NSLog(tf.text);
			if([Passcode isEqualToString:tf.text])
			{
				[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",0] forKey:@"Passcode"];
				[[NSUserDefaults standardUserDefaults] synchronize];
				[[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"PasscodeNo"];
				[[NSUserDefaults standardUserDefaults] synchronize];
			}
			else
			{
				UIAlertView *alert3=[[UIAlertView alloc]initWithTitle:@"" message:@"Incorrect passcode entered. Please enter the correct passcode." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				alert3.tag=5;
				[alert3 show];
				[alert3 release];
			}
			
		}
		else
			[tblView reloadData];
	}
	if(alertView.tag==5)
	{
		tf.text=@"";
		[self termCondition]; 
	}
}

#pragma mark TextField Entry methods

-(BOOL)keyboardInput:(id)k shouldInsertText:(id)i isMarkedText:(int)b 
{
	char s=[i characterAtIndex:0];
	if(s!=10)
	{
		int len=[tf.text length];
		if(len<4)
		{	
			if(len==3)
			{
				[NSTimer scheduledTimerWithTimeInterval:(0.2)  target:self selector:@selector(OK) userInfo:nil repeats:NO];
			}
			return YES;
		}
		else
		{			
			return NO;
		}
	}
	return NO;
}		


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc 
{
	[tblView release];
    [super dealloc];
}

@end