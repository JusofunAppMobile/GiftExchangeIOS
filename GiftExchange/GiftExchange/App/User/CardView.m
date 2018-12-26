//
//  CardView.m
//  GiftExchange
//
//  Created by WangZhipeng on 17/8/11.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "CardView.h"
@interface CardView ()
{
    UIScrollView *backScrollView;
    
    UITextField *nameTextFlf;
    UITextField *passWordFlf;
    
    UIView*inputView;
    
    UIView*guideView;
}

@end
@implementation CardView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
        
        backScrollView = [[UIScrollView alloc]initWithFrame:KFrame(0, 0, self.width, self.height)];
        [self addSubview:backScrollView];
        
        [self drawInputView];
        
        [self drawGuideView];
        
    }
    return self;
}

-(void)exchange
{
    [self resignFirstResponder];
    if(nameTextFlf.text.length == 0)
    {
        [MBProgressHUD showError:@"请输入卡号" toView:self];
        return;
    }
    if(passWordFlf.text.length == 0)
    {
        [MBProgressHUD showError:@"请输入密码" toView:self];
        return;
    }
    
    if(self.resultBlock)
    {
        self.resultBlock(nameTextFlf.text,passWordFlf.text);
    }
    
}

-(void)drawInputView
{
    inputView = [[UIView alloc]initWithFrame:KFrame(0, 10, KDeviceW, 100)];
    inputView.backgroundColor = [UIColor whiteColor];
    [backScrollView addSubview:inputView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:KFrame(20, 0, KDeviceW -40, 25)];
    label.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.40 alpha:1.00];
    label.font = KFont(12);
    label.text = @"卡密兑奖";
    [inputView addSubview:label];
    
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:KFrame(0, label.maxY, 60, 60)];
    nameLabel.textColor = [UIColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:1.00];
    nameLabel.textAlignment = NSTextAlignmentRight;
    nameLabel.font = KFont(16);
    nameLabel.text = @"卡号:";
    [inputView addSubview:nameLabel];
    
    nameTextFlf = [[UITextField alloc]initWithFrame:KFrame(nameLabel.maxX+10, nameLabel.y, KDeviceW - nameLabel.maxX - 30  , nameLabel.height)];
    nameTextFlf.placeholder = @"请输入卡号";
    [nameTextFlf setValue:[UIColor colorWithRed:0.40 green:0.40 blue:0.40 alpha:1.00] forKeyPath:@"_placeholderLabel.textColor"];
    nameTextFlf.font = KFont(15);
    nameTextFlf.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.40 alpha:1.00];
    nameTextFlf.autocorrectionType = UITextAutocorrectionTypeNo;
    nameTextFlf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    nameTextFlf.spellCheckingType = UITextSpellCheckingTypeNo;
    [inputView addSubview:nameTextFlf];
    
    
    
    UILabel *passLabel = [[UILabel alloc]initWithFrame:KFrame(0, nameLabel.maxY, 60, 60)];
    passLabel.textColor = [UIColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:1.00];
    passLabel.textAlignment = NSTextAlignmentRight;
    passLabel.font = KFont(16);
    passLabel.text = @"密码:";
    [inputView addSubview:passLabel];
    
    passWordFlf = [[UITextField alloc]initWithFrame:KFrame(passLabel.maxX+10, passLabel.y, KDeviceW - passLabel.maxX - 30  , passLabel.height)];
    passWordFlf.placeholder = @"请输入密码";
    [passWordFlf setValue:[UIColor colorWithRed:0.40 green:0.40 blue:0.40 alpha:1.00] forKeyPath:@"_placeholderLabel.textColor"];
    passWordFlf.font = KFont(15);
    passWordFlf.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.40 alpha:1.00];
    passWordFlf.secureTextEntry = YES;
    passWordFlf.autocorrectionType = UITextAutocorrectionTypeNo;
    passWordFlf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    passWordFlf.spellCheckingType = UITextSpellCheckingTypeNo;
    [inputView addSubview:passWordFlf];

    
    
    [self addLineViewWithFrame:KFrame(0, label.maxY, KDeviceW, 1) withBackView:inputView];
    
    [self addLineViewWithFrame:KFrame(0, nameLabel.maxY, KDeviceW, 1) withBackView:inputView];
    
    [self addLineViewWithFrame:KFrame(0, passLabel.maxY, KDeviceW, 1) withBackView:inputView];
    
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = KFrame(48, passWordFlf.maxY + 30 , KDeviceW - 48*2, 40);
    [button jm_setCornerRadius:20 withBackgroundColor:[UIColor colorWithRed:1.00 green:0.40 blue:0.00 alpha:1.00]];
    [button setTitle:@"我要兑奖" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(exchange) forControlEvents:UIControlEventTouchUpInside];
    [inputView addSubview:button];
    
    inputView.frame = KFrame(0, 10, KDeviceW, button.maxY + 40);

    
    
}

-(void)drawGuideView
{
    guideView = [[UIView alloc]initWithFrame:KFrame(0, inputView.maxY+10, KDeviceW, 100)];
    guideView.backgroundColor = [UIColor whiteColor];
    [backScrollView addSubview:guideView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:KFrame(20, 0, KDeviceW -40, 25)];
    label.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.40 alpha:1.00];
    label.font = KFont(12);
    label.text = @"兑奖指南";
    [guideView addSubview:label];
    
    [self addLineViewWithFrame:KFrame(0, label.maxY, KDeviceW, 1) withBackView:guideView];
    
    
    NSArray *imageArray = @[@"扫描二维码",@"选择奖品",@"地址",@"收货"];
    NSArray *numArray = @[@"card1",@"card2",@"card3",@"card4"];
    NSArray *textArray = @[@"通过扫描兑奖卡二维码或输入卡密进行兑奖",@"选择您心怡的奖品",@"填写您的收货地址，并提交",@"等待收货"];
    
    int y = label.maxY + 20;
    
    for(int i = 0;i<imageArray.count;i++)
    {
        UIView *view = [self cellViewWithFrame:KFrame(0, y, KDeviceW, 66) imageName:[imageArray objectAtIndex:i] numImageName:[numArray objectAtIndex:i] text:[textArray objectAtIndex:i]halfType:i];
        [guideView addSubview:view];
        
        y = y+66;
    }
    
    guideView.frame = KFrame(0, inputView.maxY+10, KDeviceW, y);
    
    backScrollView.contentSize = CGSizeMake(0, guideView.maxY);
    
}



-(UIView*)cellViewWithFrame:(CGRect)frame imageName:(NSString*)imageName numImageName:(NSString*)nameImageStr text:(NSString*)text halfType:(int)type
{
    UIView*backView = [[UIView alloc]initWithFrame:frame];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:KFrame(0, 0, 100, backView.height)];
    imageView.image = KImageName(imageName);
    imageView.contentMode = UIViewContentModeCenter;
    [backView addSubview:imageView];
    
    UIImageView *shuImageView = [[UIImageView alloc]initWithFrame:KFrame(imageView.maxX + 8, 0, 1, backView.height)];
    shuImageView.image = KImageName(@"竖虚线");
    [backView addSubview:shuImageView];
    
    if(type == 0 )
    {
        shuImageView.frame = KFrame(imageView.maxX + 8, backView.height/2, 1, backView.height/2);
    }
    if(type == 3)
    {
        shuImageView.frame = KFrame(imageView.maxX + 8, 0, 1, backView.height/2);
    }
    
    UIImageView *numImageView = [[UIImageView alloc]initWithFrame:KFrame(imageView.maxX, 0, 16, backView.height)];
    numImageView.image = KImageName(nameImageStr);
    numImageView.contentMode = UIViewContentModeCenter;
    [backView addSubview:numImageView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:KFrame(numImageView.maxX +10, 0, KDeviceW - numImageView.maxX - 10 - 20, backView.height)];
    label.textColor = [UIColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:1.00];
    label.font = KFont(12);
    label.numberOfLines = 0;
    label.text = text;
    [backView addSubview:label];
    
    
    return backView;
}



-(UIView *)addLineViewWithFrame:(CGRect)frame withBackView:(UIView *)backView
{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
    [backView addSubview:view];
    return view;
}




@end
