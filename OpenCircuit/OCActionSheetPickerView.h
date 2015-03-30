//
//  OCActionSheetPickerView.h
//  OpenCircuit
//
//  Created by August Meyer on 3/30/15.
//  Copyright (c) 2015 LuTec. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



typedef NS_ENUM(NSUInteger, OCActionSheetPickerStyle) {
    
    OCActionSheetPickerStyleTextPicker,
    
    OCActionSheetPickerStyleDatePicker,
    
};

@class OCActionSheetPickerView;


@protocol OCActionSheetPickerViewDelegate <NSObject>

- (void)actionSheetPickerView:(OCActionSheetPickerView *)pickerView didSelectTitles:(NSArray*)titles;

@optional
- (void)actionSheetPickerView:(OCActionSheetPickerView *)pickerView didChangeRow:(NSInteger)row inComponent:(NSInteger)component;
@end


@interface OCActionSheetPickerView : UIView

- (instancetype)initWithTitle:(NSString *)title delegate:(id<OCActionSheetPickerViewDelegate>)delegate NS_DESIGNATED_INITIALIZER;

-(void)show;

-(void)showWithCompletion:(void (^)(void))completion;

-(void)dismiss;

-(void)dismissWithCompletion:(void (^)(void))completion;

@property(nonatomic, weak) id<OCActionSheetPickerViewDelegate> delegate;

@property(nonatomic, assign) OCActionSheetPickerStyle actionSheetPickerStyle;   //

@property(nonatomic, strong) NSArray *selectedTitles;

-(void)setSelectedTitles:(NSArray *)selectedTitles animated:(BOOL)animated;

@property(nonatomic, strong) NSArray *titlesForComponenets;

@property(nonatomic, strong) NSArray *widthsForComponents;

-(void)selectIndexes:(NSArray *)indexes animated:(BOOL)animated;

@property(nonatomic, assign) BOOL isRangePickerView;

-(void)reloadComponent:(NSInteger)component;

-(void)reloadAllComponents;

@property(nonatomic, assign) NSDate *date; //get/set date.

-(void)setDate:(NSDate *)date animated:(BOOL)animated;

@property (nonatomic, retain) NSDate *minimumDate;

@property (nonatomic, retain) NSDate *maximumDate;

@end

