//
//  NDTBridgeTo.h
//  nodeit
//
//  Created by Alan Shaw on 10/08/2013.
//  Copyright (c) 2013 Alan Shaw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebScriptObject.h>

@interface NDTBridgeTo : NSObject {
    BOOL _ready;
}

@property WebScriptObject *windowObject;
@property (nonatomic, assign) BOOL ready;
@property NSArray *pathsToOpen; // A list of paths to open when nodeit is ready

#pragma mark -
#pragma mark NDTBridgeTo

- (void)attachToWindowObject:(WebScriptObject *)wo;
- (void)callback:(WebScriptObject *)cb error:(NSString *)msg arguments:(NSArray *)args;

- (void)neu;
- (void)open;
- (void)open:(NSString *)path;
- (void)save;
- (int)count;
- (BOOL)closeAll;

- (WebScriptObject *)getPlugin:(NSString *)pluginId;

- (void)increaseFontSize;
- (void)decreaseFontSize;
- (void)resetFontSize;

@end
