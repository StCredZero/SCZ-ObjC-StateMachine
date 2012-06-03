//
//  RegexpTest1.h
//  SCZObjCStateMachine
//
//  Created by Peter Suk on 6/2/12.
//  Copyright (c) 2012 Ooghamist LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCZDFAStateMachine.h"

@interface T1StateMachine : SCZDFAStateMachine
{
    NSUInteger index;
    NSString *inputString;
}
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, strong) NSString *inputString;
- (void)increment;
- (unichar)currentChar;
@end

@interface T1State :  SCZDFAAbstractState
@end

@interface T1InitialState :  T1State <SCZDFAState>
@end

@interface T1StateA2 :  T1State <SCZDFAState>
@end

@interface T1StateB2 :  T1State <SCZDFAState>
@end

@interface T1FinalState :  T1State <SCZDFAState>
@end
