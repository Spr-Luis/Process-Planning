//
//  ProcessManager.h
//  Process Planning
//
//  Created by Luis Armando Chávez Soto on 19/05/15.
//  Copyright (c) 2015 Luis Chávez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProcessManager : NSObject

+ (id)sharedManager;

@property (nonatomic, retain) NSMutableDictionary *processList;

@end
