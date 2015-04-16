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
    
    
     UIAlertController *alertController = [UIAlertController
     alertControllerWithTitle:@"Data"
     message:@""
     preferredStyle:UIAlertControllerStyleAlert];
     
     [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
     }];
     
     
     UIAlertAction *cancelAction = [UIAlertAction
     actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
     style:UIAlertActionStyleCancel
     handler:^(UIAlertAction *action)
     {
     }];
     
     UIAlertAction *okAction = [UIAlertAction
     actionWithTitle:NSLocalizedString(@"Create", @"OK action")
     style:UIAlertActionStyleDefault
     handler:^(UIAlertAction *action)
     {
     UITextField *login = alertController.textFields.firstObject;
     
         
         //Complex
         [self createBox:login.text and:[titles objectAtIndex:0]];
         
     }];
     
     [alertController addAction:cancelAction];
     [alertController addAction:okAction];
     
     [self presentViewController:alertController animated:YES completion:nil];

    
    
}

- (void)createBox:(NSString *)title and:(NSString *)str
{
    
    if ([str isEqualToString:@"3-PinBox"]) {
        MovableView *movableViewImage = [[MovableView alloc] initWithFrame:CGRectMake(0, 0, 60, 50)];
        UIImageView *component = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        component.image = [UIImage imageNamed:@"3-PinBox.png"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 60, 10)];
        label.text = title;
        [label setFont:[UIFont systemFontOfSize:8]];
        label.textAlignment = NSTextAlignmentCenter;
        component.backgroundColor = [UIColor redColor];
        [movableViewImage addSubview:component];
        [movableViewImage addSubview:label];
        movableViewImage.backgroundColor = [UIColor clearColor];
        [xview addSubview:movableViewImage];
    }
    
    if ([str isEqualToString:@"Capacitor"]) {
        MovableView *movableViewImage = [[MovableView alloc] initWithFrame:CGRectMake(0, 0, 60, 50)];
        UIImageView *component = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        component.image = [UIImage imageNamed:@"Capacitor.png"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 60, 10)];
        label.text = title;
        [label setFont:[UIFont systemFontOfSize:8]];
        label.textAlignment = NSTextAlignmentCenter;
        component.backgroundColor = [UIColor redColor];
        [movableViewImage addSubview:component];
        [movableViewImage addSubview:label];
        movableViewImage.backgroundColor = [UIColor clearColor];
        [xview addSubview:movableViewImage];
    }
    
    if ([str isEqualToString:@"Generic Component"]) {
        MovableView *movableViewImage = [[MovableView alloc] initWithFrame:CGRectMake(0, 0, 60, 50)];
        UIImageView *component = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        component.image = [UIImage imageNamed:@"Generic Component.png"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 60, 10)];
        label.text = title;
        [label setFont:[UIFont systemFontOfSize:8]];
        label.textAlignment = NSTextAlignmentCenter;
        component.backgroundColor = [UIColor redColor];
        [movableViewImage addSubview:component];
        [movableViewImage addSubview:label];
        movableViewImage.backgroundColor = [UIColor clearColor];
        [xview addSubview:movableViewImage];
    }
    
    if ([str isEqualToString:@"Ground"]) {
        MovableView *movableViewImage = [[MovableView alloc] initWithFrame:CGRectMake(0, 0, 60, 50)];
        UIImageView *component = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        component.image = [UIImage imageNamed:@"Ground.png"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 60, 10)];
        label.text = title;
        [label setFont:[UIFont systemFontOfSize:8]];
        label.textAlignment = NSTextAlignmentCenter;
        component.backgroundColor = [UIColor redColor];
        [movableViewImage addSubview:component];
        [movableViewImage addSubview:label];
        movableViewImage.backgroundColor = [UIColor clearColor];
        [xview addSubview:movableViewImage];
    }
    
    if ([str isEqualToString:@"Inductor"]) {
        MovableView *movableViewImage = [[MovableView alloc] initWithFrame:CGRectMake(0, 0, 60, 50)];
        UIImageView *component = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        component.image = [UIImage imageNamed:@"Inductor.png"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 60, 10)];
        label.text = title;
        [label setFont:[UIFont systemFontOfSize:8]];
        label.textAlignment = NSTextAlignmentCenter;
        component.backgroundColor = [UIColor redColor];
        [movableViewImage addSubview:component];
        [movableViewImage addSubview:label];
        movableViewImage.backgroundColor = [UIColor clearColor];
        [xview addSubview:movableViewImage];
    }
    
    if ([str isEqualToString:@"LED Diode"]) {
        MovableView *movableViewImage = [[MovableView alloc] initWithFrame:CGRectMake(0, 0, 60, 50)];
        UIImageView *component = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        component.image = [UIImage imageNamed:@"LED Diode.png"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 60, 10)];
        label.text = title;
        [label setFont:[UIFont systemFontOfSize:8]];
        label.textAlignment = NSTextAlignmentCenter;
        component.backgroundColor = [UIColor redColor];
        [movableViewImage addSubview:component];
        [movableViewImage addSubview:label];
        movableViewImage.backgroundColor = [UIColor clearColor];
        [xview addSubview:movableViewImage];
    }
    
    if ([str isEqualToString:@"Power"]) {
        MovableView *movableViewImage = [[MovableView alloc] initWithFrame:CGRectMake(0, 0, 60, 50)];
        UIImageView *component = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        component.image = [UIImage imageNamed:@"Power.png"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 60, 10)];
        label.text = title;
        [label setFont:[UIFont systemFontOfSize:8]];
        label.textAlignment = NSTextAlignmentCenter;
        component.backgroundColor = [UIColor redColor];
        [movableViewImage addSubview:component];
        [movableViewImage addSubview:label];
        movableViewImage.backgroundColor = [UIColor clearColor];
        [xview addSubview:movableViewImage];
    }
    
    if ([str isEqualToString:@"Resistor"]) {
        MovableView *movableViewImage = [[MovableView alloc] initWithFrame:CGRectMake(0, 0, 60, 50)];
        UIImageView *component = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        component.image = [UIImage imageNamed:@"Resistor.png"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 60, 10)];
        label.text = title;
        [label setFont:[UIFont systemFontOfSize:8]];
        label.textAlignment = NSTextAlignmentCenter;
        component.backgroundColor = [UIColor redColor];
        [movableViewImage addSubview:component];
        [movableViewImage addSubview:label];
        movableViewImage.backgroundColor = [UIColor clearColor];
        [xview addSubview:movableViewImage];
    }
    
    if ([str isEqualToString:@"RGB LED"]) {
        MovableView *movableViewImage = [[MovableView alloc] initWithFrame:CGRectMake(0, 0, 60, 50)];
        UIImageView *component = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        component.image = [UIImage imageNamed:@"RGB LED.png"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 60, 10)];
        label.text = title;
        [label setFont:[UIFont systemFontOfSize:8]];
        label.textAlignment = NSTextAlignmentCenter;
        component.backgroundColor = [UIColor redColor];
        [movableViewImage addSubview:component];
        [movableViewImage addSubview:label];
        movableViewImage.backgroundColor = [UIColor clearColor];
        [xview addSubview:movableViewImage];
    }
    
    if ([str isEqualToString:@"Switch"]) {
        MovableView *movableViewImage = [[MovableView alloc] initWithFrame:CGRectMake(0, 0, 60, 50)];
        UIImageView *component = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        component.image = [UIImage imageNamed:@"Switch.png"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 60, 10)];
        label.text = title;
        [label setFont:[UIFont systemFontOfSize:8]];
        label.textAlignment = NSTextAlignmentCenter;
        component.backgroundColor = [UIColor redColor];
        [movableViewImage addSubview:component];
        [movableViewImage addSubview:label];
        movableViewImage.backgroundColor = [UIColor clearColor];
        [xview addSubview:movableViewImage];
    }
    
    if ([str isEqualToString:@"Transistor"]) {
        MovableView *movableViewImage = [[MovableView alloc] initWithFrame:CGRectMake(0, 0, 60, 50)];
        UIImageView *component = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        component.image = [UIImage imageNamed:@"Transistor.png"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 60, 10)];
        label.text = title;
        [label setFont:[UIFont systemFontOfSize:8]];
        label.textAlignment = NSTextAlignmentCenter;
        component.backgroundColor = [UIColor redColor];
        [movableViewImage addSubview:component];
        [movableViewImage addSubview:label];
        movableViewImage.backgroundColor = [UIColor clearColor];
        [xview addSubview:movableViewImage];
    }
    
    if ([str isEqualToString:@"Wire"]) {
        MovableView *movableViewImage = [[MovableView alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
        UIImageView *component = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
        component.image = [UIImage imageNamed:@"Wire.png"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 10)];
        label.text = title;
        [label setFont:[UIFont systemFontOfSize:8]];
        label.textAlignment = NSTextAlignmentCenter;
        component.backgroundColor = [UIColor redColor];
        [movableViewImage addSubview:component];
        [movableViewImage addSubview:label];
        movableViewImage.backgroundColor = [UIColor clearColor];
        [xview addSubview:movableViewImage];
    }
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

- (IBAction)addButtonPressed:(id)sender {
    
    OCActionSheetPickerView *picker = [[OCActionSheetPickerView alloc] initWithTitle:@"Com" delegate:self];
    [picker setTag:1];
    [picker setTitlesForComponenets:@[@[@"3-PinBox", @"Capacitor", @"Generic Component", @"Ground", @"Inductor", @"LED Diode", @"Power", @"Resistor", @"RGB LED", @"Switch", @"Transistor", @"Wire"]]];
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
