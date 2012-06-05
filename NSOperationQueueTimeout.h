//
//  NSOperationQueueTimeout.h
//  SCZObjCStateMachine
//
//  Created by Peter Suk on 6/5/12.
//  Copyright (c) 2012 Peter Kwangjun Suk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSOperationQueueTimeout : NSObject
{    
    NSOperationQueue *operationQueue;
}

@property (nonatomic, strong, readonly) NSOperationQueue *operationQueue;

+ (NSOperationQueueTimeout*)withQueue:(NSOperationQueue*)anOperationQueue;
+ (void)withQueue:(NSOperationQueue*)anOperationQueue
         interval:(NSTimeInterval)timeInterval;
- (id)initWithQueue:(NSOperationQueue*)anOperationQueue;
- (void)cancelAllOperations;
- (void)waitUntilAllFinishedOr:(NSTimeInterval)timeInterval;

@end
