//
//  NDTAppDelegate.m
//  nodeit
//
//  Created by Alan Shaw on 05/08/2013.
//  Copyright (c) 2013 Alan Shaw. All rights reserved.
//

#import "NDTAppDelegate.h"

@implementation NDTAppDelegate

@synthesize webView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"nodeit"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    
    [[webView mainFrame] loadRequest:request];
}

@end
