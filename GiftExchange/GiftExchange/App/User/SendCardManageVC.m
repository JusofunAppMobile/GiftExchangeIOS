//
//  SendCardManageVC.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/29.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "SendCardManageVC.h"
#import "SendCardCell.h"
#import "SendCardView.h"
#import "CustomAlertView.h"
//#import "SendCardManageModel.h"
#import "ReceptUserModel.h"
#import "ReceptBankAdminModel.h"
#import "SearchNoResultView.h"
#import "CardManageModel.h"
#import "CardManageCell.h"

static NSString *SendCardCellID = @"SendCardCell";
static NSString *CardManageCellID = @"CardManageCell";


@interface SendCardManageVC ()<UITableViewDelegate,UITableViewDataSource,SendCardCommitDelegate,CustomAlertDelegate,SendCardDelegate,AdminSendCardDelegate>

@property (nonatomic ,strong) UITableView  *tableview;

@property (nonatomic ,strong) SendCardView *sendCardView;

@property (nonatomic ,strong) NSMutableArray  *dataList;

@property (nonatomic ,strong) CardManageModel *sendCardModel;

@property (nonatomic ,strong) ReceptUserModel *sendUserModel;//发送给的用户

@property (nonatomic ,assign) int page;

@property (nonatomic ,assign) BOOL moreData;

@end

@implementation SendCardManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackBtn];
    [self setNavigationBarTitle:@"发卡管理"];
    
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 80;
    self.page = 1;
    [self initView];
    [self addRefreshView];
    [self loadData:YES];
    [self loadReceptUser];
}

#pragma mark - initView
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
        view.delegate        = self;
        view.dataSource      = self;
        view.tableFooterView = [UIView new];
        [view registerClass:[SendCardCell class] forCellReuseIdentifier:SendCardCellID];
        [view registerClass:[CardManageCell class] forCellReuseIdentifier:CardManageCellID];
        view;
    });
}

- (void)addRefreshView{//下拉刷新
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0?10:CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [KUSER.type intValue] == UserTypeAdmin ? 65 : 105;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([KUSER.type intValue] == UserTypeAdmin) {
        SendCardCell *cell = [tableView dequeueReusableCellWithIdentifier:SendCardCellID forIndexPath:indexPath];
        cell.delegate = self;
        cell.model = _dataList[indexPath.section];
        return cell;
    }else{
        CardManageCell *cell = [tableView dequeueReusableCellWithIdentifier:CardManageCellID forIndexPath:indexPath];
        cell.delegate = self;
        cell.model = _dataList[indexPath.section];
        return cell;
    }
}

#pragma mark - 网络请求
- (void)loadData:(BOOL)loading{//发卡管理列表
    KWeakSelf
    if (loading) {
        [MBProgressHUD showMessag:@"" toView:nil];
    }
    NSString *url = [KUSER.type intValue] == UserTypeAdmin?KCardManageList:KElecCardManage;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:@(_page) forKey:@"pageNum"];

    [RequestManager postWithURLString:url parameters:params  success:^(id responseObject) {
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
            
            weakSelf.moreData = !(datas.count <KPageSize);;
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


- (void)loadReceptUser{//发卡银行列表
    NSString *type =  [KUSER.type intValue] == UserTypeAdmin?@"0":@"1";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:type forKey:@"type"];
    KWeakSelf
    [MBProgressHUD showMessag:@"" toView:nil];
    [RequestManager postWithURLString:KGetBankAdminOrStaffList parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHudToView:nil animated:YES];
        if ([responseObject[@"code"] intValue] == 1) {
            weakSelf.sendCardView.models = [ReceptBankAdminModel mj_objectArrayWithKeyValuesArray:
                                            responseObject[@"data"][@"list"]];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"] toView:nil];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHudToView:nil animated:YES];
    }];
}

//重新加载
- (void)netFailReload{
    [self loadData:YES];
}

#pragma mark CardManageModel 点击发卡按钮
//管理员发卡 银行管理员发卡
- (void)didTapSendCardButton:(CardManageModel *)model{
    _sendCardModel = model;
    [self.sendCardView showInView:self.view];
    [self.view endEditing:YES];
}

- (void)adminDidTapSendCardBtn:(CardManageModel *)model{
    _sendCardModel = model;
    [self.sendCardView showInView:self.view];
    [self.view endEditing:YES];
}

- (void)commitWithUser:(ReceptUserModel *)userModel{//点击提交SendCardCommitDelegate
    _sendUserModel = userModel;
    NSString *msg          = [NSString stringWithFormat:@"确认向%@下发%@X%@张？",
                              userModel.name,_sendCardModel.cardName,userModel.num];
    CustomAlertView *alert = [[CustomAlertView alloc]initWithMessage:msg icon:@"问号"];    //弹出确认提示框
    alert.delegate         = self;
    [alert show];
}

//点击确认发卡CustomAlertDelegate
- (void)dismissWithAssureButton{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:_sendCardModel.pid forKey:@"cardTypeId"];
    [params setObject:_sendUserModel.num forKey:@"num"];
    [params setObject:_sendUserModel.pid forKey:@"pid"];//职员或银行管理员id
    
    NSString *url = nil;
    if ([KUSER.type intValue] == UserTypeBankAdmin) {//发送给银行职员
        url = KSendCardToBankUser;
    }else{
        [params setObject:_sendUserModel.bankID forKey:@"bankId"];
        url = KSendCardToBankAdmin;
    }

    KWeakSelf
    [MBProgressHUD showMessag:@"" toView:nil];
    [RequestManager postWithURLString:url parameters:params  success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 1) {
            [MBProgressHUD showSuccess:@"发卡成功！" toView:nil];
            [weakSelf loadData:NO];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"] toView:nil];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHudToView:nil animated:YES];
    }];
}

#pragma mark lazy load
- (SendCardView *)sendCardView{
    if (!_sendCardView) {
        _sendCardView = [[SendCardView alloc]init];
        _sendCardView.delegate = self;
    }
    return _sendCardView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
