//
//  NDTAppDelegate.h
//  nodeit
//
//  Created by Alan Shaw on 05/08/2013.
//  Copyright (c) 2013 Alan Shaw. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "NDTBridgeTo.h"
#import "NDTBridgeFrom.h"

@interface NDTAppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet WebView *webView;
@property NDTBridgeTo *bridgeTo;
@property NDTBridgeFrom *bridgeFrom;

#pragma mark -
#pragma mark NSApplicationDelegate

- (IBAction)newDocument:(id)sender;
- (IBAction)saveDocument:(id)sender;
- (IBAction)openDocument:(id)sender;

#pragma mark -
#pragma mark NSWindowDelegate

- (BOOL)windowShouldClose:(id)sender;

@end
