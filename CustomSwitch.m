//
//  CustomSwitch.m
//  hLog
//
//  Created by Bhoomi on 3/28/09.
//  Copyright 2009 4th Main Software Inc. All rights reserved.
//

#import "CustomSwitch.h"

@interface _UISwitchSlider : UIView
@end

@implementation CustomSwitch


- (_UISwitchSlider *) slider { 
	return [[self subviews] lastObject]; 
}
- (UIView *) textHolder { 
	return [[[self slider] subviews] objectAtIndex:2]; 
}
- (UILabel *) leftLabel { 
	return [[[self textHolder] subviews] objectAtIndex:0]; 
}
- (UILabel *) rightLabel { 
	return [[[self textHolder] subviews] objectAtIndex:1]; 
}
- (void) setLeftLabelText: (NSString *) labelText { 
	[[self leftLabel] setText:labelText]; 
}
- (void) setRightLabelText: (NSString *) labelText { 
	[[self rightLabel] setText:labelText]; 
}

@end
