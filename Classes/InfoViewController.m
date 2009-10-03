//
//  InfoViewController.m
//  hLog
//
//  Created by MAC02 on 5/19/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import "InfoViewController.h"


@implementation InfoViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

// Called after the view has been loaded. For view controllers created in code, this is after -loadView. For view controllers unarchived from a nib, this is after the view is set.
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	self.navigationItem.title=@"Information";	
	self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [super viewDidLoad];
}


/// Called when click on Link
-(IBAction)btnLink_Click:(id)sender
{
	[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"mailto:comments@4thmainsoftware.com"]];
}

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
