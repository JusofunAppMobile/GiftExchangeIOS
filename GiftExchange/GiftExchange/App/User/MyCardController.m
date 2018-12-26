//
//  MyCardController.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/30.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "MyCardController.h"
#import "MyCardCell.h"
#import "MyCardModel.h"
#import "ChooseGiftController.h"
#import "ChooseGiftModel.h"

static NSString *cellID = @"MyCardCell";

@interface MyCardController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableview;

@property (nonatomic ,strong) NSArray *dataList;

@property (nonatomic ,strong) NSArray *giftList;

@property (nonatomic ,strong) MyCardModel *chooseCardModel;

@end

@implementation MyCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackBtn];
    [self setNavigationBarTitle:@"我的电子券"];

    [self initView];
    [self addRefreshView];
    [self loadData];
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
        view.delegate = self;
        view.dataSource = self;
        [view registerClass:[MyCardCell class] forCellReuseIdentifier:cellID];
        view;
    });

}

- (void)addRefreshView{
    KWeakSelf
    _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_dataList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0?10:CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    [cell loadCell:_dataList[indexPath.section]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MyCardModel *model = _dataList[indexPath.section];
    
    if ([model.status intValue] == 0) {
        [self getGiftListWithNo:model];
    }else if([model.status intValue] == 2){
        [MBProgressHUD showError:@"卡券已过期！" toView:nil];
    }else {
        [MBProgressHUD showError:@"卡券已兑换！" toView:nil];
    }
}

#pragma mark 网络请求
- (void)loadData{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    KWeakSelf
    [MBProgressHUD showMessag:@"" toView:nil];
    [RequestManager postWithURLString:KMyElecCardList parameters:params success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 1) {
            
            weakSelf.dataList = [MyCardModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            [weakSelf showNoResultInView:weakSelf.tableview hidden:[weakSelf.dataList count]];
            [weakSelf.tableview reloadData];
            
            [MBProgressHUD hideHudToView:nil animated:YES];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"] toView:nil];
        }
        [weakSelf.tableview.mj_header endRefreshing];
        [weakSelf hideNetFailView];
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHudToView:nil animated:YES];
        [weakSelf.tableview.mj_header endRefreshing];
        [weakSelf showNetFailWithFrame:weakSelf.tableview.frame];;
    }];
}

//重新加载
- (void)netFailReload{
    [self loadData];
}

#pragma mark 请求数据
- (void)getGiftListWithNo:(MyCardModel *)model{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:model.cardNo forKey:@"cardNo"];
    [params setObject:model.cardPwd forKey:@"cardPwd"];

    KWeakSelf
    [MBProgressHUD showMessag:@"" toView:nil];
    [RequestManager postWithURLString:KSearchGiftListByCardNo parameters:params  success:^(id responseObject) {
        [MBProgressHUD hideHudToView:nil animated:YES];
        
        if ([responseObject[@"code"] intValue] == 1) {
            weakSelf.giftList = [ChooseGiftModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            weakSelf.chooseCardModel = [MyCardModel mj_objectWithKeyValues:responseObject[@"data"][@"cardInfo"]];
            [weakSelf jumpToChooseGiftVc];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"] toView:nil];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHudToView:nil animated:YES];
    }];
}


#pragma mark - 跳转选择礼物
- (void)jumpToChooseGiftVc{

    ChooseGiftController *vc = [ChooseGiftController new];
    vc.cardModel = _chooseCardModel;
    vc.datalist = _giftList;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
