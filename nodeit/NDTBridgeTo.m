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

#pragma mark -
#pragma mark NDTBridgeTo

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
    
    WebScriptObject* nodeit = [windowObject evaluateWebScript:@"nodeit"];
    
    [nodeit callWebScriptMethod:@"emit"
                  withArguments:[[NSArray arrayWithObject:eventName] arrayByAddingObjectsFromArray:args]];
}

// Create a new file
- (void)neu {
    NSLog(@"New file");
    WebScriptObject* nodeit = [windowObject evaluateWebScript:@"nodeit"];
    [nodeit callWebScriptMethod:@"neu" withArguments:nil];
}

// Open an unknown file (select file from dialog)
- (void)open {
    NSLog(@"Open unknown file");
    WebScriptObject* nodeit = [windowObject evaluateWebScript:@"nodeit"];
    [nodeit callWebScriptMethod:@"open" withArguments:nil];
}

// Open a particular file
- (void)open:(NSString *)path {
    NSLog(@"Open file %@", path);
    WebScriptObject* nodeit = [windowObject evaluateWebScript:@"nodeit"];
    [nodeit callWebScriptMethod:@"open" withArguments:[NSArray arrayWithObject:path]];
}

- (void)save {
    NSLog(@"Save file");
    WebScriptObject* nodeit = [windowObject evaluateWebScript:@"nodeit"];
    [nodeit callWebScriptMethod:@"save" withArguments:[NSArray array]];
}

@end
