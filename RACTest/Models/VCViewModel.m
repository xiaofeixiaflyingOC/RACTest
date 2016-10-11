//
//  VCViewModel.m
//  RACTest
//
//  Created by shengxin on 16/10/10.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import "VCViewModel.h"
#import "Users.h"

@implementation VCViewModel

#pragma - public
- (instancetype)init{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)login{
    if ([self.userName length]==0||[self.passWord length]==0) {
        NSLog(@"error login");
    }else{
        Users *user = [[Users alloc] init];
        [user setValue:self.userName forKey:@"userName"];
        [user setValue:self.passWord forKey:@"passWord"];
        [_loginSuccessObject sendNext:user];
        //通知传递
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PostLoginDataNotification" object:nil userInfo:@{@"data":@[self.userName,self.passWord]}];
    }

}
#pragma mark -private
- (void)initialize{
    _loginSuccessObject = [RACSubject subject];
}
@end
