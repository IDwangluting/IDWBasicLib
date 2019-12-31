//
//  WWOrderedDictionary.h
//  WWBaseLib
//
//  Created by luting on 2018/12/28.
//  Copyright © 2018 luting. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WWOrderedDictionary : NSMutableDictionary

- (instancetype)baseOrdered;

- (NSInteger)lookupWithKey:(id)key;


- (NSObject *)firstObject;

- (NSObject *)lastObject;

- (NSObject *)objectAtIndex:(NSUInteger)index;


- (void)removeFirstObject;

- (void)removeLastObject;

- (void)removeObjectAtIndex:(NSUInteger)index;


- (void)insertValue:(id)value key:(id)key atIndex:(NSUInteger)index;

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

- (BOOL)swapValueWithKey:(id)key1 key:(id)key2;  // 交换字典的顺序

@end

NS_ASSUME_NONNULL_END
