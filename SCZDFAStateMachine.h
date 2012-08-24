//
//  SCZDFAStateMachine.h
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

#import <UIKit/UIKit.h>
#include "objc/runtime.h"
#import <dispatch/dispatch.h>

@class SCZDFAStateMachine;

#pragma mark - SCZDFAState
@protocol SCZDFAState <NSObject>

@property (nonatomic, weak) SCZDFAStateMachine * stateMachine;

- (void)runInMachine:(id)fsm;
- (void)setForMachine:(id)fsm;
- (void)finishTransition;
- (NSString *)nextStateName;
- (BOOL)isFinalState;

- (NSString*)stateLabel;
- (double)nextTransitionDelay;
- (NSInteger)maxCount;

@end


@interface SCZDFAAbstractState :  NSObject <SCZDFAState>
{
    NSString *nextStateName;
    SCZDFAStateMachine __weak *stateMachine;
}
@property (nonatomic, strong) NSString *nextStateName;
@end

#pragma mark - SCZDFAStateMachine
@interface SCZDFAStateMachine : NSObject
{
    NSString *stateName;
    id stateInstance;
    dispatch_queue_t backgroundQueue;
    BOOL synchronous;
    BOOL transitioning;
    NSMutableDictionary *stateCounts;
}

@property (nonatomic, strong) NSString *stateName;
@property (nonatomic, strong) id stateInstance;
@property (nonatomic, assign) BOOL synchronous;
@property (nonatomic, assign) BOOL transitioning;
@property (nonatomic, strong) NSMutableDictionary *stateCounts;

- (void)start;
- (void)transitionState;
- (void)transitionDidFinish:(id)state;
- (NSString*)nextStateNameFor:(id)state;
- (BOOL)isInFinalState;

- (NSString*)failureStateName;
@end
