//
//  UserPicker.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/30.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "UserPicker.h"
#import "ReceptUserModel.h"
#import "ReceptBankAdminModel.h"

#define BG_HEIGHT 40.
#define PICKER_HEIGHT 216.

#define BUTTON_WH 30.f


@interface UserPicker ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic ,strong) UIButton *saveBtn;

@property (nonatomic ,strong) UIButton *cancleBtn;

@property (nonatomic ,strong) UIPickerView *picker;

@property (nonatomic ,strong) UIView *backView;

@property (nonatomic ,strong) NSArray *datas;

@property (nonatomic ,strong) NSArray *userList;//二级picker的数据


@end

@implementation UserPicker

- (instancetype)initWithData:(NSArray *)datas{
    
    if (self = [super init]) {
        self.frame = KeyWindow.bounds;
        self.datas = datas;
        
        ReceptBankAdminModel *model = _datas[0];//初始化数据源，这种方式能防止多级滚动crash
        self.userList = model.userList;
        
        self.backView = [[UIView alloc]initWithFrame:KFrame(0, KDeviceH, KDeviceW, BG_HEIGHT+PICKER_HEIGHT)];
        _backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_backView];
        
        UIView *grayview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KDeviceW, BG_HEIGHT)];
        grayview.backgroundColor = [UIColor redColor];
        [_backView addSubview:grayview];
        
        UIButton *cancelButton=[[UIButton alloc]initWithFrame:CGRectMake(10, (BG_HEIGHT-30)/2, 30, 30)];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        cancelButton.titleLabel.font=[UIFont systemFontOfSize:15];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelButton sizeToFit];
        [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        self.cancleBtn=cancelButton;
        [grayview addSubview:cancelButton];
        
        
        UIButton *saveButton=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)-10-30, (BG_HEIGHT-30)/2, 30, 30)];
        [saveButton setTitle:@"确定" forState:UIControlStateNormal];
        saveButton.titleLabel.font=[UIFont systemFontOfSize:15];
        [saveButton sizeToFit];
        [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [saveButton addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
        self.saveBtn=saveButton;
        [grayview addSubview:saveButton];
        
        
        _picker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, BG_HEIGHT, KDeviceW,PICKER_HEIGHT )];
        _picker.showsSelectionIndicator=YES;
        _picker.delegate=self;
        _picker.dataSource=self;
        [_backView addSubview:_picker];

    }
    return self;
}


#pragma mark
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0) {
        return _datas.count;
    }else{
        return [_userList count];
    }
}
//更新二级数据源userlist
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        ReceptBankAdminModel *model = _datas[row];
        self.userList = model.userList;
        [pickerView selectRow:0 inComponent:1 animated:NO];
        [pickerView reloadComponent:1];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        ReceptBankAdminModel *adminModel = _datas[row];
        return adminModel.name;
    }else{
        ReceptUserModel *model = _userList[row];
        return model.name;
    }
}

#pragma mark 按钮
- (void)cancelAction{

    [self dismiss];
}

- (void)saveAction{
    
    [self dismiss];
    
    if ([self.delegate respondsToSelector:@selector(didSelectUserPicker:)]) {
        
        NSInteger row0 = [_picker selectedRowInComponent:0];
        NSInteger row1 = [_picker selectedRowInComponent:1];
        ReceptUserModel *model = _userList[row1];
        ReceptBankAdminModel *adminModel = _datas[row0];
        model.bankID = adminModel.pid;
        model.bankName = adminModel.name;
        
        [self.delegate didSelectUserPicker:model];
    }
}

- (void)show{
    [KeyWindow addSubview:self];
    [UIView animateWithDuration:0.4 animations:^{
        _backView.center = CGPointMake(self.width/2, _backView.centerY - _backView.height);
    }];
}

- (void)dismiss{
    [UIView animateWithDuration:0.4 animations:^{
        _backView.center = CGPointMake(self.width/2, _backView.centerY + _backView.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
