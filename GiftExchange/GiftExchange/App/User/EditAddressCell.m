//
//  EditAddressCell.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/11.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "EditAddressCell.h"
#import "AddressModel.h"

@interface EditAddressCell ()<UITextFieldDelegate>

@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UITextField *contentLab;
@property (nonatomic ,strong) UIButton *iconView;
@property (nonatomic ,assign) NSInteger index;

@end

@implementation EditAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initViews];
    }
    return self;
}

- (void)initViews{

    self.nameLab = ({
        UILabel *view = [UILabel new];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(80);
            make.top.bottom.mas_equalTo(self.contentView);
            make.height.mas_equalTo(60);
        }];
        view.font = KFont(15);
        view;
    });
    
    
    self.iconView = ({
        UIButton *view = [UIButton new];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nameLab.mas_right);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(self.contentView);
            make.width.mas_equalTo(30);
        }];
        [view setImage:KImageName(@"定位icon") forState:UIControlStateNormal];
        [view addTarget:self action:@selector(locateAction) forControlEvents:UIControlEventTouchUpInside];
        view;
    });
 
    self.contentLab = ({
        UITextField *view = [UITextField new];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconView.mas_right);
            make.height.mas_equalTo(self.contentView.mas_height);
            make.right.mas_equalTo(self.contentView).offset(-15);
            
        }];
        view.delegate = self;
        view.font = KFont(15);
        view;
    });
    
  
}

- (void)locateAction{
    if ([_delegate respondsToSelector:@selector(didTapLocateButton)]) {
        [_delegate didTapLocateButton];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([_delegate respondsToSelector:@selector(cellDidEndEditingWithText:index:)]) {
        [_delegate cellDidEndEditingWithText:_contentLab.text index:_index];
    }
}

- (void)loadCell:(AddressModel *)model index:(NSInteger)index{
    
    _index = index;
    
    switch (index) {
        case 0:
            _nameLab.text = @"收货人：";
            _iconView.hidden = YES;
            _contentLab.enabled = YES;
            _contentLab.placeholder = @"请输入姓名";
            _contentLab.text = model.name;
            self.accessoryType = UITableViewCellAccessoryNone;
            break;
        case 1:
            
            _nameLab.text = @"手机号码：";
            _iconView.hidden = YES;
            _contentLab.enabled = YES;
            _contentLab.placeholder = @"请输入手机号码";
            _contentLab.text = model.phone;
            self.accessoryType = UITableViewCellAccessoryNone;
            
            break;
        case 2:
            _nameLab.text = @"所在地区：";
            _iconView.hidden = NO;
            _contentLab.enabled = NO;
            _contentLab.placeholder = @"请选择地区";
            _contentLab.text = model.addr;
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 3:
            
            _nameLab.text = @"详细地址：";
            _iconView.hidden = YES;
            _contentLab.enabled = YES;
            _contentLab.placeholder = @"请输入详细地址";
            _contentLab.text = model.addrDetail;
            self.accessoryType = UITableViewCellAccessoryNone;
            break;
        default:
            
            break;
    }
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
