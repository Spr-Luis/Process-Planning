//
//  SetupPPViewController.h
//  Process Planning
//
//  Created by Luis Armando Chávez Soto on 17/05/15.
//  Copyright (c) 2015 Luis Chávez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"


@interface SetupPPViewController : UIViewController

@property (weak, nonatomic) IBOutlet SwipeView *processViewSelection;
@property (weak, nonatomic) IBOutlet UIView *circleView;

- (IBAction)segmentedButton:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UILabel *arrivalTimeLabel;

@end
