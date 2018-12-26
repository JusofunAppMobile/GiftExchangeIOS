//
//  UserPlainCell.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/14.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "UserPlainCell.h"

@interface UserPlainCell ()



@property (nonatomic ,strong) UIImageView *iconView;

@property (nonatomic ,strong) UILabel *titleLab;
@end

@implementation UserPlainCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.iconView = ({
            UIImageView *view = [UIImageView new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.centerY.mas_equalTo(self.contentView);
            }];
            view;
        });
        
        
        self.titleLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_iconView.mas_right).offset(15);
                make.centerY.mas_equalTo(self.contentView);
            }];
            view.text = @"兑换记录";
            view;
        });
        
    }
    return self;
}

- (void)loadCellWithTitle:(NSString *)title{

    _titleLab.text = title;
    
    if ([title hasPrefix:@"联系客服"]) {
        _iconView.image = KImageName(@"电话");
    }else{
        _iconView.image = KImageName(title);
    }
    
}


@end
