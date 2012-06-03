SCZ-ObjC-StateMachine
=====================

Implementation of an OOP state machine. This isn't for something that needs to be
tight and fast. Instead, use it when you want to integrate a Finite State Automaton
with Protocols or the Delegate pattern or other patterns in Objective-C. 

Code targets iOS 5 with ARC. 

Each state is an Objective-C class which implements the SCZDFAState protocol, 
consisting of 3 simple methods. 