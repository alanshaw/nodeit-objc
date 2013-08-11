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
    if (sel == @selector(open:cb:)) {
        return @"open";
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

- (void)open:(NSString *)path cb:(WebScriptObject *)cb {
    NSError *er = nil;
    
    if (path == nil || path == [WebUndefined undefined] || [path isEqualToString:@""]) {
        NSLog(@"Open");
        
        NSOpenPanel *openPanel = [NSOpenPanel openPanel];
        [openPanel setAllowsMultipleSelection:YES];
        NSInteger result = [openPanel runModal];
        
        if (result == NSFileHandlingPanelOKButton) {
            NSLog(@"%@", openPanel.filenames);
            
            if ([openPanel.filenames count] == 1) {
                NSString *contents = [[NSString alloc] initWithContentsOfFile:[openPanel.filenames objectAtIndex:0]
                                                                     encoding:NSStringEncodingConversionAllowLossy
                                                                        error:&er];
                if (er == nil) {
                    [bridgeTo call:cb error:nil arguments:[NSArray arrayWithObjects:[openPanel.filenames objectAtIndex:0], contents, nil]];
                } else {
                    NSLog(@"%@", er);
                    [bridgeTo call:cb error:[er description] arguments:nil];
                }
                
            } else {
                for (id path in openPanel.filenames) {
                    [bridgeTo open:path];
                }
            }
            
        } else {
            [bridgeTo call:cb error:@"cancelled" arguments:nil];
        }
        
    } else {
        NSLog(@"Open file %@", path);
        
        NSString *contents = [[NSString alloc] initWithContentsOfFile:path
                                                             encoding:NSStringEncodingConversionAllowLossy
                                                                error:&er];
        if (er == nil) {
            [bridgeTo call:cb error:nil arguments:[NSArray arrayWithObjects:path, contents, nil]];
        } else {
            NSLog(@"%@", er);
            [bridgeTo call:cb error:[er description] arguments:nil];
        }
    }
}

- (void)save:(NSString *)path contents:(NSString *)contents cb:(WebScriptObject *)cb {
    NSError *er = nil;
    
    if (path == nil || path == [WebUndefined undefined] || [path isEqualToString:@""]) {
        NSLog(@"Save new");
        
        NSSavePanel *savePanel = [NSSavePanel savePanel];
        NSInteger result = [savePanel runModal];
        
        if (result == NSFileHandlingPanelOKButton) {
        
            path = savePanel.filename;
            
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
