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

@interface NDTAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet WebView *webView;
@property NDTBridgeTo *bridgeTo;

#pragma mark -
#pragma mark NDTAppDelegate

- (IBAction)newDocument:(id)sender;
- (IBAction)saveDocument:(id)sender;
- (IBAction)openDocument:(id)sender;

@end
