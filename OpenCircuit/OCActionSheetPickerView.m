//
//  OCActionSheetPickerView.m
//  OpenCircuit
//
//  Created by August Meyer on 3/30/15.
//  Copyright (c) 2015 LuTec. All rights reserved.
//


#import "OCActionSheetPickerView.h"
#import <QuartzCore/QuartzCore.h>
#import "OCActionSheetViewController.h"

@interface OCActionSheetPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIPickerView    *_pickerView;
    UIDatePicker    *_datePicker;
    UIToolbar       *_actionToolbar;
    UILabel         *_titleLabel;

    OCActionSheetViewController *_actionSheetController;
}

@end

@implementation OCActionSheetPickerView

@synthesize actionSheetPickerStyle  = _actionSheetPickerStyle;
@synthesize titlesForComponenets    = _titlesForComponenets;
@synthesize widthsForComponents     = _widthsForComponents;
@synthesize isRangePickerView       = _isRangePickerView;
@synthesize delegate                = _delegate;
@synthesize date                    = _date;

- (instancetype)initWithTitle:(NSString *)title delegate:(id<OCActionSheetPickerViewDelegate>)delegate
{
    self = [super init];

    if (self)
    {
        {
            _actionToolbar = [[UIToolbar alloc] init];
            _actionToolbar.barStyle = UIBarStyleBlackTranslucent;
            [_actionToolbar sizeToFit];
            
            CGRect toolbarFrame = _actionToolbar.frame;
            toolbarFrame.size.height = 44;
            _actionToolbar.frame = toolbarFrame;
            
            NSMutableArray *items = [[NSMutableArray alloc] init];
            

            UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(pickerCancelClicked:)];
            [items addObject:cancelButton];
            
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _actionToolbar.frame.size.width-66-57.0-16, 44)];
            _titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
            [_titleLabel setBackgroundColor:[UIColor clearColor]];
            [_titleLabel setTextAlignment:NSTextAlignmentCenter];
            [_titleLabel setText:title];
            [_titleLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
            
            UIBarButtonItem *titlebutton = [[UIBarButtonItem alloc] initWithCustomView:_titleLabel];
            titlebutton.enabled = NO;
            
            

            UIBarButtonItem *nilButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            [items addObject:nilButton];
            

            UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked:)];
            [items addObject:doneButton];
            
            [_actionToolbar setItems:items];
            
            [self addSubview:_actionToolbar];
        }

        {
            _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_actionToolbar.frame) , CGRectGetWidth(_actionToolbar.frame), 216)];
            [_pickerView setShowsSelectionIndicator:YES];
            [_pickerView setDelegate:self];
            [_pickerView setDataSource:self];
            [self addSubview:_pickerView];
        }
        
        {
            _datePicker = [[UIDatePicker alloc] initWithFrame:_pickerView.frame];
            _datePicker.frame = _pickerView.frame;
            [_datePicker setDatePickerMode:UIDatePickerModeDate];
            [self addSubview:_datePicker];
        }
        
        {
            self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
            [self setFrame:CGRectMake(0, 0, CGRectGetWidth(_pickerView.frame), CGRectGetMaxY(_pickerView.frame))];
            [self setActionSheetPickerStyle:OCActionSheetPickerStyleTextPicker];
            
            self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
            _actionToolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            _pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            _datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        }
    }
    
    _delegate = delegate;
    
    return self;
}

-(void)setActionSheetPickerStyle:(OCActionSheetPickerStyle)actionSheetPickerStyle
{
    _actionSheetPickerStyle = actionSheetPickerStyle;
    
    switch (actionSheetPickerStyle) {
        case OCActionSheetPickerStyleTextPicker:
            [_pickerView setHidden:NO];
            [_datePicker setHidden:YES];
            break;
        case OCActionSheetPickerStyleDatePicker:
            [_pickerView setHidden:YES];
            [_datePicker setHidden:NO];
            break;
            
        default:
            break;
    }
}

-(void)pickerCancelClicked:(UIBarButtonItem*)barButton
{
    [self dismiss];
}

-(void)pickerDoneClicked:(UIBarButtonItem*)barButton
{
    if ([self.delegate respondsToSelector:@selector(actionSheetPickerView:didSelectTitles:)])
    {
        NSMutableArray *selectedTitles = [[NSMutableArray alloc] init];
        
        if (_actionSheetPickerStyle == OCActionSheetPickerStyleTextPicker)
        {
            for (NSInteger component = 0; component<_pickerView.numberOfComponents; component++)
            {
                NSInteger row = [_pickerView selectedRowInComponent:component];
                
                if (row!= -1)
                {
                    [selectedTitles addObject:_titlesForComponenets[component][row]];
                }
                else
                {
                    [selectedTitles addObject:[NSNull null]];
                }
            }
            
            [self setSelectedTitles:selectedTitles];
        }
        else if (_actionSheetPickerStyle == OCActionSheetPickerStyleDatePicker)
        {
            [selectedTitles addObject:_datePicker.date];
            [self setDate:_datePicker.date];
            
            [self setSelectedTitles:@[_datePicker.date]];
        }
        
        [self.delegate actionSheetPickerView:self didSelectTitles:selectedTitles];
    }
    
    [self dismiss];
}

-(void)setSelectedTitles:(NSArray *)selectedTitles
{
    [self setSelectedTitles:selectedTitles animated:NO];
}

-(NSArray *)selectedTitles
{
    NSMutableArray *selectedTitles = [[NSMutableArray alloc] init];
    
    if (_actionSheetPickerStyle == OCActionSheetPickerStyleTextPicker)
    {
        NSUInteger totalComponent = _pickerView.numberOfComponents;
        
        for (NSInteger component = 0; component<totalComponent; component++)
        {
            NSInteger selectedRow = [_pickerView selectedRowInComponent:component];
            
            if (selectedRow == -1)
            {
                [selectedTitles addObject:[NSNull null]];
            }
            else
            {
                NSArray *items = _titlesForComponenets[component];
                
                if ([items count] > selectedRow)
                {
                    id selectTitle = items[selectedRow];
                    [selectedTitles addObject:selectTitle];
                }
                else
                {
                    [selectedTitles addObject:[NSNull null]];
                }
            }
        }
    }
    else if (_actionSheetPickerStyle == OCActionSheetPickerStyleDatePicker)
    {
        [selectedTitles addObject:_datePicker.date];
    }
    
    return selectedTitles;
}

-(void)setSelectedTitles:(NSArray *)selectedTitles animated:(BOOL)animated
{
    if (_actionSheetPickerStyle == OCActionSheetPickerStyleTextPicker)
    {
        NSUInteger totalComponent = MIN(selectedTitles.count, _pickerView.numberOfComponents);
        
        for (NSInteger component = 0; component<totalComponent; component++)
        {
            NSArray *items = _titlesForComponenets[component];
            id selectTitle = selectedTitles[component];
            
            if ([items containsObject:selectTitle])
            {
                NSUInteger rowIndex = [items indexOfObject:selectTitle];
                [_pickerView selectRow:rowIndex inComponent:component animated:animated];
            }
        }
    }
    else if (_actionSheetPickerStyle == OCActionSheetPickerStyleDatePicker)
    {
        if (selectedTitles.count && [[selectedTitles firstObject] isKindOfClass:[NSDate class]])
        {
            [self setDate:[selectedTitles firstObject]];
        }
    }
}

-(void)selectIndexes:(NSArray *)indexes animated:(BOOL)animated
{
    if (_actionSheetPickerStyle == OCActionSheetPickerStyleTextPicker)
    {
        NSUInteger totalComponent = MIN(indexes.count, _pickerView.numberOfComponents);
        
        for (NSInteger component = 0; component<totalComponent; component++)
        {
            NSArray *items = _titlesForComponenets[component];
            NSUInteger selectIndex = [indexes[component] unsignedIntegerValue];
            
            if (selectIndex < items.count)
            {
                [_pickerView selectRow:selectIndex inComponent:component animated:animated];
            }
        }
    }
}

-(void)reloadComponent:(NSInteger)component
{
    [_pickerView reloadComponent:component];
}

-(void)reloadAllComponents
{
    [_pickerView reloadAllComponents];
}

-(void) setDate:(NSDate *)date
{
    [self setDate:date animated:NO];
}

-(void)setDate:(NSDate *)date animated:(BOOL)animated
{
    _date = date;
    if (_date != nil)   [_datePicker setDate:_date animated:animated];
}

-(void)setMinimumDate:(NSDate *)minimumDate
{
    _minimumDate = minimumDate;
    
    _datePicker.minimumDate = minimumDate;
}

-(void)setMaximumDate:(NSDate *)maximumDate
{
    _maximumDate = maximumDate;
    
    _datePicker.maximumDate = maximumDate;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    //If having widths
    if (_widthsForComponents)
    {
        //If object isKind of NSNumber class
        if ([_widthsForComponents[component] isKindOfClass:[NSNumber class]])
        {
            CGFloat width = [_widthsForComponents[component] floatValue];
            
            //If width is 0, then calculating it's size.
            if (width == 0)
                return ((pickerView.bounds.size.width-20)-2*(_titlesForComponenets.count-1))/_titlesForComponenets.count;
            //Else returning it's width.
            else
                return width;
        }
        //Else calculating it's size.
        else
            return ((pickerView.bounds.size.width-20)-2*(_titlesForComponenets.count-1))/_titlesForComponenets.count;
    }
    //Else calculating it's size.
    else
    {
        return ((pickerView.bounds.size.width-20)-2*(_titlesForComponenets.count-1))/_titlesForComponenets.count;
    }
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return [_titlesForComponenets count];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_titlesForComponenets[component] count];
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *labelText = [[UILabel alloc] init];
    labelText.font = [UIFont boldSystemFontOfSize:20.0];
    labelText.backgroundColor = [UIColor clearColor];
    [labelText setTextAlignment:NSTextAlignmentCenter];
    [labelText setText:_titlesForComponenets[component][row]];
    return labelText;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([self.delegate respondsToSelector:@selector(actionSheetPickerView:didChangeRow:inComponent:)]) {
        [self.delegate actionSheetPickerView:self didChangeRow:row inComponent:component];
    }
    if (_isRangePickerView && pickerView.numberOfComponents == 3)
    {
        if (component == 0)
        {
            [pickerView selectRow:MAX([pickerView selectedRowInComponent:2], row) inComponent:2 animated:YES];
        }
        else if (component == 2)
        {
            [pickerView selectRow:MIN([pickerView selectedRowInComponent:0], row) inComponent:0 animated:YES];
        }
    }
}

-(void)dismiss
{
    [_actionSheetController dismissWithCompletion:nil];
}

-(void)dismissWithCompletion:(void (^)(void))completion
{
    [_actionSheetController dismissWithCompletion:completion];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)show
{
    [self showWithCompletion:nil];
}

-(void)showWithCompletion:(void (^)(void))completion
{
    [_pickerView reloadAllComponents];
    
    _actionSheetController = [[OCActionSheetViewController alloc] init];
    [_actionSheetController showPickerView:self completion:completion];
    
}

@end

