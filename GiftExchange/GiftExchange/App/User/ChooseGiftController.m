//
//  ChooseGiftController.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/11.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "ChooseGiftController.h"
#import "ChooseGiftCell.h"
#import "EditAddressController.h"
#import "ChooseGiftModel.h"
#import "MyCardModel.h"

static NSString *cellId = @"ChooseGiftCell";

@interface ChooseGiftController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableview;
@property (nonatomic ,strong) UIButton *commitBtn;
@property (nonatomic ,strong) UILabel *tipLab;

@end

@implementation ChooseGiftController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"选择礼品"];
    [self setBackBtn];
    
    [self initViews];
}


- (void)initViews{
    
    self.tableview = ({
        UITableView *view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];//取消footer粘滞
        [self.view addSubview:view];
        view.estimatedRowHeight = 0;
        view.estimatedSectionHeaderHeight = 0;
        view.estimatedSectionFooterHeight = 0;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view).offset(10);
            make.bottom.left.right.mas_equalTo(self.view);
        }];
        view.delegate = self;
        view.dataSource = self;
        view.tableHeaderView = [self headerView];
        [view registerClass:[ChooseGiftCell class] forCellReuseIdentifier:cellId];
        view.backgroundColor = [UIColor whiteColor];
        view.separatorInset = UIEdgeInsetsZero;
        view;
    });
    
    
    self.commitBtn = ({
        UIButton *view = [UIButton new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.bottom.offset(-35);
        }];
        [view setTitle:@"确认兑奖" forState:UIControlStateNormal];
        [view setBackgroundImage:KImageName(@"兑奖按钮") forState:UIControlStateNormal];
        [view addTarget:self action:@selector(exchangeAction) forControlEvents:UIControlEventTouchUpInside];
        view.titleLabel.font = KFont(16);
        view;
    });

}

- (UIView *)headerView{

    UIView *view = [[UIView alloc]initWithFrame:KFrame(0, 0, KDeviceW, 25)];
    view.backgroundColor = [UIColor whiteColor];
    
    self.tipLab = ({
        UILabel *label  = [UILabel new];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(view);
            make.left.mas_equalTo(15);
        }];
        label.font      = KFont(12);
        label.textColor = RGBHex(@"#4a4a4a");
        label.text = [NSString stringWithFormat:@"您当前使用的是%@，可选择以下任意一件礼品进行兑换！",_cardModel.cardName];

        label;
    });
    
    UIView *line = [[UIView alloc]initWithFrame:KFrame(0,CGRectGetHeight(view.frame)-.5, KDeviceW, .5)];
    line.backgroundColor = RGBHex(@"#eeeeee");
    [view addSubview:line];
    
    return view;
}



#pragma mark UITableViewDataSource
//设置footerview的颜色,只在plain的时候有用
//- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
//    view.tintColor = [UIColor whiteColor];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_datalist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChooseGiftCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    [cell loadCellWithModel:_datalist[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return _commitBtn.height+35*2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

#pragma mark 确认兑奖
- (void)exchangeAction{
    NSIndexPath *selectPath   = [_tableview indexPathForSelectedRow];

    if (!selectPath) {
        [MBProgressHUD showError:@"请选择礼品" toView:nil];
        return;
    }
    
    EditAddressController *vc = [EditAddressController new];
    vc.giftModel              = _datalist[selectPath.row];
    vc.type                   = ControllerTypeEdit;
    vc.cardModel              = _cardModel;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
