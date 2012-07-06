//
//  SFDefaultTab.m
//  tabtest
//
//  Created by Matteo Rattotti on 2/28/10.
//  Copyright 2010 www.shinyfrog.net. All rights reserved.
//

#import "SFDefaultTab.h"




@implementation SFLabelLayer
- (BOOL)containsPoint:(CGPoint)p
{
	return FALSE;
}
@end

@implementation SFDefaultTab
{
	NSImage*  activeTab;
	NSImage*  inactiveTab;
}

- (void) setRepresentedObject: (id) representedObject {
	CAConstraintLayoutManager *layout = [CAConstraintLayoutManager layoutManager];
    [self setLayoutManager:layout];

    _representedObject = representedObject;
    self.frame = CGRectMake(0, 0, 125, 28);
	if(!activeTab) {
		activeTab = [NSImage imageNamed:@"activeTab.png"];
		inactiveTab = [NSImage imageNamed:@"inactiveTab.png"];
	}
	
	[self setContents:inactiveTab];

    SFLabelLayer *tabLabel = [SFLabelLayer layer];
	
	if ([representedObject objectForKey:@"name"] != nil) {
		tabLabel.string = [representedObject objectForKey:@"name"];
	}
	[tabLabel setFontSize:13.0f];
	[tabLabel setShadowOpacity:.9f];
	tabLabel.shadowOffset = CGSizeMake(0, -1);
	tabLabel.shadowRadius = 1.0f;
	tabLabel.shadowColor = CGColorCreateGenericRGB(1,1,1, 1);
	tabLabel.foregroundColor = CGColorCreateGenericRGB(0.1,0.1,0.1, 1);
	tabLabel.truncationMode = kCATruncationEnd;
	tabLabel.alignmentMode = kCAAlignmentCenter;
	CAConstraint *constraint = [CAConstraint constraintWithAttribute:kCAConstraintMidX
                                                          relativeTo:@"superlayer"
                                                           attribute:kCAConstraintMidX];    
    [tabLabel addConstraint:constraint];
    
    constraint = [CAConstraint constraintWithAttribute:kCAConstraintMidY
                                            relativeTo:@"superlayer"
                                             attribute:kCAConstraintMidY
												offset:-2.0];
    [tabLabel addConstraint:constraint];

	constraint = [CAConstraint constraintWithAttribute:kCAConstraintMaxX
                                            relativeTo:@"superlayer"
                                             attribute:kCAConstraintMaxX
												offset:-20.0];
    [tabLabel addConstraint:constraint];

	constraint = [CAConstraint constraintWithAttribute:kCAConstraintMinX
                                            relativeTo:@"superlayer"
                                             attribute:kCAConstraintMinX
												offset:20.0];
    [tabLabel addConstraint:constraint];
	
	
	[tabLabel setFont:@"LucidaGrande"];
	
	[self addSublayer:tabLabel];

}

- (void) setSelected: (BOOL) selected {
    [CATransaction begin]; 
    [CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];

    if (selected)
        [self setContents:activeTab];
    else
        [self setContents:inactiveTab];
    
    [CATransaction commit];

}

@end
