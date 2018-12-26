//
//  ConfirmExchangeControlle.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/14.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "ConfirmExchangeControlle.h"
#import "EditAddressController.h"
#import "AddressModel.h"
#import "ChooseGiftModel.h"
#import "RecordController.h"
#import "MyCardModel.h"

@interface ConfirmExchangeControlle ()

@property (nonatomic ,strong) UIView *backView1;

@property (nonatomic ,strong) UIView *backView2;

@property (nonatomic ,strong) UILabel *nameLab;

@property (nonatomic ,strong) UILabel *phoneLab;

@property (nonatomic ,strong) UILabel *addrLab;

@property (nonatomic ,strong) UIImageView *iconView;

@property (nonatomic ,strong) UILabel *modelLab;

@property (nonatomic ,strong) UILabel *numLab;

@end

@implementation ConfirmExchangeControlle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarTitle:@"确认兑奖"];
    [self setBackBtn];
    
    [self initView];
    [self observeChangeAddressNoti];//监听地址更改
}


- (void)initView{

    self.backView1 = ({
        UIView *view = [UIView new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view).offset(10);
            make.left.right.mas_equalTo(self.view);
        }];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    
    
    //添加点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [_backView1 addGestureRecognizer:tap];
    
    
    self.nameLab = ({
        UILabel *view = [UILabel new];
        [_backView1 addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_backView1).offset(30);
            make.top.mas_equalTo(_backView1).offset(15);
        }];
        view.text =_addrModel.name;
        view;
    });
    
    self.phoneLab = ({
        UILabel *view = [UILabel new];
        [_backView1 addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nameLab.mas_right).offset(15);
            make.top.mas_equalTo(_nameLab.mas_top);
        }];
        view.text = _addrModel.phone;
        view;
    });
    
    self.addrLab = ({
        UILabel *view = [UILabel new];
        [_backView1 addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nameLab.mas_left);
            make.top.mas_equalTo(_nameLab.mas_bottom).offset(15);
            make.right.mas_equalTo(-60);
        }];
        view.font = KFont(12);
        view.textColor = RGBHex(@"#3a3a3a");
        view.text = [NSString stringWithFormat:@"%@ %@",_addrModel.addr,_addrModel.addrDetail];
        view.numberOfLines = 0;
        view;
    });
    
    //定位
    UIImageView *locateIcon = [UIImageView new];
    [_backView1 addSubview:locateIcon];
    [locateIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_addrLab.mas_left).offset(-5);
        make.top.mas_equalTo(_addrLab);
    }];
    [locateIcon setImage:KImageName(@"定位icon")];
    
    
    UIImageView *nextIcon = [UIImageView new];
    [_backView1 addSubview:nextIcon];
    [nextIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_backView1);
        make.right.mas_equalTo(-15);
    }];
    [nextIcon setImage:KImageName(@"右箭头")];
    
    
    UIImageView *lineIcon = [UIImageView new];
    [_backView1 addSubview:lineIcon];
    [lineIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_backView1);
        make.top.mas_equalTo(_addrLab.mas_bottom).offset(15);
        make.bottom.mas_equalTo(_backView1.mas_bottom);
    }];
    [lineIcon setImage:KImageName(@"彩线")];
    
//=========================================
    
    self.backView2 = ({
        UIView *view = [UIView new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.view);
            make.top.mas_equalTo(_backView1.mas_bottom).offset(10);
            make.height.mas_equalTo(100);
        }];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    
    self.iconView = ({
        UIImageView *view = [UIImageView new];
        [_backView2 addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(_backView2);
            make.height.width.mas_equalTo(55);
        }];
        [view sd_setImageWithURL:[NSURL URLWithString:_giftModel.img] placeholderImage:nil];
        view;
    });
    
    
    self.numLab = ({
        UILabel *view = [UILabel new];
        [_backView2 addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_backView2);
            make.right.mas_equalTo(-15);
        }];
        view.font = KFont(12);
        view.text = @"X1";
        view.textColor = RGBHex(@"#7d7d7d");
        view;
    });
    
    //奖品名字
    self.modelLab = ({
        UILabel *view = [UILabel new];
        [_backView2 addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconView.mas_right).offset(25);
            make.top.mas_equalTo(_iconView);
            make.right.lessThanOrEqualTo(_numLab.mas_left).offset(-25);
        }];
        view.font = KFont(15);
        view.textColor = RGBHex(@"#3a3a3a");
        view.numberOfLines = 2;
        view.text = [NSString stringWithFormat:@"%@",_giftModel.name];
        view;
    });
    
    
    
    UIButton *confirmBtn = [UIButton new];
    [self.view addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-35);
    }];
    confirmBtn.titleLabel.font = KFont(16);
    [confirmBtn setBackgroundImage:KImageName(@"兑奖按钮") forState:UIControlStateNormal];
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark 按钮确认兑奖
- (void)confirmAction{

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:KUSER.userId forKey:@"userId"];
    [param setObject:_giftModel.pid forKey:@"pid"];
    [param setObject:_cardModel.cardNo forKey:@"no"];
    [param setObject:_cardModel.cardPwd forKey:@"password"];
    [param setObject:_addrModel.name forKey:@"name"];
    [param setObject:_addrModel.phone forKey:@"phone"];
    [param setObject:_addrModel.addrDetail forKey:@"addrDetail"];
    [param setObject:_addrModel.addr forKey:@"addr"];
    
    KWeakSelf
    [MBProgressHUD showMessag:@"" toView:nil];
    [RequestManager postWithURLString:KGiftExchange parameters:param  success:^(id responseObject) {
        
        if ([responseObject[@"code"] intValue] == 1) {
            RecordController *vc = [RecordController new];
            vc.fromConfrimVC = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
            [MBProgressHUD showSuccess:@"兑奖成功！" toView:nil];
        }else{
            
            [MBProgressHUD showError:responseObject[@"msg"] toView:nil];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"您的网络不稳定" toView:nil];
    }];
}

//修改地址
- (void)tapAction{
    EditAddressController *vc = [EditAddressController new];
    vc.type = ControllerTypeChange;
    vc.addrModel = _addrModel;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 通知
- (void)observeChangeAddressNoti{
    [KNotificationCenter addObserver:self selector:@selector(reloadAddress:) name:KChangeAddressNoti object:nil];
}
//更新地址
- (void)reloadAddress:(NSNotification *)noti{

    AddressModel *model = noti.userInfo[@"address"];

    _nameLab.text       = model.name;
    _phoneLab.text      = model.phone;
    _addrLab.text = [NSString stringWithFormat:@"%@ %@",model.addr,model.addrDetail];
}
#pragma mark lazy load



@end
