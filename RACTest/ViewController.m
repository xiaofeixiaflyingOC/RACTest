//
//  ViewController.m
//  RACTest
//
//  Created by shengxin on 16/10/10.
//  Copyright © 2016年 shengxin. All rights reserved.
//

#import "ViewController.h"
#import "VCViewModel.h"
#import "Users.h"
#import "VCTableView.h"

@interface ViewController ()

@property (nonatomic, strong) VCViewModel *iVCViewModel;
@property (nonatomic, strong) UITextField *iUserNameTextField;
@property (nonatomic, strong) UITextField *iPassWordTextField;
@property (nonatomic, strong) UIButton *iLoginBtn;
@property (nonatomic, strong) VCTableView *iVCTableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self adddViews];
    [self bindModel];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
- (UITextField*)iUserNameTextField{
    if (_iUserNameTextField==nil) {
        _iUserNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 120,(self.view.frame.size.width-100)/2, 50)];
        _iUserNameTextField.placeholder = @"请输入用户名";
        _iUserNameTextField.backgroundColor = [UIColor grayColor];
    }
    return _iUserNameTextField;
}

- (UITextField*)iPassWordTextField{
    if (_iPassWordTextField==nil) {
        _iPassWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 120+20+50,(self.view.frame.size.width-100)/2, 50)];
        _iPassWordTextField.placeholder = @"请输入密码";
        _iPassWordTextField.backgroundColor = [UIColor grayColor];
    }
    return _iPassWordTextField;
}

- (UIButton*)iLoginBtn{
    if(_iLoginBtn==nil){
        _iLoginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_iLoginBtn setFrame:CGRectMake(50, 120+20+100+20,(self.view.frame.size.width-100)/2 , 50)];
        [_iLoginBtn setTitle:@"Login" forState:UIControlStateNormal];
        _iLoginBtn.backgroundColor = [UIColor grayColor];
    }
    return _iLoginBtn;
}

- (VCTableView*)iVCTableView{
    if (_iVCTableView==nil) {
        _iVCTableView = [[VCTableView alloc] initWithFrame:CGRectMake(0, 120+20+100+20+50, self.view.frame.size.width, self.view.frame.size.height-(120+20+100+20+50))];

    }
    return _iVCTableView;
}

- (void)adddViews{
    [self.view addSubview:self.iUserNameTextField];
    [self.view addSubview:self.iPassWordTextField];
    [self.view addSubview:self.iLoginBtn];
    [self.view addSubview:self.iVCTableView];
}

- (void)bindModel{
    _iVCViewModel = [[VCViewModel alloc] init];
    //用于给某个对象的某个属性绑定
    RAC(self.iVCViewModel,userName) = self.iUserNameTextField.rac_textSignal;
    RAC(self.iVCViewModel,passWord) = self.iPassWordTextField.rac_textSignal;
    __weak ViewController *weself = self;
    //用于监听某个事件
    [[self.iLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [weself.iVCViewModel login];
    }];
    //订阅登录成功的信号
    [self.iVCViewModel.loginSuccessObject subscribeNext:^(id x) {
        Users *u = (Users*)x;
        [weself.iVCTableView setData:u];
    }];
    //订阅点击tableView的信号
    [self.iVCTableView.touchCellObject subscribeNext:^(id x) {
        NSIndexPath *indexPath = (NSIndexPath*)x;
        NSLog(@"%li",(long)indexPath.row);
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"PostLoginDataNotification" object:nil] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}


@end
