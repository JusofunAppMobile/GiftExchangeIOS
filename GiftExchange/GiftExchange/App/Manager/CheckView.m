//
//  CheckView.m
//  GiftExchange
//
//  Created by WangZhipeng on 17/8/14.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "CheckView.h"
@interface CheckView ()
{
    UIView *coveView;
    UIView*backView;
    UIButton *passBtn;
    UIButton *rejectBtn;
    
    CheckType type;
    
    UIImageView *chooseImageView;
}

@end
@implementation CheckView

-(instancetype)init
{
    self = [super initWithFrame:KFrame(0, 0, KDeviceW, KDeviceH)];
    if(self)
    {
        coveView = [[UIView alloc]initWithFrame:KFrame(0, 0, KDeviceW, KDeviceH)];
        coveView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self addSubview:coveView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        [coveView addGestureRecognizer:tap];
        
        
        backView = [[UIView alloc]initWithFrame:KFrame(40, (KDeviceH -200)/2 - 20, KDeviceW - 80, 200)];
        backView.backgroundColor = [UIColor whiteColor];
        backView.layer.cornerRadius = 5;
        [coveView addSubview:backView];
        
        
        
        
        passBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        passBtn.frame = KFrame(0, 25, backView.width, 50);
        [passBtn addTarget:self action:@selector(buttonSelector:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:passBtn];
        passBtn.selected = YES;
        type =  CheckPass;
        [passBtn setBackgroundColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00]];
      
        UILabel *label2 = [[UILabel alloc]initWithFrame:KFrame(20, 0, passBtn.width -40, passBtn.height)];
        label2.textColor = [UIColor colorWithRed:0.42 green:0.42 blue:0.42 alpha:1.00];
        label2.backgroundColor = [UIColor clearColor];
        label2.text = @"通过";
        label2.font = KFont(16);
        [passBtn addSubview:label2];
        
        
        
        rejectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rejectBtn.frame = KFrame(0, passBtn.maxY, backView.width, 50);
        [rejectBtn addTarget:self action:@selector(buttonSelector:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:rejectBtn];
        
        UILabel *label = [[UILabel alloc]initWithFrame:KFrame(20, 0, rejectBtn.width -40, rejectBtn.height)];
        label.textColor = [UIColor colorWithRed:0.42 green:0.42 blue:0.42 alpha:1.00];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"不通过";
        label.font = KFont(16);
        [rejectBtn addSubview:label];
        
        chooseImageView = [[UIImageView alloc]initWithFrame:KFrame(backView.width - 20 - 25, passBtn.y + 12, 25, 25)];
        chooseImageView.contentMode = UIViewContentModeScaleAspectFit;
        chooseImageView.image = KImageName(@"选中");
        [backView addSubview:chooseImageView];

        
        [self addLineViewWithFrame:KFrame(0, passBtn.maxY, KDeviceW, 1) withBackView:backView];
        
        [self addLineViewWithFrame:KFrame(0, rejectBtn.maxY, KDeviceW, 1) withBackView:backView];
        
        CGFloat width = (backView.width - 15*3)/2.0;
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = KFrame(15, rejectBtn.maxY+20, width, 40);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor colorWithRed:0.64 green:0.64 blue:0.64 alpha:1.00] forState:UIControlStateNormal];
        [cancelBtn setBackgroundColor:[UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1.00]];
        cancelBtn.tag = 4764;
        cancelBtn.layer.cornerRadius = 20;
        [cancelBtn addTarget:self action:@selector(operationSelector:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:cancelBtn];
        
        UIButton *applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        applyBtn.frame = KFrame(cancelBtn.maxX +15, cancelBtn.y, cancelBtn.width, cancelBtn.height);
        [applyBtn setTitle:@"提交" forState:UIControlStateNormal];
        [applyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        applyBtn.tag = 4765;
        applyBtn.layer.cornerRadius = 20;
        [applyBtn setBackgroundColor:[UIColor colorWithRed:0.99 green:0.20 blue:0.08 alpha:1.00]];
        [applyBtn addTarget:self action:@selector(operationSelector:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:applyBtn];

        
        
    }
    
    return self;
}

-(void)buttonSelector:(UIButton*)button
{
    
    button.selected = YES;
    [button setBackgroundColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00]];
    if(button == passBtn)
    {
        type = CheckPass;
        rejectBtn.selected = NO;
        [rejectBtn setBackgroundColor:[UIColor whiteColor]];
        chooseImageView.frame = KFrame(backView.width - 20 - 25, passBtn.y + 12, 25, 25);
    }
    else
    {
        type = CheckReject;
        passBtn.selected = NO;
        [passBtn setBackgroundColor:[UIColor whiteColor]];
        chooseImageView.frame = KFrame(backView.width - 20 - 25, rejectBtn.y + 12, 25, 25);
    }
}

-(void)operationSelector:(UIButton*)button
{
    if(button.tag == 4765)//提价
    {
        if(self.checkBlock)
        {
            self.checkBlock(type);
        }
    }
    
    
    [self dismiss];
}


-(void)show
{
    [KeyWindow addSubview:self];
}



-(void)dismiss
{
    [self removeFromSuperview];
}


-(UIView *)addLineViewWithFrame:(CGRect)frame withBackView:(UIView *)subView
{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
    [subView addSubview:view];
    return view;
}




@end
