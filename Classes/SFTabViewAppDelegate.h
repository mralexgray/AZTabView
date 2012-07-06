//
//  SFTabViewAppDelegate.h
//  SFTabView
//
//  Created by Matteo Rattotti on 5/10/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SFTabView.h"

@interface SFTabViewAppDelegate : NSObject <NSApplicationDelegate, SFTabViewDelegate> {	
	int number;
	
}

@property (nonatomic, retain) IBOutlet NSWindow *window;
@property (nonatomic, retain) IBOutlet SFTabView *tabView;


- (void) removeTab: (id) sender;
- (void) addTab: (id) sender;

@end
