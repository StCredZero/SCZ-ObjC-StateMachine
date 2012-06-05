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
- (void)run {}
- (void)finishTransition
{
    [self.stateMachine transitionDidFinish:self.nextStateName];
}
- (BOOL)isFinalState { return NO; }
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
@synthesize operationQueue;

-(id)init
{
    if (self = [super init])
    {
        self.operationQueue = [[NSOperationQueue alloc] init];
        [self.operationQueue setMaxConcurrentOperationCount:1];
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

- (void)transitionState
{
    [self.stateInstance setStateMachine:self];
    [self.operationQueue addOperationWithBlock: 
     ^{
        [self.stateInstance run];
     }];
}

- (void)transitionDidFinish:(NSString*)nextStateName
{
    self.stateName = nextStateName;
    if ( ! [self isInFinalState])
    {
        [self transitionState];
    }
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

- (void)waitUntilFinalState
{
    [self.operationQueue waitUntilAllOperationsAreFinished];
}

@end
