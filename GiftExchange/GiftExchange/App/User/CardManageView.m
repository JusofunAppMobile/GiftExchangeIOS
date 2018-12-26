//
//  CardManageView.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/29.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "CardManageView.h"
#import "CustomTextField.h"

@interface CardManageView ()

@property (nonatomic ,strong) CustomTextField *phoneField;

@property (nonatomic ,strong) CustomTextField *nameField;

@property (nonatomic ,strong) UIView *backView;

@end

@implementation CardManageView

- (instancetype)init{
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
        self.frame           = KFrame(0, 0, KDeviceW, KDeviceH);
        
        [self addTapGesture];
        [self initView];
    }
    return self;
}


- (void)initView{
    
    CGFloat scale = MIN(1.f, KDeviceW/375.f);
    
    self.backView = ({
        UIView *view = [UIView new];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(180);
            make.width.mas_equalTo(KDeviceW-80*scale);
            make.centerX.mas_equalTo(self);
        }];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 5.f;
        view;
    });
    
    self.phoneField = ({
        CustomTextField *view = [CustomTextField new];
        [_backView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_backView).offset(25);
            make.left.mas_equalTo(_backView).offset(18);
            make.right.mas_equalTo(_backView).offset(-18);
            make.height.mas_equalTo(40);
        }];
        view.placeholder = @"请输入手机号";
        view.font = KFont(15);
        view.textColor = [UIColor colorWithRed:0.42 green:0.42 blue:0.42 alpha:1.00];
//        view.textAlignment = NSTextAlignmentCenter;
        view.layer.borderWidth = 1.f;
        view.layer.borderColor = RGBHex(@"#d7d7d7").CGColor;
        view.layer.cornerRadius = 20.f;
        view;
    });
    
    
    self.nameField = ({
        CustomTextField *view = [CustomTextField new];
        [_backView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_phoneField.mas_bottom).offset(20);
            make.left.right.mas_equalTo(_phoneField);
            make.height.mas_equalTo(40);
        }];
        view.placeholder = @"请输入姓名";
        view.font = KFont(15);
        view.textColor = [UIColor colorWithRed:0.42 green:0.42 blue:0.42 alpha:1.00];
//        view.textAlignment = NSTextAlignmentCenter;
        view.layer.borderWidth = 1.f;
        view.layer.borderColor = RGBHex(@"#d7d7d7").CGColor;
        view.layer.cornerRadius = 20.f;
        view;
    });
    
    
    UIButton *cancelBtn = [UIButton new];
    [_backView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameField.mas_left);
        make.top.mas_equalTo(_nameField.mas_bottom).offset(20);
        make.bottom.mas_equalTo(_backView).offset(-20);
        make.width.mas_equalTo(125*scale);
        make.height.mas_equalTo(40*scale);
    }];
    [cancelBtn setBackgroundImage:KImageName(@"灰色按钮") forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:RGBHex(@"#9a9a9a") forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *commitBtn = [UIButton new];
    [_backView addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_nameField.mas_right);
        make.top.bottom.mas_equalTo(cancelBtn);
        make.width.mas_equalTo(125*scale);
        make.height.mas_equalTo(40*scale);
    }];
    [commitBtn setBackgroundImage:KImageName(@"桔色按钮") forState:UIControlStateNormal];
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];

}

- (void)addTapGesture{

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
}

- (void)cancelAction{
    [self dismiss];
    
}

- (void)commitAction{
    
    if (![_phoneField.text length]) {
        [MBProgressHUD showHint:@"请输入手机号" toView:nil];
        return;
    }
    if (![_nameField.text length]) {
        [MBProgressHUD showHint:@"请输入姓名" toView:nil];
        return;
    }
    
    if ([_delegate respondsToSelector:@selector(didTapCommitBtnWithPhone:name:)]) {
        [_delegate didTapCommitBtnWithPhone:_phoneField.text name:_nameField.text];
    }
    [self dismiss];

}

#pragma mark 单击
- (void)tapAction{
    [self dismiss];
}

- (void)showInView:(UIView *)view{
    if (!view) {
        view = KeyWindow;
    }
    [view addSubview:self];
}

- (void)dismiss{
    _phoneField.text = nil;
    _nameField.text = nil;
    [self removeFromSuperview];
}


@end
