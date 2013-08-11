//
//  NDTBridge.m
//  nodeit
//
//  Created by Alan Shaw on 09/08/2013.
//  Copyright (c) 2013 Alan Shaw. All rights reserved.
//

#import "NDTBridgeFrom.h"

@implementation NDTBridgeFrom

@synthesize windowObject;
@synthesize bridgeTo;

#pragma mark -
#pragma mark WebScripting protocol

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
    if (sel == @selector(dealloc:)) {
        return YES;
    }
    return NO;
}

+ (BOOL)isKeyExcludedFromWebScript:(const char *)property {
    return NO;
}

#pragma mark -
#pragma mark NDTBridgeFrom

- (void) dealloc {
	windowObject = nil;
}

- (void) attachToWindowObject:(WebScriptObject *)wo {
    windowObject = wo;
    [wo setValue:self forKey:@"nodeitBridge"];
}

- (void)log:(NSObject *)msg {
    NSLog(@"> %@", msg);
}

- (void)save:(NSString *)path contents:(NSString *)contents cb:(WebScriptObject *)cb {
    NSError *er = nil;
    
    if (path == nil || [path isEqualToString:@""]) {
        NSLog(@"Save new");
        
        NSSavePanel *save = [NSSavePanel savePanel];
        NSInteger result = [save runModal];
        
        if (result == NSFileHandlingPanelOKButton) {
        
            path = save.filename;
            
            if ([contents writeToFile:path atomically:YES encoding:NSStringEncodingConversionAllowLossy error:&er]) {
                [bridgeTo call:cb error:nil arguments:[NSArray arrayWithObjects:path, contents, nil]];
            } else {
                NSLog(@"%@", er);
                [bridgeTo call:cb error:[er description] arguments:nil];
            }
            
        } else {
            [bridgeTo call:cb error:@"cancelled" arguments:nil];
        }
        
    } else {
        NSLog(@"Save file %@", path);
        
        if ([contents writeToFile:path atomically:YES encoding:NSStringEncodingConversionAllowLossy error:&er]) {
            [bridgeTo call:cb error:nil arguments:[NSArray arrayWithObjects:path, contents, nil]];
        } else {
            NSLog(@"%@", er);
            [bridgeTo call:cb error:[er description] arguments:nil];
        }
    }
    
}

@end
