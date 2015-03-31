//
//  ViewController.m
//  OpenCircuit
//
//  Created by August Meyer on 3/19/15.
//  Copyright (c) 2015 LuTec. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import "OCActionSheetPickerView.h"
#import "Common.h"


@interface ViewController () <OCActionSheetPickerViewDelegate>
@property (strong, nonatomic) UIImage *screenshotTaken;
@end

@implementation ViewController


-(void)actionSheetPickerView:(OCActionSheetPickerView *)pickerView didSelectTitles:(NSArray *)titles
{
    
    NSLog(@"%@",titles);
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

- (IBAction)addButtonPressed:(id)sender {
    
    
    OCActionSheetPickerView *picker = [[OCActionSheetPickerView alloc] initWithTitle:@"Single Picker" delegate:self];
    [picker setTag:1];
    [picker setTitlesForComponenets:@[@[@"First", @"Second", @"Third", @"Four", @"Five"]]];
    [picker show];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)shareButtonPressed:(id)sender {
    
    
    
    
    
}

@end
