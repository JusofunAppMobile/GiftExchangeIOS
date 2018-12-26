//
//  SendCardRecordController.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/29.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "SendCardRecordController.h"
#import "SendCardRecordCell.h"
#import "SendCardRecordModel.h"


static NSString *cellID = @"SendCardRecordCell";

@interface SendCardRecordController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableview;
@property (nonatomic ,strong) NSMutableArray *dataList;

@property (nonatomic ,assign) int page;

@property (nonatomic ,assign) BOOL moreData;

@end

@implementation SendCardRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"发卡历史"];
    [self setBackBtn];
    
    self.page = 1;
    [self initView];
    [self addRefreshView];
    [self loadData:YES];
}

#pragma mark - initView
- (void)initView{

    self.tableview = ({
        UITableView *view = [UITableView new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
        view.delegate = self;
        view.dataSource = self;
        view.tableFooterView = [UIView new];
        view.separatorInset = UIEdgeInsetsZero;
        view.backgroundColor = [UIColor clearColor];
        [view registerClass:[SendCardRecordCell class] forCellReuseIdentifier:cellID];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SendCardRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    [cell loadCell:_dataList[indexPath.row]];
    return cell;
}

#pragma mark 请求数据
- (void)loadData:(BOOL)loading{
    KWeakSelf
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:KUSER.userId forKey:@"userId"];
    [params setObject:@(_page) forKey:@"pageNum"];

    if (loading) {
        [MBProgressHUD showMessag:@"" toView:nil];
    }
    [RequestManager postWithURLString:KSendCardRecordAdminList parameters:params  success:^(id responseObject) {
        if ([responseObject[@"code"] intValue] == 1) {
            if (weakSelf.page == 1) {
                [weakSelf.dataList removeAllObjects];
            }
            NSArray *datas = [SendCardRecordModel mj_objectArrayWithKeyValuesArray:
                              responseObject[@"data"][@"list"]];
            weakSelf.dataList = datas.mutableCopy;
            [weakSelf.tableview reloadData];
            
            weakSelf.moreData = !(datas.count <KPageSize);
            weakSelf.page += weakSelf.moreData;
            
            [weakSelf showNoResultInView:weakSelf.tableview
                                  hidden:[weakSelf.dataList count]];
            [MBProgressHUD hideHudToView:nil animated:YES];
        }else{
            [MBProgressHUD showError:responseObject[@"msg" ] toView:nil];
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

@end
