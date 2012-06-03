//
//  SCZDFAStateMachine.m
//  SCZObjCStateMachine
//
//  Created by Peter Suk on 6/2/12.
//  Copyright (c) 2012 Ooghamist LLC. All rights reserved.
//

#import "SCZDFAStateMachine.h"

@implementation SCZDFAAbstractState
@synthesize nextStateName;
@synthesize stateMachine;
- (void)run {}
- (BOOL)isFinalState { return NO; }
@end



@implementation SCZDFAStateMachine
{
    NSString *currentState;
    id currentStateInstance;
}

@synthesize stateName;
@synthesize stateInstance;

//#include <objc/objc-runtime.h>
//id object = [[NSClassFromString(@"TheClassName") alloc] init];
- (void)setStateName:(NSString*)aStateName
{
    stateInstance = [[NSClassFromString(aStateName) alloc] init];
    
    
}

- (NSString*)stateName
{
    if (self.stateInstance == nil)
        return nil;
    return NSStringFromClass([self.stateInstance class]);
}

//[NSString stringWithUTF8String:class_getName(self)]

- (void)transitionState
{
    [self.stateInstance setStateMachine:self];
    [self.stateInstance run];
    NSString *nextStateName = [self.stateInstance nextStateName];
    self.stateName = nextStateName;
}

- (BOOL)isInFinalState
{
    if (self.stateInstance == nil)
        return NO;
    
    return [self.stateInstance isFinalState];
}

@end
