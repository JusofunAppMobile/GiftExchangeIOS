//
//  NetFailView.m
//  RecruitOnline
//
//  Created by JUSFOUN on 2017/7/14.
//  Copyright © 2017年 JUSFOUN. All rights reserved.
//

#import "NetFailView.h"

@implementation NetFailView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        NSString* imageName = @"连接断开";
        NSString* msg = @"网络出现了问题";
        
        
        UIImageView *imageView = [UIImageView new];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(60);
            make.height.mas_equalTo(130*(KDeviceW/375.f));
            make.width.mas_equalTo(200*(KDeviceW/375.f));
        }];
        imageView.image = KImageName(imageName);
        
        
        UILabel *label = [UILabel new];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(imageView.mas_bottom).offset(25);
        }];
        label.font = KFont(15);
        label.text = msg;
        label.textColor = RGBHex(@"#a9a9a9");
        
        UIButton *button = [UIButton new];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(label.mas_bottom).offset(60);
        }];
        button.titleLabel.font = KFont(15);
        [button setTitle:@"重新加载" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(reloadAction) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:KImageName(@"兑奖点击") forState:UIControlStateNormal];
        
        
    }
    return self;
}


- (void)reloadAction{
    if ([_delegate respondsToSelector:@selector(netFailReload)]) {
        [_delegate netFailReload];
    }
}


@end
