//
//  EditAddressController.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/11.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "EditAddressController.h"
#import "EditAddressCell.h"
#import "CityPickerView.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import "ConfirmExchangeControlle.h"
#import "ChooseGiftModel.h"
#import "NSString+Verify.h"


static NSString *cellID = @"EditAddressCell";

@interface EditAddressController ()<UITableViewDelegate,UITableViewDataSource,LocateDelegate,CityPickerDelegate>

@property (nonatomic ,strong) UITableView *tableview;

@property (nonatomic ,strong) UIButton    *commitBtn;

@property (nonatomic ,strong) CityPickerView *cityPicker;

@property (nonatomic ,strong) AMapLocationManager *locationManager;

@end

@implementation EditAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackBtn];
    [self setNavigationBarTitle:@"收货地址"];
    [self initAddressModel];
    [self initViews];
}

- (void)initViews{
    self.tableview = ({
        UITableView *view = [UITableView new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.right.bottom.mas_equalTo(self.view);
        }];
        view.delegate = self;
        view.dataSource = self;
        view.estimatedRowHeight = 60;
        view.rowHeight = UITableViewAutomaticDimension;
        view.tableFooterView = [UIView new];
        [view registerClass:[EditAddressCell class] forCellReuseIdentifier:cellID];
        view;
    });
    
    self.commitBtn = ({
        UIButton *view = [UIButton new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view).offset(-35);
        }];
        [view setTitle:@"提交" forState:UIControlStateNormal];
        [view setBackgroundImage:KImageName(@"兑奖按钮") forState:UIControlStateNormal];
        view.titleLabel.font = KFont(16);
        [view addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
        view;
    });
    
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EditAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.delegate = self;
    [cell loadCell:_addrModel index:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
    if (indexPath.row == 2) {
        [self.cityPicker show];
    }
}

#pragma mark 提交按钮
- (void)commitAction{
    [self.view endEditing:YES];
    
    if (![_addrModel.name length]||![_addrModel.phone length]||![_addrModel.addr length]||![_addrModel.addrDetail length]) {
        [MBProgressHUD showError:@"请将信息补充完整！" toView:nil];
        return;
    }
    if (![_addrModel.phone validateMobile]) {
        [MBProgressHUD showError:@"请输入正确的手机号码！" toView:nil];
        return;
    }
    if (_type == ControllerTypeEdit) {
        
        ConfirmExchangeControlle *vc = [ConfirmExchangeControlle new];
        vc.addrModel                 = _addrModel;
        vc.giftModel                 = _giftModel;
        vc.cardModel                 = _cardModel;
        [self.navigationController pushViewController:vc animated:YES];
        
        NSMutableArray *vcs = [self.navigationController.viewControllers mutableCopy];
        [vcs removeObject:self];
        self.navigationController.viewControllers = vcs;
        
        [self saveAddressModel];

    }else{
        if (_type == ControllerTypeChange) {
            
            [self backToReload];
            [self saveAddressModel];

        }else{
        
            [self changeAdrrToServer];
        }
    }
}

//修改地址提交服务器
- (void)changeAdrrToServer{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:_orderId forKey:@"pid"];
    [params setObject:_addrModel.name forKey:@"name"];
    [params setObject:_addrModel.phone forKey:@"phone"];
    [params setObject:_addrModel.addr forKey:@"addr"];
    [params setObject:_addrModel.addrDetail forKey:@"addrDetail"];

    KWeakSelf
    [RequestManager postWithURLString:KModifyAddress parameters:params  success:^(id responseObject) {
        
        if ([responseObject[@"code"] intValue] == 1) {
            
            [weakSelf backToReload];
            [weakSelf saveAddressModel];
        }else{
            
            [MBProgressHUD showError:responseObject[@"msg"] toView:nil];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHudToView:nil animated:YES];
    }];
}

//修改成功 更新地址
- (void)backToReload{
    [MBProgressHUD showSuccess:@"修改成功！" toView:nil];
    NSDictionary *info = @{@"address":_addrModel};
    [KNotificationCenter postNotificationName:KChangeAddressNoti object:nil userInfo:info];
    [self.navigationController popViewControllerAnimated:YES];
}

//定位按钮
- (void)didTapLocateButton{
    [self locate];
}

//城市选择确定按钮
- (void)cityPickerDidSelectWithAddress:(NSString *)addr{
    self.addrModel.addr = addr;
    [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

//text结束编辑
- (void)cellDidEndEditingWithText:(NSString *)text index:(NSInteger)index{
    
    switch (index) {
        case 0:
            self.addrModel.name = text;
            break;
        case 1:
            self.addrModel.phone = text;
            break;
        case 2:
            self.addrModel.addr = text;
            break;
        case 3:
            self.addrModel.addrDetail = text;
            break;
        default:
            break;
    }
}
//定位
- (void)locate{
    
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyThreeKilometers];
    self.locationManager.locationTimeout = 10;
    self.locationManager.reGeocodeTimeout = 10;
    
    [MBProgressHUD showMessag:@"" toView:nil];
    KWeakSelf
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        [MBProgressHUD hideHudToView:nil animated:YES];
        if (regeocode){
            NSMutableString *str = [NSMutableString string];
            if ([regeocode.province length]) {
                [str appendString:regeocode.province];
            }
            if (![regeocode.province isEqualToString:regeocode.city]) {
                [str appendString:regeocode.city];
            }
            if ([regeocode.district length]) {
                [str appendString:regeocode.district];
            }
            
            if ([str length]) {
                [weakSelf.addrModel setAddr:str];
                [weakSelf.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];//更新reload会清空其他textfield的内容
            }
        }
    }];
    
}

#pragma mark - 初始化地址信息

- (void)initAddressModel{
    AddressModel *model = KUSER.addrInfo;
    if (model) {
        self.addrModel = model;
    }
}

- (void)saveAddressModel{

    [_addrModel saveOrUpdate];//地址入库
}


#pragma mark lazy load
- (CityPickerView *)cityPicker{
    if (!_cityPicker) {
        _cityPicker = [[CityPickerView alloc]init];
        _cityPicker.delegate = self;
    }
    return _cityPicker;
}

- (AMapLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc]init];
    }
    return _locationManager;
}

- (AddressModel *)addrModel{
    if (!_addrModel) {
        _addrModel = [AddressModel new];
    }
    return _addrModel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
