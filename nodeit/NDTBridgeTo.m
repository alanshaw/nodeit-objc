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
@synthesize ready = _ready;
@synthesize pathsToOpen;

#pragma mark -
#pragma mark NDTBridgeTo

- (void)dealloc {
	windowObject = nil;
}

- (void)attachToWindowObject:(WebScriptObject *)wo {
    NSLog(@"Attaching nodeitBridgeCallback to window");
    
    windowObject = wo;
    
    /**
     * Invoke a function with the passed args. Used by the bridge to invoke callback functions.
     *
     * @param {Function} fn Function to invoke
     * @param {*} ... Variable length args to pass to the function
     */
    [wo evaluateWebScript:@"window.nodeitBridgeCallback = function (fn, er) { var args = Array.prototype.slice.call(arguments, 1); if (er) { args[0] = new Error(er) } fn.apply(window, args) }"];
}

- (void)setReady:(BOOL)readyState {
    _ready = readyState;
    if (_ready) {
        if (pathsToOpen != nil) {
            for (id path in pathsToOpen) {
                [self open:path];
            }
            pathsToOpen = nil;
        } else {
            [self neu];
        }
    }
}

// Call a javascript callback passed to the bridge from the other side
- (void)callback:(WebScriptObject *)cb error:(NSString *)msg arguments:(NSArray *)args {
    if (msg == nil) {
        msg = @"";
    }
    
    if (args == nil) {
        args = [NSArray array];
    }
    
    args = [[NSArray arrayWithObjects:cb, msg, nil] arrayByAddingObjectsFromArray: args];
    
    NSLog(@"nodeitBridgeCallback %@", args);
    
    [windowObject callWebScriptMethod:@"nodeitBridgeCallback" withArguments:args];
}

// Create a new file
- (void)neu {
    NSLog(@"New file");
    WebScriptObject *nodeit = [windowObject evaluateWebScript:@"nodeit"];
    [nodeit callWebScriptMethod:@"neu" withArguments:nil];
}

// Open an unknown file (select file from dialog)
- (void)open {
    NSLog(@"Open unknown file");
    WebScriptObject *nodeit = [windowObject evaluateWebScript:@"nodeit"];
    [nodeit callWebScriptMethod:@"open" withArguments:nil];
}

// Open a particular file
- (void)open:(NSString *)path {
    if (!self.ready) {
        NSLog(@"When ready, will open file %@", path);
        if (pathsToOpen == nil) {
            pathsToOpen = [NSArray arrayWithObject:path];
        } else {
            pathsToOpen = [pathsToOpen arrayByAddingObject:path];
        }
        return;
    }
    
    NSLog(@"Open file %@", path);
    WebScriptObject *nodeit = [windowObject evaluateWebScript:@"nodeit"];
    [nodeit callWebScriptMethod:@"open" withArguments:[NSArray arrayWithObject:path]];
}

- (void)save {
    NSLog(@"Save file");
    WebScriptObject *nodeit = [windowObject evaluateWebScript:@"nodeit"];
    [nodeit callWebScriptMethod:@"save" withArguments:nil];
}

- (int)count {
    WebScriptObject *nodeit = [windowObject evaluateWebScript:@"nodeit"];
    return [(NSNumber *)[nodeit callWebScriptMethod:@"count" withArguments:[NSArray array]] intValue];
}

- (BOOL)closeAll {
    NSLog(@"Close all");
    WebScriptObject *nodeit = [windowObject evaluateWebScript:@"nodeit"];
    [nodeit callWebScriptMethod:@"closeAll" withArguments:nil];
    return YES;
}

- (WebScriptObject *)getPlugin:(NSString *)pluginId {
    WebScriptObject *nodeit = [windowObject evaluateWebScript:@"nodeit"];
    return [nodeit callWebScriptMethod:@"getPlugin" withArguments:[NSArray arrayWithObject:pluginId]];
}

- (void)increaseFontSize {
    WebScriptObject *plugin = [self getPlugin:@"font-size"];
    [plugin callWebScriptMethod:@"increase" withArguments:nil];
}

- (void)decreaseFontSize {
    WebScriptObject *plugin = [self getPlugin:@"font-size"];
    [plugin callWebScriptMethod:@"decrease" withArguments:nil];
}

- (void)resetFontSize {
    WebScriptObject *plugin = [self getPlugin:@"font-size"];
    [plugin callWebScriptMethod:@"reset" withArguments:nil];
}

@end
