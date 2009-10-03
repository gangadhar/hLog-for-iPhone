//
//  ContactViewController.h
//  hLog
//
//  Created by MAC02 on 7/20/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthTrackerAppDelegate.h"
#import <AddressBook/AddressBook.h>
//#import "SelectViewController.h"
//#import "Contact.h"

@interface ContactViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>{

	
	NSMutableArray *list;
	IBOutlet UITableView *tableViewContacts;
	HealthTrackerAppDelegate *appDelegate;
	IBOutlet UIBarButtonItem *Save;
	IBOutlet UIBarButtonItem *cancel;
	NSString *selectedemail;
	int row;
	int Section;
	NSMutableDictionary *ContactDIC;
	NSMutableDictionary *MailDic;
	NSMutableDictionary *Selectarray;
	NSMutableArray *Arr;
	NSMutableArray *Arr1;
}

-(IBAction)save_Click:(id)sender;
-(IBAction)cancel_Click:(id)sender;
-(void)getContacts;
@end
