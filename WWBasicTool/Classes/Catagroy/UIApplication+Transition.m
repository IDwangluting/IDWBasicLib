//
//  UIApplication+Transition.m
//  WWBaseLib
//
//  Created by luting on 2018/2/6.
//  Copyright © 2018年 HaiNa. All rights reserved.
//

#import "UIApplication+Transition.h"

@implementation UIApplication (Transition)

- (UINavigationController *) navigationViewController {
    id rootViewController = self.keyWindow.rootViewController;
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        return rootViewController;
    } else if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        id selectNv = [(UITabBarController *)rootViewController selectedViewController];
        if ([selectNv isKindOfClass:[UINavigationController class]])  return selectNv;
    }
    return nil;
}

- (UIViewController *) topViewController {
    UINavigationController *nav = [self navigationViewController];
    return nav.topViewController;
}

- (void) pushViewController:(UIViewController *)viewController {
    @autoreleasepool {
        viewController.hidesBottomBarWhenPushed = YES;
        [[self navigationViewController] pushViewController:viewController animated:YES];
    }
}

- (UIViewController *) popViewController {
    return [[self navigationViewController] popViewControllerAnimated:YES];
}

- (NSArray *) popToRootViewController {
    return [[self navigationViewController] popToRootViewControllerAnimated:YES];
}

- (NSArray *) popToViewController:(UIViewController *)viewController {
    return [[self navigationViewController] popToViewController:viewController animated:YES];
}

- (void) presentViewController:(UIViewController *)viewController
                      animated:(BOOL)animated
                    completion:(void (^)(void))completion {
    UIViewController *top = [self topViewController];
    if (viewController.navigationController == nil) {
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewController];
        [top presentViewController:nav animated:animated completion:completion];
        return ;
    }
    [top presentViewController:viewController animated:animated completion:completion];
}

- (void) dismissViewController:(UIViewController *)viewController
                      animated:(BOOL)animated
                    completion:(void (^)(void))completion {
    if (viewController.navigationController != self.navigationViewController) {
        [viewController dismissViewControllerAnimated:YES completion:completion];
        return ;
    }
    [viewController.navigationController popViewControllerAnimated:YES];
}

@end
