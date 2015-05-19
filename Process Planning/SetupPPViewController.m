//
//  SetupPPViewController.m
//  Process Planning
//
//  Created by Luis Armando Chávez Soto on 17/05/15.
//  Copyright (c) 2015 Luis Chávez. All rights reserved.
//

#import "SetupPPViewController.h"
#import "ProcessListViewController.h"

@interface SetupPPViewController (){
    NSArray *processes;
    BOOL isArivalTimeZero;
}

@end

@implementation SetupPPViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    processes = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
    self.processViewSelection.pagingEnabled = YES;
    self.processViewSelection.alignment = SwipeViewAlignmentCenter;

    self.circleView.layer.cornerRadius = 45/2.f;
    self.circleView.layer.borderWidth = 2.5f;
    self.circleView.layer.borderColor = [UIColor colorWithRed:71/255.f green:160/255.f blue:219/255.f alpha:1.0].CGColor;
    
    isArivalTimeZero = true;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"processList"]) {
    
        ProcessListViewController *vc = segue.destinationViewController;
        vc.noProcess = [self.processViewSelection currentItemIndex]+1;
    }
}


#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return [processes count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    if (view == nil)
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [label setFont:[UIFont fontWithName:@"Avenir-Medium" size:20]];
        label.textColor = [UIColor lightGrayColor];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        label = (UILabel *)[view viewWithTag:1];
    }
    
    label.text = [processes objectAtIndex:index];
    return view;
}

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    return CGSizeMake(50, 50);
}

-(void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index{
    [swipeView scrollToItemAtIndex:index duration:0.5];
}


- (IBAction)segmentedButton:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.arrivalTimeLabel.text = @"Todos los procesos tendrán un instante de llegada igual a cero.";
            isArivalTimeZero = true;
            break;
        case 1:
            self.arrivalTimeLabel.text = @"Los procesos tendrán instante de llagada diferentes.";
            isArivalTimeZero = false;
            break;
        default:
            break;
    }
}
@end
