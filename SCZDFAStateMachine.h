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
