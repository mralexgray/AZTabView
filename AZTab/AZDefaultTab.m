#import "AZDefaultTab.h"
#import <Quartz/Quartz.h>
#import <QuartzCore/QuartzCore.h>

//static CGImageRef  activeTab;
//static CGImageRef  inactiveTab;
//@implementation AZTabObject
//@synthesize color, name;
//- (void) setWithDictionary:(NSDictionary *)dict; {
//	self.color = ([dict valueForKey:@"color"] ? [dict valueForKey:@"color"] : RANDOMCOLOR);
//	self.name  = ([dict valueForKey:@"name"] ? [dict valueForKey:@"name"] : @"NO NAME");
////	[self setValuesForKeysWithDictionary:dict];
//}
//@end
@interface AZColorBar ()
@property (strong, nonatomic) CAConstraintLayoutManager *layout;
@end
@implementation AZColorBar {
		 AZFile *_rep;
}

@synthesize representedObject = _rep, layout, selected, silhouette;
//active, inactive, currentImage, ;

- (id)init
{
    self = [super init];
    if (self) {
		float wide = ([[NSScreen mainScreen]frame].size.width/ [NSColor fengshui].count);
		NSRect u = NSMakeRect(0,0,wide,20);
		self.frame = u;
	}
	return self;	
}
- (void) setRepresentedObject:(id)representedObject {
	_rep = representedObject;
	[self makeShapes]; 
}
-(void) makeShapes {
	silhouette = [CAShapeLayer layer];
	silhouette.fillColor = _rep.color.CGColor;
	silhouette.shadowOffset = CGSizeMake(2, -2);
	silhouette.shadowRadius = 5.0;
	silhouette.shadowColor = cgBLACK;
	silhouette.shadowOpacity = 0.8;
	silhouette.lineWidth = 3;
	silhouette.strokeColor = cgWHITE;
	NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:self.frame cornerRadius:5 inCorners:OSBottomLeftCorner | OSBottomRightCorner];
	silhouette.path = [path quartzPath];
	[self addSublayer: silhouette];
}

@end


@implementation AZLabelLayer
- (BOOL)containsPoint:(CGPoint)p {	return FALSE; }
@end
@interface AZLassoLayer : CAShapeLayer
@end
@implementation AZLassoLayer
- (BOOL)containsPoint:(CGPoint)p {	return FALSE; }
@end

@interface AZDefaultTab ()
@property (strong, nonatomic) AZLabelLayer *label;
@property (strong, nonatomic) CALayerNoHit *over;
@end

@implementation AZDefaultTab {	 
	AZFile *_rep; 
	AZLassoLayer *highlightLayer; 
	CALayer *shineLayer; 
	CAConstraint * horizontalConstraint;
	CAConstraint * verticalConstraint; 
	CAConstraint * widthConstraint;
}
@synthesize selected, label, representedObject = _rep, layout, silhouette, highlighted, over;


- (id)init
{
    self = [super init];
    if (self) {
	layout = [CAConstraintLayoutManager layoutManager];
    [self setLayoutManager:layout];
//	representedObject = arepresentedObject;
//	CGFloat totes = [[NSScreen mainScreen]frame].size.width / [AtoZ dock].count;
    self.frame = CGRectMake(0, 0 , 100, 40);
//	widthConstraint = [CAConstraint constraintWithAttribute:kCAConstraintMaxX
//												 relativeTo:@"superlayer"
//												  attribute:kCAConstraintMaxX];    
	
	verticalConstraint = [CAConstraint constraintWithAttribute:kCAConstraintMaxY
													relativeTo:@"superlayer"
													 attribute:kCAConstraintMaxY
														offset:2.0];

	[self addObserver:self forKeyPath:@"zPosition" options:0 context:nil];
	[self addObserver:self forKeyPath:@"transform" options:0 context:nil];

	}
	return self;
}


-(void)didChangeValueForKey:(NSString *)key {
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
		if ([key isEqual:@"zPosition"]) {
//			NSLog(@"received notification of change to z position");
			label.string = $(@"Spot:%i Z:%i", _rep.spot, (int)self.zPosition);
		}
		if ([key isEqual:@"zPosition"]) {
			NSLog(@"received notification of change to transform");
			[label setConstraints:$array(widthConstraint, verticalConstraint)];
		}
//		else 	// Unrecognized keypath
//			[superlayer observeValueForKeyPath:key];
//	}
}
//	[[NSNotificationCenter defaultCenter] addob
//	addObserverForName:@"zPosition" object:self queue:opQ usingBlock:^(NSNotification *note) {
//		label.string = self.zPosition;
//	}];


//  	CAShapeLayer *gradientMask = [CAShapeLayer layer];   
//	gradientMask.fillColor = cgCLEARCOLOR;
//	gradientMask.strokeColor = cgBLACK;
//	gradientMask.lineWidth = 4;
//	gradientMask.path = [path quartzPath];
//-(void) makeTabs {
//	NSColor *c = (_rep ? _rep.color : RED.darker );
//	active = [[NSImage imageNamed:@"activeTab.png"] tintedWithColor: c];
//	[_rep.image setScalesWhenResized:YES];
//	[_rep.image setSize:NSMakeSize(self.frame.size.height, self.frame.size.height)];

//	[active lockFocus];  
//	[_rep.image drawCenteredinRect:AGMakeRectFromSize(self.frame.size) operation:NSCompositeSourceOver fraction:1];
//	[active unlockFocus];	
//	inactive = [[NSImage imageNamed:@"inactiveTab.png"] tintedWithColor: c.darker];
//	if (active) [self setContents:active]; else [self setContents:inactive];
//}
- (void) setRepresentedObject:(id)representedObject {
	_rep = representedObject;
	[self makeShapes]; 
}
	
//	CALayer *customDrawn = [CALayer layer];
//	customDrawn.delegate = self;
//	customDrawn.backgroundColor = [UIColor greenColor].CGColor;
//	customDrawn.frame = CGRectMake(30, 250, 128, 40);
//	customDrawn.shadowOffset = CGSizeMake(0, 3);
//	customDrawn.shadowRadius = 5.0;
//	customDrawn.shadowColor = [UIColor blackColor].CGColor;
//	customDrawn.shadowOpacity = 0.8;
//	customDrawn.cornerRadius = 10.0;
//	customDrawn.borderColor = [UIColor blackColor].CGColor;
//	customDrawn.borderWidth = 2.0;
//	customDrawn.masksToBounds = YES;
//	[self.view.layer addSublayer:customDrawn];
//	[customDrawn setNeedsDisplay];
- (void) makeShapes {
		 
	silhouette = [CAShapeLayer layer];
	silhouette.fillColor = _rep.color.CGColor;
//	slice.strokeColor = cgBLACK;
//	slice.lineWidth = 3.0;
	silhouette.shadowOffset = CGSizeMake(2, -2);
	silhouette.shadowRadius = 5.0;
	silhouette.shadowColor = cgBLACK;
	silhouette.shadowOpacity = 0.8;
//	silhouette.anchorPoint = CGPointMake(.5, 1);
	NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:self.frame cornerRadius:5 inCorners:OSBottomLeftCorner | OSBottomRightCorner];
	silhouette.path = [path quartzPath];
//    highlightLayer = [AZLassoLayer layer];
//    highlightLayer.fillColor = [NSColor colorWithDeviceRed:0.25f
//														   green:0.25f
//															blue:0.25f
//														   alpha:0.75].CGColor;
//    highlightLayer.frame = self.bounds;
//	highlightLayer.strokeColor = cgWHITE;
//	highlightLayer.lineDashPhase = 10;
//	highlightLayer.lineWidth = 4;
//    highlightLayer.hidden = YES;
//    [silhouette addSublayer:highlightLayer];// insertSublayer:highlightLayer below:shineLayer];
	over = [CALayerNoHit layer];
	NSImage *i = _rep.image;
//	i.scalesWhenResized = Y ES;
	[i setSize: NSMakeSize(35,35)];
	over.contents = i;//[i  tintedWithColor:_rep.color];
//	over.bounds = NSMakeRect(0,0,35,35);
	over.anchorPoint = CGPointMake(1,0);
	over.position = CGPointMake(1,0);
//	over.position = NSMakePoint(self.bounds.size.width-17, 17);
//	over.contentsGravity = kCAGravityRight;
    label = [AZLabelLayer layer];	
	//	if ([_representedObject valueForKey:@"name"] != nil) { tabLabel.string = [_representedObject valueForKey:@"name"]; }
	
	[label setFontSize:13.0f];
	[label setShadowOpacity:.9f];
	label.shadowOffset = CGSizeMake(0, -1);
	label.shadowRadius = 1.0f;
	label.shadowColor = CGColorCreateGenericRGB(1,1,1, 1);
	label.foregroundColor = cgWHITE;// CGColorCreateGenericRGB(0.1,0.1,0.1, 1);
	label.truncationMode = kCATruncationEnd;
//	label.alignmentMode = kCAAlignmentRight;
//	CAConstraint * horizontalConstraint;
	[label setConstraints:$array(widthConstraint, verticalConstraint)];

//	[self addHighlightLayer];	
//	[self makelabel];
	[self addSublayer:silhouette];
	[self addSublayer:label];
	[self addSublayer: over];
//	CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
//	anim.duration = 1.0;
//	// flip the path
//	anim.fromValue = (__bridge id)fromPath;
//	anim.toValue = (__bridge id)toPath;
//	anim.removedOnCompletion = NO;
//	anim.fillMode = kCAFillModeForwards;
//	[slice addAnimation:anim forKey:nil];
}


//-(NSImage*) active {
//	if (!active)
//		active = [[NSImage imageNamed:@"activeTab.png"] tintedWithColor: RANDOMCOLOR];
//	return active;
//
//// ([_representedObject valueForKey:@"color"] ? [_representedObject valueForKey:@"color"] : 
//}
//-(NSImage*) inactive {
//
//	if (!inactive)
//		inactive = [[NSImage imageNamed:@"activeTab.png"] tintedWithColor:GREY];
//	return inactive;
//}
//	CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//	gradientLayer.startPoint = CGPointMake(0.5,1.0);
//	gradientLayer.endPoint = CGPointMake(0.5,0.0);
//	gradientLayer.frame = self.bounds;
//	NSColor *r = RANDOMCOLOR;
//	gradientLayer.colors = $array(r.brighter, r.darker);
//	
//	[gradientLayer setMask:gradientMask];
//	[self addSublayer:gradientLayer];
// 
	
	
//	CGRect superS = [[self superlayer] bounds];
//	NSImage *anImage = [NSImage systemImages].randomElement;
//	NSImage *masked = [anImage maskedWithColor:GREEN];
//	[anImage setSize:NSMakeSize(64,64)];
//	self.frame = AGMakeRectFromSize(anImage.size);
//	self.contents = masked;
//	self.contentsGravity = kCAGravityCenter;
//    self.frame = self.bounds;// CGRectMake(0, 0 , NSMaxX(superS), NSMaxY(superS));
//	self.backgroundColor = CGColorCreateGenericRGB(1,0,1,1);
//	NSLog(@"%@",);


//	if(!activeTab) {
//		NSImage *tab = ;
//		activeTab = [self ];//  [_representedObject valueForKeyPath:@"dictionary.active"];
//		NSImage *intab = [[NSImage imageNamed:@"inactiveTab.png"]tintedWithColor:RANDOMCOLOR];
//		inactiveTab = (id)intab;

//		CFStringRef path = (CFStringRef)[[NSBundle mainBundle] pathForResource:@"activeTab" ofType:@"png"];
//		CFURLRef imageURL = CFURLCreateWithFileSystemPath(nil, path, kCFURLPOSIXPathStyle, NO);
//		CGImageSourceRef imageSource = CGImageSourceCreateWithURL(imageURL, nil);
//		activeTab = CGImageSourceCreateImageAtIndex(imageSource, 0, nil);
//		CFRelease(imageURL); CFRelease(imageSource);

		
//		path = (CFStringRef)[[NSBundle mainBundle] pathForResource:@"inactiveTab" ofType:@"png"];
//		imageURL = CFURLCreateWithFileSystemPath(nil, path, kCFURLPOSIXPathStyle, NO);
//		imageSource = CGImageSourceCreateWithURL(imageURL, nil);
//		inactiveTab = CGImageSourceCreateImageAtIndex(imageSource, 0, nil);
//		CFRelease(imageURL); CFRelease(imageSource);
//	}
	
//	[self setContents: (id)inactiveTab];
-(void) makelabel {

	CAConstraint *constraint = [CAConstraint constraintWithAttribute:kCAConstraintMaxX
                                                          relativeTo:@"superlayer"
                                                           attribute:kCAConstraintMaxX];    
    [label addConstraint:constraint];
    constraint = [CAConstraint constraintWithAttribute:kCAConstraintMinY
                                            relativeTo:@"superlayer"
                                             attribute:kCAConstraintMinY
												offset:2.0];
    [label addConstraint:constraint];
	constraint = [CAConstraint constraintWithAttribute:kCAConstraintMaxX
                                            relativeTo:@"superlayer"
                                             attribute:kCAConstraintMaxX
												offset:-20.0];
    [label addConstraint:constraint];

	constraint = [CAConstraint constraintWithAttribute:kCAConstraintMinX
                                            relativeTo:@"superlayer"
                                             attribute:kCAConstraintMinX
												offset:20.0];
    [label addConstraint:constraint];
	
	
	[label setFont:@"LucidaGrande"];
	
	[silhouette addSublayer:label];
//	return alabel;
}

//- (BOOL) selected {
//	return selected;
//}
- (void) setSelected:(BOOL)sel {
//	NSLog(@"%@", self.propertiesPlease);
	selected = sel;
//	silhouette.anchorPoint = CGPointMake(1.0f, 1.0f);
	
    [CATransaction begin]; 
//    [CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
	[CATransaction setAnimationDuration:.1];
	[CATransaction setAnimationTimingFunction:
		[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
	CATransform3D move;
	if (sel){
//		NSRect g = self.bounds;
//		g.size.height += 300;
//		NSPoint sd = self.position;
//		sd.y -= 300;
//		self.position = sd;
//		self.bounds = g;

//		[self setBounds:g];
		CATransform3D transform = CATransform3DMakeScale(1.0f,  2.0f , 1.0f);
		CATransform3D moveit = CATransform3DMakeTranslation(0,  -40, 0);
		move = CATransform3DConcat( transform, moveit);
////	  [self setContents:(selected ? self.active : self.inactive)];
	} else {
		move = CATransform3DIdentity;
	}  	silhouette.transform = move;
	[CATransaction commit];
}


- (void)setHighlighted:(BOOL)highlight {
    highlightLayer.hidden = highlight;
}
@end
