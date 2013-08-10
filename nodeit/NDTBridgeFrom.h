//
//  NDTBridge.h
//  nodeit
//
//  Created by Alan Shaw on 09/08/2013.
//  Copyright (c) 2013 Alan Shaw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebScriptObject.h>
#import "NDTBridgeTo.h"

@interface NDTBridgeFrom : NSObject

@property (assign) WebScriptObject *windowObject;
@property (assign) NDTBridgeTo *bridgeTo;

- (void) attachToWindowObject:(WebScriptObject *)wo;

/* WebScripting methods */
+ (BOOL)isSelectorExcludedFromWebScript:(SEL)selector;
+ (BOOL)isKeyExcludedFromWebScript:(const char *)property;
+ (NSString *) webScriptNameForSelector:(SEL)sel;

- (void)log:(NSObject *)msg;
- (void)save:(NSString *)path contents:(NSString *)contents cb:(WebScriptObject *)cb;

@end
