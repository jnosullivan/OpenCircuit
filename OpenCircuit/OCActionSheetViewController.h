//
//  OCActionSheetViewController.h
//  OpenCircuit
//
//  Created by August Meyer on 3/30/15.
//  Copyright (c) 2015 LuTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OCActionSheetPickerView;

@interface OCActionSheetViewController : UIViewController

@property(nonatomic, strong, readonly) OCActionSheetPickerView *pickerView;

-(void)showPickerView:(OCActionSheetPickerView*)pickerView completion:(void (^)(void))completion;

-(void)dismissWithCompletion:(void (^)(void))completion;

@end
