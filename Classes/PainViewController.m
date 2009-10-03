//
//  PainViewController.m
//  hLog
//
//  Created by MAC02 on 5/19/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import "PainViewController.h"


@implementation PainViewController

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
/// Called when click on save button
-(IBAction)btnSave_Clicked:(id)sender
{
	//if([txtPain.text length]>0)
	{
		[txtPain resignFirstResponder];
		appDelegate.Vitals_Detailref.Pain=[NSString stringWithFormat:@"%@",txtPain.text]; 
		appDelegate.Vitals_Detailref.Magnitude=[lblMagnitude.text intValue];
		[self.navigationController popViewControllerAnimated:YES];	
	}
}

/// Called when click on cancel button
-(IBAction)btnCancel_Clicked:(id)sender
{
	[txtPain resignFirstResponder];
	[self.navigationController popViewControllerAnimated:YES];
}

//// Called when change Slider value
-(IBAction)sliderEvent:(id)sender
{
	int value = MagnitudeSlider.value;
	lblMagnitude.text=[NSString stringWithFormat:@"%d",value];
	NSLog(@"%d",value);
}

-(BOOL)keyboardInput:(id)k shouldInsertText:(id)i isMarkedText:(int)b 
{
	int len=[txtPain.text length];
	if(len<35)
	{	
		return YES;
	}
	else
	{
		return NO;
	}
	return YES;
}

#pragma mark View Methods

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	self.navigationItem.title=@"Pain";
	self.navigationItem.rightBarButtonItem=btnSave;
	self.navigationItem.leftBarButtonItem=btnCancel;
	appDelegate=[[UIApplication sharedApplication]delegate];
	txtPain.delegate=self;
	MagnitudeSlider.minimumValue = 1;
	MagnitudeSlider.maximumValue = 10;
	MagnitudeSlider.value = 0;
	txtPain.font=[UIFont boldSystemFontOfSize:16];
	[MagnitudeSlider setContinuous:YES];
	self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
	UILabel *lblHeader=[[UILabel alloc]init];
	lblHeader.frame=CGRectMake(0, 21, 320, 21);
	lblHeader.text=@"Magnitude of pain";
	lblHeader.numberOfLines=0;
	lblHeader.textAlignment=UITextAlignmentCenter;
	lblHeader.textColor=[UIColor colorWithRed:0.3019 green:0.3450 blue:0.4274 alpha:1.0];
	lblHeader.font=[UIFont systemFontOfSize:18];
	[self.view addSubview:lblHeader];
	lblHeader.backgroundColor=[UIColor clearColor];
	lblHeader.shadowColor = [UIColor whiteColor];
	lblHeader.shadowOffset = CGSizeMake(0.0, 1.0);
	[lblHeader release];
	
	UILabel *lblLocation=[[UILabel alloc]init];
	lblLocation.frame=CGRectMake(0, 105, 320, 21);
	lblLocation.text=@"Location of pain";
	lblLocation.numberOfLines=0;
	lblLocation.textAlignment=UITextAlignmentCenter;
	lblLocation.textColor=[UIColor colorWithRed:0.3019 green:0.3450 blue:0.4274 alpha:1.0];
	lblLocation.font=[UIFont systemFontOfSize:18];
	[self.view addSubview:lblLocation];
	lblLocation.backgroundColor=[UIColor clearColor];
	lblLocation.shadowColor = [UIColor whiteColor];
	lblLocation.shadowOffset = CGSizeMake(0.0, 1.0);
	[lblLocation release];
    [super viewDidLoad];
}

// Called when the view is about to made visible. Default does nothing
- (void)viewWillAppear:(BOOL)animated
{	
	lblMagnitude.text=[NSString stringWithFormat:@"%d",appDelegate.Vitals_Detailref.Magnitude];
	txtPain.text=appDelegate.Vitals_Detailref.Pain;
	if(appDelegate.Vitals_Detailref.Magnitude==0)
	{
		MagnitudeSlider.value=1;
	}
	else
		MagnitudeSlider.value=appDelegate.Vitals_Detailref.Magnitude;	
	
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
