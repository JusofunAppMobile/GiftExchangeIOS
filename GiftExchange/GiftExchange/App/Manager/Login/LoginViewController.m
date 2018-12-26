//
//  LoginViewController.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/10.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "LoginViewController.h"
#import "UIButton+Verification.h"
#import "User.h"
#import "AppDelegate.h"
#import "NSString+Verify.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic ,strong) UITableView *tableview;

@property (nonatomic ,strong) UITextField *phoneField;

@property (nonatomic ,strong) UITextField *codeField;

@property (nonatomic ,strong) UIButton *codeBtn;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"登录"];
    [self setBackBtn];
    
    [self initViews];
    
    
}

- (void)initViews{
    
    UIView *bgView = [UIView new];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    bgView.backgroundColor = [UIColor whiteColor];
    
    
    
    //
    self.codeBtn = ({
        UIButton *verifyBtn = [UIButton new];
        [self.view addSubview:verifyBtn];
        [verifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.width.mas_equalTo(85);
            make.height.mas_equalTo(30);
            make.top.mas_equalTo(bgView).offset(15);
        }];
        verifyBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        verifyBtn.layer.borderWidth = 1;
        verifyBtn.layer.cornerRadius = 5;
        verifyBtn.layer.masksToBounds = YES;
        verifyBtn.titleLabel.font = KFont(12);
        [verifyBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [verifyBtn setTitleColor:RGBHex(@"#8e8e8e") forState:UIControlStateNormal];
        [verifyBtn addTarget:self action:@selector(verifyAction) forControlEvents:UIControlEventTouchUpInside];
        [verifyBtn sizeThatFits:CGSizeMake([self titleWidth:verifyBtn.currentTitle], 30)];
        verifyBtn;
    });
    

    
    self.phoneField = ({
        UITextField *view = [UITextField new];
        view.delegate = self;
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bgView);
            make.height.mas_equalTo(60);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(_codeBtn.mas_left).offset(-10);
        }];
        view.keyboardType = UIKeyboardTypeNumberPad;
        view.font = KFont(15);
        view.placeholder = @"请输入手机号";
        view;
    });

    
    
    
    UIView *line1 = [UIView new];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(_phoneField.mas_bottom);
    }];
    line1.backgroundColor = RGBHex(@"#eeeeee");
    
    
    self.codeField = ({
        UITextField *view = [UITextField new];
        view.delegate = self;
        view.returnKeyType = UIReturnKeyDone;
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(line1.mas_bottom);
            make.height.mas_equalTo(60);
            make.right.mas_equalTo(-15);
        }];
        view.font = KFont(15);
        view.placeholder = @"请输入短信验证码";
        view;
    });
    
    UIView *line2 = [UIView new];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(_codeField.mas_bottom);
    }];
    line2.backgroundColor = RGBHex(@"#eeeeee");
    
    
    UIButton *loginBtn = [UIButton new];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line2.mas_bottom).offset(100);
        make.centerX.mas_equalTo(self.view);
    }];
    [loginBtn setBackgroundImage:KImageName(@"兑奖按钮") forState:UIControlStateNormal];
    loginBtn.titleLabel.font = KFont(16);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView *logoView = [UIImageView new];
    [self.view addSubview:logoView];
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-35);
    }];
    logoView.image = KImageName(@"LOGO");
}

#pragma mark 按钮action
//获取验证码
- (void)verifyAction{
    
    if (![_phoneField.text length]) {
        [MBProgressHUD showError:@"请输入您的手机号" toView:nil];
        return;
    }
    if (![_phoneField.text validateMobile]) {
        [MBProgressHUD showError:@"请输入正确的手机号" toView:nil];
        return;
    }
    
    NSString *randomNum = [Tools randomNum];
    NSString *md5 = [NSString stringWithFormat:@"%@%@%@",_phoneField.text,randomNum,PRIVATE_KEY];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:_phoneField.text forKey:@"phone"];
    [param setObject:randomNum forKey:@"Random"];
    [param setObject:[Tools md5:md5] forKey:@"encryption"];
    
    KWeakSelf
    [MBProgressHUD showMessag:@"" toView:self.view];
    [RequestManager postWithURLString:KSendCode parameters:param  success:^(id responseObject) {
        
        if ([responseObject[@"code"] intValue] == 1) {
            
            [MBProgressHUD hideHudToView:weakSelf.view animated:YES];
        }else{
            
            [MBProgressHUD showError:responseObject[@"msg"] toView:weakSelf.view];
        }
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHudToView:weakSelf.view animated:YES];
    }];
    
    [_codeBtn startTimeWithDuration:60];

}

//登录
- (void)loginAction{
    
    [self.view endEditing:YES];
    
    if (![_phoneField.text length]) {
        [MBProgressHUD showError:@"请输入您的手机号" toView:nil];
        return;
    }
    
    if (![_codeField.text length]) {
        [MBProgressHUD showError:@"请输入验证码" toView:nil];
        return;
    }
    if (![_phoneField.text validateMobile]) {
        [MBProgressHUD showError:@"请输入正确的手机号" toView:nil];
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:_phoneField.text forKey:@"phone"];
    [param setObject:_codeField.text forKey:@"code"];
    
    KWeakSelf
    [MBProgressHUD showMessag:@"" toView:self.view];
    [RequestManager postWithURLString:KLOGIN parameters:param  success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 1) {
            User *user = [User mj_objectWithKeyValues:responseObject[@"data"]];
            user.phone = _phoneField.text;
            [user save];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            
            [MBProgressHUD showError:responseObject[@"msg"] toView:nil];
        }
        
        [MBProgressHUD hideHudToView:weakSelf.view animated:YES];
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHudToView:weakSelf.view animated:YES];
    }];

}

- (CGFloat)titleWidth:(NSString *)title{
    CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : KFont(12)} context:nil].size;
    return ceil(size.width);
}

- (void)willMoveToParentViewController:(UIViewController*)parent{
    [super willMoveToParentViewController:parent];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.navigationController.navigationBarHidden = NO;
}

@end
