//
//  AZTabViewAppDelegate.m
//  AZTabView
//
//  Created by Alex Gray on 7/6/12.
//  Copyright (c) 2012 mrgray.com, inc. All rights reserved.
//

#import "AZTabViewAppDelegate.h"

@implementation AZTabViewAppDelegate
@synthesize window, tabView, colorBar;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	tabView.delegate = self;
    tabView.tabOffset = -15;
    tabView.startingOffset = 20;
	
    [tabView addTabWithRepresentedObject:[NSDictionary dictionaryWithObject:@"One" forKey:@"name"]];
    
	number = 1;
}

- (void) removeTab: (id) sender {
	--number;
	
	[tabView removeTab:[tabView selectedTab]];
}

- (void) addTab: (id) sender {
	++number;
	[tabView addTabWithRepresentedObject:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d", number] forKey:@"name"]];
	[tabView selectTab:[tabView lastTab]];
}

- (void)tabView:(AZTabView *)tabView didAddTab:(CALayer *)tab {
}

- (void)tabView:(AZTabView *)tabView didRemovedTab:(CALayer *)tab {
}

- (BOOL)tabView:(AZTabView *)tabView shouldSelectTab:(CALayer *)tab {
    return YES;
}

- (void)tabView:(AZTabView *)tabView didSelectTab:(CALayer *)tab {
}

- (void)tabView:(AZTabView *)tabView willSelectTab:(CALayer *)tab {
}
@end
