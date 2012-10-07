	//
	//  SFTabViewAppDelegate.m
	//  SFTabView
	//
	//  Created by Matteo Rattotti on 5/10/10.
	//  Copyright 2010 Shiny Frog. All rights reserved.
	//

#import "SFTabViewAppDelegate.h"



@interface ShroudWindow : BaseModel
@property (nonatomic, retain) NSString* windowClass;
@property (nonatomic, retain) NSString* viewClass;
@property (weak) IBOutlet id win;
@property (weak) IBOutlet id view;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, assign) NSRect upFrame;
@property (nonatomic, assign) NSRect dnFrame;

+ (instancetype) instanceWithClass:(Class)class named:(NSString*)name;
@end



@implementation ShroudWindow
+ (instancetype) instanceWithClass:(Class)class named:(NSString*)name{
	ShroudWindow* new = [super instance];
	new.windowClass = class;
	new.name = name;
	return new;
}
@end

@interface SFTabViewAppDelegate ()

@property (weak) IBOutlet ShroudWindow *leveler;
@property (weak) IBOutlet ShroudWindow *shroud;
@property (weak) IBOutlet ShroudWindow *window;
//@property (weak) ShroudWindow *windowLeveler;
//@property (weak) ShroudWindow *windowLeveler;
//@property (nonatomic, assign) IBOutlet NSWindow *windowLeveler;
//@property (nonatomic, assign) IBOutlet NSView *beveledEdge;
//@property (nonatomic, assign) IBOutlet NSImageView *shroudImage;
//@property (nonatomic, assign) IBOutlet TransparentWindow *shroud;
//@property (nonatomic, assign) IBOutlet TransparentWindow *window;
@end
@implementation SFTabViewAppDelegate
{
	NSTimer *refreshWhileActiveTimer;
	NSRect unPushedScreenRect,pushedScreenRect, barFrame, barFrameUp, visible, flippedSnapRect;
}
@synthesize tabView;
//window = _window, shroudImage = _shroudImage, , shroud = _shroud, beveledEdge = _beveledEdge;


- (void) awakeFromNib {
//	self.shroud = [
// 	NSArray *windows = @[ @{ @"NSWindow": _leveler}, @{ @"TransparentWindow":_shround } ,@{ @"TransparentWindow": _window } ]:
//	[windows each:^( obj, NSUInteger index, BOOL *stop) {
//	_leveler = [ShroudWindow instanceWithClass:[NSWindow class] named:@"leveler"];
//	_shroud = [ShroudWindow instanceWithClass:[TransparentWindow class] named:@"shroud"];
//	_leveler = [ShroudWindow instanceWithClass:[TransparentWindow class] named:@"window"];
	[_leveler.win setClass:[NSWindow class]];
	_leveler.name = @"leveler";
//	_shroud = [ShroudWindow instanceWithClass:[TransparentWindow class] named:@"shroud"];
//	_leveler = [ShroudWindow instanceWithClass:[TransparentWindow class] named:@"window"
//	@[ , _shroudImage, _shroud, _window]
//	[each:^(id obj, NSUInteger index, BOOL *stop) {
//	] each  each:^(id obj, NSUInteger index, BOOL *stop) {
//		obj[@"delegate"] = self;
//		obj[@"ba/ckgroundColor"] = CLEAR;
//		[self set]
//		[obj orderFront:obj];
//	}];
	[self defineRects];
	[_leveler.win orderFrontRegardless];
	[_leveler.win setFrame:NSMakeRect(0, (ScreenHighness()-1),1,1) display:YES animate:NO];


	[_leveler.win setLevel: 0];

	[_shroud.win setLevel : 14 ];

	[_shroud.win setIgnoresMouseEvents:YES];
	[_window.win setLevel:14];


//	[NSEvent addGlobalMonitorForEventsMatchingMask:NSLeftMouseDownMask handler:^(NSEvent *e) {
//		if ( NSPointInRect([NSEvent mouseLocation], _shroud.frame) ) {
//			[_shroud fadeOut];
//				//			[[_shroud nextResponder] mouseDown:e];
//		}
//	}];

}

- (void) capture {

	[self defineRects];
//	visiNow.size.height -= offset;
//	visiNow.origin.y +=offset;
//		visible.size.height -= window.frame.size.height;
	[(NSImageView*)_shroud.view setImage : [NSImage imageFromCGImageRef:
						  CGWindowListCreateImage(
												  flippedSnapRect,
												  kCGWindowListOptionOnScreenBelowWindow,
												  [_leveler.win windowNumber],
												  kCGWindowImageDefault ) ]];
	if ([[NSApplication sharedApplication]isActive]) {
		[_shroud.view setNeedsDisplay : YES];
		[_shroud.win setFrame:pushedScreenRect display:YES];
		[_shroud.win setFrame:pushedScreenRect display:YES];
	}
}

	//	CFMutableArrayRef windowIDs = CFArrayCreateMutable(NULL, 0, NULL);
	//    CFArrayRef allWindowIDs = CGWindowListCreate(<#CGWindowListOption option#>, <#CGWindowID relativeToWindow#>)
	//	kCGWindowListOptionOnScreenBelowWindow | kCGWindowListOptionIncludingWindow |kCGWindowListOptionOnScreenBelowWindow, kCGNormalWindowLevelKey);
	////    NSLog(@"min window level: %d", kCGMinimumWindowLevel);
	////    NSLog( @"looking for windows on level: %d", kCGNormalWindowLevelKey );
	////    NSLog( @"NOt actually looking for windows on level: %d", kCGMinimumWindowLevel );
	////    NSLog( @"NOt actually looking for windows on the dock level: %d", kCGDockWindowLevel );
	//    if (allWindowIDs) {
	//        CFArrayRef windowDescs = CGWindowListCreateDescriptionFromArray(allWindowIDs);
	//        for (CFIndex idx=0; idx<CFArrayGetCount(windowDescs); idx++)
	//        {
	//            CFDictionaryRef dict = CFArrayGetValueAtIndex(windowDescs, idx);
	//            CFStringRef ownerName = CFDictionaryGetValue(dict, kCGWindowOwnerName);
	//            NSLog(@"owner name = %@", ownerName);
	//            if (CFStringCompare(ownerName, CFSTR("Dock"), 0) == kCFCompareEqualTo)
	//            {
	//					// the Dock level has the dock and the desktop picture
	//                CGRect windowBounds;
	//                BOOL success = CGRectMakeWithDictionaryRepresentation(
	//																	  (CFDictionaryRef)(CFDictionaryGetValue(dict, kCGWindowBounds)),
	//																	  &windowBounds);
	//
	//                NSRect screenBounds = [NSScreen mainScreen].frame;
	//                CFNumberRef windowLayer = CFDictionaryGetValue(dict, kCGWindowLayer);
	//
	//					//CFDictionaryGetValue(dict, kCGWindowBounds)
	//                NSLog(@"window bounds %f, %f, matches screen bounds? %d, on level %@",
	//                      windowBounds.size.width,
	//                      windowBounds.size.height,
	//                      CGRectEqualToRect(windowBounds, screenBounds),
	//                      windowLayer
	//                      );
	//
	//                NSNumber* ourDesiredLevelNumber = [NSNumber numberWithInt: kCGDesktopWindowLevel - 1];  // Desktop Window level must mean "icons" ??? WD-rpw 04-22-2012
	//                if ( CGRectEqualToRect(windowBounds, screenBounds) && [ourDesiredLevelNumber isEqualToNumber: windowLayer] )
	//                    CFArrayAppendValue(windowIDs, CFArrayGetValueAtIndex(allWindowIDs, idx));
	//            }
	//
	//        }
	//        CFRelease(windowDescs);
	//        CFRelease(allWindowIDs);
	//    }
	//	CGImageRef windowImage = CGWindowListCreateImage(imageBounds, singleWindowListOptions, windowID, imageOptions);
	//    CGImageRef cgImage = CGWindowListCreateImageFromArray( [NSScreen mainScreen].frame, windowIDs, kCGWindowImageDefault);
	//
	//		// Create a bitmap rep from the image...
	//    NSBitmapImageRep *bitmapRep = [[NSBitmapImageRep alloc] initWithCGImage:cgImage];
	//		// Create an NSImage and add the bitmap rep to it...
	//    NSImage *image = [[NSImage alloc] init];
	//    [image addRepresentation:bitmapRep];
/* Create an image containing a composite of the specified set of windows
 contained within a rectangular area. The set of windows is specified
 using options from `CGWindowListOption', along with an optional
 additional window ID.

 The windows list options are:

 --- kCGWindowListOptionAll, kCGWindowListOptionOnScreenOnly: Use all
 on-screen windows in this user session to construct the image. The
 parameter `windowID' should be `kCGNullWindowID'.

 --- kCGWindowListOptionOnScreenAboveWindow: Use all on-screen windows in
 this user session above the window specified by `windowID', ordered from
 front to back, to construct the image. To include the window specified by
 `windowID', add the flag `kCGWindowListOptionIncludingWindow'.

 --- kCGWindowListOptionOnScreenBelowWindow: Use all on-screen windows in
 this user session below the window specified by `windowID', ordered from
 front to back, to construct the image. To include the window specified by
 `windowID', add the flag `kCGWindowListOptionIncludingWindow'.

 --- kCGWindowListOptionIncludingWindow: Use only the window specified by
 `windowID' to construct the image.

 The parameter `screenBounds' specifies the rectangle in screen space
 (origin at the upper-left; y-value increasing downward). Setting
 `screenBounds' to `CGRectInfinite' will include all the windows on the
 entire desktop. Setting `screenBounds' to `CGRectNull' will use the
 bounding box of the specified windows as the screen space rectangle.

 The parameter `imageOptions' allows you to specify whether the window
 frame ornamentation, such as a shadow or similar effect, should be
 included or excluded in the bounds calculation when `CGRectNull' is
 specified for the window bounds.

 If no windows meet the specified criteria, or the windows can't be read,
 then a transparent black image will be returned.

 Any on-screen window with sharing type `kCGWindowSharingNone' will not
 be included in the image.

 This function returns NULL if the caller is not running within a Quartz
 GUI session or the window server is disabled. */

	//	CG_EXTERN CGImageRef CGWindowListCreateImage(CGRect screenBounds,
	//												 CGWindowListOption listOption, CGWindowID windowID,
	//												 CGWindowImageOption imageOption)


	
	//    CGImageRef imageRef =	CGDisplayCreateImage(kCGDirectMainDisplay);

	//	CGImageRef imageRef =
	//												  kCGWindowListOptionOnScreenBelowWindow, win, kCGWindowImageShouldBeOpaque);
	//	//visiNow, kCGWindowListOptionOnScreenBelowWindo,NULL);
	//	CGImageRef imageRef = CGDisplayCreateImageForRect(kCGDirectMainDisplay, visiNow);
	//	CGImageRef 	imageRef = CGWindowListCreateImage(visiNow, kCGWindowListOptionOnScreenBelowWindow,[self windowLevelerID],NULL);

	//imageRef];
	//	CFRelease(imageRef);
	//	[[NSImage alloc]initWithCGImage:imageRef size:NSZeroSize];
	//	CGFloat trimOff = tabView.frame.size.height + 22;

	//	NSImage *shrouder = [[NSImage alloc] initWithSize:visible];
	//	[shrouder lockFocus];
	//	[image drawAtPoint:NSZeroPoint fromRect:AZMakeRectFromSize(visible) operation:NSCompositeCopy fraction:1];
	////	[[GREEN colorWithAlphaComponent:.4] set];
	////	NSRectFillUsingOperation(AZMakeRectFromSize(visible), NSCompositeSourceAtop);
	//	[shrouder unlockFocus];
	//	[shrouder saveAs:@"/Users/localadmin/Desktop/shroud.png"];
	//    return image;
//}

/*-(CGWindowID) windowLevelerID {

	return (CGWindowID) [[NSWindow windowNumbersWithOptions:NSWindowNumberListAllApplications] filterOne:^BOOL(id object) {
		NSWindow *test = [[NSApplication sharedApplication]windowWithWindowNumber:[object unsignedIntegerValue]];
		if (test) {
			if (  [test isKindOfClass:[NSWindow class]] ) {
				if ([[test identifier] isEqualToString:@"Leveler"]) {
					NSLog(@"found leveler!  %@", test);
					return YES;
				} else return NO;
			} else return  NO;
		} else return NO;
	}];
}
*/
- (void) applicationWillResignActive:(NSNotification *)notification {

 	[refreshWhileActiveTimer invalidate];
	[NSAnimationContext beginGrouping];
	[[_window.win animator]setFrame:barFrameUp display:YES animate:YES];
	[[_shroud.win animator]setFrame:unPushedScreenRect display:YES animate:YES];
	[NSAnimationContext endGrouping];
	refreshWhileActiveTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(capture) userInfo:nil repeats:YES];

}
- (void) applicationDidResignActive:(NSNotification *)notification{

	[@[_window.win, _shroud.win] az_each:^(id obj, NSUInteger index, BOOL *stop) {
		if ([obj isVisible]) [obj fadeOutWithDuration:.001];
	}];
	[_shroud.win setFrame:unPushedScreenRect  display:NO animate:NO];
	_shroudState = ShroudIsUp;
}

- (void)defineRects{

	flippedSnapRect = AZScreenFrame();

	float offset = ([[NSApplication sharedApplication]isActive] ?
					22 : (22 + 46) );
	flippedSnapRect.size.height -= offset;
	flippedSnapRect.origin.y += offset;

	unPushedScreenRect = AZMakeRect((NSPoint){0,  ScreenHighness() - ( 22 + 46)},(NSSize){ ScreenWidess(), 0 });
	pushedScreenRect  = AZMakeRect(NSZeroPoint, (NSSize){ ScreenWidess(),ScreenHighness() - ( 22 + 46)});
	barFrame = AZMakeRectMaxXUnderMenuBarY(46);
	barFrameUp = barFrame;
	barFrameUp.origin.y += 46;//tabView.frame.size.height;
	barFrameUp.size.height = 0;
}
- (IBAction) setShroudState:(ShroudIs)shroudState{
	_shroudState = shroudState;
		if (_shroudState == ShroudIsDown) {
			[self applicationWillBecomeActive:nil];
//		}
//		[sender setState:NSOnState];
//
	} else {
		[self applicationWillResignActive:nil];
//[sender setState:NSOffState];

	}
}

- (void) applicationWillBecomeActive:(NSNotification *)notification{

	if (refreshWhileActiveTimer) 	[refreshWhileActiveTimer invalidate];
	[_window.win setFrame:barFrameUp display:YES];
	[_shroud.win setFrame:unPushedScreenRect display:YES];
}
- (void) applicationDidBecomeActive:(NSNotification *)notification {
		//	[_shroud setAlphaValue:1];
//	[self performSelectorOnMainThread:@selector(capture) withObject:nil waitUntilDone:YES];
	[NSThread performBlockInBackground:^{
		[self capture];
		[[NSThread mainThread] performBlock:^{

			[_shroud.win orderFrontRegardless];
			[_window.win orderFrontRegardless];
			[NSAnimationContext beginGrouping];
			[[_window.win animator]setFrame:barFrame display:YES animate:YES];
			[[_shroud.win animator]setFrame:pushedScreenRect display:YES animate:YES];
			[NSAnimationContext endGrouping];
		} waitUntilDone:YES];
	}];

	refreshWhileActiveTimer = [NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(capture) userInfo:nil repeats:YES];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	__block NSArray *thradedArray;
	[NSThread performBlockInBackground:^{
		thradedArray = [AZFolder appFolder];//[AtoZ dockSorted];
		[[NSThread mainThread] performBlock:^{
			[thradedArray az_each:^(AZFile * obj, NSUInteger index, BOOL *stop) {
				number++;
				[tabView addTabWithRepresentedObject: obj];//@{ @"name": obj.name }];
			}];

		}waitUntilDone:YES];
	}];

	[_window.win setBackgroundColor:RED];
	tabView.delegate = self;
    tabView.tabOffset = -15;
    tabView.startingOffset = 20;
	number = 1;


}

- (void) removeTab: (id) sender {
	--number;
	[tabView removeTab:[tabView selectedTab]];
}

- (void) addTab: (id) sender {
	++number;
	[tabView addTabWithRepresentedObject:sender];//@{@"name": [NSString stringWithFormat:@"%d", number]}];
	[tabView selectTab:[tabView lastTab]];
}

- (void)tabView:(SFTabView *)tabView didAddTab:(CALayer *)tab {
}

- (void)tabView:(SFTabView *)tabView didRemovedTab:(CALayer *)tab {
}

- (BOOL)tabView:(SFTabView *)tabView shouldSelectTab:(CALayer *)tab {
    return YES;
}

- (void)tabView:(SFTabView *)tabView didSelectTab:(CALayer *)tab {

	NSLog(@"%@", [RuntimeReporter methodNamesForClass:[AtoZ class]]);
//	id d = [AtoZ sharedInstance];
	AZFile *w = (AZFile*)[(SFDefaultTab*)tab representedObject];
	[AtoZ performSelector:@selector(jsonRequest:) withObject:$(@"http://api.alternativeto.net/software/%@/?count=5&platform=mac", w.name)];
//	[AtoZ jsonReq
//	[[AtoZ sharedInstance] performSelector:@selector(jsonRequest:) withObject:$(@"http://api.alternativeto.net/software/%@/?count=5&platform=mac", w.name)];
//	NSLog(@"JSON: %@", ff);
}

- (void)tabView:(SFTabView *)tabView willSelectTab:(CALayer *)tab {
}
@end
