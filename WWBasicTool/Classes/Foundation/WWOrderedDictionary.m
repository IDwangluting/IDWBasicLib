//
//  WWOrderedDictionary.m
//  WWBaseLib
//
//  Created by luting on 2018/12/28.
//  Copyright © 2018 luting. All rights reserved.
//

#import "WWOrderedDictionary.h"

typedef struct {
    NSObject<NSCopying> * key;
    NSObject * value;
} OrderedItem ;

@interface WWOrderedDictionary ()

@property (nonatomic,strong)NSMutableArray <NSValue *> * orderedArray;

@end

@implementation WWOrderedDictionary

#pragma mark create

+ (nullable NSMutableDictionary *)dictionaryWithContentsOfFile:(NSString *)path {
    return  [(id)[super dictionaryWithContentsOfFile:path] baseOrdered];
}

+ (instancetype)dictionaryWithObject:(id)object forKey:(id <NSCopying>)key {
    return [[super dictionaryWithObject:object forKey:key] baseOrdered];
}

+ (nullable NSMutableDictionary *)dictionaryWithContentsOfURL:(NSURL *)url {
    return [(id)[super dictionaryWithContentsOfURL:url] baseOrdered];
}

+ (instancetype)dictionaryWithDictionary:(NSDictionary *)dic {
    return [[super dictionaryWithDictionary:dic] baseOrdered];
}

+ (instancetype)dictionaryWithObjects:(NSArray *)objects forKeys:(NSArray *)keys {
    return [[super dictionaryWithObjects:objects forKeys:keys] baseOrdered];
}

+ (instancetype)dictionaryWithCapacity:(NSUInteger)numItems {
    WWOrderedDictionary * dictionary = [super dictionaryWithCapacity:numItems];
    dictionary->_orderedArray = [NSMutableArray arrayWithCapacity:numItems];
    return dictionary;
}

- (nullable NSMutableDictionary *)initWithContentsOfFile:(NSString *)path {
    return  [[super initWithContentsOfFile:path] baseOrdered];
}

- (nullable NSDictionary<NSString *,id> *)initWithContentsOfURL:(NSURL *)url error:(NSError **)error {
    return [[super initWithContentsOfURL:url error:error] baseOrdered];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [[super initWithCoder:aDecoder] baseOrdered];
}

- (nullable NSMutableDictionary *)initWithContentsOfURL:(NSURL *)url {
    return [[super initWithContentsOfURL:url] baseOrdered];
}

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary{
    return [[super initWithDictionary:otherDictionary] baseOrdered];
}

+ (instancetype)dictionaryWithContentsOfURL:(NSURL *)url error:(NSError **)error {
     return [self dictionaryWithDictionary:[super dictionaryWithContentsOfURL:url error:error]];
}

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary copyItems:(BOOL)flag {
    return [[super initWithDictionary:otherDictionary copyItems:flag] baseOrdered];
}

- (instancetype)initWithObjects:(NSArray*)objects forKeys:(NSArray *)keys {
    return [[super initWithObjects:objects forKeys:keys] baseOrdered];
}

+ (NSMutableDictionary *)dictionaryWithSharedKeySet:(id)keyset {
    return [(id)[super dictionaryWithSharedKeySet:keyset] baseOrdered];
}

#pragma mark set method

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if ([self.allKeys containsObject:aKey]) {
        NSInteger index = [self lookupWithKey:aKey];
        if (index >= 0){
            self.orderedArray[index] = [self orderedItemWithKey:aKey value:anObject];
        }
    } else {
        [self.orderedArray addObject:[self orderedItemWithKey:aKey value:anObject]];
    }
    [super setObject:anObject forKey:aKey];
}

- (void)setDictionary:(NSDictionary *)otherDictionary {
    [self removeAllObjects];
    [super setDictionary:otherDictionary];
    [otherDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self.orderedArray addObject:[self orderedItemWithKey:key value:obj]];
    }];
}

#pragma mark get method

- (NSArray *)allkeys {
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:self.orderedArray.count];
    OrderedItem item;
    for (NSValue *value in self.orderedArray ) {
        [value getValue:&item];
        [array addObject:item.key];
    }
    return array;
}

- (NSArray *)allValues {
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:self.orderedArray.count];
    OrderedItem item;
    for (NSValue *value in self.orderedArray ) {
        [value getValue:&item];
        [array addObject:item.value];
    }
    return array;
}

- (NSArray *)allKeysForObject:(id)anObject{
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:4];
    OrderedItem item ;
    for (NSValue * value in self.orderedArray) {
        [value getValue:&item];
        if (item.value == anObject) {
            [array addObject:item.key];
        }
    }
    return array ;
}

- (NSObject *)objectAtIndex:(NSUInteger)index {
    return [self orderedItemAtIndex:index].value;
}

- (NSObject *)firstObject {
    return [self orderedItemAtIndex:0].value;
}

- (NSObject *)lastObject {
    return [self orderedItemAtIndex:self.orderedArray.count - 1].value;
}

- (NSArray *)objectsForKeys:(NSArray *)keys notFoundMarker:(id)marker{
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:4];
    OrderedItem item ;
    for (id key in keys) {
        if ([self.allKeys containsObject:key]) {
            for (NSValue * value in self.orderedArray) {
                [value getValue:&item];
                if (item.key == key) {
                    [array addObject:item.value];
                    break ;
                }
            }
        } else if (marker){
            [array addObject:marker];
        }
    }
    return array;
}

#pragma remove method

- (void)removeFirstObject {
    id key = [self orderedItemAtIndex:0].key;
    [self removeObjectForKey:key];
    [self.orderedArray removeObjectAtIndex:0];
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    [self removeObjectForKey:[self orderedItemAtIndex:index].key];
}

- (void)removeObjectForKey:(id)aKey {
    NSInteger index = [self lookupWithKey:aKey];
    if (index < 0) {
        NSLog(@"WWOrderedDictionary not found key:%@",aKey);
        return ;
    }
    [super removeObjectForKey:aKey];
    [self.orderedArray removeObjectAtIndex:index];
}

- (void)removeAllObjects {
    [super removeAllObjects];
    [self.orderedArray removeAllObjects];
}

- (void)removeLastObject {
    OrderedItem item = [self orderedItemAtIndex:self.count-1];
    [self removeObjectForKey:item.key];
    [self.orderedArray removeLastObject];
}

- (void)removeObjectsForKeys:(NSArray *)keyArray {
    [super removeObjectsForKeys:keyArray];
    for (id key in keyArray) {
        [self.orderedArray removeObjectAtIndex:[self lookupWithKey:key]];
    }
}

#pragma mark other

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject{
    id key  = [self orderedItemAtIndex:index].key;
    [self setObject:anObject forKey:key];
    self.orderedArray[index] = [self orderedItemWithKey:key value:anObject];
}

- (BOOL)swapValueWithKey:(id)key1 key:(id)key2 {
    NSInteger index1 = [self lookupWithKey:key1];
    NSInteger index2 = [self lookupWithKey:key2];
    if (index1 < 0 || index2 < 0 )  return false;
    
    if (index1 == index2)  return true;
    
    [self.orderedArray exchangeObjectAtIndex:index2 withObjectAtIndex:index1];
    
    return true;
}

- (void)insertValue:(id)value key:(id)key atIndex:(NSUInteger)index {
    NSUInteger count = self.count ;
    [self setValue:value forKey:key];
    if (self.count == count) {
        NSInteger atIndex = [self lookupWithKey:key];
        if (atIndex < 0)  return ;
        self.orderedArray[atIndex] = [self orderedItemWithKey:key value:value];
        return ;
    }
    [self.orderedArray addObject: [self orderedItemWithKey:key value:value]];
}

#pragma  mark help mathod

- (NSValue *)orderedItemWithKey:(id)key value:(id)value {
    OrderedItem item = {key,value};
    return [NSValue valueWithBytes:&item objCType:@encode(OrderedItem)];
}

- (OrderedItem)orderedItemAtIndex:(NSUInteger)index {
    OrderedItem item;
    [[self.orderedArray objectAtIndex:index] getValue:&item];
    return item;
}

- (NSInteger)lookupWithKey:(id)key{
    __block NSInteger index =  -1;
    [self.orderedArray enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        OrderedItem temp = [self orderedItemAtIndex:idx];
        if ([temp.key isEqual:key]) {
            index = idx ;
            *stop = YES;
        }
    }];
    return index;
}

- (instancetype)baseOrdered {
    __block NSInteger index = 0;
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSValue * value = [self orderedItemWithKey:key value:obj];
        if ([self.allKeys containsObject:key]) {
            NSInteger index = [self lookupWithKey:key];
            self.orderedArray[index] = value;
        }else{
            [self.orderedArray addObject:value];
        }
        index++;
    }];
    return self;
}

- (NSMutableArray *)orderedArray {
    if (!_orderedArray) {
        _orderedArray = [NSMutableArray arrayWithCapacity:4];
    }
    return _orderedArray;
}

- (BOOL)writeToURL:(NSURL *)url error:(NSError **)error {
    BOOL success =  [super writeToURL:url error:error];
    [self baseOrdered];
    return success;
}

- (void)addEntriesFromDictionary:(NSDictionary *)otherDictionary {
    [super addEntriesFromDictionary:otherDictionary];
    [self.orderedArray removeAllObjects];
    [self baseOrdered];
}

// + (instancetype)dictionaryWithObjectsAndKeys:(id)firstObject, ...
//- (instancetype)initWithObjectsAndKeys:(id)firstObject, ...{
//    NSMethodSignature * signature = [[self class] instanceMethodSignatureForSelector:_cmd];
//    NSUInteger count = signature.numberOfArguments;
//    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:count -2];
//    va_list args ;
//    va_start(args, firstObject);
//    for(NSUInteger index = 2; index < count ; ++index){
//       id val = va_arg(args,id);
//    }
//    va_end(args);
//    return self ;
//}

//- (void)setObject:(nullable ObjectType)obj forKeyedSubscript:(KeyType <NSCopying>)key
//- (nullable id)objectForKeyedSubscript:(id)key

@end
