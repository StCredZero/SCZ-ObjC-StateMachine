//
//  ObjCStateMachineUnitTests.m
//  ObjCStateMachineUnitTests
//
//  Created by Peter Suk on 6/2/12.
//  Copyright (c) 2012 Peter Suk. All rights reserved.
//

#import "RegexpTest1.h"
#import "ObjCStateMachineUnitTests.h"

@implementation ObjCStateMachineUnitTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testAA
{
    T1StateMachine *stateMachine = [[T1StateMachine alloc] init];
    stateMachine.inputString = @"AA";
    stateMachine.stateName = @"T1InitialState";
    [stateMachine transitionState];
    [stateMachine waitUntilFinalState];
    STAssertTrue([stateMachine isInFinalState],@"Should be in final state");
}

- (void)testBB
{
    T1StateMachine *stateMachine = [[T1StateMachine alloc] init];
    stateMachine.inputString = @"BB";
    stateMachine.stateName = @"T1InitialState";
    [stateMachine transitionState];
    [stateMachine waitUntilFinalState];
    STAssertTrue([stateMachine isInFinalState],@"Should be in final state");
}

@end
