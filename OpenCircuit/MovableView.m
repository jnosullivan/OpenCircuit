//
//  MovableView.m
//  OpenCircuit
//
//  Created by John O'Sullivan on 4/6/15.
//  Copyright (c) 2015 LuTec. All rights reserved.
//


#import "MovableView.h"

#import <QuartzCore/QuartzCore.h>

/*
* Movable View Tool For Convert
*/
CGFloat ViewDegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat ViewRadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};
CGFloat ViewTransformToRadians(CGAffineTransform transform) {return atan2(transform.b, transform.a);};

@implementation MovableViewTools
@end

// MovableView class starts here
@implementation MovableView
@synthesize delegate = _delegate;
@synthesize pinchRecognizer = _pinchRecognizerview;
@synthesize rotationRecognizer = _rotationRecognizerview;
@synthesize panRecognizer = _panRecognizerview;
@synthesize tapRecognizer = _tapRecognizerview;
@synthesize Scale = _Scale;
@synthesize Rotation = _Rotation;
@synthesize fPoint = _fPoint;
@synthesize lPoint = _lPoint;

//Init class for movable with nscoder
- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        //Configs _pinchRecognizerview
        _pinchRecognizerview = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
        [_pinchRecognizerview setDelegate:self];
        [self addGestureRecognizer:_pinchRecognizerview];
        //Configs _rotationRecognizerview
        _rotationRecognizerview = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
        [_rotationRecognizerview setDelegate:self];
        [self addGestureRecognizer:_rotationRecognizerview];
        //Configs _panRecognizerview
        _panRecognizerview = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveview:)];
        [_panRecognizerview setMinimumNumberOfTouches:1];
        [_panRecognizerview setMaximumNumberOfTouches:1];
        [_panRecognizerview setDelegate:self];
        [self addGestureRecognizer:_panRecognizerview];
        //Configs _tapRecognizerview
        _tapRecognizerview = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [_tapRecognizerview setNumberOfTapsRequired:1];
        [_tapRecognizerview setDelegate:self];
        [self addGestureRecognizer:_tapRecognizerview];
    }
    return self;
}

//Init class for movable with frame
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //Configs _pinchRecognizerview
        _pinchRecognizerview = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
        [_pinchRecognizerview setDelegate:self];
        [self addGestureRecognizer:_pinchRecognizerview];
        //Configs _rotationRecognizerview
        _rotationRecognizerview = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
        [_rotationRecognizerview setDelegate:self];
        [self addGestureRecognizer:_rotationRecognizerview];
        //Configs _panRecognizerview
        _panRecognizerview = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveview:)];
        [_panRecognizerview setMinimumNumberOfTouches:1];
        [_panRecognizerview setMaximumNumberOfTouches:1]; //TODO, use center of 2 touches as center
        [_panRecognizerview setDelegate:self];
        [self addGestureRecognizer:_panRecognizerview];
        //Configs _tapRecognizerview
        _tapRecognizerview = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [_tapRecognizerview setNumberOfTapsRequired:1];
        [_tapRecognizerview setDelegate:self];
        [self addGestureRecognizer:_tapRecognizerview];
    }
    return self;
}
//Trigger the pinch to resize
-(void)pinch:(id)sender {
    
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {  return;  }
    
    MovableView *movableView = (MovableView*) [(UIPinchGestureRecognizer*)sender view];
    
    [[[(UITapGestureRecognizer*)sender view] layer] removeAllAnimations];
    
    CGPoint point1;
    
    CGPoint point2;
    
    if ([(UIPinchGestureRecognizer*)sender numberOfTouches] > 1) {
        point1 = [(UIPinchGestureRecognizer*)sender locationOfTouch:0 inView:movableView.superview];
        point2 = [(UIPinchGestureRecognizer*)sender locationOfTouch:1 inView:movableView.superview];
    } else { return; }
    
    CGFloat pointX = point1.x;
    CGFloat pointY = point1.y;
    
    if (point2.x < point1.x) {
        pointX = point2.x;
    }
    
    if (point2.y < point1.y) {
        pointY = point2.y;
    }
    
    CGPoint translatedPoint = CGPointMake(pointX+fabs(point1.x-point2.x)/2, pointY+fabs(point1.y-point2.y)/2);
    
    CGFloat newpointX = translatedPoint.x;
    
    CGFloat newpointY = translatedPoint.y;
    
    CGPoint velocity = CGPointMake(newpointX-self.lPoint.x, newpointY-self.lPoint.y);
    
    [self moveView:movableView withSender:sender withTranslated:(CGPoint) translatedPoint newX:(CGFloat) newpointX newY:(CGFloat) newpointY];
    
    if ([_delegate respondsToSelector:@selector(MovableView:movedToPoint:withVelocity:)]) { [_delegate MovableView:self movedToPoint:CGPointMake(newpointX,newpointY) withVelocity:velocity]; }
}

//Triggers when making a rotating
-(void)rotate:(id)sender {
    
    MovableView *movableView = (MovableView*) [(UIRotationGestureRecognizer*)sender view];
    
    CGPoint translatedPoint = movableView.center;
    
    CGFloat newX = translatedPoint.x;
    CGFloat newY = translatedPoint.y;
    
    if([(UIRotationGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        movableView.Rotation = 0.0;
        [self moveView:movableView withSender:sender withTranslated:(CGPoint) translatedPoint newX:(CGFloat) newX newY:(CGFloat) newY];
        return;
    }
    [self moveView:movableView withSender:sender withTranslated:(CGPoint) translatedPoint newX:(CGFloat) newX newY:(CGFloat) newY];
    
    CGFloat rotation = 0.0 - (movableView.Rotation - [(UIRotationGestureRecognizer*)sender rotation]);
    
    CGAffineTransform currentTransform = [(UIPinchGestureRecognizer*)sender view].transform;
    
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
    
    [[(UIRotationGestureRecognizer*)sender view] setTransform:newTransform];
    
    movableView.Rotation = [(UIRotationGestureRecognizer*)sender rotation];
    
    CGPoint velocity = CGPointMake(newX-self.lPoint.x, newY-self.lPoint.y);
    
    CGFloat t = ViewRadiansToDegrees(ViewTransformToRadians(self.transform))+360;
    
    if ([_delegate respondsToSelector:@selector(MovableView:transformed:toPoint:withVelocity:)]) { [_delegate MovableView:self transformed:t toPoint:CGPointMake(newX, newY) withVelocity:velocity]; }
}

//Moving the view
-(void) moveView:(MovableView*) movableView withSender:(id) sender withTranslated:(CGPoint) translatedPoint newX:(CGFloat) newX newY:(CGFloat) newY {
    
    [self.superview bringSubviewToFront:movableView];
    
    translatedPoint = CGPointMake(newX, newY);
    
    [UIView beginAnimations:nil context:NULL];
    
    [UIView setAnimationBeginsFromCurrentState:NO];
    
    [UIView setAnimationDuration:.35];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationDidStopSelector:@selector(animationComplete:)];
    
    [[sender view] setCenter: translatedPoint];
    
    [UIView commitAnimations];
    
    self.lPoint = CGPointMake(newX, newY);
    
}

-(void) animationComplete:(id) sender {
    
}

-(void)moveview:(id)sender {

    MovableView *movableView = (MovableView*) [(UIPanGestureRecognizer*)sender view];
    
    [[[(UITapGestureRecognizer*)sender view] layer] removeAllAnimations];
    
    CGPoint touchedPoint = [(UIPanGestureRecognizer*)sender locationInView:self.superview];
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) { movableView.fPoint = CGPointMake([[sender view] center].x-touchedPoint.x,[[sender view] center].y-touchedPoint.y); }
    
    CGPoint translatedPoint = CGPointMake(touchedPoint.x+movableView.fPoint.x, touchedPoint.y+movableView.fPoint.y);
    
    CGFloat newX = touchedPoint.x+movableView.fPoint.x;
    CGFloat newY = touchedPoint.y+movableView.fPoint.y;
    
    [self moveView:movableView withSender:sender withTranslated:(CGPoint) translatedPoint newX:(CGFloat) newX newY:(CGFloat) newY];
    
    UIPanGestureRecognizer *pRecognizer = (UIPanGestureRecognizer*)sender;
    CGPoint velocity = [pRecognizer velocityInView:self.superview];
    
    if ([_delegate respondsToSelector:@selector(MovableView:movedToPoint:withVelocity:)]) { [_delegate MovableView:self movedToPoint:CGPointMake(newX, newY) withVelocity:velocity]; }
}

//Triggers when the view is tapped
-(void)tapped:(id)sender {
    
    [[[(UITapGestureRecognizer*)sender view] layer] removeAllAnimations];
    
    if ([_delegate respondsToSelector:@selector(MovableView:tappedAtPoint:)]) { [_delegate MovableView:self tappedAtPoint:self.center]; }
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]])  {
        return NO;
    }
    return YES;
}

@end
