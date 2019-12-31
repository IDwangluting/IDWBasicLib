//
//  UIApplication+Transition.h
//  WWBaseLib
//
//  Created by luting on 2018/2/6.
//  Copyright © 2018年 HaiNa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,TransitionType) {
    TransitionTypePush = 1,
    TransitionTypePresent,
    TransitionTypeCustom,
};

@interface UIApplication (Transition)

- (UINavigationController *)navigationViewController ;

- (UIViewController *)topViewController ;

- (void)pushViewController:(UIViewController *)viewController ;

- (UIViewController *)popViewController;

- (NSArray *)popToRootViewController ;

- (NSArray *)popToViewController:(UIViewController *)viewController;

- (void)presentViewController:(UIViewController *)viewController
                     animated:(BOOL)animated
                   completion:(void (^)(void))completion ;

- (void)dismissViewController:(UIViewController *)viewController
                     animated:(BOOL)animated
                   completion:(void (^)(void))completion ;

@end
