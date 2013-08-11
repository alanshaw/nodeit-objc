//
//  NDTBridgeTo.h
//  nodeit
//
//  Created by Alan Shaw on 10/08/2013.
//  Copyright (c) 2013 Alan Shaw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebScriptObject.h>

@interface NDTBridgeTo : NSObject

@property WebScriptObject *windowObject;

#pragma mark -
#pragma mark NDTBridgeTo

- (void)attachToWindowObject:(WebScriptObject *)wo;
- (void)call:(WebScriptObject *)cb error:(NSString *)msg arguments:(NSArray *)args;
- (void)emit:(NSString *)eventName withArguments:(NSArray *)args;

- (void)neu;
- (void)open;
- (void)open:(NSString *)path;
- (void)save;

@end
