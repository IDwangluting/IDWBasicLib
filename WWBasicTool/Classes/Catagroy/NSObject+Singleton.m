//
//  NSObject+Singleton.m
//  WWBaseLib
//
//  Created by aggie on 4/16/13.
//  Copyright (c) 2013 Baidu. All rights reserved.
//

#import "NSObject+Singleton.h"

@implementation NSObject (Singleton)

NSMutableDictionary *_instanceDict;

+ (instancetype)getInstance {
    return nil;
}

//命名
+ (instancetype)sharedInstance {
    id _instance;
    @synchronized(self) {
        if (_instanceDict == nil) {
            _instanceDict = [[NSMutableDictionary alloc] initWithCapacity:10];
        }
        
        NSString * className = NSStringFromClass([self class]);
        if (className) {
            _instance =[_instanceDict objectForKey:className];
            if (_instance == nil) {
                _instance = [self getInstance];
                if (_instance && _instanceDict && className) {
                    [_instanceDict setValue:_instance forKey:className];
                }
            }
            if (_instance == nil) {
                _instance = [[self.class alloc] init];
                if (_instance && _instanceDict && className) {
                    [_instanceDict setValue:_instance forKey:className];
                }
            }
        }
        return _instance;
    }
}

+ (void)destorySharedInstancec{
    if (_instanceDict == nil)  return;

    NSString *className = NSStringFromClass([self class]);
    if ([_instanceDict objectForKey:className]) {
        [_instanceDict removeObjectForKey:className];
    }
}

@end
