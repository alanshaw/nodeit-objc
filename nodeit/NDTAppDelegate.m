//
//  NDTAppDelegate.m
//  nodeit
//
//  Created by Alan Shaw on 05/08/2013.
//  Copyright (c) 2013 Alan Shaw. All rights reserved.
//

#import "NDTAppDelegate.h"
#import "NDTBridgeFrom.h"
#import "NDTBridgeTo.h"

@implementation NDTAppDelegate

@synthesize webView;
@synthesize bridgeTo;

#pragma mark -
#pragma mark NSApplicationDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSLog(@"nodeit did finish launching");
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"nodeit"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    
    [[webView mainFrame] loadRequest:request];
}
/*
- (BOOL)application:(NSApplication *)theApplication openFile:(NSString *)filename {
    NSLog(@"Open %@", filename);
    return NO;
}
*/

#pragma mark -
#pragma mark WebFrameLoadDelegate

- (void)webView:(WebView *)sender didClearWindowObject:(WebScriptObject *)windowObject forFrame:(WebFrame *)frame {
    bridgeTo = [[NDTBridgeTo alloc] init];
    
    [bridgeTo attachToWindowObject:windowObject];
    
    NDTBridgeFrom *bridgeFrom = [[NDTBridgeFrom alloc] init];
    
    [bridgeFrom attachToWindowObject:windowObject];
    
    bridgeFrom.bridgeTo = bridgeTo;
}

#pragma mark -
#pragma mark NDTAppDelegate

- (IBAction)newDocument:(id)sender {
    [bridgeTo open:nil];
}

- (IBAction)saveDocument:(id)sender {
    [bridgeTo save];
}

@end
