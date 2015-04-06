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


@interface DragView : UIView
{
    CGPoint previousLocation;
}
@end

@implementation DragView
- (id) initWithImage: (CGRect *) anImage
{
    if (self = [super initWithFrame:*anImage])
    {
        self.userInteractionEnabled = YES;
        UIPanGestureRecognizer *panRecognizer =
        [[UIPanGestureRecognizer alloc]
         
         initWithTarget:self action:@selector(handlePan:)];
        self.gestureRecognizers = @[panRecognizer];
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Promote the touched view
    [self.superview bringSubviewToFront:self];
    
    // Remember original location
    previousLocation = self.center;
}

- (void) handlePan: (UIPanGestureRecognizer *) uigr
{
    CGPoint translation = [uigr translationInView:self.superview];
    self.center = CGPointMake(previousLocation.x + translation.x,
                              previousLocation.y + translation.y);}
@end


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
    
    DragView *view = [[DragView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    view.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:view];
    
    
    /*
    
    OCActionSheetPickerView *picker = [[OCActionSheetPickerView alloc] initWithTitle:@"Single Picker" delegate:self];
    [picker setTag:1];
    [picker setTitlesForComponenets:@[@[@"First", @"Second", @"Third", @"Four", @"Five"]]];
    [picker show];
    */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)shareButtonPressed:(id)sender {
    
    
    
    
    
}

@end
