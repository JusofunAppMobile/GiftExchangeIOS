//
//  CardManageCell.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/28.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "CardManageCell.h"
#import "CardManageModel.h"

@interface CardManageCell ()

@property (nonatomic ,strong) UILabel *titleLab;

@property (nonatomic ,strong) UILabel *totalLab;

@property (nonatomic ,strong) UILabel *leftLab;

@property (nonatomic ,assign) NSInteger index;
@end

@implementation CardManageCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.titleLab = ({
        UILabel *view = [UILabel new];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(10);
        }];
        view.textColor = RGBHex(@"#ff5803");
        view.font = KFont(15);
        view.text = @"福瑞卡";
        view;
    });
    
    //-----------------------
    UILabel *totalTitle = [UILabel new];
    [self.contentView addSubview:totalTitle];
    [totalTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(_titleLab.mas_bottom).offset(15);
    }];
    totalTitle.text = @"全部卡券：";
    totalTitle.font = KFont(14);
   
    
    self.totalLab= ({
        UILabel *view = [UILabel new];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(totalTitle.mas_right);
            make.centerY.mas_equalTo(totalTitle);
        }];
        view.font = KFont(12);
        view.textColor = RGBHex(@"#7d7d7d");
        view.text = @"100";
        view;
    });
    
    //---------------------------
    UILabel *leftTitle = [UILabel new];
    [self.contentView addSubview:leftTitle];
    [leftTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(_totalLab.mas_bottom).offset(10);
    }];
    leftTitle.text = @"剩余卡券：";
    leftTitle.font = KFont(14);
    
    self.leftLab = ({
        UILabel *view = [UILabel new];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftTitle.mas_right);
            make.centerY.mas_equalTo(leftTitle);
        }];
        view.font = KFont(12);
        view.textColor = RGBHex(@"#7d7d7d");
        view.text = @"59";
        view;
    });
    
    
    UIButton *sendBtn = [UIButton new];
    [self.contentView addSubview:sendBtn];
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(25);
        make.centerY.mas_equalTo(self.contentView);
    }];
    sendBtn.layer.borderWidth = 1.f;
    sendBtn.layer.borderColor = RGBHex(@"#ff8923").CGColor;
    sendBtn.layer.cornerRadius = 12.5;
    sendBtn.layer.masksToBounds = YES;
    sendBtn.titleLabel.font = KFont(14);
    [sendBtn setTitle:@"发卡" forState:UIControlStateNormal];
    [sendBtn setTitleColor:RGBHex(@"#ff8923") forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendCardAction) forControlEvents:UIControlEventTouchUpInside];

    
}

- (void)setModel:(CardManageModel *)model{
    _model = model;
    _titleLab.text = model.cardName;
    _totalLab.text = model.totalNum;
    _leftLab.text  = model.remainNum;
}

- (void)sendCardAction{
    
    if ([_delegate respondsToSelector:@selector(didTapSendCardButton:)]) {
        
        [_delegate didTapSendCardButton:_model];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
