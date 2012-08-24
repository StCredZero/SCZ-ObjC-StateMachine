//
//  SCZDFAStateMachine.m
//  SCZObjCStateMachine
//
//  Created by Peter Suk on 6/2/12.
//  Copyright (c) 2012 Peter Suk. All rights reserved.
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/StCredZero/SCZ-ObjC-StateMachine
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

#import "SCZDFAStateMachine.h"

#pragma mark - SCZDFAState
@implementation SCZDFAAbstractState
@synthesize nextStateName;
@synthesize stateMachine;

- (void)runInMachine:(id)fsm
{
    [self setForMachine:(id)fsm];
    // You fill in the rest below
    [self finishTransition];
}

- (void)setForMachine:(id)fsm
{
    SCZDFAStateMachine *myStateMachine = (SCZDFAStateMachine*)fsm;
    [self setStateMachine:myStateMachine];
}

- (void)finishTransition
{
    if (self.stateMachine)
        [self.stateMachine transitionDidFinish:self];
}

- (BOOL)isFinalState { return NO; }

- (void)run {}

- (NSString*)stateLabel
{
    return [NSString stringWithFormat:@"Waiting"];
}

- (double)nextTransitionDelay
{
    return 0.3f;
}

- (NSInteger)maxCount
{
    return 20;
}

@end

////////////////////////////////////////////////////////////////////////////////
#pragma mark - SCZDFAStateMachine
@implementation SCZDFAStateMachine
{
    NSString *currentState;
    id currentStateInstance;
}

@synthesize stateName;
@synthesize stateInstance;
@synthesize synchronous;
@synthesize transitioning;
@synthesize stateCounts;

-(id)init
{
    if (self = [super init])
    {
        NSString *guid = [[NSProcessInfo processInfo] globallyUniqueString];
        backgroundQueue = dispatch_queue_create([guid UTF8String], NULL);  
        self.synchronous = YES;
    }
    return self;
}

- (void)setStateName:(NSString*)aStateName
{
#if __has_feature(objc_arc)
#else
    if (stateInstance)
    {
        [stateInstance release];
    }
#endif
    stateInstance = [[NSClassFromString(aStateName) alloc] init];
#if __has_feature(objc_arc)
#else
    if (stateInstance)
    {
        [stateInstance retain];
    }
#endif
}

- (NSString*)stateName
{
    if (self.stateInstance == nil)
        return nil;
    return NSStringFromClass([self.stateInstance class]);
}

- (void)start
{
    if (self.synchronous)
    {
        while( ! [self isInFinalState])
        {
            [self transitionState];
        }
    }
    else 
    {
        [self transitionState];
    }
}

- (void)doPreState
{

}

- (NSInteger)preCountForState
{
    if ([self.stateCounts objectForKey:self.stateName])
    {
        NSInteger count = [[self.stateCounts objectForKey:self.stateName] integerValue] + 1;
        [self.stateCounts setObject:[NSNumber numberWithInteger:count] forKey:self.stateName];
        return count;
    }
    [self.stateCounts setObject:[NSNumber numberWithInteger:1] forKey:self.stateName];
    return 1;
}

- (void)transitionState
{
    @synchronized(self)
    {
        if ( ! self.transitioning)
        {
            if ([self preCountForState] <= [self.stateInstance maxCount])
            {
                self.transitioning = YES;
                [self doPreState];
                [self.stateInstance runInMachine:self];
            }
            else
            {
                self.transitioning = YES;
                self.stateName = [self failureStateName];
                [self doPreState];
                [self.stateInstance runInMachine:self];
            }
        }
    }
}

- (NSString*)failureStateName
{
    return @"SCZFailureState";
}

- (void)transitionDidFinish:(id)state
{
    NSString *nextStateName = [self nextStateNameFor:state];
    [self doPostState:nextStateName];
    self.stateName = nextStateName;
    if (self.synchronous) return;
    
    if ( ! [self isInFinalState])
    {
        [self transitionState];
    }
}

- (void)doPostState:(NSString*)nextStateName
{
    
}

- (NSString*)nextStateNameFor:(id)state
{
    return @"Should override this";
}

- (BOOL)isInFinalState
{
    if (self.stateInstance == nil)
    {
        // The state name is something we can't find a class for
        // so we should stop
        return YES; 
    }
    
    return [self.stateInstance isFinalState];
}

- (void)dealloc
{
    dispatch_release(backgroundQueue);
}

@end
