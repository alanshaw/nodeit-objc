//
//  NDTAppDelegate.m
//  nodeit
//
//  Created by Alan Shaw on 05/08/2013.
//  Copyright (c) 2013 Alan Shaw. All rights reserved.
//

#import "NDTAppDelegate.h"
#import "NDTBridge.h"

@implementation NDTAppDelegate

@synthesize webView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSLog(@"nodeit did finish launching");
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"nodeit"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    
    [[webView mainFrame] loadRequest:request];
}

- (void)webView:(WebView *)sender didClearWindowObject:(WebScriptObject *)windowObject forFrame:(WebFrame *)frame {    
    NDTBridge *bridge = [[NDTBridge alloc] init];
    [bridge attachToWindowObject:windowObject];
}

@end
