//
//  AZTabViewAppDelegate.m
//  AZTabView
//
//  Created by Alex Gray on 7/6/12.
//  Copyright (c) 2012 mrgray.com, inc. All rights reserved.
//

#import "AZTabViewAppDelegate.h"

@implementation AZTabViewAppDelegate {
	NSArray *rainbow;
}
@synthesize window, tabView, colorBar;

- (void) awakeFromNib {
	tabView.defaultTabClassName = @"AZDefaultTab";
	colorBar.defaultTabClassName = @"AZColorBar";
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	tabView.delegate = self;
    tabView.tabOffset = -15;
    tabView.startingOffset = 20;
//    [tabView addTabWithRepresentedObject:[NSDictionary dictionaryWithObject:@"One" forKey:@"name"]];
	number = 0;
	
	[NSApp activateIgnoringOtherApps:YES];
	[window setDelegate: self];
	[window makeKeyAndOrderFront:window];
	NSRect v, z;
	v = z = [[NSScreen mainScreen]frame];
	v.size.height = 169;
	v.origin.y = z.size.height -v.size.height - 22;		
	[window setFrame:v display:YES animate:NO];
	window.minSize = v.size;
	
	[[AtoZ dockSorted] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		AZFile *t = obj;
		[tabView addTabWithRepresentedObject:t];
		number++;
	}];		
	colorBar.tabOffset = -10;
	colorBar.startingOffset = 20;
	colorBar.defaultTabClassName = @"AZColorBar";
	rainbow = [[NSColor fengshui].reversed arrayUsingBlock:^id(id obj) {
		NSColor *g = obj;
		AZFile *t = [AZFile dummy];
		t.color = g;
		t.spot = 22;
		return t;
	}];
	[rainbow enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		AZFile *t = obj;
		[colorBar addTabWithRepresentedObject:t];
	}];

}

- (void) removeTab: (id) sender {
	--number;
	[tabView removeTab:[tabView selectedTab]];
}

- (void) addTab: (id) sender {
//	++number;
//	[tabView addTabWithRepresentedObject:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d", number] forKey:@"name"]];
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
