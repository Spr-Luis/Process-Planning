//
//  FCFS_Algorithm.m
//  Process Planning
//
//  Created by Luis Armando Chávez Soto on 20/05/15.
//  Copyright (c) 2015 Luis Chávez. All rights reserved.
//

#import "FCFS_Algorithm.h"
#import "NSDate+MTDates.h"



NSString* const kInitialTime = @"initialTime";
NSString* const kProcessTimes = @"times";

@implementation FCFS_Algorithm

+(Process *)setupProcessDateWithName:(NSString*)name info:(NSDictionary *)processInfo{

    
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
                exec.startDate = [[NSDate date]mt_startOfCurrentDay];
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
    
    return process;
}


+(Process *)setupProcessTimeWithName:(NSString*)name info:(NSDictionary *)processInfo{
    
    
    Process *process = [[Process alloc] init];
    process.name =  name;
    process.exections = [NSMutableArray array];
    process.data = processInfo;
    
    for (int i = 0; i < [[processInfo objectForKey:kProcessTimes] count]; i++) {
        //NSLog(@"i = %d",i);
        Execution *exec = [[Execution alloc] init];
        
        if(i % 2){
            //NSLog(@"Impar");
            exec.startTime = [(Execution*)[process.exections objectAtIndex:i-1] endTime];
            exec.endTime = exec.startTime + [[[processInfo objectForKey:kProcessTimes] objectAtIndex:i] integerValue];
            exec.durationTime = exec.endTime - exec.startTime;
            exec.executionType = @"E/S";
            [process.exections addObject:exec];
            
        }else{
            //NSLog(@"Par");
            
            if (i == 0) {
                exec.startTime = 0;
                exec.endTime = exec.startTime + [[[processInfo objectForKey:kProcessTimes] objectAtIndex:i] integerValue];
                exec.durationTime = exec.endTime - exec.startTime;
                exec.executionType = @"CPU";
                //NSLog(@"Start: %@",exec.startDate);
                //NSLog(@"End: %@", exec.endDate);
                
                [process.exections addObject:exec];
            }else{
                exec.startTime = [(Execution*)[process.exections objectAtIndex:i-1] endTime];
                exec.endTime = exec.startTime + [[[processInfo objectForKey:kProcessTimes] objectAtIndex:i] integerValue];
                exec.durationTime = exec.endTime - exec.startTime;
                exec.executionType = @"CPU";
                [process.exections addObject:exec];
                
            }
        }
    }
    
    NSLog(@"Process Name: %@", process.name);
    
    for (Execution* ex in process.exections) {
        NSLog(@"%@ ::: %d -> %d ::: %d", ex.executionType, ex.startTime, ex.endTime,ex.durationTime);
    }
    
    return process;
}

+(NSArray*)FCFSWithProcessList:(NSDictionary *)info{
    
    NSMutableArray *allProcess = [NSMutableArray array];
    for (NSString *nameKey in [info allKeys]) {
        [allProcess addObject:[FCFS_Algorithm setupProcessTimeWithName:nameKey info:[info objectForKey:nameKey]]];
    }
    
    
// Iteration of all process
    for (int i = 0; i < [allProcess count]; i++) {
        
        /*
        if (i%2) {
            // Impar
            Process *processE_S = [allProcess objectAtIndex:i];
            
            if (i != 0) {
                ((Execution*)[processE_S.exections objectAtIndex:i]).startTime = ((Execution*)[processE_S.exections objectAtIndex:i-1]).endTime;
                ((Execution*)[processE_S.exections objectAtIndex:i]).endTime = ((Execution*)[processE_S.exections objectAtIndex:i]).startTime +((Execution*)[processE_S.exections objectAtIndex:i]).durationTime;
            }
            
            
        }else{
            // Par
            
            Process *processA = [allProcess objectAtIndex:i];
            if (i != [allProcess count]-1) {
                Process *processB = [allProcess objectAtIndex:i+1];
                
                // CPU
                ((Execution*)[processB.exections objectAtIndex:i]).startTime = ((Execution*)[[processA exections]objectAtIndex:i]).durationTime + ((Execution*)[[processA exections]objectAtIndex:i]).startTime;
                ((Execution*)[processB.exections objectAtIndex:i]).endTime = ((Execution*)[[processB exections]objectAtIndex:i]).durationTime + ((Execution*)[[processB exections]objectAtIndex:i]).startTime;
                
                
            }
        }*/
        
        /*
        Process *process_A = [allProcess objectAtIndex:i];
        if (i != 0) {
            ((Execution*)[process_A.exections objectAtIndex:i]).startTime = ((Execution*)[process_A.exections objectAtIndex:i-1]).endTime;
            ((Execution*)[process_A.exections objectAtIndex:i]).endTime = ((Execution*)[process_A.exections objectAtIndex:i]).startTime +((Execution*)[process_A.exections objectAtIndex:i]).durationTime;
        }

        if (i != [allProcess count]-1) {
            Process *process_B = [allProcess objectAtIndex:i+1];
            
            
            if (i%2) {
                // Impar
                // E/S
                if (i != 0) {
                    ((Execution*)[process_B.exections objectAtIndex:i]).startTime = ((Execution*)[process_B.exections objectAtIndex:i-1]).endTime;
                    ((Execution*)[process_B.exections objectAtIndex:i]).endTime = ((Execution*)[process_B.exections objectAtIndex:i]).startTime +((Execution*)[process_B.exections objectAtIndex:i]).durationTime;
                }
                
            }else{
                // Par
                // CPU
                ((Execution*)[process_B.exections objectAtIndex:i]).startTime = ((Execution*)[[process_A exections]objectAtIndex:i]).durationTime + ((Execution*)[[process_A exections]objectAtIndex:i]).startTime;
                ((Execution*)[process_B.exections objectAtIndex:i]).endTime = ((Execution*)[[process_B exections]objectAtIndex:i]).durationTime + ((Execution*)[[process_B exections]objectAtIndex:i]).startTime;
            }
        }*/
        NSLog(@"*");
        NSLog(@"*");
        NSLog(@"*");
        NSLog(@"*");
        NSLog(@"*");
        NSLog(@"*");
        
        /*
        Process *process_A = [allProcess objectAtIndex:i];
        
        if (i != [allProcess count]-1) {
            Process *process_B = [allProcess objectAtIndex:i+1];
                        
            for (int k = 0; [process_A.exections count] >= [process_B.exections count]? k<[process_B.exections count] : k<[process_A.exections count]; k++) {
                
                if (k != 0) {
                    ((Execution*)[process_A.exections objectAtIndex:k]).startTime = ((Execution*)[process_A.exections objectAtIndex:k-1]).endTime;
                    ((Execution*)[process_A.exections objectAtIndex:k]).endTime = ((Execution*)[process_A.exections objectAtIndex:k]).startTime +((Execution*)[process_A.exections objectAtIndex:k]).durationTime;
                }
                
                if (k%2) {
                    // Impar
                    // E/S
                    
                    
                }else{
                    // Par
                    // CPU
                    ((Execution*)[process_B.exections objectAtIndex:k]).startTime = ((Execution*)[[process_A exections]objectAtIndex:k]).durationTime + ((Execution*)[[process_A exections]objectAtIndex:k]).startTime;
                    ((Execution*)[process_B.exections objectAtIndex:k]).endTime = ((Execution*)[[process_B exections]objectAtIndex:k]).durationTime + ((Execution*)[[process_B exections]objectAtIndex:k]).startTime;
                    
                    if (k != 0) {
                        ((Execution*)[process_B.exections objectAtIndex:k]).startTime = ((Execution*)[process_B.exections objectAtIndex:k-1]).endTime;
                        ((Execution*)[process_B.exections objectAtIndex:k]).endTime = ((Execution*)[process_B.exections objectAtIndex:k]).startTime +((Execution*)[process_B.exections objectAtIndex:k]).durationTime;
                    }
                }
                
                NSLog(@"Process A: %@",process_A.name);
                NSLog(@"%@ ::: %ld -> %ld ::: %ld",((Execution*)[process_A.exections objectAtIndex:k]).executionType, (long)((Execution*)[process_A.exections objectAtIndex:k]).startTime,(long)((Execution*)[process_A.exections objectAtIndex:k]).endTime, (long)((Execution*)[process_A.exections objectAtIndex:k]).durationTime);
                
                NSLog(@"Process B: %@",process_B.name);
                NSLog(@"%@ ::: %ld -> %ld ::: %ld",((Execution*)[process_B.exections objectAtIndex:k]).executionType, (long)((Execution*)[process_B.exections objectAtIndex:k]).startTime,(long)((Execution*)[process_B.exections objectAtIndex:k]).endTime, (long)((Execution*)[process_B.exections objectAtIndex:k]).durationTime);

            }
            
            
        }
        
    }*/
        
        Process *process_A = [allProcess objectAtIndex:i];
        
        if (i != [allProcess count]-1) {
            Process *process_B = [allProcess objectAtIndex:i+1];
            
            for (int k = 0; [process_A.exections count] >= [process_B.exections count]? k<[process_B.exections count] : k<[process_A.exections count]; k++) {
                
                if (k != 0) {
        
                    if ([((Execution*)[process_A.exections objectAtIndex:k]).executionType isEqualToString:@"CPU"] && k >=2) {
                        ((Execution*)[process_A.exections objectAtIndex:k]).startTime = ((Execution*)[process_B.exections objectAtIndex:k-2]).endTime;
                        ((Execution*)[process_A.exections objectAtIndex:k]).endTime = ((Execution*)[process_A.exections objectAtIndex:k]).startTime +((Execution*)[process_A.exections objectAtIndex:k]).durationTime;
                    }
                
                }
                
                if ([((Execution*)[process_B.exections objectAtIndex:k]).executionType isEqualToString:@"CPU"]) {
                    // CPU - B
                    if (k > 1){
                        ((Execution*)[process_B.exections objectAtIndex:k]).startTime = ((Execution*)[[process_B exections]objectAtIndex:k-1]).endTime;
                        ((Execution*)[process_B.exections objectAtIndex:k]).endTime = ((Execution*)[[process_B exections]objectAtIndex:k]).durationTime + ((Execution*)[[process_B exections]objectAtIndex:k]).startTime;
                    }else{
                        ((Execution*)[process_B.exections objectAtIndex:k]).startTime = ((Execution*)[[process_A exections]objectAtIndex:k]).durationTime + ((Execution*)[[process_A exections]objectAtIndex:k]).startTime;
                        ((Execution*)[process_B.exections objectAtIndex:k]).endTime = ((Execution*)[[process_B exections]objectAtIndex:k]).durationTime + ((Execution*)[[process_B exections]objectAtIndex:k]).startTime;

                    }
                }else{
                        // E/S - B
                        ((Execution*)[process_B.exections objectAtIndex:k]).startTime = ((Execution*)[process_B.exections objectAtIndex:k-1]).endTime;
                        ((Execution*)[process_B.exections objectAtIndex:k]).endTime = ((Execution*)[process_B.exections objectAtIndex:k]).startTime +((Execution*)[process_B.exections objectAtIndex:k]).durationTime;
                }
                
                
                NSLog(@"Process A: %@",process_A.name);
                NSLog(@"%@ ::: %ld -> %ld ::: %ld",((Execution*)[process_A.exections objectAtIndex:k]).executionType, (long)((Execution*)[process_A.exections objectAtIndex:k]).startTime,(long)((Execution*)[process_A.exections objectAtIndex:k]).endTime, (long)((Execution*)[process_A.exections objectAtIndex:k]).durationTime);
                
                NSLog(@"Process B: %@",process_B.name);
                NSLog(@"%@ ::: %ld -> %ld ::: %ld",((Execution*)[process_B.exections objectAtIndex:k]).executionType, (long)((Execution*)[process_B.exections objectAtIndex:k]).startTime,(long)((Execution*)[process_B.exections objectAtIndex:k]).endTime, (long)((Execution*)[process_B.exections objectAtIndex:k]).durationTime);
                
            }
            
            
        }
        
    }

    
    NSLog(@"*");
    NSLog(@"*");
    NSLog(@"*");
    NSLog(@"*");
    NSLog(@"*");
    NSLog(@"*");
    
    for (Process *proc in allProcess) {
     
        NSLog(@"Process Name: %@", proc.name);
        
        for (Execution* ex in proc.exections) {
            NSLog(@"%@ ::: %ld -> %ld ::: %ld", ex.executionType, (long)ex.startTime, (long)ex.endTime,(long)
                  ex.durationTime);
        }
        
    }
    
    return nil;
}
                                  
@end
