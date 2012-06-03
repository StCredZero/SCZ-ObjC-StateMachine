//
//  RegexpTest1.m
//  SCZObjCStateMachine
//
//  Created by Peter Suk on 6/2/12.
//  Copyright (c) 2012 Ooghamist LLC. All rights reserved.
//

#import "RegexpTest1.h"

/*
 
Implements a simple DFA for test purposes.
 
            <Initial>
             /     \
            A       B
           /         \
        <A2>         <B2>
           \         /
            A       B
             \     /
             <Final>
 
 This is just the regular expression (.*(AA|BB))

 You shouldn't use an OOP state machine framework like this for 
 something that needs to be tight and fast like parsing regexp,
 but we implemented this as a simple example for the test.
 
 */

@implementation T1StateMachine
@synthesize index;
@synthesize inputString;
-(id)init {
    self = [super init];
    if(self) {
        self.index = 0;
    }
    return self;
}
- (void)increment;
{
    self.index += 1;
}
- (unichar)currentChar
{
    return [self.inputString characterAtIndex:self.index];
}

@end

@implementation T1State
- (T1StateMachine*)t1StateMachine
{
    return (T1StateMachine*)self.stateMachine;
}
- (unichar)currentChar
{
    return [[self t1StateMachine] currentChar];
}
- (void)increment
{
    [[self t1StateMachine] increment];
}
- (void)run {}
- (BOOL)isFinalState { return NO; }
@end

@implementation T1InitialState
- (void)run 
{
    switch ([self currentChar]) 
    {
        case 'A': self.nextStateName = @"T1StateA2"; break;
        case 'B': self.nextStateName = @"T1StateB2"; break;
    } 
    [self increment];
}
- (BOOL)isFinalState { return NO; }
@end

@implementation T1StateA2
- (void)run 
{
    if ([self currentChar] == 'A')
    {
        self.nextStateName = @"T1FinalState";
    }
    else 
    {
        self.nextStateName = @"T1InitialState";
    }
    [self increment];
}
- (BOOL)isFinalState { return NO; }
@end

@implementation T1StateB2
- (void)run 
{
    if ([self currentChar] == 'B')
    {
        self.nextStateName = @"T1FinalState";
    }
    else 
    {
        self.nextStateName = @"T1InitialState";
    }
    [self increment];
}
- (BOOL)isFinalState { return NO; }
@end

@implementation T1FinalState
- (void)run { }
- (BOOL)isFinalState { return YES; }
@end


