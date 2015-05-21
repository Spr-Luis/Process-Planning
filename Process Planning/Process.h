//
//  Process.h
//  Process Planning
//
//  Created by Luis Armando Chávez Soto on 20/05/15.
//  Copyright (c) 2015 Luis Chávez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Process : NSObject

@property (nonatomic, retain) NSNumber *iD;
@property (nonatomic, retain) NSString *name;

@property (nonatomic, retain) NSMutableArray *exections;
@property (nonatomic, retain) NSDictionary *data;

@property (nonatomic, readonly) NSInteger returnTime;
@property (nonatomic, readonly) NSInteger waitTime;

@end
