//
//  OCActionSheetViewController.m
//  OpenCircuit
//
//  Created by August Meyer on 3/30/15.
//  Copyright (c) 2015 LuTec. All rights reserved.
//

#import "OCActionSheetViewController.h"
#import "OCActionSheetPickerView.h"

@interface OCActionSheetViewController ()<UIApplicationDelegate>

@end

@implementation OCActionSheetViewController

-(void)loadView
{
    
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.view.backgroundColor = [UIColor clearColor];
}

-(void)showPickerView:(OCActionSheetPickerView*)pickerView completion:(void (^)(void))completion
{
    _pickerView = pickerView;
    
    UIViewController *topController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    while ([topController presentedViewController])	topController = [topController presentedViewController];
    
    __block CGRect pickerViewFrame = pickerView.frame;
    {
        pickerViewFrame.origin.y = self.view.bounds.size.height;
        pickerView.frame = pickerViewFrame;
        [self.view addSubview:pickerView];
    }

    {
        self.view.frame = CGRectMake(0, 0, topController.view.bounds.size.width, topController.view.bounds.size.height);
        self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [topController addChildViewController: self];
        [topController.view addSubview: self.view];
    }

    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState|7<<16 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        
        pickerViewFrame.origin.y = self.view.bounds.size.height-pickerViewFrame.size.height;
        pickerView.frame = pickerViewFrame;

    } completion:^(BOOL finished) {
        if (completion) completion();
    }];
}

-(void)dismissWithCompletion:(void (^)(void))completion
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState|7<<16 animations:^{
        
        self.view.backgroundColor = [UIColor clearColor];
        CGRect pickerViewFrame = _pickerView.frame;
        pickerViewFrame.origin.y = self.view.bounds.size.height;
        _pickerView.frame = pickerViewFrame;
        
    } completion:^(BOOL finished) {

        [_pickerView removeFromSuperview];
        

        [self willMoveToParentViewController:nil];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];

        if (completion) completion();
    }];
}

@end
