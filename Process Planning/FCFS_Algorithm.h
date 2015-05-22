//
//  FCFS_Algorithm.h
//  Process Planning
//
//  Created by Luis Armando Chávez Soto on 20/05/15.
//  Copyright (c) 2015 Luis Chávez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Execution.h"
#import "Process.h"

@interface FCFS_Algorithm : NSObject

+(NSArray*)FCFSWithProcessList:(NSDictionary *)info;
@end
