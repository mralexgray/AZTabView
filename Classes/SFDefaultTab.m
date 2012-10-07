//
//  SFDefaultTab.m
//  tabtest
//
//  Created by Matteo Rattotti on 2/28/10.
//  Copyright 2010 www.shinyfrog.net. All rights reserved.
//

#import "SFDefaultTab.h"

void MyDrawColoredPattern (void *info, CGContextRef context) {
    CGColorRef dotColor = cgBLACK;
    CGColorRef shadowColor = cgWHITE;
    CGContextSetFillColorWithColor(context, dotColor);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 1), 1, shadowColor);
    CGContextAddArc(context, 3, 3, 4, 0, DEG2RAD(360), 0);
    CGContextFillPath(context);
    CGContextAddArc(context, 16, 16, 4, 0, DEG2RAD(360), 0);
    CGContextFillPath(context);
}


@implementation SFLabelLayer


- (BOOL)containsPoint:(CGPoint)p
{
	return FALSE;
}
@end

@implementation SFDefaultTab
{
	NSBezierPath *thePath;
	NSImage*  activeTab;
	NSImage*  inactiveTab;
	NSTimer *timer;
//	NSView*  activeTab;
//	NSView*  inactiveTab;

}

- (void) setRepresentedObject: (AZFile*) representedObject {
	self.delegate = self;
//	[self setNeedsDisplay];
	CAConstraintLayoutManager *layout = [CAConstraintLayoutManager layoutManager];
    [self setLayoutManager:layout];

	CGRect tab = ([self.viewDelegate fitToFrame] ?
		(CGRect) { 0, 0, [self.viewDelegate frame].size.width / [self.viewDelegate numberOfTabs], 46 }
		: (CGRect){0, 0, 125, 46} );
//	CGPathRef path = [[NSBezierPath bezierPathWithRoundedRect:tab cornerRadius:10 inCorners:OSBottomLeftCorner|OSBottomRightCorner]quartzPath];
//
//	CAShapeLayer *shapeBasedMaskLayer = [CAShapeLayer layer];
//	shapeBasedMaskLayer.path = path;
////	shapeBasedMaskLayer.fillRule = kCAFillRuleEvenOdd;
//	shapeBasedMaskLayer.frame = tab;

    _representedObject = representedObject;
//	NSImage *ico = 	_representedObject.image;
//	NSSize icosize = AZSizeFromDimension(200);
//	self.masksToBounds = YES;
//	shapeBasedMaskLayer.shadowColor = cgBLACK;
//	shapeBasedMaskLayer.fillColor = cgCLEARCOLOR;
//	shapeBasedMaskLayer.backgroundColor = cgCLEARCOLOR;
//	shapeBasedMaskLayer.shadowOffset = (CGSize){5.,-4.};
//	shapeBasedMaskLayer.shadowRadius = 10.;
//	shapeBasedMaskLayer.shadowOpacity = .9;
//	shapeBasedMaskLayer.shadowPath = path;
//	shapeBasedMaskLayer.zPosition = -1000;
//	[self addSublayer:shapeBasedMaskLayer];
//	NSRect icorect = AZSquareFromLength(200);
//	self.mask = shapeBasedMaskLayer;
//	NSImage *swatch = [NSImage swatchWithGradientColor:_representedObject.color size:tab.size];
    self.frame = tab;
	if(!activeTab) {
//		activeTab = swatch;//  [NSImage imageNamed:@"activeTab.png"];
//		inactiveTab = swatch; //[NSImage imageNamed:@"inactiveTab.png"];
	}
	
//	[self setContents:inactiveTab];

    SFLabelLayer *tabLabel = [SFLabelLayer layer];
	
//	if (representedObject[@"name"] != nil) {
		tabLabel.string = _representedObject.name;//[@"name"];
//	}
	[tabLabel setFontSize:13.0f];
	[tabLabel setShadowOpacity:.9f];
	tabLabel.shadowOffset = CGSizeMake(0, -1);
	tabLabel.shadowRadius = 1.0f;
	tabLabel.shadowColor = _representedObject.color.contrastingForegroundColor.inverted.CGColor;
	tabLabel.foregroundColor = _representedObject.color.contrastingForegroundColor.cgColor;
	tabLabel.truncationMode = kCATruncationEnd;
	tabLabel.alignmentMode = kCAAlignmentCenter;
    tabLabel.constraints = @[ 	AZConstRelSuper(kCAConstraintMidX),
								AZConstRelSuperScaleOff(kCAConstraintMidY, 1, -2.0),
								AZConstRelSuperScaleOff(kCAConstraintMaxX, 1, -20.0),
								AZConstRelSuperScaleOff(kCAConstraintMinX, 1, 20.0) ];
	NSFont *f = [AtoZ fontWithSize:15];
	NSString *font = [f fontName];
	[tabLabel setFont:(__bridge CFStringRef)font];//[fontName]];//@"Museo Slab 300"];
	
	[self addSublayer:tabLabel];
	[self setNeedsDisplay];

}

- (void) setSelected: (BOOL) selected {
	_selected = selected;
    [CATransaction begin];
//    [CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];

    if (selected) {
//        [self setContents:activeTab];
		timer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(stroke) userInfo:nil repeats:YES];
	}
    else {
//        [self setContents:inactiveTab];
    	[timer invalidate];
		[self setNeedsDisplay];
	}
    [CATransaction commit];



}

- (void) stroke {
	CGFloat dash[2], phase; NSInteger ct;
	[thePath getLineDash:dash count:&ct phase:&phase];
	[thePath setLineDash:dash count:ct phase:phase+1];
	[self setNeedsDisplay];

}

- (void)drawLayer:(CALayer *)theLayer inContext:(CGContextRef)ctx
{


	[NSGraphicsContext saveGraphicsState];
	[NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithGraphicsPort:ctx flipped:NO]];
//	NSLog(@"gstate: %@", [RuntimeReporter methodNamesForClass:[CALayer class]]);

//	[NSShadow setShadowWithOffset:NSZeroSize blurRadius:3 color:BLACK];
	if (!thePath) {
		thePath = [NSBezierPath bezierPathWithRect:theLayer.bounds];
		thePath.lineWidth = 10;
		thePath.dashPattern = @[@10,@10];
	}
	[thePath fillGradientFrom:_representedObject.color.darker.darker to:_representedObject.color.brighter angle:90];
	if (_selected)	[thePath stroke];
	[NSGraphicsContext restoreGraphicsState];
//	[NSShadow clearShadow];
	
//	[NSGraphicsContext saveGraphicsState];
//	CALayer *sublayer = [CALayer layer];
//	sublayer.backgroundColor = cgBLUE;
//	sublayer.shadowOffset = CGSizeMake(0, 3);
//	sublayer.shadowRadius = 5.0;
//	sublayer.shadowColor = cgBLACK;
//	sublayer.shadowOpacity = 0.8;
//	sublayer.frame = self.bounds;//CGRectMake(30, 30, 128, 192);
//	sublayer.zPosition = -10000;
//	[self  addSublayer:sublayer];
//
////	NSGraphicsContext *oldCtx = [NSGraphicsContext currentContext];
////	[NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithGraphicsPort:ctx flipped:NO]];
//	NSString *letter = @"vag";//"[[theLayer valueForKey:@"letter"] uppercaseString];
//	NSFont *font = [NSFont fontWithName:@"Monaco" size:20.0];
//	NSDictionary *attr = @ { NSFontAttributeName: font,  NSForegroundColorAttributeName: WHITE };
//	NSSize letterSize = [letter sizeWithAttributes:attr];
//
//	NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:RANDOMCOLOR endingColor:RANDOMCOLOR];
//	[gradient drawInRect: theLayer.frame angle:90];//NSMakeRect(0,0,40,45) angle:90];
//	[letter drawAtPoint:theLayer.frame.origin withAttributes:attr];
////	[NSGraphicsContext setCurrentContext:oldCtx];
//	[NSGraphicsContext restoreGraphicsState];
//	 NSMakePoint(20 - letterSize.width/2, 82 - letterSize.height)
//	}
//	else {
//		[gradient drawInRect:NSMakeRect(0,0,40,45) angle:270];
//		[letter drawAtPoint:NSMakePoint(20 - letterSize.width/2, 37 - letterSize.height) withAttributes:attr];
//	}
//	[gradient release];

}

@end
