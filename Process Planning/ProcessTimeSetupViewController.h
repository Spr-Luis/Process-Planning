//
//  ProcessTimeSetupViewController.h
//  Process Planning
//
//  Created by Luis Armando Chávez Soto on 19/05/15.
//  Copyright (c) 2015 Luis Chávez. All rights reserved.
//


#import "XLFormViewController.h"

@interface ProcessTimeSetupViewController : XLFormViewController <XLFormDescriptorDelegate>

@property (weak,nonatomic) NSString* processName;
@property (nonatomic) NSInteger tag;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
- (IBAction)saveAction:(UIBarButtonItem *)sender;

@end
