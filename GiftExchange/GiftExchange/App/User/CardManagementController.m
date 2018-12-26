//
//  CardManagementController.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/28.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "CardManagementController.h"
#import "CardManageCell.h"
#import "WaitingView.h"
#import "CardManageView.h"
#import "CustomAlertView.h"
#import "CardManageModel.h"
#import "QRCodeView.h"
#import "NSString+Verify.h"


static NSString *cellID = @"CardManageCell";

@interface CardManagementController ()<UITableViewDelegate,UITableViewDataSource,SendCardDelegate,CardCommitDelegate,CustomAlertDelegate>

@property (nonatomic ,strong) UITableView *tableview;

@property (nonatomic ,strong) CardManageView *cardMv;

@property (nonatomic ,strong) NSMutableArray *dataList;

@property (nonatomic ,strong) CardManageModel *sendModel;

@property (nonatomic ,copy) NSString *phone;

@property (nonatomic ,copy) NSString *name;

@property (nonatomic ,strong) QRCodeView *qrView;

@property (nonatomic ,assign) int page;

@property (nonatomic ,assign) BOOL moreData;

@end

@implementation CardManagementController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"赠送电子券"];
    [self setBackBtn];
    
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 80;
    self.page = 1;
    [self initView];
    [self addRefreshView];
    [self loadData:YES];
}

#pragma mark initView
- (void)initView{
    self.tableview = ({
        UITableView *view = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:view];
        view.estimatedRowHeight = 0;
        view.estimatedSectionHeaderHeight = 0;
        view.estimatedSectionFooterHeight = 0;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
        view.delegate = self;
        view.dataSource = self;
        [view registerClass:[CardManageCell class] forCellReuseIdentifier:cellID];
        view;
    });
}

- (void)addRefreshView{
    KWeakSelf
    _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf loadData:NO];
    }];
    
    _tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadData:NO];
    }];
}

- (void)endRefresh{
    [_tableview.mj_header endRefreshing];
    if (_moreData) {
        [_tableview.mj_footer endRefreshing];
    }else{
        [_tableview.mj_footer endRefreshingWithNoMoreData];
    }
}
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_dataList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0?10:CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CardManageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.delegate = self;
    cell.model = _dataList[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 请求
//电子券列表
- (void)loadData:(BOOL)loading{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:@(_page) forKey:@"pageNum"];

    KWeakSelf
    if (loading) {
        [MBProgressHUD showMessag:@"" toView:nil];
    }
    [RequestManager postWithURLString:KElecCardManage parameters:params success:^(id responseObject) {
        
        if (loading) {
            [MBProgressHUD hideHudToView:nil animated:YES];
        }
        if ([responseObject[@"code"] intValue] == 1) {
            if (weakSelf.page == 1) {
                [weakSelf.dataList removeAllObjects];
            }
            NSArray *datas = [CardManageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            weakSelf.dataList = datas.mutableCopy;
            [weakSelf.tableview reloadData];
            
            weakSelf.moreData = !(datas.count <KPageSize);
            weakSelf.page += weakSelf.moreData;
            [weakSelf showNoResultInView:weakSelf.tableview hidden:[weakSelf.dataList count]];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"] toView:nil];
        }
        [weakSelf endRefresh];
        [weakSelf hideNetFailView];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHudToView:nil animated:YES];
        [weakSelf endRefresh];
        [weakSelf showNetFailWithFrame:weakSelf.tableview.frame];
    }];
}

//重新加载
- (void)netFailReload{
    [self loadData:YES];
}

//发卡给普通用户
- (void)sendCardToUser{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:_sendModel.pid forKey:@"pid"];
    [params setObject:_phone forKey:@"phone"];
    [params setObject:_name forKey:@"name"];
    KWeakSelf
    [MBProgressHUD showMessag:@"" toView:nil];
    [RequestManager postWithURLString:KSendCardToUser parameters:params  success:^(id responseObject) {
        [MBProgressHUD hideHudToView:nil animated:YES];
        if ([responseObject[@"code"] intValue] == 1) {
            NSDictionary *data = responseObject[@"data"];
            [weakSelf showQRCard:data[@"link"]];
            [weakSelf loadData:NO];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"] toView:nil];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHudToView:nil animated:YES];
    }];
}

//生成二维码弹出框
- (void)showQRCard:(NSString *)str{
    [self.qrView showWithString:str];
}

#pragma mark delegate
//SendCardDelegate 点击发卡
- (void)didTapSendCardButton:(CardManageModel *)model{
    _sendModel = model;
    [self.cardMv showInView:self.view];
}

//点击提交CardCommitDelegate
- (void)didTapCommitBtnWithPhone:(NSString *)phone name:(NSString *)name{
    
    if (![phone validateMobile]) {
        [MBProgressHUD showError:@"请输入正确的手机号码！" toView:self.view];
        return;
    }
    
    _phone = phone;
    _name  = name;
    NSString *msg          = [NSString stringWithFormat:@"确认向%@（%@）赠送%@？",phone,name,_sendModel.cardName];
    CustomAlertView *alert = [[CustomAlertView alloc]initWithMessage:msg icon:@"问号"];
    alert.delegate = self;
    [alert show];
}

//弹出框点击确定发卡
- (void)dismissWithAssureButton{
    [self sendCardToUser];
}
#pragma mark lazy load
- (CardManageView *)cardMv{
    if (!_cardMv) {
        _cardMv = [[CardManageView alloc]init];
        _cardMv.delegate = self;
    }
    return _cardMv;
}

- (QRCodeView *)qrView{
    if (!_qrView) {
        _qrView = [[QRCodeView alloc]initWithFrame:KFrame(0, 0, KDeviceW, KDeviceH)];
    }
    return  _qrView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
