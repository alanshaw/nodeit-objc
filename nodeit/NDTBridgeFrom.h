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

@property WebScriptObject *windowObject;
@property NDTBridgeTo *bridgeTo;

#pragma mark -
#pragma mark WebScripting protocol

+ (BOOL)isSelectorExcludedFromWebScript:(SEL)selector;
+ (BOOL)isKeyExcludedFromWebScript:(const char *)property;
+ (NSString *)webScriptNameForSelector:(SEL)sel;

#pragma mark -
#pragma mark NDTBridgeFrom

- (void)attachToWindowObject:(WebScriptObject *)wo;
- (void)log:(NSObject *)msg;
- (void)ready;
- (void)open:(NSString *)path cb:(WebScriptObject *)cb;
- (void)save:(NSString *)path contents:(NSString *)contents cb:(WebScriptObject *)cb;

@end
