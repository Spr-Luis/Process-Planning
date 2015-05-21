//
//  FCFS_Algorithm.m
//  Process Planning
//
//  Created by Luis Armando Chávez Soto on 20/05/15.
//  Copyright (c) 2015 Luis Chávez. All rights reserved.
//

#import "FCFS_Algorithm.h"

#import "Execution.h"
#import "Process.h"

NSString* const kInitialTime = @"initialTime";
NSString* const kProcessTimes = @"times";

@implementation FCFS_Algorithm

+(void)setupProcessWithName:(NSString*)name info:(NSDictionary *)processInfo{

    
    Process *process = [[Process alloc] init];
    process.name =  name;
    process.exections = [NSMutableArray array];
    process.data = processInfo;

    for (int i = 0; i < [[processInfo objectForKey:kProcessTimes] count]; i++) {
        //NSLog(@"i = %d",i);
        Execution *exec = [[Execution alloc] init];

        if(i % 2){
            //NSLog(@"Impar");
            exec.startDate = [(Execution*)[process.exections objectAtIndex:i-1] endDate];
            exec.endDate = [exec.startDate dateByAddingTimeInterval:[[[processInfo objectForKey:kProcessTimes] objectAtIndex:i] integerValue]];
            exec.executionType = @"E/S";
            [process.exections addObject:exec];

        }else{
            //NSLog(@"Par");
            
            if (i == 0) {
                exec.startDate = [self dateAtStartOfDay];
                exec.endDate = [exec.startDate dateByAddingTimeInterval:[[[processInfo objectForKey:kProcessTimes] objectAtIndex:i] integerValue]];
                exec.executionType = @"CPU";
                //NSLog(@"Start: %@",exec.startDate);
                //NSLog(@"End: %@", exec.endDate);
                
                [process.exections addObject:exec];
            }else{
                exec.startDate = [(Execution*)[process.exections objectAtIndex:i-1] endDate];
                exec.endDate = [exec.startDate dateByAddingTimeInterval:[[[processInfo objectForKey:kProcessTimes] objectAtIndex:i] integerValue]];
                exec.executionType = @"CPU";
                [process.exections addObject:exec];

            }
        }
    }
    
    NSLog(@"Process Name: %@", process.name);
    
    for (Execution* ex in process.exections) {
        NSLog(@"%@ -> %@ -> %@", ex.executionType, ex.startDate, ex.endDate);
    }
}

                                  
                                  
+ (NSDate *) dateAtStartOfDay{
                    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal) fromDate:[NSDate date]];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    [components setNanosecond:0];
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}
                                  
@end
