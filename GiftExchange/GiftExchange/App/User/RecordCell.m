//
//  RecordCell.m
//  GiftExchange
//
//  Created by WangZhipeng on 17/8/14.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "RecordCell.h"

#define KImageViewWidth  (KDeviceW - 30 - 30)/4.0

@implementation RecordCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        self.timeLabel = [[UILabel alloc]initWithFrame:KFrame(KDeviceW - 145, 0, 130, 55)];
        self.timeLabel.font =  KFont(14);
        self.timeLabel.textColor = [UIColor colorWithRed:0.53 green:0.53 blue:0.53 alpha:1.00];
        [self.contentView addSubview:self.timeLabel];
        
        self.orderLabel = [[UILabel alloc]initWithFrame:KFrame(15, 0, KDeviceW - self.timeLabel.width - 30 - 15, 55)];
        self.orderLabel.font =  KFont(14);
        [self.contentView addSubview:self.orderLabel];
        
        
        [self addLineViewWithFrame:KFrame(0, self.orderLabel.height -1, KDeviceW, 1) withBackView:self.contentView];
        
        
        self.goodsImageView = [[UIImageView alloc]initWithFrame:KFrame(15, self.orderLabel.maxY + 10, KImageViewWidth, 90)];
        self.goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.goodsImageView.clipsToBounds = YES;
        [self.contentView addSubview:self.goodsImageView];
        
        self.goodsImageView2 = [[UIImageView alloc]initWithFrame:KFrame(self.goodsImageView.maxX +10, self.goodsImageView.y, self.goodsImageView.width, self.goodsImageView.height)];
        self.goodsImageView2.contentMode = UIViewContentModeScaleAspectFill;
        self.goodsImageView2.clipsToBounds = YES;
        [self.contentView addSubview:self.goodsImageView2];
        self.goodsImageView2.hidden = YES;
        
        self.goodsImageView3 = [[UIImageView alloc]initWithFrame:KFrame(self.goodsImageView2.maxX +10, self.goodsImageView.y, self.goodsImageView.width, self.goodsImageView.height)];
        self.goodsImageView3.contentMode = UIViewContentModeScaleAspectFill;
        self.goodsImageView3.clipsToBounds = YES;
        [self.contentView addSubview:self.goodsImageView3];
        self.goodsImageView3.hidden = YES;
        
        self.cardLabel = [[UILabel alloc]initWithFrame:KFrame(KDeviceW - KImageViewWidth-15, self.goodsImageView.y, KImageViewWidth, self.goodsImageView.height)];
        self.cardLabel.textAlignment = NSTextAlignmentCenter;
        self.cardLabel.font =  KFont(14);
        [self.contentView addSubview:self.cardLabel];
        
        self.nameLabel = [[LYLabel alloc]initWithFrame:KFrame(self.goodsImageView.maxX+10, self.goodsImageView.y, KDeviceW - KImageViewWidth*2 -20 - 30, self.goodsImageView.height/2)];
        self.nameLabel.font = KFont(16);
        self.nameLabel.textColor = [UIColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:1.00];
        self.nameLabel.numberOfLines = 0;
        [self.nameLabel setVerticalAlignment:VerticalAlignmentBottom];
        [self.contentView addSubview:self.nameLabel];
        
        
        self.typeLabel = [[LYLabel alloc]initWithFrame:KFrame(self.nameLabel.x, self.nameLabel.maxY+10, self.nameLabel.width, self.goodsImageView.height/2-10)];
        self.typeLabel.font =  KFont(16);
        self.typeLabel.textColor = [UIColor colorWithRed:0.53 green:0.53 blue:0.53 alpha:1.00];
        self.typeLabel.numberOfLines = 0;
        [self.typeLabel setVerticalAlignment:VerticalAlignmentTop];
        [self.contentView addSubview:self.typeLabel];
        
        
        [self addLineViewWithFrame:KFrame(0, self.goodsImageView.maxY + 10 -1, KDeviceW, 1) withBackView:self.contentView];
        
        
        self.numLabel = [[UILabel alloc]initWithFrame:KFrame(15, self.goodsImageView.maxY +10, 100, 50)];
        self.numLabel.font =  KFont(14);
        self.numLabel.textColor = [UIColor colorWithRed:0.53 green:0.53 blue:0.53 alpha:1.00];
        [self.contentView addSubview:self.numLabel];
        
        
        self.adressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.adressBtn.frame = KFrame(KDeviceW - 80-15,self.numLabel.y + 12.5 , 80, 25);
        self.adressBtn.titleLabel.font = KFont(14);
        [self.adressBtn setTitle:@"更改地址" forState:UIControlStateNormal];
        [self.adressBtn setTitleColor:[UIColor colorWithRed:1.00 green:0.37 blue:0.04 alpha:1.00] forState:UIControlStateNormal];
        [self.adressBtn jm_setCornerRadius:self.adressBtn.height/2.0 withBorderColor:[UIColor colorWithRed:1.00 green:0.37 blue:0.04 alpha:1.00] borderWidth:1 backgroundColor:[UIColor whiteColor] backgroundImage:nil contentMode:UIViewContentModeScaleToFill];
        [self.adressBtn addTarget:self action:@selector(changeAdress) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.adressBtn];
        
        self.adressBtn.hidden = YES;
        
        self.tipLabel = [[UILabel alloc]initWithFrame:KFrame(KDeviceW - self.adressBtn.width - 25, self.numLabel.y, 70, 50)];
        self.tipLabel.font =  KFont(14);
        self.tipLabel.textColor = [UIColor colorWithRed:0.53 green:0.53 blue:0.53 alpha:1.00];
        self.tipLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.tipLabel];
        
        
        self.logisticsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.logisticsBtn.frame = KFrame(KDeviceW - 80-15,self.numLabel.y + 12.5 , 80, 25);
        self.logisticsBtn.titleLabel.font = KFont(14);
        [self.logisticsBtn setTitle:@"查看物流" forState:UIControlStateNormal];
        [self.logisticsBtn setTitleColor:[UIColor colorWithRed:0.07 green:0.49 blue:0.96 alpha:1.00] forState:UIControlStateNormal];
        [self.logisticsBtn jm_setCornerRadius:self.adressBtn.height/2.0 withBorderColor:[UIColor colorWithRed:0.07 green:0.49 blue:0.96 alpha:1.00] borderWidth:1 backgroundColor:[UIColor whiteColor] backgroundImage:nil contentMode:UIViewContentModeScaleToFill];
        [self.logisticsBtn addTarget:self action:@selector(checkLogistics) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.logisticsBtn];
        
        self.logisticsBtn.hidden = YES;
        
        UIView *kongView = [[UIView alloc]initWithFrame:KFrame(0, self.numLabel.maxY, KDeviceW, 10)];
        kongView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
        [self.contentView addSubview:kongView];
        
        
    }
    
    return self;
}

-(void)setModel:(GiftExchangeModel *)model
{
    _model = model;
    
    NSString *str = @"订单号：";
    NSString *order = model.no;
    NSString *allStr = [NSString stringWithFormat:@"%@%@",str,order];
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:allStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:1.00] range:NSMakeRange(0, str.length)];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.53 green:0.53 blue:0.53 alpha:1.00] range:NSMakeRange(str.length, order.length)];
    
    self.orderLabel.attributedText = attStr;
    
    NSArray *imageArray = model.imgs;
    
    NSArray *imageViewArray = @[self.goodsImageView,self.goodsImageView2,self.goodsImageView3];
    
    NSInteger maxCount = [imageArray count]>3?3:[imageArray count];
    
    for(int i = 0;i<maxCount;i++)
    {
        NSDictionary *dic = [imageArray objectAtIndex:i];
        UIImageView *imageView = [imageViewArray objectAtIndex:i];
        imageView.hidden = NO;
        [imageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"img"]] placeholderImage:KImageName(@"兑奖icon默认")];
    }
    
    self.timeLabel.text = [Tools timestampSwitchTime:model.time];
    
    
    self.nameLabel.text = model.name;
    //self.typeLabel.text = @"九层妖塔";
    
    NSString *str2 = model.cardName;
    NSString *order2 = @" × 1";
    NSString *allStr2 = [NSString stringWithFormat:@"%@%@",str2,order2];
    
    NSMutableAttributedString *attStr2 = [[NSMutableAttributedString alloc] initWithString:allStr2 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    [attStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:1.00] range:NSMakeRange(0, str2.length)];
    [attStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.53 green:0.53 blue:0.53 alpha:1.00] range:NSMakeRange(str2.length, order2.length)];
    
    self.cardLabel.attributedText = attStr2;
    
   
    if(self.goodsImageView2.hidden && self.goodsImageView3.hidden)
    {
        self.nameLabel.hidden = NO;
        self.typeLabel.hidden = NO;
        self.nameLabel.frame = KFrame(self.goodsImageView.maxX+10, self.goodsImageView.y, KDeviceW - KImageViewWidth*2 -20 - 30, self.goodsImageView.height/2);
        self.typeLabel.frame = KFrame(self.nameLabel.x, self.nameLabel.maxY+10, self.nameLabel.width, self.goodsImageView.height/2-10);
    }
    else if (!self.goodsImageView2.hidden && self.goodsImageView3.hidden)
    {
        self.nameLabel.hidden = NO;
        self.typeLabel.hidden = NO;
        self.nameLabel.frame = KFrame(self.goodsImageView2.maxX+10, self.goodsImageView.y,  KImageViewWidth, self.goodsImageView.height/2);
        self.typeLabel.frame = KFrame(self.nameLabel.x, self.nameLabel.maxY+10, self.nameLabel.width, self.goodsImageView.height/2-10);
    }
    else
    {
        self.nameLabel.hidden = YES;
        self.typeLabel.hidden = YES;
    }
    
    //0：待审核 1：审核通过，待发货 2：审核不通过  3：已发货 4：已完成
    int status = [model.status intValue];
    
    if(status == 0)
    {
        self.adressBtn.hidden = NO;
        self.logisticsBtn.hidden = YES;
        self.tipLabel.text = @"待审核";
        self.tipLabel.hidden = NO;
        self.tipLabel.frame = KFrame(KDeviceW - self.adressBtn.width - 50 - 25, self.numLabel.y, 50, 50);
        self.tipLabel.textColor = [UIColor colorWithRed:0.53 green:0.53 blue:0.53 alpha:1.00];
    }
    else if (status == 1)
    {
        self.adressBtn.hidden = YES;
        self.logisticsBtn.hidden = YES;
        self.tipLabel.hidden = NO;
        self.tipLabel.text = @"审核通过 待发货";
        self.tipLabel.frame = KFrame(KDeviceW - 120 - 15, self.numLabel.y, 120, 50);
        self.tipLabel.textColor = [UIColor colorWithRed:0.07 green:0.51 blue:1.00 alpha:1.00];
    }
    else if (status == 2)
    {
        self.adressBtn.hidden = YES;
        self.logisticsBtn.hidden = YES;
        self.tipLabel.hidden = NO;
        self.tipLabel.text = @"审核未通过";
        self.tipLabel.frame = KFrame(KDeviceW - 120 - 15, self.numLabel.y, 120, 50);
        self.tipLabel.textColor = [UIColor colorWithRed:0.07 green:0.51 blue:1.00 alpha:1.00];
    }
    else if (status == 3)
    {
        self.adressBtn.hidden = YES;
        self.logisticsBtn.hidden = NO;
        self.tipLabel.hidden = YES;
    }
    else
    {
        self.adressBtn.hidden = YES;
        self.logisticsBtn.hidden = NO;
        self.tipLabel.hidden = YES;
    }
    
    
    
    self.numLabel.text = [NSString stringWithFormat:@"共%@件奖品",model.num];
    

}


-(void)changeAdress
{
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(changeAddress:)])
    {
        [self.delegate changeAddress:self.model];
    }
}

-(void)checkLogistics
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(checkLogistics:)])
    {
        [self.delegate checkLogistics:self.model];
    }
}

-(UIView *)addLineViewWithFrame:(CGRect)frame withBackView:(UIView *)backView
{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
    [backView addSubview:view];
    return view;
}



@end
