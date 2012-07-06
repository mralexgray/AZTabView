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
    NSWindow *__unsafe_unretained window;
    IBOutlet SFTabView *tabView;
	
	int number;
	
}

@property (unsafe_unretained) IBOutlet NSWindow *window;

- (void) removeTab: (id) sender;
- (void) addTab: (id) sender;

@end
