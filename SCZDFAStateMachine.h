//
//  SCZDFAStateMachine.h
//  SCZObjCStateMachine
//
//  Created by Peter Suk on 6/2/12.
//  Copyright (c) 2012 Peter Suk. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "objc/runtime.h"

@class SCZDFAStateMachine;

@protocol SCZDFAState <NSObject>

@property (nonatomic, weak) SCZDFAStateMachine * stateMachine;

- (void)run;
- (NSString *)nextStateName;
- (BOOL)isFinalState;

@end

@interface SCZDFAAbstractState :  NSObject <SCZDFAState>
{
    NSString *nextStateName;
    SCZDFAStateMachine __weak *stateMachine;
}
@property (nonatomic, strong) NSString *nextStateName;
@end


@interface SCZDFAStateMachine : NSObject
{
    NSString *stateName;
    id stateInstance;
}

@property (nonatomic, strong) NSString *stateName;
@property (nonatomic, strong) id stateInstance;

- (void)transitionState;
- (BOOL)isInFinalState;

@end
