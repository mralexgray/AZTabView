//
//  SFTabViewAppDelegate.h
//  SFTabView
//
//  Created by Matteo Rattotti on 5/10/10.
//  Copyright 2010 Shiny Frog. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AtoZ/AtoZ.h>
#import "SFTabView.h"
#import "SFDefaultTab.h"

typedef enum { 	ShroudIsUp, ShroudIsDown} ShroudIs;

@class TransparentWindow;
@interface SFTabViewAppDelegate : NSObject <NSApplicationDelegate, SFTabViewDelegate, NSWindowDelegate, SFDefaultTabDelegate> {
	int number;

	
}
//@property (assign) NSRect 	pushedScreenRect;
//@property (assign) NSRect 	unPushedScreenRect;
//@property (assign) NSRect 	barFrame;
//@property (assign) NSRect 	barFrameUp;

@property (nonatomic, retain) IBOutlet SFTabView *tabView;

@property (assign) ShroudIs shroudState;

- (IBAction) toggleActive:(id)sender;
- (IBAction) removeTab: (id) sender;
- (IBAction) addTab: (id) sender;

@end
