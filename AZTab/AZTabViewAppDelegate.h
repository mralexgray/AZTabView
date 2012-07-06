//
//  AZTabViewAppDelegate.h
//  AZTabView
//
//  Created by Alex Gray on 7/6/12.
//  Copyright (c) 2012 mrgray.com, inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "AZTabView.h"
#import <AtoZ/AtoZ.h>


@interface AZTabViewAppDelegate : NSObject 
<NSWindowDelegate, NSApplicationDelegate, AZTabViewDelegate> 
{		int number;
	
}
@property (nonatomic, retain) IBOutlet AZTabView *colorBar;
@property (nonatomic, retain) IBOutlet NSWindow *window;
@property (nonatomic, retain) IBOutlet AZTabView *tabView;

- (void) removeTab: (id) sender;
- (void) addTab: (id) sender;

@end
