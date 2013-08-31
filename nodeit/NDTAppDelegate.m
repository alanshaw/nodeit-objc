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

@synthesize window;
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
    bridgeFrom.window = window;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"nodeit"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    
    [[webView mainFrame] loadRequest:request];
}

- (BOOL)application:(NSApplication *)theApplication openFile:(NSString *)filename {
    [bridgeTo open:filename];
    [window makeKeyAndOrderFront:self];
    return YES;
}

- (void)application:(NSApplication *)sender openFiles:(NSArray *)filenames {
    for (id path in filenames) {
        [bridgeTo open:path];
    }
    [window makeKeyAndOrderFront:self];
}

#pragma mark -
#pragma mark WebFrameLoadDelegate

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
    sender.mainFrame.frameView.allowsScrolling = NO;
}

- (void)webView:(WebView *)sender didClearWindowObject:(WebScriptObject *)windowObject forFrame:(WebFrame *)frame {
    [bridgeTo attachToWindowObject:windowObject];
    [bridgeFrom attachToWindowObject:windowObject];
}

#pragma mark -
#pragma mark NDTAppDelegate

- (IBAction)newDocument:(id)sender {
    [window makeKeyAndOrderFront:self];
    [bridgeTo neu];
}

- (IBAction)saveDocument:(id)sender {
    [bridgeTo save];
}

- (IBAction)openDocument:(id)sender {
    [window makeKeyAndOrderFront:self];
    [bridgeTo open];
}

- (IBAction)increaseFontSize:(id)sender {
    NSLog(@"Increase font size");
    [bridgeTo increaseFontSize];
}

- (IBAction)decreaseFontSize:(id)sender {
    NSLog(@"Decrease font size");
    [bridgeTo decreaseFontSize];
}

- (IBAction)resetFontSize:(id)sender {
    NSLog(@"Reset font size");
    [bridgeTo resetFontSize];
}

#pragma mark -
#pragma mark NSWindowDelegate

- (BOOL)windowShouldClose:(id)sender {
    NSLog(@"Window should close");
    return [bridgeTo closeAll];
}

#pragma mark -
#pragma mark WebUIDelegate

- (BOOL)webView:(WebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WebFrame *)frame {
    NSLog(@"JS confirm");
    NSAlert *alert = [[NSAlert alloc] init];
    
    [alert addButtonWithTitle:@"Yes"];
    [alert addButtonWithTitle:@"No"];
    [alert setMessageText:message];
    [alert setAlertStyle:NSWarningAlertStyle];
    
    if ([alert runModal] == NSAlertFirstButtonReturn)
        return YES;
    else
        return NO;
}

@end
