//
//  ProcessListViewController.h
//  Process Planning
//
//  Created by Luis Armando Chávez Soto on 18/05/15.
//  Copyright (c) 2015 Luis Chávez. All rights reserved.
//

#import "XLFormViewController.h"

@interface ProcessListViewController : XLFormViewController

@property NSInteger noProcess;
@property (nonatomic,strong) NSMutableArray *processList;

@end
