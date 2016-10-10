//
//  VCTableView.m
//  RACTest
//
//  Created by shengxin on 16/10/10.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import "VCTableView.h"

@interface VCTableView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *iTableViewArr;
@end
@implementation VCTableView

#pragma mark -public
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        _touchCellObject = [RACSubject subject];
        self.iTableViewArr = [NSMutableArray array];
    }
    return self;
}

- (void)setData:(Users*)user{
//    [self.iTableViewArr removeAllObjects];
    [self.iTableViewArr addObject:user];
    [self reloadData];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.iTableViewArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"VCTableView";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    Users *user = [self.iTableViewArr objectAtIndex:indexPath.row];
    cell.textLabel.text = user.userName;
    cell.detailTextLabel.text = user.passWord;
    return cell;
}

#pragma mark -UITableViewDelegat
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.touchCellObject sendNext:indexPath];
}
@end
