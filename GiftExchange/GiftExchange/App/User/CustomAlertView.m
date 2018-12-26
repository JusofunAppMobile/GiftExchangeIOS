//
//  CustomAlertView.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/30.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "CustomAlertView.h"

@interface CustomAlertView ()

@property (nonatomic ,strong) UIView *backView;

@property (nonatomic ,strong) UIImageView *iconView;

@property (nonatomic ,strong) UILabel *titleLab;

@property (nonatomic ,strong) UIButton *cancelBtn;

@property (nonatomic ,strong) UIButton *assureBtn;


@end

@implementation CustomAlertView



- (instancetype)initWithMessage:(NSString *)msg icon:(NSString *)imageName{
    if (self = [super init]) {
        
        CGFloat scale = MIN(1.f, KDeviceW/375.f);

        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
        self.frame = KeyWindow.bounds;
        
        self.backView = ({
            UIView *view = [UIView new];
            [self addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(180);
                make.width.mas_equalTo(KDeviceW-70*scale);
                make.centerX.mas_equalTo(self);
            }];
            view.backgroundColor = [UIColor whiteColor];
            view.layer.cornerRadius = 5.f;
            view;
        });
        
        self.iconView = ({
            UIImageView *view = [UIImageView new];
            [_backView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_backView).offset(25);
                make.centerX.mas_equalTo(_backView);
            }];
            view.image = KImageName(imageName);
            view;
        });
        
        self.titleLab = ({
            UILabel *view = [UILabel new];
            [_backView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_backView).offset(15);
                make.right.mas_equalTo(_backView).offset(-15);
                make.top.mas_equalTo(_iconView.mas_bottom).offset(20);
            }];
            view.font = KFont(13);
            view.numberOfLines = 2;
            view.text = msg;
            view.textColor = RGBHex(@"#2d2d2d");
            view.textAlignment = NSTextAlignmentCenter;
            view.lineBreakMode = NSLineBreakByTruncatingMiddle;
            view;
        });
        
        self.cancelBtn = ({
            UIButton *view = [UIButton new];
            [_backView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_backView).offset(15);
                make.top.mas_equalTo(_titleLab.mas_bottom).offset(10);
                make.bottom.mas_equalTo(_backView).offset(-20);
                make.width.mas_equalTo(125*scale);
                make.height.mas_equalTo(40*scale);
            }];
            view.titleLabel.font = KFont(15);
            [view setBackgroundImage:KImageName(@"灰色按钮") forState:UIControlStateNormal];
            [view setTitle:@"取消" forState:UIControlStateNormal];
            [view setTitleColor:RGBHex(@"#9a9a9a") forState:UIControlStateNormal];
            [view addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
            view;
        });
        
        self.assureBtn = ({
            UIButton *view = [UIButton new];
            [_backView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(_backView).offset(-15);
                make.bottom.mas_equalTo(_backView).offset(-20);
                make.top.mas_equalTo(_titleLab.mas_bottom).offset(10);
                make.width.mas_equalTo(125*scale);
                make.height.mas_equalTo(40*scale);
            }];
            view.titleLabel.font = KFont(15);
            [view setBackgroundImage:KImageName(@"桔色按钮") forState:UIControlStateNormal];
            [view setTitle:@"确定" forState:UIControlStateNormal];
            [view addTarget:self action:@selector(assureAction) forControlEvents:UIControlEventTouchUpInside];
            view;
        });
    
    }
    return self;
}


- (void)cancelAction{
    [self dismiss];
}

- (void)assureAction{
    [self dismiss];
    
    if ([_delegate respondsToSelector:@selector(dismissWithAssureButton)]) {
        [_delegate dismissWithAssureButton];
    }
}


#pragma mark 显示 隐藏

- (void)show{
    
    [KeyWindow addSubview:self];
}

- (void)dismiss{
    [self removeFromSuperview];
    
}

@end
