//
//  ViewController.m
//  OpenCircuit
//
//  Created by August Meyer on 3/19/15.
//  Copyright (c) 2015 LuTec. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()
@property (strong, nonatomic) UIImage *screenshotTaken;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.screenshotTaken = [self.view takescreenshot];

    
    imview.image = self.screenshotTaken;
    
   
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)shareButtonPressed:(id)sender {


}

@end
