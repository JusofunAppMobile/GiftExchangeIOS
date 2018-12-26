//
//  SendCardCell.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/29.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "SendCardCell.h"
#import "CardManageModel.h"

@interface SendCardCell ()

@property (nonatomic ,strong) UILabel *nameLab;

@end

@implementation SendCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

- (void)initView{

    self.nameLab = ({
        UILabel *view = [UILabel new];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
        view.font = KFont(15);
        view.text = @"福瑞卡";
        view;
    });
    
    
    UIButton *sendBtn = [UIButton new];
    [self.contentView addSubview:sendBtn];
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(25);
    }];
    sendBtn.layer.borderWidth = 1.f;
    sendBtn.layer.borderColor = RGBHex(@"#ff8923").CGColor;
    sendBtn.layer.cornerRadius = 12.5;
    sendBtn.layer.masksToBounds = YES;
    sendBtn.titleLabel.font = KFont(14);
    [sendBtn setTitle:@"发卡" forState:UIControlStateNormal];
    [sendBtn setTitleColor:RGBHex(@"#ff8923") forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
}


- (void)setModel:(CardManageModel *)model{
    _model = model;
    _nameLab.text = model.cardName;
}

- (void)sendAction{
    if ([_delegate respondsToSelector:@selector(adminDidTapSendCardBtn:)]) {
        [_delegate adminDidTapSendCardBtn:_model];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
