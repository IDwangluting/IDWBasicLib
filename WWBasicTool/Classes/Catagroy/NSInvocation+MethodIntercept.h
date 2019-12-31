//
//  NSInvocation+MethodIntercept.h
//  WWBaseLib
//
//  Created by luting on 2018/11/15.
//  Copyright © 2018年 zyb. All rights reserved.
//

/*****************************************************
 ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
 
 传递方法的参数时，要注意基本数据类型的value一定要与类型保持一致，
 否则会导致不可预知的错误
 
 *****************************************************/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSInvocation (MethodIntercept)

+ (id)invocationWithTarget:(NSObject *)target seletorStr:(NSString *)seletorStr,...;

+ (id)invocationWithTarget:(NSObject *)target selector:(SEL)selector,...;

+ (id)invocationWithTarget:(NSObject *)target
                seletorStr:(NSString *)seletorStr
                      args:(va_list)args;

+ (id)invocationWithTarget:(NSObject *)target
                  selector:(SEL)selector args:(va_list)args;

@end

@interface NSInvocation (TypeMatch)

- (id)returnValue ;

- (void)setArgumentWithArgs:(va_list)args atIndex:(NSInteger)index ;

@end

@interface NSObject (validateInvocation)

- (BOOL)validate:(NSObject *)target seletorStr:(NSString *)seletorStr ;

- (BOOL)validate:(NSObject *)target selector:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
