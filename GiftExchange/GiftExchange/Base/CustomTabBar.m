//
//  CustomTabBar.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/18.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "CustomTabBar.h"
#import "AppDelegate.h"
#import "ExchangeController.h"
#import "BasicNavigationController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"


@interface CustomTabBar ()

@property (nonatomic ,strong) UIButton *midBtn;
@property (nonatomic,assign)UIEdgeInsets oldSafeAreaInsets;

@end
@implementation CustomTabBar


- (void) safeAreaInsetsDidChange
{
    [super safeAreaInsetsDidChange];
    if(self.oldSafeAreaInsets.left != self.safeAreaInsets.left ||
       self.oldSafeAreaInsets.right != self.safeAreaInsets.right ||
       self.oldSafeAreaInsets.top != self.safeAreaInsets.top ||
       self.oldSafeAreaInsets.bottom != self.safeAreaInsets.bottom)
    {
        self.oldSafeAreaInsets = self.safeAreaInsets;
        [self invalidateIntrinsicContentSize];
        [self.superview setNeedsLayout];
        [self.superview layoutSubviews];
    }
    
}

- (CGSize) sizeThatFits:(CGSize) size
{
    CGSize s = [super sizeThatFits:size];
    if(@available(iOS 11.0, *))
    {
        CGFloat bottomInset = self.safeAreaInsets.bottom;
        if( bottomInset > 0 && s.height < 50) {
            s.height += bottomInset;
        }
    }
    return s;
}

- (UIButton *)midBtn{

    if (_midBtn == nil) {
    
        _midBtn = [UIButton new];
        [self addSubview:_midBtn];
        [_midBtn setImage:KImageName(@"兑奖icon默认") forState:UIControlStateNormal];
        [_midBtn setImage:KImageName(@"兑奖icon选中") forState:UIControlStateHighlighted];
        [_midBtn setTitle:@"兑奖" forState:UIControlStateNormal];
        [_midBtn setTitleColor:RGBHex(@"#5b5b5b") forState:UIControlStateNormal];
        [_midBtn setTitleColor:RGBHex(@"#ff0000") forState:UIControlStateHighlighted];
        _midBtn.titleLabel.font = KFont(10);
        _midBtn.frame = KFrame(0, 0, self.width/3, self.height);
        _midBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        _midBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _midBtn.imageEdgeInsets = UIEdgeInsetsMake(7, (_midBtn.width-_midBtn.imageView.width)/2, 0, 0);
        _midBtn.titleEdgeInsets = UIEdgeInsetsMake(7+_midBtn.imageView.height+7, _midBtn.width/2-(_midBtn.imageView.width+_midBtn.titleLabel.width/2), 0, 0);

        [_midBtn addTarget:self action:@selector(midAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _midBtn;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSInteger num = self.items.count +1;
    
    CGFloat btnW = self.frame.size.width/num;
    
    CGFloat btnH = 83;
    
    NSInteger i = 0;
    for (UIView *tabBarButton in self.subviews) {//num
        
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
        
            if (i == 1) {//右移第二个按钮
                i += 1;
            }
            tabBarButton.frame = CGRectMake(btnW*i, 0, btnW, btnH);
            i++;
        }
    }
    
    self.midBtn.center = CGPointMake(self.width/2, 83/2);
}


- (void)midAction{
    _midBtn.highlighted = YES;
    if ([self checkLogin]) {
        ExchangeController *vc = [ExchangeController new];
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app.rootNavi pushViewController:vc animated:YES];
    }
    
}
- (BOOL)checkLogin{
    
    if (![KUSER isLogin]) {
        LoginViewController *vc = [LoginViewController new];
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app.rootNavi pushViewController:vc animated:YES];
        //        [app setLoginController];
        
        return NO;
    }
    return YES;
}


@end
