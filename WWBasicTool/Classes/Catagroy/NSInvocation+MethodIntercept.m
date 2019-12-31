//
//  NSInvocation+MethodIntercept.m
//  WWBaseLib
//
//  Created by luting on 2018/11/15.
//  Copyright © 2018年 zyb. All rights reserved.
//

#import "NSInvocation+MethodIntercept.h"
#import <Objc/runtime.h>

@implementation NSInvocation (MethodIntercept)

+ (id)invocationWithTarget:(NSObject *)target
                 seletorStr:(NSString *)seletorStr,...{
    
    SEL selector = NSSelectorFromString(seletorStr);
    va_list args;
    va_start(args, seletorStr);
    id value = [self invocationWithTarget:target selector:selector args:args];
    va_end(args);
    return value;   
}

+ (id)invocationWithTarget:(NSObject *)target selector:(SEL)selector,...{
    va_list args;
    va_start(args, selector);
    id value = [self invocationWithTarget:target selector:selector args:args];
    va_end(args);
    return value;
}

+ (id)invocationWithTarget:(NSObject *)target
                 seletorStr:(NSString *)seletorStr
                 args:(va_list)args {
    SEL selector = NSSelectorFromString(seletorStr);
    return [self invocationWithTarget:target selector:selector args:args];
}

+ (id)invocationWithTarget:(NSObject *)target
                 selector:(SEL)selector args:(va_list)args {
    
    if (![self validate:target seletorStr:NSStringFromSelector(selector)]) return nil;
    
    NSMethodSignature *signature = [[target class] methodSignatureForSelector:selector];
    signature = signature ?: [[target class] instanceMethodSignatureForSelector:selector];
    if (!signature)  return  nil;
    
    NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.selector = selector;

    for(NSUInteger index = 2; index < signature.numberOfArguments ; ++index){
        [invocation setArgumentWithArgs:args atIndex:index];
    }
    
    [invocation invokeWithTarget:target];
    return [invocation returnValue] ;
}

@end

@implementation NSInvocation (TypeMatch)

- (id)returnValue {
    const char *returnType = self.methodSignature.methodReturnType;
    if (returnType[0] == 'r')  returnType++;
    
#define WRAP_AND_RETURN(type) \
    do { \
        type val = 0; \
        [self getReturnValue:&val]; \
        return @(val); \
    } while (0)
    
    if (strcmp(returnType, @encode(id)) == 0 ||
        strcmp(returnType, @encode(Class)) == 0 ||
        strcmp(returnType, @encode(void (^)(void))) == 0) {
        __autoreleasing id returnObj;
        [self getReturnValue:&returnObj];
        return returnObj;
    } else if (strcmp(returnType, @encode(char)) == 0) {
        WRAP_AND_RETURN(char);
    } else if (strcmp(returnType, @encode(int)) == 0) {
        WRAP_AND_RETURN(int);
    } else if (strcmp(returnType, @encode(short)) == 0) {
        WRAP_AND_RETURN(short);
    } else if (strcmp(returnType, @encode(long)) == 0) {
        WRAP_AND_RETURN(long);
    } else if (strcmp(returnType, @encode(long long)) == 0) {
        WRAP_AND_RETURN(long long);
    } else if (strcmp(returnType, @encode(unsigned char)) == 0) {
        WRAP_AND_RETURN(unsigned char);
    } else if (strcmp(returnType, @encode(unsigned int)) == 0) {
        WRAP_AND_RETURN(unsigned int);
    } else if (strcmp(returnType, @encode(unsigned short)) == 0) {
        WRAP_AND_RETURN(unsigned short);
    } else if (strcmp(returnType, @encode(unsigned long)) == 0) {
        WRAP_AND_RETURN(unsigned long);
    } else if (strcmp(returnType, @encode(unsigned long long)) == 0) {
        WRAP_AND_RETURN(unsigned long long);
    } else if (strcmp(returnType, @encode(float)) == 0) {
        WRAP_AND_RETURN(float);
    } else if (strcmp(returnType, @encode(double)) == 0) {
        WRAP_AND_RETURN(double);
    } else if (strcmp(returnType, @encode(BOOL)) == 0) {
        WRAP_AND_RETURN(BOOL);
    } else if (strcmp(returnType, @encode(char *)) == 0) {
        WRAP_AND_RETURN(const char *);
    } else if (strcmp(returnType, @encode(void)) == 0) {
        return nil;
    } else {
        NSUInteger valueSize = 0;
        NSGetSizeAndAlignment(returnType, &valueSize, NULL);
        
        unsigned char valueBytes[valueSize];
        [self getReturnValue:valueBytes];
        
        return [NSValue valueWithBytes:valueBytes objCType:returnType];
    }
#undef WRAP_AND_RETURN
    return nil;
}

- (void)setArgumentWithArgs:(va_list)args atIndex:(NSInteger)index {
#define ARG_GET_SET(type) \
    do { \
    type val = 0; \
    val = va_arg(args,type); \
    [self setArgument:&val atIndex:index];}\
while (0)
    
    const char* argType = [self.methodSignature getArgumentTypeAtIndex:index];
    if (argType[0] == _C_CONST) argType++;
    if (argType[0] == '@') {                                //id and block
        ARG_GET_SET(id);
    }else if (strcmp(argType, @encode(Class)) == 0 ){       //Class
        ARG_GET_SET(Class);
    }else if (strcmp(argType, @encode(IMP)) == 0 ){         //IMP
        ARG_GET_SET(IMP);
    }else if (strcmp(argType, @encode(SEL)) == 0) {         //SEL
        ARG_GET_SET(SEL);
    }else if (strcmp(argType, @encode(double)) == 0){       //
        ARG_GET_SET(double);
    }else if (strcmp(argType, @encode(float)) == 0){
        ARG_GET_SET(double);
    }else if (argType[0] == '^'){                           //pointer ( andconst pointer)
        ARG_GET_SET(void*);
    }else if (strcmp(argType, @encode(char *)) == 0) {      //char* (and const char*)
        ARG_GET_SET(char *);
    }else if (strcmp(argType, @encode(unsigned long)) == 0) {
        ARG_GET_SET(unsigned long);
    }else if (strcmp(argType, @encode(unsigned long long)) == 0) {
        ARG_GET_SET(unsigned long long);
    }else if (strcmp(argType, @encode(long)) == 0) {
        ARG_GET_SET(long);
    }else if (strcmp(argType, @encode(long long)) == 0) {
        ARG_GET_SET(long long);
    }else if (strcmp(argType, @encode(int)) == 0) {
        ARG_GET_SET(int);
    }else if (strcmp(argType, @encode(unsigned int)) == 0) {
        ARG_GET_SET(unsigned int);
    }else if (strcmp(argType, @encode(BOOL)) == 0 ||
              strcmp(argType, @encode(bool)) == 0 ||
              strcmp(argType, @encode(char)) == 0 ||
              strcmp(argType, @encode(unsigned char)) == 0 ||
              strcmp(argType, @encode(short)) == 0 ||
              strcmp(argType, @encode(unsigned short)) == 0) {
        ARG_GET_SET(int);
    }else{                  //struct union and array
        //            assert(false && "struct union array unsupported!");
    }
    #undef ARG_GET_SET
}

@end


@implementation NSObject (validateInvocation)

- (BOOL)validate:(NSObject *)target seletorStr:(NSString *)seletorStr {
    if (!seletorStr || seletorStr.length < 1)  return false ;
    
    return [self validate:target selector:NSSelectorFromString(seletorStr)];
}

- (BOOL)validate:(NSObject *)target selector:(SEL)selector {
    if (!target) return false ;
  
    if (![target isKindOfClass:[NSObject class]])  return false ;
    
    Class targetClass = [target class] ;
    
    if (!objc_lookUpClass(class_getName(targetClass))) return false ;
   
    if (![target respondsToSelector:selector] && ![[target class]instancesRespondToSelector:selector]) return false;
    
    return YES;
}

@end
