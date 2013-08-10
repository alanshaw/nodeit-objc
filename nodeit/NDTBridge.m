//
//  NDTBridge.m
//  nodeit
//
//  Created by Alan Shaw on 09/08/2013.
//  Copyright (c) 2013 Alan Shaw. All rights reserved.
//

#import "NDTBridge.h"

@implementation NDTBridge

@synthesize windowObject;

- (void) dealloc {
	windowObject = nil;
}

- (void) attachToWindowObject:(WebScriptObject *)wo {
    windowObject = wo;
    
    [wo setValue:self forKey:@"nodeitBridge"];
    
    /**
     * Invoke a function with the passed args. Used by the bridge to invoke callback functions.
     *
     * @param {Function} fn Function to invoke
     * @param {*} ... Variable length args to pass to the function
     */
    [wo evaluateWebScript:@"window.nodeitBridgeCall = function (fn, er) { var args = Array.prototype.slice.call(arguments, 1); if (er) { args[0] = new Error(er) } fn.apply(window, args) }"];
}

- (void)log:(NSObject *)msg {
    NSLog(@"%@", msg);
}

- (void)save:(NSString *)path contents:(NSString *)contents cb:(WebScriptObject *)cb {
    NSLog(@"Saving %@", path);
    [self call:cb error:nil arguments:[NSArray arrayWithObjects:path, contents, nil]];
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

/* WebScripting methods */

+ (NSString *)webScriptNameForSelector:(SEL)sel {
    if (sel == @selector(log:)) {
        return @"log";
    }
    if (sel == @selector(save:contents:cb:)) {
        return @"save";
    }
    return nil;
}

+ (BOOL)isSelectorExcludedFromWebScript:(SEL)sel {
    if (sel == @selector(attachToWindowObject:)) {
        return YES;
    }
    if (sel == @selector(call:error:arguments:)) {
        return YES;
    }
    if (sel == @selector(emit:withArguments:)) {
        return YES;
    }
    if (sel == @selector(dealloc:)) {
        return YES;
    }
    return NO;
}

+ (BOOL)isKeyExcludedFromWebScript:(const char *)property {
    return NO;
}

@end
