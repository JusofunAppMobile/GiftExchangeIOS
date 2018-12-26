//
//  WaitingView.m
//  GiftExchange
//
//  Created by WangZhipeng on 17/8/15.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "WaitingView.h"
@interface WaitingView ()
{
    UIView *coveView;
    UIView*backView;
   
    UITextField *textFld;
    
}

@end
@implementation WaitingView

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
        
        
        backView = [[UIView alloc]initWithFrame:KFrame(40, (KDeviceH -200)/2 - 20, KDeviceW - 80, 150)];
        backView.backgroundColor = [UIColor whiteColor];
        backView.layer.cornerRadius = 5;
        [coveView addSubview:backView];
        
        
        
        
        textFld = [[UITextField alloc]initWithFrame:KFrame(15, 25, backView.width-30, 40)];
        textFld.textColor = [UIColor colorWithRed:0.42 green:0.42 blue:0.42 alpha:1.00];
        textFld.backgroundColor = [UIColor whiteColor];
        textFld.placeholder = @"请输入快递单号";
        textFld.font = KFont(16);
        textFld.textAlignment = NSTextAlignmentCenter;
        textFld.layer.borderWidth = 1;
        textFld.layer.borderColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1.00].CGColor;
        textFld.layer.cornerRadius = 20;
        [backView addSubview:textFld];
        
        
       
        
        CGFloat width = (backView.width - 15*3)/2.0;
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = KFrame(15, textFld.maxY+20, width, 40);
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



-(void)operationSelector:(UIButton*)button
{
    if(button.tag == 4765)//提价
    {
        if(self.logisticsBlock)
        {
            self.logisticsBlock(textFld.text);
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







@end
