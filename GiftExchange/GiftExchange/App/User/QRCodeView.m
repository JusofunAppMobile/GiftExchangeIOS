//
//  QRCodeView.m
//  GiftExchange
//
//  Created by JUSFOUN on 2018/4/11.
//  Copyright © 2018年 jusfoun. All rights reserved.
//

#import "QRCodeView.h"
#import "UIImage+LXDCreateBarcode.h"
#import "AppDelegate.h"


@interface QRCodeView()
@property (nonatomic ,strong) UIView *footerView;
@property (nonatomic ,strong) UIImageView *imageView;
@end

@implementation QRCodeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
        self.frame           = KFrame(0, 0, KDeviceW, KDeviceH);
        [self initView];
    }
    return self;
}

- (void)initView{
    _footerView = [[UIView alloc]initWithFrame:KFrame(0, KDeviceH, KDeviceW, KDeviceW)];
    _footerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_footerView];
    
    self.imageView = ({
        UIImageView *view = [UIImageView new];
        view.backgroundColor = [UIColor whiteColor];
        [_footerView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(200);
            make.centerX.mas_equalTo(_footerView);
            make.top.mas_equalTo((KDeviceW-200-60)/2);
        }];
        view;
    });
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = KHexRGB(0xcccccc);
    [_footerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(KDeviceW-60);
    }];
    
    UIButton *button = [UIButton new];
    [button setTitle:@"关闭" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_footerView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(_footerView);
        make.height.mas_equalTo(60);
    }];
}

- (void)showWithString:(NSString *)str{
    str = str?str:@"";
    UIImage * image = [UIImage imageOfQRFromURL:str codeSize: 200 red: 0 green: 0 blue: 0 insertImage: nil roundRadius: 0];
    _imageView.image = image;
    [KeyWindow addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        _footerView.frame = KFrame(0, KDeviceH-KDeviceW, KDeviceW, KDeviceW);
    }];
}

- (void)dismiss{
    
    [UIView animateWithDuration:0.3 animations:^{
        _footerView.frame = KFrame(0, KDeviceH, KDeviceW, KDeviceW);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
