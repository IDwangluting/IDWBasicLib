//
//  WWViewController.m
//  WWBase
//
//  Created by IDwangluting on 12/21/2018.
//  Copyright (c) 2018 IDwangluting. All rights reserved.
//

#import "WWViewController.h"

@interface WWViewController ()

@end

@implementation WWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [[KGRNetworking manager] getRequest:InsertInClassWorkerOrder
//                             parameters: parameters
//                                success:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable result) {
//                                    @strongify(self);
//                                    if([result isKindOfClass:[NSError class]] ) {
//                                        if (self.submitTime == 0)  self.submitTime = [[NSDate date] timeIntervalSince1970];
//                                        [self tipsWithText:result.domain];
//                                        return ;
//                                    }
//                                    [self submitSucess];
//                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
//                                    [LMToastView showWithTitile:error.domain];
//                                }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
