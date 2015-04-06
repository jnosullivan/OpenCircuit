//
//  UIView-Drag.h
//  OpenCircuit
//
//  Created by John O'Sullivan on 4/6/15.
//  Copyright (c) 2015 LuTec. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (Drag)

@property (nonatomic) UIPanGestureRecognizer *panGesture;

@property (nonatomic) CGRect cagingArea;

@property (nonatomic) CGRect handle;

@property (nonatomic) BOOL shouldMoveAlongX;

@property (nonatomic) BOOL shouldMoveAlongY;

@property (nonatomic, copy) void (^draggingStartedBlock)();

@property (nonatomic, copy) void (^draggingEndedBlock)();

- (void)enableDragging;

- (void)setDraggable:(BOOL)draggable;

@end