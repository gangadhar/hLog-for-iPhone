//
//  EnterPasscodeViewController.m
//  hLog
//
//  Created by Bhoomi on 3/18/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import "EnterPasscodeViewController.h"


@implementation EnterPasscodeViewController
@synthesize Flag;

#pragma mark ButtonClick Methods

//// Calld when click on Save button and also check enter passcode valid or not
-(IBAction)btnSave_click:(id)sender
{
	[SelectedText resignFirstResponder];
	if(self.Flag==TRUE) //// Is for change passcode
	{
		if([txtPassword.text length]==4 && [txtRetypePassword.text length]==4 && [txtOldPassword.text length]==4) /// All have complasury 4 length
		{
			if([[[NSUserDefaults standardUserDefaults] valueForKey:@"PasscodeNo"] isEqualToString:txtOldPassword.text]) //// If equal then 
			{
				if([txtPassword.text isEqualToString:txtRetypePassword.text]) /// check for old or new are same or not
				{
					[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",1] forKey:@"Passcode"];
					[[NSUserDefaults standardUserDefaults] synchronize];
					
					[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",txtPassword.text] forKey:@"PasscodeNo"];
					[[NSUserDefaults standardUserDefaults] synchronize];
					
					[self.navigationController popViewControllerAnimated:YES];
				}
				else /// if no then show messahr
				{
					UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"New passcode and confirm passcode must be same!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
					alert.tag=2;
					[alert show];
					[alert release];
					
				}
			}
			else 
			{
				UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Incorrect passcode entered. Please enter the correct passcode." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				alert.tag=4;
				[alert show];
				[alert release];
			}
		}
		else
		{
				UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"All the three passcode fields are compulsory, Passcode must contain four characters!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				alert.tag=3;
				[alert show];
				[alert release];
		}
	}
	else
	{		
		if([txtPassword.text length]==4 && [txtRetypePassword.text length]==4) 
		{
			if([[NSUserDefaults standardUserDefaults] valueForKey:@"PasscodeNo"]==nil)
			{
				if([txtPassword.text isEqualToString:txtRetypePassword.text]) // For checking passcode and confirm passcode are same ot not...
				{
					[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",1] forKey:@"Passcode"];
					[[NSUserDefaults standardUserDefaults] synchronize];
					
					[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",txtPassword.text] forKey:@"PasscodeNo"];
					[[NSUserDefaults standardUserDefaults] synchronize];
					
					[self.navigationController popViewControllerAnimated:YES];
				}
				else
				{
					UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Both passcodes must be same!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
					alert.tag=2;
					[alert show];
					[alert release];					
				}
			}
		}
		else
		{		
			if([txtRetypePassword.text length]==0 && [txtPassword.text length]==0)
			{
				UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Passcode and retype passcode, both are compulsory and must be of four characters!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				alert.tag=3;
				[alert show];
				[alert release];
			}
			else if([txtRetypePassword.text length]==0)
			{
				UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Passcode should have four digits only" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				alert.tag=3;
				[alert show];
				[alert release];
			}			
			else if([txtPassword.text length]==0)
			{
				UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Passcode must have four characters!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				alert.tag=3;
				[alert show];
				[alert release];
			}
			else
			{
				UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Both must have four characters!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				alert.tag=3;
				[alert show];
				[alert release];
			}
		}		
	}
}

#pragma mark AlertView Delegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(alertView.tag==1)
	{
		[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",1] forKey:@"Passcode"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
		[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",txtPassword.text] forKey:@"PasscodeNo"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
		[self.navigationController popViewControllerAnimated:YES];
	}
	else if(alertView.tag!=5)
	{
		if(self.Flag==TRUE)
		{
			[txtOldPassword becomeFirstResponder];
		}
		else
			[txtPassword becomeFirstResponder];
		txtPassword.text=@"";
		txtOldPassword.text=@"";
		txtRetypePassword.text=@"";
	}
}

#pragma mark View Methods
// Called after the view has been loaded. For view controllers created in code, this is after -loadView. For view controllers unarchived from a nib, this is after the view is set.
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	txtPassword.delegate=self;
	txtRetypePassword.delegate=self;
	txtOldPassword.delegate=self;
	txtPassword.secureTextEntry=YES;
	txtRetypePassword.secureTextEntry=YES;
	txtOldPassword.secureTextEntry=YES;
	txtPassword.tag=1;
	txtRetypePassword.tag=2;
	txtOldPassword.tag=3;
	txtPassword.keyboardType=UIKeyboardTypeNumberPad;
	txtRetypePassword.keyboardType=UIKeyboardTypeNumberPad;
	txtOldPassword.keyboardType=UIKeyboardTypeNumberPad;
	txtPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
	txtRetypePassword.clearButtonMode = UITextFieldViewModeWhileEditing;
	txtOldPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
	self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
	self.navigationItem.rightBarButtonItem=btnSave;
	appDelegate=[[UIApplication sharedApplication]delegate];
	lblPassword.textAlignment=UITextAlignmentRight;
	lblOldPassword.textAlignment=UITextAlignmentRight;
	txtPassword.keyboardType=UIKeyboardTypeNumberPad;
	txtRetypePassword.keyboardType=UIKeyboardTypeNumberPad;
	txtOldPassword.keyboardType=UIKeyboardTypeNumberPad;	
	txtOldPassword.keyboardAppearance=UIKeyboardAppearanceAlert; 
	txtRetypePassword.keyboardAppearance=UIKeyboardAppearanceAlert; 
	txtPassword.keyboardAppearance=UIKeyboardAppearanceAlert; 
	lblRetypePassword.textAlignment=UITextAlignmentRight;
    [super viewDidLoad];
}

// Called when the view is about to made visible. Default does nothing
- (void)viewWillAppear:(BOOL)animated
{
	txtPassword.text=@"";
	txtOldPassword.text=@"";
	txtRetypePassword.text=@"";
	if(self.Flag==TRUE)
	{
		self.navigationItem.title=@"Change Passcode";
		txtOldPassword.hidden=FALSE;
		lblOldPassword.hidden=FALSE;	
		lblPassword.text=@"New Passcode";
		lblRetypePassword.text=@"Confirm Passcode";
		lblOldPassword.text=@"Old Passcode";
		txtPassword.frame=CGRectMake(200, 85 ,90, 30);
		txtRetypePassword.frame=CGRectMake(200, 135, 90, 30);
		txtOldPassword.frame=CGRectMake(200, 35, 90, 30);
		lblOldPassword.frame=CGRectMake(7, 30, 190, 35);
		lblPassword.frame=CGRectMake(7, 80, 190, 35);
		lblRetypePassword.frame=CGRectMake(7, 130, 190, 35);		
		[txtOldPassword becomeFirstResponder];
	}
	else
	{
		self.navigationItem.title=@"Passcode";
		txtOldPassword.hidden=TRUE;
		lblOldPassword.hidden=TRUE;		
		txtPassword.frame=CGRectMake(200, 45, 90, 30);
		txtRetypePassword.frame=CGRectMake(200, 120, 90, 30);			
		lblPassword.frame=CGRectMake(7, 42, 190, 35);
		lblRetypePassword.frame=CGRectMake(7, 117, 190, 35);
		[txtPassword becomeFirstResponder];
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
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark textField

-(BOOL)keyboardInput:(id)k shouldInsertText:(id)i isMarkedText:(int)b 
{
	char s=[i characterAtIndex:0];
	if(s!=10)
	{
		int len=[SelectedText.text length];
		
			if(len<4)
			{	
				return YES;
			}
			else
			{
				return NO;
			}
		}
	return NO;
}

 // return NO to disallow editing.
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	SelectedText=textField;
	SelectedText.keyboardType=UIKeyboardTypeNumberPad;
	return YES;
}

 // called when 'return' key pressed. return NO to ignore.
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

- (void)dealloc
{	
	[txtPassword release];
	[txtRetypePassword release];
	[txtOldPassword release];	
	[lblPassword release];
	[lblRetypePassword release];
	[lblOldPassword release];
	[btnSave release];
	[SelectedText release];	
    [super dealloc];
}


@end
