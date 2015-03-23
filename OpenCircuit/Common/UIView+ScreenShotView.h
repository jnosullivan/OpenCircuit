//
//  ScreenShotView.h
//  OpenCircuit
//
//  Created by John O'Sullivan on 3/23/15.
//  Copyright (c) 2015 LuTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ScreenShotView)

- (UIImage *)takescreenshot;

- (UIImage *)screenshotFromRect:(CGRect)rect;

@end