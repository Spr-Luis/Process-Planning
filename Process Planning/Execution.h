//
//  Execution.h
//  Process Planning
//
//  Created by Luis Armando Chávez Soto on 20/05/15.
//  Copyright (c) 2015 Luis Chávez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Execution : NSObject

@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) NSDate *endDate;

@property (nonatomic) NSInteger startTime;
@property (nonatomic) NSInteger endTime;
@property (nonatomic) NSInteger durationTime;

@property (nonatomic, retain) NSString *executionType;

@end
