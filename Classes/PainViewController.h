//
//  PainViewController.h
//  hLog
//
//  Created by MAC02 on 5/19/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthTrackerAppDelegate.h"

@interface PainViewController : UIViewController <UITextFieldDelegate>{

	IBOutlet UITextField *txtPain;
	IBOutlet UIBarButtonItem *btnSave;
	IBOutlet UIBarButtonItem *btnCancel;
	HealthTrackerAppDelegate *appDelegate;
	IBOutlet UISlider *MagnitudeSlider;
	IBOutlet UILabel *lblMagnitude;
	IBOutlet UIImageView *imgSmlie;
	IBOutlet UIImageView *imgCrying;
}

-(IBAction)btnSave_Clicked:(id)sender;
-(IBAction)btnCancel_Clicked:(id)sender;
-(IBAction)sliderEvent:(id)sender;
@end
