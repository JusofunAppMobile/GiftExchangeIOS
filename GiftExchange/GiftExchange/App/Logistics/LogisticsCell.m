//
//  LogisticsCell.m
//  GiftExchange
//
//  Created by WangZhipeng on 17/8/14.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "LogisticsCell.h"
#import "AddressModel.h"
#import "NSDate+Tool.h"

#define TiTle_W 72.f

@interface LogisticsCell ()

@property (nonatomic ,strong) UILabel *numLab;

@end

@implementation LogisticsCell




-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *orderBg = [UIView new];
        [self.contentView addSubview:orderBg];
        [orderBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(self.contentView);
            make.height.mas_equalTo(53);
        }];
        orderBg.backgroundColor = [UIColor whiteColor];
        
        self.timeLabel = ({
            UILabel *view = [UILabel new];
            [orderBg addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(orderBg).offset(-15);
                make.centerY.mas_equalTo(orderBg);
                make.width.mas_equalTo(135);
            }];
            view.font = KFont(14);
            view.textColor = RGBHex(@"#7d7d7d");
            view.textAlignment = NSTextAlignmentRight;
            view;
        });

        
        UILabel *orderTitle = [UILabel new];
        [orderBg addSubview:orderTitle];
        [orderTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(orderBg);
            make.left.mas_equalTo(orderBg.mas_left).offset(15);
            make.width.mas_equalTo(TiTle_W);
        }];
        orderTitle.text = @"订单号：";
        orderTitle.font = KFont(14);
        
        self.orderLabel = ({
            UILabel *label = [UILabel new];
            [orderBg addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(orderTitle.mas_right);
                make.centerY.mas_equalTo(orderBg);
            }];
            label.font = KFont(14);
            label.textColor = RGBHex(@"#7d7d7d");
            label;
        });
        
      
        [self addLineToView:orderBg];
        
        //------------------------------------------
        
        UIView *infoBg = [UIView new];
        [self.contentView addSubview:infoBg];
        [infoBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(orderBg.mas_bottom);
            make.left.right.mas_equalTo(self.contentView);
        }];
        infoBg.backgroundColor = [UIColor whiteColor];
        
        
        UILabel *nameTitle = [UILabel new];
        [infoBg addSubview:nameTitle];
        [nameTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(infoBg).offset(15);
            make.top.mas_equalTo(infoBg).offset(15);
            make.width.mas_equalTo(TiTle_W);
        }];
        nameTitle.text = @"收件人：";
        nameTitle.font = KFont(14);
        
        
        self.nameLabel = ({
            UILabel *view = [UILabel new];
            [infoBg addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(nameTitle);
                make.left.mas_equalTo(nameTitle.mas_right);
            }];
            view.font = KFont(14);
            view.textColor = RGBHex(@"#7d7d7d");
            view;
        });
        
        
        UILabel *phoneTitle = [UILabel new];
        [infoBg addSubview:phoneTitle];
        [phoneTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(infoBg).offset(15);
            make.top.mas_equalTo(nameTitle.mas_bottom).offset(10);
            make.width.mas_equalTo(TiTle_W);
        }];
        phoneTitle.text = @"收件电话：";
        phoneTitle.font = KFont(14);
        
        
        self.phoneLabel = ({
            UILabel *view = [UILabel new];
            [infoBg addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(phoneTitle);
                make.left.mas_equalTo(phoneTitle.mas_right);
            }];
            view.font = KFont(14);
            view.textColor = RGBHex(@"#7d7d7d");
            view;
        });

        UILabel *addrTitle = [UILabel new];
        [infoBg addSubview:addrTitle];
        [addrTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(infoBg).offset(15);
            make.top.mas_equalTo(phoneTitle.mas_bottom).offset(10);
            make.width.mas_equalTo(TiTle_W);
        }];
        addrTitle.text = @"收件地址：";
        addrTitle.font = KFont(14);
        
        
        self.adressLabel = ({
            UILabel *view = [UILabel new];
            [infoBg addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(addrTitle);
                make.left.mas_equalTo(addrTitle.mas_right);
                make.bottom.mas_equalTo(infoBg).offset(-15);
                make.right.mas_equalTo(infoBg).offset(-15);
            }];
            view.font = KFont(14);
            view.textColor = RGBHex(@"#7d7d7d");
            view.numberOfLines = 0;
            view;
        });
        
        [self addLineToView:infoBg];
        
     //---------------------------------------------
        self.imageBgView = ({
           UIView *view = [UIView new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(infoBg.mas_bottom);
                make.left.right.mas_equalTo(self.contentView);
                make.height.mas_equalTo(100);
            }];
            view.backgroundColor = [UIColor whiteColor];
            view;
        });
        
        
        self.numLab = ({
            UILabel *view = [UILabel new];
            [_imageBgView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(_imageBgView);
                make.right.mas_equalTo(_imageBgView).offset(-15);
                make.width.mas_equalTo(40);
            }];
            view.font = KFont(14);
            view.textColor = RGBHex(@"#7d7d7d");
            view.textAlignment = NSTextAlignmentRight;
            view;
        });
        
        [self addLineToView:_imageBgView];
        
        
        //---------------------------
        UIView *btnBg = [UIView new];
        [self.contentView addSubview:btnBg];
        [btnBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_imageBgView.mas_bottom);
            make.left.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(53);
            make.bottom.mas_equalTo(self.contentView);
        }];
        btnBg.backgroundColor = [UIColor whiteColor];
        
        self.numLabel = ({
            UILabel *view = [UILabel new];
            [btnBg addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(btnBg).offset(15);
                make.centerY.mas_equalTo(btnBg);
            }];
            view.font = KFont(14);
            view.textColor = RGBHex(@"#7d7d7d");
            view;
        });
        
        
        self.checkBtn = ({
            UIButton *view = [UIButton new];
            [btnBg addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(btnBg);
                make.width.mas_equalTo(80);
                make.height.mas_equalTo(25);
                make.right.mas_equalTo(btnBg).offset(-15);
            }];
            view.titleLabel.font = KFont(14);
            [view setTitle:@"扫描录入" forState:UIControlStateNormal];
            [view setTitleColor:[UIColor colorWithRed:1.00 green:0.37 blue:0.04 alpha:1.00] forState:UIControlStateNormal];
            [view jm_setCornerRadius:25/2.0 withBorderColor:[UIColor colorWithRed:1.00 green:0.37 blue:0.04 alpha:1.00] borderWidth:1 backgroundColor:[UIColor whiteColor] backgroundImage:nil contentMode:UIViewContentModeScaleToFill];
            [view addTarget:self action:@selector(changeAdress) forControlEvents:UIControlEventTouchUpInside];
            view;
        });
        
        
        self.logisticsBtn = ({
            UIButton *view = [UIButton new];
            [btnBg addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(btnBg);
                make.width.mas_equalTo(80);
                make.height.mas_equalTo(25);
                make.right.mas_equalTo(_checkBtn.mas_left).offset(-15);
            }];
            view.titleLabel.font = KFont(14);
            [view setTitle:@"更改记录" forState:UIControlStateNormal];
            [view setTitleColor:[UIColor colorWithRed:0.07 green:0.49 blue:0.96 alpha:1.00] forState:UIControlStateNormal];
            [view jm_setCornerRadius:25/2.0 withBorderColor:[UIColor colorWithRed:0.07 green:0.49 blue:0.96 alpha:1.00] borderWidth:1 backgroundColor:[UIColor whiteColor] backgroundImage:nil contentMode:UIViewContentModeScaleToFill];
            [view addTarget:self action:@selector(checkLogistics) forControlEvents:UIControlEventTouchUpInside];
            view;
        });
        
        self.tipLabel = ({
            UILabel *view = [UILabel new];
            [btnBg addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(_logisticsBtn.mas_left).offset(-10);
                make.centerY.mas_equalTo(btnBg);
            }];
            view.font =  KFont(14);
            view.text = @"快递信息：";
            view.textColor = RGBHex(@"#7d7d7d");
            view;
        });
                
    }
    
    return self;
}



-(void)setModel:(GiftExchangeModel *)model
{
    _model = model;
    
    self.orderLabel.text = model.no;
    
    AddressModel *addrModel = model.addrInfo;
    
    self.nameLabel.text = addrModel.name;
    self.phoneLabel.text = addrModel.phone;
    self.adressLabel.text = [NSString stringWithFormat:@"%@%@",addrModel.addr,addrModel.addrDetail];
    
    self.timeLabel.text = [NSDate stringFromTimeStamp:[model.time doubleValue] withFormat:@"yyyy-MM-dd HH:mm"];
    
//    NSArray *imageArray = model.imgs;
    
    for(UIView *view in [self.imageBgView subviews])
    {
        if(![view isEqual:_numLab] ){
            [view removeFromSuperview];
        }
    }
    
    if ([model.num intValue]>1) {
        [self addMultiIconView:model];
    }else{
        [self addSingleIconView:model];
    }
    
    self.numLabel.text = [NSString stringWithFormat:@"共%@件奖品",model.num];
    _numLab.text = [NSString stringWithFormat:@"X%@",model.num];

}

//0：待处理  1:已发货
-(void)setCellType:(int)cellType
{
    _cellType = cellType;
    
    
    if(cellType == 0)
    {
        self.tipLabel.hidden = NO;
        
        [self.logisticsBtn setTitle:@"手动录入" forState:UIControlStateNormal];
        [self.checkBtn setTitle:@"扫描录入" forState:UIControlStateNormal];
        
    }
    else if (cellType == 1)
    {
        self.tipLabel.hidden = YES;
        
        [self.logisticsBtn setTitle:@"更改物流" forState:UIControlStateNormal];
        [self.checkBtn setTitle:@"物流记录" forState:UIControlStateNormal];
    
    }
    
}

-(void)changeAdress
{
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(check:)])
    {
        [self.delegate check:self.model];
    }
}

-(void)checkLogistics
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(checkLogistics:)])
    {
        [self.delegate checkLogistics:self.model];
    }
}

- (void)addLineToView:(UIView *)view{
    UIView *line = [UIView new];
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(view);
        make.height.mas_equalTo(1);
    }];
    line.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
}

-(UIView *)addLineViewWithFrame:(CGRect)frame withBackView:(UIView *)backView
{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
    [backView addSubview:view];
    return view;
}
#pragma mark singleCell

- (void)addSingleIconView:(GiftExchangeModel *)model{

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 20, 55, 55)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.imgs[0][@"img"]]];
    [self.imageBgView addSubview:imageView];
    
    UILabel *nameLab = [UILabel new];
    [self.imageBgView addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(10);
        make.top.mas_equalTo(imageView).offset(5);
        make.right.mas_equalTo(_numLab.mas_left).offset(-15);
    }];
    nameLab.text = model.name;
    nameLab.numberOfLines = 2;
    nameLab.font = KFont(16);
    nameLab.textColor = [UIColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:1.00];
    
}

- (void)addMultiIconView:(GiftExchangeModel *)model{

    int num = [model.num intValue]>3?3:[model.num intValue];

    for (int i = 0; i<num; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15+10*i+60*i, 20, 55, 55)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.imgs[i][@"img"]]];
        [self.imageBgView addSubview:imageView];
    }
}



@end
