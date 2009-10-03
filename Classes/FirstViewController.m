//
//  FirstViewController.m
//  hLog
//
//  Created by Bhoomi on 3/30/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import "FirstViewController.h"
#import "CalendarTableViewCell1.h"
#define title_Array [NSArray arrayWithObjects: @"Personal Information",@"Medical History",@"Health Care Providers",@"Insurance Information",nil]

#define FirstString @"Hello,\n\nThank you for using hLog. The application has attached your requested health log to this email.\n\nPlease note that this is an automated system generated email. Your privacy is important to us and so the data has not been read by anyone and is not stored online.\n\n"
#define SecondString @"Replies to this email will go to an unmonitored email address. If you have any questions, please feel free to contact us at comments@4thmainsoftware.com instead. Please visit us at www.hlogapp.com for further information.\n\nRegards,\nhLog Team\n\n"
#define ThirdString @"PS: You can open the attachment in any application that can read spreadsheets like Microsoft Excel, Google Docs, Open Office Calc etc."
@implementation FirstViewController

#pragma mark View Methods
// Called after the view has been loaded. For view controllers created in code, this is after -loadView. For view controllers unarchived from a nib, this is after the view is set.
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	self.navigationItem.title=@"Health Tracker";
	tblView.delegate=self;
	tblView.dataSource=self;
	self.navigationController.navigationBar.barStyle= UIBarStyleBlackOpaque; 
	tblView.rowHeight=50;
	appDelegate=[[UIApplication sharedApplication]delegate];
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Back";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];
	dateFormatter=[[NSDateFormatter alloc]init];
	[dateFormatter setDateFormat:@"MMM_dd_yyyy"];
//	toolbar.tintColor=[UIColor blackColor];
    [super viewDidLoad];
}

// Called when the view is about to made visible. Default does nothing
- (void)viewWillAppear:(BOOL)animated
{	
	if(appDelegate.isForMail==FALSE)
	{
		self.navigationItem.rightBarButtonItem=nil;
		//[appDelegate.AddNewUserDict retain];
		//if(self.User_ID>0)
//		{
//			[appDelegate selectUserdata:self.User_ID];
//		}
		if([appDelegate.UserArray count] == 0)
		{
			self.navigationItem.hidesBackButton=TRUE;
		}
		else
		{
			self.navigationItem.hidesBackButton=FALSE;
		}	
		self.navigationItem.title=appDelegate.UserStatus;		
	}
	else
	{
		self.navigationItem.rightBarButtonItem=btnSend;
		self.navigationItem.title=@"Export Data";		
	}
	lblmessage.text=@"";
	activity.hidden=TRUE; 
	[tblView reloadData];
}

//// Check Internet Available ot Not..

-(BOOL) checkInternetConnection
{
	NSString *requestString =@"";
	NSData *requestData = [NSData dataWithBytes: [requestString UTF8String] length: [requestString length]];
	NSMutableURLRequest *request1 = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString:@"http://www.google.com"]];
	[request1 setTimeoutInterval:10];
	[request1 setHTTPMethod: @"POST"];
	[request1 setHTTPBody: requestData];
	return [ NSURLConnection sendSynchronousRequest: request1 returningResponse: nil error: nil ]!=nil;
}

#pragma mark ButtonClick Events
/// Called when call send button
-(IBAction)btnSend_Click:(id)sender
{
	if([[appDelegate.RegistrationDic valueForKey:@"Contact_Info"] length]!=0 || [appDelegate.NewTableArray count]>0)
	{
		if(![self checkInternetConnection])
		{
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Internet connection is not available."
																message:nil
															   delegate:self
													  cancelButtonTitle:nil
													  otherButtonTitles:@"Ok", nil];
			
			[alertView show];
			[alertView release];
			return;
		}	
		for(int i=0;i<[appDelegate.NewTableArray count];i++)
		{
			NSString *toeamil=[NSString stringWithFormat:@"%@",[appDelegate.NewTableArray objectAtIndex:i]];//[toeamil stringByAppendingFormat:[NSString stringWithFormat:@"%@,",[arr1 objectAtIndex:i]]];
			activity.hidden = FALSE;
			[activity startAnimating];
			lblmessage.hidden = FALSE;
			lblmessage.text = @"Please wait...Connecting to the server to send email";
			
			self.navigationItem.hidesBackButton = TRUE;
			[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
			
			SKPSMTPMessage *testMsg = [[SKPSMTPMessage alloc] init];
			
			testMsg.fromEmail = [appDelegate.RegistrationDic valueForKey:@"From E-Mail"];
			testMsg.toEmail = toeamil;
			
			testMsg.relayHost = [appDelegate.RegistrationDic valueForKey:@"SMTP Host"] ;
			testMsg.requiresAuth = YES;
			testMsg.login = [appDelegate.RegistrationDic valueForKey:@"From E-Mail"] ;
			testMsg.pass =[appDelegate.RegistrationDic valueForKey:@"Password"];
			testMsg.subject = @"Your hLog Records";
			testMsg.wantsSecure = YES;			
			testMsg.delegate = self;
			isSendSuccessfull=FALSE;
			
			time=[NSTimer scheduledTimerWithTimeInterval:120 target:self selector:@selector(StopMail) userInfo:nil repeats:NO];		
			
			//NSData *data=[[NSData alloc]initWithContentsOfFile:strSource];
			NSString *str3=[NSString stringWithFormat:@"%@%@%@",FirstString,SecondString,ThirdString];
			NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
									   str3 ,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];	
			
			NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
			NSString *documentsDirectory = [paths objectAtIndex:0];
			NSString *filePath = [documentsDirectory stringByAppendingPathComponent: @"myPDF.csv"];
			
			NSData *vcfData=[[NSData alloc]initWithContentsOfFile:filePath];
			NSString *date=[dateFormatter stringFromDate:[NSDate date]];
			NSDictionary *vcfPart = [NSDictionary dictionaryWithObjectsAndKeys:[NSString  stringWithFormat:@"text/directory;\r\n\tx-unix-mode=0644;\r\n\tname=\"hLog_%@.csv\"",date],kSKPSMTPPartContentTypeKey,
									 [NSString  stringWithFormat:@"attachment;\r\n\tfilename=\"hLog_%@.csv\"",date],kSKPSMTPPartContentDispositionKey,[vcfData encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];
			
			testMsg.parts = [NSArray arrayWithObjects:plainPart,vcfPart,nil];
			//testMsg.parts = [NSArray arrayWithObjects:plainPart,nil];
			[testMsg send];
		}
		NSArray *TMPARRAY=[[appDelegate.RegistrationDic valueForKey:@"Contact_Info"] componentsSeparatedByString:@"\n"];
		for(int i=0;i<[TMPARRAY count];i++)
		{
			BOOL ISValidEmail=FALSE;
			NSArray *Arr=[[TMPARRAY objectAtIndex:i] componentsSeparatedByString:@"@"];
			if([Arr count]>1 && [[Arr objectAtIndex:0]length]!=0)
			{
				NSArray *arr2=[[Arr objectAtIndex:1]  componentsSeparatedByString:@"."];
				if([arr2 count]>1)
				{
					ISValidEmail=TRUE;
				}
			}
			if(ISValidEmail)
			{
				NSString *toeamil=[NSString stringWithFormat:@"%@",[TMPARRAY objectAtIndex:i]];//[toeamil stringByAppendingFormat:[NSString stringWithFormat:@"%@,",[arr1 objectAtIndex:i]]];
				activity.hidden = FALSE;
				[activity startAnimating];
				lblmessage.hidden = FALSE;
				lblmessage.text = @"Please wait...Connecting to the server to send email";
				
				self.navigationItem.hidesBackButton = TRUE;
				[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
				
				SKPSMTPMessage *testMsg = [[SKPSMTPMessage alloc] init];
				
				testMsg.fromEmail = [appDelegate.RegistrationDic valueForKey:@"From E-Mail"];
				testMsg.toEmail = toeamil;
				
				testMsg.relayHost = [appDelegate.RegistrationDic valueForKey:@"SMTP Host"] ;
				testMsg.requiresAuth = YES;
				testMsg.login = [appDelegate.RegistrationDic valueForKey:@"From E-Mail"] ;
				testMsg.pass =[appDelegate.RegistrationDic valueForKey:@"Password"];
				testMsg.subject = @"Your hLog Records";
				testMsg.wantsSecure = YES;			
				testMsg.delegate = self;
				isSendSuccessfull=FALSE;
				
				time=[NSTimer scheduledTimerWithTimeInterval:120 target:self selector:@selector(StopMail) userInfo:nil repeats:NO];		
				
				//NSData *data=[[NSData alloc]initWithContentsOfFile:strSource];
				NSString *str3=[NSString stringWithFormat:@"%@%@%@",FirstString,SecondString,ThirdString];
				NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
										   str3 ,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];	
				
				NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
				NSString *documentsDirectory = [paths objectAtIndex:0];
				NSString *filePath = [documentsDirectory stringByAppendingPathComponent: @"myPDF.csv"];
				
				NSData *vcfData=[[NSData alloc]initWithContentsOfFile:filePath];
				NSString *date=[dateFormatter stringFromDate:[NSDate date]];
				NSDictionary *vcfPart = [NSDictionary dictionaryWithObjectsAndKeys:[NSString  stringWithFormat:@"text/directory;\r\n\tx-unix-mode=0644;\r\n\tname=\"hLog_%@.csv\"",date],kSKPSMTPPartContentTypeKey,
										 [NSString  stringWithFormat:@"attachment;\r\n\tfilename=\"hLog_%@.csv\"",date],kSKPSMTPPartContentDispositionKey,[vcfData encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];
				
				testMsg.parts = [NSArray arrayWithObjects:plainPart,vcfPart,nil];
				//testMsg.parts = [NSArray arrayWithObjects:plainPart,nil];
				[testMsg send];
			}
		}
		
	}
	else
	{
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
															message:@"Select a contact who should be the recipient of the report."
														   delegate:self
												  cancelButtonTitle:nil
												  otherButtonTitles:@"Ok", nil];
		
		[alertView show];
		[alertView release];
	}
}

-(void)StopMail
{
	if(!isSendSuccessfull)
	{
		self.navigationItem.hidesBackButton = FALSE;
		[activity stopAnimating];
		activity.hidden = TRUE;
		lblmessage.text = @"Email Sending Fail!";
		[[UIApplication sharedApplication] endIgnoringInteractionEvents];
	}
}

#pragma mark Mail Validation Message 
/// Called when Mail sending is Succed
- (void)messageSent:(SKPSMTPMessage *)message
{
	self.navigationItem.hidesBackButton = FALSE;
	[activity stopAnimating];
	activity.hidden = TRUE;
	isSendSuccessfull=TRUE;
	[time invalidate];
	time=nil;
	lblmessage.text = @"Email has been sent. Please check your bulk/junk email folders in case you do not see the email in your inbox!";
	[[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

/// Called when Mail sending is fail
- (void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error
{
	self.navigationItem.hidesBackButton = FALSE;
	[activity stopAnimating];
	activity.hidden = TRUE;
	isSendSuccessfull=TRUE;
	lblmessage.text =@"Failed to send Email. Please try again";
	[time invalidate];
	time=nil;
	[[UIApplication sharedApplication] endIgnoringInteractionEvents];
	[message release];
}

#pragma mark Table view methods
// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if(appDelegate.isForMail==FALSE)
	{
		return 1;
	}
	else
	{
		return 2;
	}
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	if(appDelegate.isForMail==FALSE)
	{
		return 4;
	}
	else
	{
		if(section==0)
			return [appDelegate.NewTableArray count]+1;
		else
			return 1;
	}
}

/// Return Height Base on text
-(CGFloat)findHeightForCell:(NSString *)text
{
	CGFloat		result = 45.0f;
	CGFloat		width = 0;
	
	width = 250;
	// fudge factor
	if (text)
	{
		CGSize		textSize = { width, 20000.0f };		// width and height of text area
		CGSize		size = [text sizeWithFont:[UIFont boldSystemFontOfSize:14.0f] constrainedToSize:textSize lineBreakMode:UILineBreakModeCharacterWrap];
		
		size.height += 25.0f;			// top and bottom margin
		result = MAX(size.height, 44.0f);	// at least one row		
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
	if(appDelegate.isForMail==FALSE)
	{
		return 45;
	}
	else
	{
		if(indexPath.section==1)			
		{
			//NSLog(@"%f",[self findHeightForCell:[appDelegate.RegistrationDic valueForKey:@"Contact_Info"]]);
			return [self findHeightForCell:[appDelegate.RegistrationDic valueForKey:@"Contact_Info"]];
		}
		else 
		{			
			return 45;
		}	
	}
	return 45;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if(appDelegate.isForMail==FALSE)
	{
		static NSString *CellIdentifier = @"Cell";
		UITableViewCell *cell =(UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		}
		//// For edit and Insert User
		cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
		cell.indentationLevel = 1;
		cell.textColor=[UIColor colorWithRed:0.317 green:0.4 blue:0.56 alpha:1.0];
		cell.text=[title_Array objectAtIndex:indexPath.row];
		cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
		return cell;
	}
	else
	{
		/// For insert new email address for sending mail
		
		static NSString *CellIdentifier1 = @"Cell1";
		CalendarTableViewCell1 *cell1 =(CalendarTableViewCell1 *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
		if (cell1 == nil) {
			cell1 = [[[CalendarTableViewCell1 alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier1] autorelease];
		}	
		cell1.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
		cell1.indentationLevel = 0;
		//cell1.text.font=[UIFont boldSystemFontOfSize:14];
		cell1.lblName.textColor=[UIColor colorWithRed:0.317 green:0.4 blue:0.56 alpha:1.0];
		
		if(indexPath.section==1)
		{			
			if([[appDelegate.RegistrationDic valueForKey:@"Contact_Info"] length]!=0)
			{
				cell1.lblName.text=[appDelegate.RegistrationDic valueForKey:@"Contact_Info"];
			}
			else
			{
				cell1.lblName.text=@"Select Contact";
			}
		}
		else
		{
			if(indexPath.row==[appDelegate.NewTableArray count])
			{
				cell1.lblName.text=@"Add New";
			}
			else
			{
				cell1.lblName.text=[appDelegate.NewTableArray objectAtIndex:indexPath.row];
			}
		}
		cell1.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
		return cell1;
	}
	return nil;
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tblView deselectRowAtIndexPath:indexPath animated:YES];
	if(appDelegate.isForMail==FALSE)
	{
		//// Called when add/Edit New User
		NSAutoreleasePool *Pool=[[NSAutoreleasePool alloc]init];
		NSLog(@"User ID %@",[appDelegate.AddNewUserDict valueForKey:@"UserID"]);
		if([[appDelegate.AddNewUserDict valueForKey:@"UserID"]intValue]==0 && (indexPath.row==1 || indexPath.row==2 || indexPath.row==3))
		{
			UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Fill the details in personal information first" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
		else
		{
			if(indexPath.row==2 || indexPath.row==3)
			{
				if(!appDelegate.objSelectViewController)
					appDelegate.objSelectViewController=[[SelectViewController alloc]initWithNibName:@"SelectViewController" bundle:nil];
				appDelegate.ISFromFirstViewController=TRUE;
				appDelegate.objSelectViewController.SelectedIndexRow=indexPath.row;
				appDelegate.objSelectViewController.USER_ID=[[appDelegate.AddNewUserDict valueForKey:@"UserID"]intValue];
				[self.navigationController pushViewController:appDelegate.objSelectViewController animated:YES];
			}
			else
			{
				if(!AddNewUser)
				{
					AddNewUser=[[AddNewUserController alloc]initWithNibName:@"AddNewUser" bundle:nil];
				}
				AddNewUser.SelectedIndexRow=indexPath.row;
				AddNewUser.Name=[title_Array objectAtIndex:indexPath.row];
				AddNewUser.BackUpDict=[appDelegate.AddNewUserDict mutableCopy];
				[self.navigationController pushViewController:AddNewUser animated:YES];
			}
		}
		[Pool release];
	}
	else
	{		
		//// Call when We want to select Contact User or Add Email Address
		if(indexPath.section==0)
		{
			appDelegate.SelectedStatus=@"Contact";
			if(!appDelegate.objUserTextEntryViewController)
			{
				appDelegate.objUserTextEntryViewController=[[UserTextEntryViewController alloc]initWithNibName:@"TextEntry" bundle:nil];
			}	
			if(indexPath.row==[appDelegate.NewTableArray count])
			{
				appDelegate.objUserTextEntryViewController.selectedIndex=-1;				
				appDelegate.objUserTextEntryViewController.TextData=@"";
			}
			else
			{
				appDelegate.objUserTextEntryViewController.selectedIndex=indexPath.row;			
				appDelegate.objUserTextEntryViewController.TextData=[appDelegate.NewTableArray objectAtIndex:indexPath.row];
			}
			appDelegate.objUserTextEntryViewController.selectedName=@"Add Contact";
			[self.navigationController pushViewController:appDelegate.objUserTextEntryViewController animated:YES];
		}
		else
		{
			if(!objContactViewController)
			{
				objContactViewController=[[ContactViewController alloc]initWithNibName:@"ContactViewController" bundle:nil];
			}
			[self.navigationController pushViewController:objContactViewController animated:YES];
		}
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
	
	[tblView release];
    [super dealloc];
}

@end
