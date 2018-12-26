//
//  SendCardRecordCell.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/29.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "SendCardRecordCell.h"
#import "SendCardRecordModel.h"
#import "NSDate+Tool.h"

@interface SendCardRecordCell ()

@property (nonatomic ,strong) UILabel *titleLab;

@property (nonatomic ,strong) UILabel *nameLab;

@property (nonatomic ,strong) UILabel *numLab;

@property (nonatomic ,strong) UILabel *timeLab;

@end

@implementation SendCardRecordCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.titleLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.top.mas_equalTo(17);
            }];
            view.font = KFont(15);
            view;
        });
        
        self.nameLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.bottom.mas_equalTo(-17);
                make.width.mas_equalTo(60);
            }];
            view.font = KFont(13);
            view;
        });
        
        self.numLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_nameLab.mas_right).offset(10);
                make.centerY.mas_equalTo(_nameLab);
            }];
            view.font = KFont(13);
            view.textColor = RGBHex(@"#5b5b5b");
            view;
        });
        
        
        self.timeLab = ({
            UILabel *view = [UILabel new];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-15);
                make.top.mas_equalTo(_nameLab);
            }];
            view.textColor = RGBHex(@"#828282");
            view.font = KFont(12);
            view;
        });
    }
    return self;
}


- (void)loadCell:(SendCardRecordModel *)model{

    _titleLab.text = model.name;
    _nameLab.text = model.cardName;
    _numLab.text = [NSString stringWithFormat:@"%@张",model.num];
    
    _timeLab.text = [NSDate stringFromTimeStamp:[model.time doubleValue] withFormat:@"yyyy-MM-dd HH:mm"];
    
}

@end
