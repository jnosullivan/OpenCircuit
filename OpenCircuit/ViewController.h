//
//  ViewController.h
//  OpenCircuit
//
//  Created by August Meyer on 3/19/15.
//  Copyright (c) 2015 LuTec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ScreenShotView.h"
#import "UIView-Drag.h"

@interface ViewController : UIViewController
 {
    
    
    IBOutlet UIImageView *imview;
    UIImageView *imageView1;
}

- (IBAction)shareButtonPressed:(id)sender;

- (IBAction)addButtonPressed:(id)sender;

@end

