//
//  NDTBridge.m
//  nodeit
//
//  Created by Alan Shaw on 09/08/2013.
//  Copyright (c) 2013 Alan Shaw. All rights reserved.
//

#import "NDTBridge.h"

@implementation NDTBridge

- (void)log:(NSObject *)msg {
    NSLog(@"%@", msg);
}

/* WebScripting methods */

+ (NSString *)webScriptNameForSelector:(SEL)sel {
    if (sel == @selector(log:)) {
        return @"log";
    }
    return nil;
}

+ (BOOL)isSelectorExcludedFromWebScript:(SEL)aSelector {
    return NO;
}

+ (BOOL)isKeyExcludedFromWebScript:(const char *)property {
    return NO;
}

@end
