//
//  SCZDFAStateMachine.m
//  SCZObjCStateMachine
//
//  Created by Peter Suk on 6/2/12.
//  Copyright (c) 2012 Ooghamist LLC. All rights reserved.
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
