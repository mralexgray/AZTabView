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

@interface AZLabelLayer : CATextLayer {}
@end

//@interface AZTabObject : AtoZ
//@property (nonatomic) NSColor *color;
//@property (nonatomic) NSString *name;
//@end



@interface AZColorBar : CALayer
@property (strong, nonatomic) CAShapeLayer *silhouette;
@property (strong, nonatomic) id representedObject;
//@property (strong, nonatomic) NSImage *currentImage;
//@property (strong, nonatomic) NSImage *active;
//@property (strong, nonatomic) NSImage *inactive;
@property (assign, nonatomic) BOOL selected;
@end

@interface AZDefaultTab : CALayer
@property (strong, nonatomic) CAShapeLayer *silhouette;
@property (strong, nonatomic) id representedObject;
@property (assign, nonatomic) BOOL selected;
@property (assign, nonatomic) BOOL highlighted;
@property (strong, nonatomic) CAConstraintLayoutManager *layout;
@end
