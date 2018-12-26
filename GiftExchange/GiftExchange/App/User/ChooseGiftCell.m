//
//  ChooseGiftCell.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/11.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "ChooseGiftCell.h"
#import "ChooseGiftModel.h"

@interface ChooseGiftCell ()

@property (nonatomic ,strong) UIImageView *iconView;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *modelLab;
@property (nonatomic ,strong) UIImageView *checkView;

@end

@implementation ChooseGiftCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initViews];
    }
    return self;
}

- (void)initViews{
    
//    self.iconView = ({
//        UIImageView *view = [UIImageView new];
//        [self.contentView addSubview:view];
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            //            make.left.bottom.top.mas_equalTo(self.contentView);
//            //            make.height.width.mas_equalTo(110);
//            
//            make.width.height.mas_equalTo(60);
//            make.centerY.mas_equalTo(self.contentView);
//            make.left.mas_equalTo(25);
//        }];
//        view;
//    });
//    
//    self.nameLab = ({
//        UILabel *view = [UILabel new];
//        [self.contentView addSubview:view];
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(_iconView.mas_right).offset(25);
//            make.top.mas_equalTo(self.contentView).offset(30);
//            make.right.mas_equalTo(self.contentView).offset(-15);
//        }];
//        view.font = KFont(15);
//        view.numberOfLines = 3;
//        view;
//    });
    
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
    
    self.checkView = ({
        UIImageView *view = [UIImageView new];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.width.height.mas_equalTo(25);
        }];
        view.hidden = YES;
        view.image = KImageName(@"选中");
        view;
    });

    
    self.nameLab = ({
        UILabel *view = [UILabel new];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(_iconView.mas_right).offset(10);
//            make.top.mas_equalTo(self.contentView).offset(30);
//            make.right.mas_equalTo(_checkView.mas_left).offset(-10);
            
            make.left.mas_equalTo(_iconView.mas_right).offset(25);
            make.top.mas_equalTo(self.contentView).offset(30);
            make.right.mas_equalTo(_checkView.mas_left).offset(-15);

        }];
        view.font = KFont(15);
        view.numberOfLines = 2;
        view;
    });

}

- (void)loadCellWithModel:(ChooseGiftModel *)model{
    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    _nameLab.text = model.name;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    _checkView.hidden = !selected;
    self.backgroundColor =selected?RGBHex(@"#f2f2f2"):[UIColor whiteColor];
}

@end
