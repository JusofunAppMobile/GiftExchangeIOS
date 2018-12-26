//
//  UserCenterController.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/8.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "UserCenterController.h"
#import "UserHeadCell.h"
#import "UserPlainCell.h"
#import "RecordController.h"
#import "AppDelegate.h"
#import "UCModelManager.h"
#import "ManagerTabController.h"
#import "LogisticsTabController.h"
#import "CardManagementController.h"
#import "SendCardRecordController.h"
#import "SendCardManageVC.h"
#import "MyCardController.h"

static NSString *HeaderID = @"UserHeadCell";
static NSString *PlainID = @"UserPlainCell";

@interface UserCenterController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableview;

@property (nonatomic ,strong) UCModelManager *modelManager;

@property (nonatomic ,strong) UIButton *logoutBtn;

@end

@implementation UserCenterController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.modelManager = [UCModelManager new];
    [self setNavigationBarTitle:@"我"];
    [self initView];
    [self loadData];
}

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
        view.tableFooterView = [UIView new];
        [view registerClass:[UserHeadCell class] forCellReuseIdentifier:HeaderID];
        [view registerClass:[UserPlainCell class] forCellReuseIdentifier:PlainID];
        view;
    });
    
    self.logoutBtn = ({
        ;        UIButton *logout = [UIButton new];
        [self.view addSubview:logout];
        [logout mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.bottom.mas_equalTo(-35);
        }];
        logout.titleLabel.font = KFont(16);
        [logout setTitle:@"退出登录" forState:UIControlStateNormal];
        [logout setBackgroundImage:KImageName(@"兑奖按钮") forState:UIControlStateNormal];
        [logout addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
        logout;
    });
   
}

#pragma mark delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 0?80:60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section==[_modelManager numberOfSections]+1-1?_logoutBtn.height+35*2:CGFLOAT_MIN;//防止被按钮遮挡
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_modelManager numberOfSections]+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0?1:[_modelManager numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        UserHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:HeaderID forIndexPath:indexPath];
        [cell loadCell];
        return cell;
    }else{
        UserPlainCell *cell = [tableView dequeueReusableCellWithIdentifier:PlainID forIndexPath:indexPath];
        [cell loadCellWithTitle:[_modelManager titleForIndexPath:indexPath]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        return;
    }
    
    NSString *title = [_modelManager titleForIndexPath:indexPath];
    
    if ([title isEqualToString:@"兑换记录"]) {
        [self exchangeRecord];
    }
    
    if ([title isEqualToString:@"我的电子券"]) {
        NSLog(@"我的电子券");
        
        MyCardController *vc = [MyCardController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if ([title isEqualToString:@"赠送电子券"]) {
        NSLog(@"赠送电子券");
        
        CardManagementController *vc = [CardManagementController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if ([title isEqualToString:@"订单核审"]) {
        NSLog(@"订单核审");
        ManagerTabController *tab = [[ManagerTabController alloc]init];
        [self.navigationController pushViewController:tab animated:YES];
    }
    
    if ([title isEqualToString:@"发卡管理"]) {
        SendCardManageVC *vc = [SendCardManageVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if ([title isEqualToString:@"发卡历史"]) {
        NSLog(@"发卡历史");
        SendCardRecordController *vc = [SendCardRecordController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if ([title isEqualToString:@"物流管理"]) {
        NSLog(@"物流管理");
        LogisticsTabController *vc = [[LogisticsTabController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if ([title hasPrefix:@"联系客服"]) {
        NSString *phone = kGetUserDefaults(@"servicenumber")?kGetUserDefaults(@"servicenumber"):@"";//客服电话
        if (phone.length) {
            NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
    }    
}

#pragma mark - 请求客服电话
- (void)loadData{
    KWeakSelf
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (KUSER.userId) {
        [params setObject:KUSER.userId forKey:@"userId"];
    }
    [RequestManager postWithURLString:KGetCantact parameters:params success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 1) {
            [weakSelf.modelManager updateModel:responseObject[@"data"][@"phone"]];
            [weakSelf.tableview reloadData];
        }
    } failure:^(NSError *error) {
    }];
}

#pragma mark 退出按钮
- (void)logoutAction{
    [User cleanUser];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app setRootViewController];
//    [app setLoginController];
//    app.rootTabController.selectedIndex = 0;
}

-(void)exchangeRecord
{
    RecordController *vc = [[RecordController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
