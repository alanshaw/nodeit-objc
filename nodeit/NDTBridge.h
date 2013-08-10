//
//  NDTBridge.h
//  nodeit
//
//  Created by Alan Shaw on 09/08/2013.
//  Copyright (c) 2013 Alan Shaw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebScriptObject.h>

@interface NDTBridge : NSObject

@property (assign) WebScriptObject *windowObject;

/* WebScripting methods */
+ (BOOL)isSelectorExcludedFromWebScript:(SEL)selector;
+ (BOOL)isKeyExcludedFromWebScript:(const char *)property;
+ (NSString *) webScriptNameForSelector:(SEL)sel;

- (void) attachToWindowObject:(WebScriptObject *)wo;

- (void)log:(NSObject *)msg;
- (void)save:(NSString *)path contents:(NSString *)contents cb:(WebScriptObject *)cb;

- (void)call:(WebScriptObject *)cb error:(NSString *)msg arguments:(NSArray *)args;
- (void)emit:(NSString *)eventName withArguments:(NSArray *)args;

@end
