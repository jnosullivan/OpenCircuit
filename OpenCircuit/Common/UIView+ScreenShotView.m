//
//  ScreenShotView.m
//  OpenCircuit
//
//  Created by John O'Sullivan on 3/23/15.
//  Copyright (c) 2015 LuTec. All rights reserved.
//

#import "UIView+ScreenShotView.h"

@implementation UIView (ScreenShotView)

- (UIImage *)takescreenshot
{
    return [self screenshotFromRect:self.bounds];
}

- (UIImage *)screenshotFromRect:(CGRect)croppingRect
{
    UIGraphicsBeginImageContextWithOptions(croppingRect.size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (context == NULL) return nil;
    
    CGContextTranslateCTM(context, -croppingRect.origin.x, -croppingRect.origin.y);
    
    [self layoutIfNeeded];
    
    [self.layer renderInContext:context];
    
    UIImage *screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return screenshotImage;
}

@end