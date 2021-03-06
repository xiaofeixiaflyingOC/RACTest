//
//  VCViewModel.h
//  RACTest
//
//  Created by shengxin on 16/10/10.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VCViewModel : NSObject

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *passWord;
@property (nonatomic, strong) RACSubject *loginSuccessObject;//登录成功的信号提供者，类似代理

- (void)login;
@end
