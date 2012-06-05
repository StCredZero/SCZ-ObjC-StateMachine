//
//  NSOperationQueueTimeout.h
//  SCZObjCStateMachine
//
//  Created by Peter Suk on 6/5/12.
//  Copyright (c) 2012 Peter Kwangjun Suk. All rights reserved.
//

#import "NSOperationQueueTimeout.h"


@interface NSOperationQueueTimeout()
@property (nonatomic, strong, readwrite) NSOperationQueue *operationQueue;
@end


@implementation NSOperationQueueTimeout
@synthesize operationQueue;

+ (NSOperationQueueTimeout*)withQueue:(NSOperationQueue*)anOperationQueue
{
    return [[NSOperationQueueTimeout alloc] initWithQueue:anOperationQueue];
}

+ (void)withQueue:(NSOperationQueue*)anOperationQueue
         interval:(NSTimeInterval)timeInterval 
{
    [[self withQueue:anOperationQueue] waitUntilAllFinishedOr:timeInterval];
}

-(id)initWithQueue:(NSOperationQueue*)anOperationQueue
{
    if (self = [self init])
    {
        self.operationQueue = anOperationQueue;
    }
    return self;
}

- (void)cancelAllOperations
{
    @synchronized(self)
    {
        if (self.operationQueue)
        {
            [self.operationQueue cancelAllOperations];
        }
    }
}

- (void)waitUntilAllFinishedOr:(NSTimeInterval)timeInterval 
{
    [self performSelector:@selector(cancelAllOperations) 
                 onThread:[NSThread mainThread] 
               withObject:self 
            waitUntilDone:NO];
    
    [self.operationQueue waitUntilAllOperationsAreFinished];
    [self cancelAllOperations];
}

@end
