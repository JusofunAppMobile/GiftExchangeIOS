//
//  SendCardView.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/29.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "SendCardView.h"
#import "CustomTextField.h"
#import "UserPicker.h"
#import "ReceptUserModel.h"

@interface SendCardView ()<UITextFieldDelegate,UIGestureRecognizerDelegate,UserPickerDelegate>

@property (nonatomic ,strong) CustomTextField *userField;

@property (nonatomic ,strong) CustomTextField *numberField;

@property (nonatomic ,strong) UIView *backView;

@property (nonatomic ,strong) UITableView *tableview;

@property (nonatomic ,strong) UserPicker *picker;

@property (nonatomic ,strong) ReceptUserModel *selectModel;

//@property (nonatomic ,assign) SendPickerType pickerType;//选择器类型 0 发送银行职员 1 发送银行管理员


@end

@implementation SendCardView

- (instancetype)init{
    if (self =[super init]) {
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
            make.top.mas_equalTo( (KDeviceH -200)/2 - 20);
            make.width.mas_equalTo(KDeviceW-80*scale);
            make.centerX.mas_equalTo(self);
        }];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 5.f;
        view;
    });
    
    UIImageView *iconView = [[UIImageView alloc]initWithImage:KImageName(@"下箭头")];
    
    self.userField = ({
        CustomTextField *view = [CustomTextField new];
        [_backView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_backView).offset(25);
            make.left.mas_equalTo(_backView).offset(18);
            make.right.mas_equalTo(_backView).offset(-18);
            make.height.mas_equalTo(40);
        }];
        view.placeholder = @"选择接收用户";
        view.font = KFont(15);
        view.textColor = [UIColor colorWithRed:0.42 green:0.42 blue:0.42 alpha:1.00];
        //        view.textAlignment = NSTextAlignmentCenter;
        view.layer.borderWidth = 1.f;
        view.layer.borderColor = RGBHex(@"#d7d7d7").CGColor;
        view.layer.cornerRadius = 20.f;
        view.rightView = iconView;
        view.rightViewMode = UITextFieldViewModeAlways;
        view.delegate = self;
        view;
    });
    
    
    self.numberField = ({
        CustomTextField *view = [CustomTextField new];
        [_backView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_userField.mas_bottom).offset(20);
            make.left.right.mas_equalTo(_userField);
            make.height.mas_equalTo(40);
        }];
        view.placeholder = @"请输入卡券数量";
        view.font = KFont(15);
        view.textColor = [UIColor colorWithRed:0.42 green:0.42 blue:0.42 alpha:1.00];
        //        view.textAlignment = NSTextAlignmentCenter;
        view.layer.borderWidth = 1.f;
        view.layer.borderColor = RGBHex(@"#d7d7d7").CGColor;
        view.layer.cornerRadius = 20.f;
        view.keyboardType = UIKeyboardTypeNumberPad;
        view;
    });
    
    
    UIButton *cancelBtn = [UIButton new];
    [_backView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_numberField.mas_left);
        make.top.mas_equalTo(_numberField.mas_bottom).offset(20);
        make.width.mas_equalTo(125*scale);
        make.height.mas_equalTo(40*scale);
        make.bottom.mas_equalTo(_backView).offset(-20);
    }];
    cancelBtn.titleLabel.font = KFont(15);
    [cancelBtn setBackgroundImage:KImageName(@"灰色按钮") forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:RGBHex(@"#9a9a9a") forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *commitBtn = [UIButton new];
    [_backView addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_numberField.mas_right);
        make.top.bottom.mas_equalTo(cancelBtn);
        make.width.mas_equalTo(125*scale);
        make.height.mas_equalTo(40*scale);
    }];
    commitBtn.titleLabel.font = KFont(15);
    [commitBtn setBackgroundImage:KImageName(@"桔色按钮") forState:UIControlStateNormal];
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark 取消，提交
- (void)cancelAction{
    [self resetView];
    [self dismiss];
}

- (void)commitAction{
    [self dismiss];
    
    if (![_userField.text length]) {
        [MBProgressHUD showHint:@"请选择接收用户" toView:nil];
        return;
    }
    if (![_numberField.text length]) {
        [MBProgressHUD showHint:@"请输入卡券数量" toView:nil];
        return;
    }
    
    _selectModel.num = _numberField.text;
    
    if ([_delegate respondsToSelector:@selector(commitWithUser:)]) {
        [_delegate commitWithUser:_selectModel];
    }
    [self resetView];//清空输入框
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:_userField]) {
        [self.picker show];
        return NO;
    }
    return YES;
}

#pragma mark 单击
- (void)addTapGesture{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    [self resetView];
    [self dismiss];
}

//解决点击-backview视图消失
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:_backView]) {
        return NO;
    }
    return YES;
}

#pragma mark 选取用户 UserPickerDelegate
- (void)didSelectUserPicker:(ReceptUserModel *)model{
    _selectModel = model;
    _userField.text = [NSString stringWithFormat:@"%@%@",model.bankName,model.name];
}
#pragma mark lazy load
- (UserPicker *)picker{
    if (!_picker) {
        _picker = [[UserPicker alloc]initWithData:_models];
        _picker.delegate = self;
    }
    return _picker;
}

//显示隐藏
- (void)showInView:(UIView *)view{
    if (!view) {
        view = KeyWindow;
    }
    [view addSubview:self];//添加到self.view
}

- (void)dismiss{
    [self removeFromSuperview];
}

- (void)resetView{
    _userField.text = nil;
    _numberField.text = nil;
}


@end
