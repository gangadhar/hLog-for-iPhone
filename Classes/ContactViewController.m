//
//  ContactViewController.m
//  hLog
//
//  Created by MAC02 on 7/20/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import "ContactViewController.h"
#import "CalendarTableViewCell1.h"

@implementation ContactViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

#pragma mark View Methods
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

	self.title =@"Contacts";
	self.view.backgroundColor = tableViewContacts.backgroundColor;
	
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Back";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];
	
	if(!list)
	{
		list=[[NSMutableArray alloc]init];
	}	
	if(!Selectarray)
	{
		Selectarray=[[NSMutableDictionary alloc]init];
	}
	Arr=[[NSMutableArray alloc]init];
	Arr1=[[NSMutableArray alloc]init];
	MailDic=[[NSMutableDictionary alloc]init];
	appDelegate=[[UIApplication sharedApplication]delegate];
	tableViewContacts.rowHeight = 44;
	tableViewContacts.delegate=self;
	tableViewContacts.dataSource=self;
	self.navigationItem.rightBarButtonItem=Save;
 	self.navigationItem.backBarButtonItem=cancel;
	[super viewDidLoad];
}

// Called when the view is about to made visible. Default does nothing
-(void)viewWillAppear:(BOOL)animated
{	
	[list removeAllObjects];
	[Selectarray removeAllObjects];
	[MailDic removeAllObjects];
	[Arr removeAllObjects];
	[Arr1 removeAllObjects];
	appDelegate =[[UIApplication sharedApplication]delegate];
	[self getContacts];
	row=-1;
	Section=-1;
	[tableViewContacts reloadData];
}

//// Get Contacts from iPhone Contacts 
-(void)getContacts
{
	ABAddressBookRef addressBook = ABAddressBookCreate();	
	NSMutableArray *addresses = (NSMutableArray *) ABAddressBookCopyArrayOfAllPeople(addressBook);
	NSInteger addressesCount = [addresses count];	
	
	for (int i = 0; i < addressesCount; i++) {	
		ABRecordRef record = [addresses objectAtIndex:i];	
		NSString *firstName = [(NSString *)ABRecordCopyValue(record, kABPersonFirstNameProperty) capitalizedString];
		NSString *lastName = (NSString *)ABRecordCopyValue(record, kABPersonLastNameProperty);
		ABMultiValueRef emailAdd=ABRecordCopyValue(record, kABPersonEmailProperty);
		NSString *emailAddress=@"";
		
		if(ABMultiValueGetCount(emailAdd)>0)
		{
			int Count=ABMultiValueGetCount(emailAdd);
			NSMutableArray *array=[[NSMutableArray alloc]init];
			NSMutableArray *Tmparray=[[NSMutableArray alloc]init];
			for(int i=0;i<Count;i++)
			{
				[array addObject:(NSString *)ABMultiValueCopyValueAtIndex(emailAdd, i)];	
				[Tmparray addObject:@"0"];	
			}
			[MailDic setObject:[array mutableCopy] forKey:[NSString stringWithFormat:@"%d",ABRecordGetRecordID(record)]];
			[Selectarray setObject:[Tmparray mutableCopy] forKey:[NSString stringWithFormat:@"%d",ABRecordGetRecordID(record)]];
			emailAddress=(NSString *)ABMultiValueCopyValueAtIndex(emailAdd, 0);
			[array release];
			[Tmparray release];
		}
		NSString *contactFirstLast=@"";
		if(firstName!=nil && lastName==nil)
		{
			contactFirstLast = [NSString stringWithFormat: @"%@",firstName];
		}
		else if(firstName==nil && lastName!=nil)
		{
			contactFirstLast = [NSString stringWithFormat: @"%@",lastName];
		}
		else if(firstName!=nil && lastName!=nil)
		{
			contactFirstLast = [NSString stringWithFormat: @"%@ %@", firstName, lastName];
		}
		
		if([emailAddress length]>0)
		{
			ContactDIC=[[NSMutableDictionary alloc]init];
			[ContactDIC setValue:contactFirstLast forKey:@"contactName"];
			[ContactDIC setValue:emailAddress forKey:@"contactEmail"];
			[ContactDIC setValue:[NSString stringWithFormat:@"%d",ABRecordGetRecordID(record)]  forKey:@"contactUniqueID"];
			[list addObject:[ContactDIC mutableCopy]];
			[ContactDIC release];
		}
	}
	///// Set then in alphabetical order
	NSSortDescriptor *firstNameSorter = [[[NSSortDescriptor alloc] initWithKey:@"contactName" ascending:YES] autorelease];
	[list sortUsingDescriptors:[NSArray arrayWithObject:firstNameSorter]];

}	

#pragma mark Table View Delegate  
// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	if([list count]==0)
		return 1;
	return [list count];
	
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	if([list count]==0)
		return 0;
	NSDictionary *DIC=[list objectAtIndex:section];
	NSArray *Tmparr=[MailDic objectForKey:[DIC valueForKey:@"contactUniqueID"]];
	return [Tmparr count];
}


// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
	CalendarTableViewCell1 *cell =(CalendarTableViewCell1 *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[CalendarTableViewCell1 alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	
	NSDictionary *DIC=[list objectAtIndex:indexPath.section];
	cell.accessoryType=UITableViewCellAccessoryNone;
	
	cell.lblName.textAlignment=UITextAlignmentLeft;
	NSArray *Tmparr=[MailDic objectForKey:[DIC valueForKey:@"contactUniqueID"]];
	NSArray *Tmparr1=[Selectarray objectForKey:[DIC valueForKey:@"contactUniqueID"]];
	cell.lblName.text=[Tmparr objectAtIndex:indexPath.row];
	if([[Tmparr1 objectAtIndex:indexPath.row]intValue]==0)
	{
		cell.accessoryType=UITableViewCellAccessoryNone; 
	}
	else
	{
		cell.accessoryType=UITableViewCellAccessoryCheckmark; 
	}
	
	return cell;
}

 // fixed font style. use custom view (UILabel) if you want something different
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if(tableView==tableViewContacts)
	{
		if([list count]==0)
			return @"";
		NSDictionary *DIC=[list objectAtIndex:section];
		return [DIC valueForKey:@"contactName"];
	}
	return nil;
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSDictionary *DIC=[list objectAtIndex:indexPath.section];
	
	NSMutableArray *Tmparr1=[Selectarray objectForKey:[DIC valueForKey:@"contactUniqueID"]];
	if([[Tmparr1 objectAtIndex:indexPath.row]intValue]==0)
	{
		[Tmparr1 replaceObjectAtIndex:indexPath.row withObject:@"1"];
	}
	else
	{
		[Tmparr1 replaceObjectAtIndex:indexPath.row withObject:@"0"];
	}
	[tableViewContacts reloadData];
}


#pragma mark Button Click Evwnts
//// Called when click on Save Button
-(IBAction)save_Click:(id)sender
{
	for(int i=0;i<[list count];i++)
	{
		NSDictionary *DIC=[list objectAtIndex:i];
		NSArray *Tmparr=[MailDic objectForKey:[DIC valueForKey:@"contactUniqueID"]];
		NSArray *Tmparr1=[Selectarray objectForKey:[DIC valueForKey:@"contactUniqueID"]];
		for(int j=0;j<[Tmparr1 count];j++)
		{
			if([[Tmparr1 objectAtIndex:j]intValue]==1)
			{
				[Arr addObject:[Tmparr objectAtIndex:j]];
			}
		}
	}
	selectedemail=@"";
	for(int i=0;i<[Arr count];i++)
	{
		if(i==([Arr count]-1))
		{
			selectedemail=[selectedemail stringByAppendingString:[NSString stringWithFormat:@"%@",[Arr objectAtIndex:i]]];
			
		}
		else
		{
			selectedemail=[selectedemail stringByAppendingString:[NSString stringWithFormat:@"%@\n",[Arr objectAtIndex:i]]];
			
		}
	}
	[appDelegate.RegistrationDic setValue:selectedemail forKey:@"Contact_Info"];
	[self.navigationController popViewControllerAnimated:YES];
}

//// Called when click on cancel Button
-(IBAction)cancel_Click:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
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
