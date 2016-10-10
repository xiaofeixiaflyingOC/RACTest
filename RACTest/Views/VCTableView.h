//
//  VCTableView.h
//  RACTest
//
//  Created by shengxin on 16/10/10.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Users.h"

@interface VCTableView : UITableView

@property (nonatomic, strong) RACSubject *touchCellObject;
- (void)setData:(Users*)user;
@end
