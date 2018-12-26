//
//  UserHeadCell.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/14.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "UserHeadCell.h"

@interface UserHeadCell ()

@property (nonatomic ,strong) UIImageView *iconView;

@property (nonatomic ,strong) UILabel *phoneLab;
@end

@implementation UserHeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.iconView = ({
            UIImageView *view = [UIImageView new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.centerY.mas_equalTo(self.contentView);
                make.width.height.mas_equalTo(60);
            }];
            view.layer.cornerRadius = 60/2;
            view.layer.borderWidth = .5;
            view.layer.borderColor = [UIColor lightGrayColor].CGColor;
            view.image = KImageName(@"头像");
            view.layer.masksToBounds = YES;
            view;
        });
        
        
        self.phoneLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_iconView.mas_right).offset(15);
                make.centerY.mas_equalTo(self.contentView);
            }];
            view;
        });
        
    }
    return self;
}

- (void)loadCell{
    _phoneLab.text = KUSER.phone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
