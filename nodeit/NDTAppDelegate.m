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
@synthesize bridgeFrom;

#pragma mark -
#pragma mark NSApplicationDelegate

-(id) init {
    self = [super init];
	if (self) {
        bridgeTo = [[NDTBridgeTo alloc] init];
        bridgeFrom = [[NDTBridgeFrom alloc] init];
        
        bridgeFrom.bridgeTo = bridgeTo;
	}
	return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSLog(@"nodeit did finish launching");
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"nodeit"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    
    [[webView mainFrame] loadRequest:request];
}

- (BOOL)application:(NSApplication *)theApplication openFile:(NSString *)filename {
    [bridgeTo open:filename];
    return YES;
}

- (void)application:(NSApplication *)sender openFiles:(NSArray *)filenames {
    for (id path in filenames) {
        [bridgeTo open:path];
    }
}

#pragma mark -
#pragma mark WebFrameLoadDelegate

- (void)webView:(WebView *)sender didClearWindowObject:(WebScriptObject *)windowObject forFrame:(WebFrame *)frame {
    [bridgeTo attachToWindowObject:windowObject];
    [bridgeFrom attachToWindowObject:windowObject];
}

#pragma mark -
#pragma mark NDTAppDelegate

- (IBAction)newDocument:(id)sender {
    [bridgeTo neu];
}

- (IBAction)saveDocument:(id)sender {
    [bridgeTo save];
}

- (IBAction)openDocument:(id)sender {
    [bridgeTo open];
}

@end
