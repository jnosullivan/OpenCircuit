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
#import "MovableView.h"

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
    [self.superview bringSubviewToFront:self];
    
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
    
    //Basic
    MovableView *movableView = [[MovableView alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    UIImageView *componentx = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    componentx.backgroundColor = [UIColor redColor];
    [movableView addSubview:componentx];
    movableView.backgroundColor = [UIColor greenColor];
    [xview addSubview:movableView];
    
    
    //Complex
    MovableView *movableViewImage = [[MovableView alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    UIImageView *component = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 100, 10)];
    label.text = @"OMHS";
    [label setFont:[UIFont systemFontOfSize:8]];
    label.textAlignment = NSTextAlignmentCenter;
    component.backgroundColor = [UIColor redColor];
    [movableViewImage addSubview:component];
    [movableViewImage addSubview:label];
    movableViewImage.backgroundColor = [UIColor greenColor];
    [xview addSubview:movableViewImage];

    
    
    
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
    
    
    NSMutableArray *sharingItems = [NSMutableArray new];
    
    UIImage *pic = [xview takescreenshot];
    
    [sharingItems addObject:pic];
  

    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
    
    
}

@end
