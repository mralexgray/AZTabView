//
//  SFDefaultTab.h
//  tabtest
//
//  Created by Matteo Rattotti on 2/28/10.
//  Copyright 2010 www.shinyfrog.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>
#import "SFTabView.h"
#import <AtoZ/AtoZ.h>

@interface SFLabelLayer : CATextLayer {}
@end

@protocol SFDefaultTabDelegate <NSObject>

- (BOOL) fitToFrame;
- (NSRect) frame;
- (int) numberOfTabs;

@end


@interface SFDefaultTab : CALayer

@property (nonatomic, assign) NSObject <SFDefaultTabDelegate> *viewDelegate;
@property (nonatomic, retain) AZFile *representedObject;
@property (nonatomic, assign) BOOL selected;


@end

