//
//  MyCardCell.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/30.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "MyCardCell.h"
#import "MyCardModel.h"

@interface MyCardCell ()

@property (nonatomic ,strong) UILabel *nameLab;

@property (nonatomic ,strong) UILabel *numberLab;

@property (nonatomic ,strong) UIImageView *iconView;

@end

@implementation MyCardCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        self.nameLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView).offset(15);
                make.top.mas_equalTo(self.contentView).offset(20);
            }];
            view.font = KFont(15);
            view;
        });
        
        
        self.numberLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_nameLab.mas_bottom).offset(15);
                make.left.mas_equalTo(15);
            }];
            view.textColor = RGBHex(@"#727272");
            view.font = KFont(14);
            view;
        });
        
        _iconView = [UIImageView new];
        [self.contentView addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(-15);
        }];
        _iconView.hidden = YES;
        
    
    }
    return self;
}

- (void)loadCell:(MyCardModel *)model{

    _nameLab.text    = model.cardName;
    _numberLab.text  = model.cardNo;

    if ([model.status intValue] == 0) {
        _iconView.image = nil;
    }else if([model.status intValue] ==2){
        _iconView.image = KImageName(@"已过期");
    }else{
        _iconView.image = KImageName(@"已兑换");
    }

    _iconView.hidden = ![model.status boolValue];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
