//
//  NDTBridgeTo.m
//  nodeit
//
//  Created by Alan Shaw on 10/08/2013.
//  Copyright (c) 2013 Alan Shaw. All rights reserved.
//

#import "NDTBridgeTo.h"

@implementation NDTBridgeTo

@synthesize windowObject;

- (void) dealloc {
	windowObject = nil;
}

- (void) attachToWindowObject:(WebScriptObject *)wo {
    windowObject = wo;
    
    /**
     * Invoke a function with the passed args. Used by the bridge to invoke callback functions.
     *
     * @param {Function} fn Function to invoke
     * @param {*} ... Variable length args to pass to the function
     */
    [wo evaluateWebScript:@"window.nodeitBridgeCall = function (fn, er) { var args = Array.prototype.slice.call(arguments, 1); if (er) { args[0] = new Error(er) } fn.apply(window, args) }"];
}

// Call a javascript callback passed to the bridge from the other side
- (void)call:(WebScriptObject *)cb error:(NSString *)msg arguments:(NSArray *)args {
    if (msg == nil) {
        msg = @"";
    }
    
    if (args == nil) {
        args = [NSArray array];
    }
    
    args = [[NSArray arrayWithObjects:cb, msg, nil] arrayByAddingObjectsFromArray: args];
    
    NSLog(@"nodeitBridgeCall %@", args);
    
    [windowObject callWebScriptMethod:@"nodeitBridgeCall" withArguments:args];
}

// Emit an event on the nodeit javascript object
- (void)emit:(NSString *)eventName withArguments:(NSArray *)args {
    NSLog(@"nodeit.emit %@ %@", eventName, args);
    
    [windowObject callWebScriptMethod:@"nodeit.emit"
                        withArguments:[[NSArray arrayWithObject:eventName] arrayByAddingObjectsFromArray:args]];
}

@end