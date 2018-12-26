//
//  HomeCell.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/8.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "HomeCell.h"
#import "HomeCellModel.h"

@interface HomeCell ()
@property (nonatomic ,strong) UIImageView *iconView;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *modelLab;

@end

@implementation HomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initViews];
    }
    return self;
}


- (void)initViews{
    
    self.iconView = ({
        UIImageView *view = [UIImageView new];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.bottom.top.mas_equalTo(self.contentView);
//            make.height.width.mas_equalTo(110);
            
            make.width.height.mas_equalTo(60);
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(25);
        }];
        view;
    });
    
    self.nameLab = ({
        UILabel *view = [UILabel new];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconView.mas_right).offset(25);
            make.top.mas_equalTo(self.contentView).offset(30);
            make.right.mas_equalTo(self.contentView).offset(-15);
        }];
        view.font = KFont(15);
        view.numberOfLines = 3;
        view;
    });
    
//    self.modelLab = ({
//        UILabel *view = [UILabel new];
//        [self.contentView addSubview:view];
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(_nameLab);
//            make.top.mas_equalTo(_nameLab.mas_bottom).offset(15);
//        }];
//        view.textColor = RGBHex(@"#7d7d7d");
//        view.text = @"STH034";
//        view.font = KBlodFont(13);
//        view;
//    });

}

- (void)loadCellWithModel:(HomeCellModel *)model{
    _nameLab.text = model.name;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
