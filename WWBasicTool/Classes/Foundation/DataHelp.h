//
//  DataHelp.h
//  WWBaseLib
//
//  Created by luting on 2018/4/4.
//  Copyright © 2018年 zyb. All rights reserved.
//

#import <Foundation/Foundation.h>

//safe
static inline NSString * safeString(NSString *string) {
    return ((string && [string isKindOfClass:[NSString class]]) ? string : @"");
}

static inline NSDictionary * safeDictionary(NSDictionary *dictionary) {
    return ((dictionary && [dictionary isKindOfClass:[NSDictionary class]]) ? dictionary : @{});
}

static inline NSArray * safeArray(NSArray *array)   {
    return ((array && [array isKindOfClass:[NSArray class]]) ? array : @[]);
}

// valid
static inline BOOL validString(NSString *string){
    if (string == nil || [string isKindOfClass:[NSString class]] == false || string.length < 1) {
        return false ;
    }
    return true ;
}

static inline BOOL validAttriString(NSAttributedString *attriString){
    if (attriString == nil || [attriString isKindOfClass:[NSAttributedString class]] == false
        || attriString.length < 1) {
        return false ;
    }
    return true ;
}

static inline BOOL validDictionary(NSDictionary *dictionary) {
    if (dictionary == nil || [dictionary isKindOfClass:[NSDictionary class]] == false
        || dictionary.count < 1) {
        return false ;
    }
    return true ;
}

static inline BOOL validMutableDictionary(NSMutableDictionary *mutableDictionary ){
    if ([mutableDictionary isKindOfClass:[NSMutableDictionary class]] == false
        || mutableDictionary.count < 1 || mutableDictionary == nil ) {
        return false ;
    }
    return true ;
}

static inline BOOL validArray(NSArray *array) {
    if (array == nil || [array isKindOfClass:[NSArray class]] == false || array.count < 1 ) {
        return false ;
    }
    return true ;
}

static inline BOOL validMutableArray(NSMutableArray *mutableArray) {
    if (mutableArray == nil || mutableArray.count < 1
        || [mutableArray isKindOfClass:[NSMutableArray class]] == false ) {
        return false ;
    }
    return true ;
}

static inline BOOL validPointerArray(NSPointerArray *pointerArray){
    if (pointerArray == nil ||  pointerArray.count < 1
        || [pointerArray isKindOfClass:[NSPointerArray class]] == false ) {
        return false ;
    }
    return true ;
}

static inline BOOL validHashTable(NSHashTable *hashTable) {
    if (hashTable == nil || hashTable.count < 1
        || [hashTable isKindOfClass:[NSHashTable class]] == false ) {
        return false ;
    }
    return true ;
}

static inline BOOL valid(NSMapTable *mapTable) {
    if ([mapTable isKindOfClass:[NSMapTable class]] == false ||
        mapTable == nil || mapTable.count < 1 ) {
        return false ;
    }
    return true ;
}

static inline BOOL validSet(NSSet *set) {
    if (set == nil || [set isKindOfClass:[NSSet class]] == false || set.count < 1 ) {
        return false ;
    }
    return true ;
}

static inline BOOL validMutableSet(NSMutableSet *mutableSet) {
    if ([mutableSet isKindOfClass:[NSMutableSet class]] == false
        || mutableSet == nil || mutableSet.count < 1 ) {
        return false ;
    }
    return true ;
}

static inline BOOL validCache(NSCache *cache) {
    if (cache == nil || [cache isKindOfClass:[NSCache class]] == false || cache.totalCostLimit < 1 ) {
        return false ;
    }
    return true ;
}
