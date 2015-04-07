//
//  MovableView.h
//  OpenCircuit
//
//  Created by John O'Sullivan on 4/6/15.
//  Copyright (c) 2015 LuTec. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>

@interface MovableViewTools : NSObject
//Converts degrees to radians
CGFloat ViewDegreesToRadians(CGFloat degrees);
//Converts radians to degress
CGFloat ViewRadiansToDegrees(CGFloat radians);
//Converts tranforms to radians
CGFloat ViewTransformToRadians(CGAffineTransform transform);
@end

@class MovableView;

@protocol MovableViewDelegate <NSObject>
//Handles view when tapped at point
-(void) MovableView:(MovableView*) movableView tappedAtPoint:(CGPoint) point;
//Handles view when moved at point
-(void) MovableView:(MovableView*) movableView movedToPoint:(CGPoint) point withVelocity:(CGPoint) velocity;
//Handles view when transformed at point
-(void) MovableView:(MovableView*) movableView transformed:(CGFloat) transform toPoint:(CGPoint) point withVelocity:(CGPoint) velocity;
@end

@interface MovableView : UIView <UIGestureRecognizerDelegate>
{
    //Custon UI entered here
}

//Declared delegate
@property(nonatomic, weak) id <NSObject, MovableViewDelegate> delegate;
//Declared UIPinchGestureRecognizer
@property(nonatomic, strong) UIPinchGestureRecognizer *pinchRecognizer;
//Declared UIRotationGestureRecognizer
@property(nonatomic, strong) UIRotationGestureRecognizer *rotationRecognizer;
//Declared UIPanGestureRecognizer
@property(nonatomic, strong) UIPanGestureRecognizer *panRecognizer;
//Declared UITapGestureRecognizer
@property(nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
//Declared Scale CGFloat
@property(assign) CGFloat Scale;
//Declared Rotation CGFloat
@property(assign) CGFloat Rotation;
//Declared fPoint CGPoint
@property(assign) CGPoint fPoint;
//Declared lPoint CGPoint
@property(assign) CGPoint lPoint;

//Handles the move of the view
-(void) moveView:(MovableView*) MovableView withSender:(id) sender withTranslated:(CGPoint) translatedPoint newX:(CGFloat) newX newY:(CGFloat) newY;

@end