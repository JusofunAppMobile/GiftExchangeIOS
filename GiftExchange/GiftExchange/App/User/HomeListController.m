//
//  HomeListController.m
//  GiftExchange
//
//  Created by JUSFOUN on 2017/8/15.
//  Copyright © 2017年 jusfoun. All rights reserved.
//

#import "HomeListController.h"
#import "HomeCell.h"
#import "HomeCellModel.h"
#import "CardTypeModel.h"
#import "GiftDetailController.h"
#import "ChooseGiftController.h"


static NSString *HomeCellId = @"HomeCell";

@interface HomeListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableview;

@end

@implementation HomeListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self addRefreshView];
    if (!_giftList) {
        [self requestData];
    }
}

- (void)initView{
    self.tableview = ({//不能使用header height因为有tableHeaderView
        UITableView *view       = [UITableView new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (@available(iOS 11.0, *)) {
                make.edges.mas_equalTo(self.view.safeAreaInsets);
            } else {
                make.edges.mas_equalTo(self.view);
            }
        }];
        view.delegate           = self;
        view.dataSource         = self;
        view.tableHeaderView    = [self headerView];
        view.tableFooterView    = [UIView new];
        view.separatorInset     = UIEdgeInsetsMake(0, 110, 0, 0);
        [view registerClass:[HomeCell class] forCellReuseIdentifier:HomeCellId];
        view;
    });
}

- (UIView *)headerView{
    
    UILabel *label       = [[UILabel alloc]initWithFrame:KFrame(15, 0, KDeviceW-15, 25)];
    label.text           = @"可兑换礼品：";
    label.font           = KFont(12);
    label.textColor      = RGBHex(@"#5b5b5b");
    
    UIView *line         = [[UIView alloc]initWithFrame:KFrame(0, 24, KDeviceW, 1)];
    line.backgroundColor = RGBHex(@"#eeeeee");
    
    UIView *bgView       = [[UIView alloc]initWithFrame:KFrame(0, 0, KDeviceW, 25)];
    [bgView addSubview:label];
    [bgView addSubview:line];
    
    return bgView;
}


- (void)addRefreshView{
    KWeakSelf
    _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
}

#pragma mark UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_giftList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeCellId forIndexPath:indexPath];
    [cell loadCellWithModel:_giftList[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    HomeCellModel *model = _giftList[indexPath.row];
    GiftDetailController *vc = [GiftDetailController new];
    vc.url = model.url;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark request

- (void)requestData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_pid forKey:@"type"];

    KWeakSelf
    [MBProgressHUD showMessag:@"" toView:self.view];
    [RequestManager postWithURLString:KGiftList parameters:params success:^(id responseObject) {
        
        if ([responseObject[@"code"] intValue] == 1) {
            weakSelf.giftList = [HomeCellModel mj_objectArrayWithKeyValuesArray:
                                 responseObject[@"data"][@"list"]];
            [weakSelf.tableview reloadData];
            [weakSelf showNoResultInView:weakSelf.tableview hidden:[weakSelf.giftList count]];
            [MBProgressHUD hideHudToView:weakSelf.view animated:YES];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"] toView:weakSelf.view];
        }
        [weakSelf hideNetFailView];

        [weakSelf.tableview.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHudToView:weakSelf.view animated:YES];
        [weakSelf.tableview.mj_header endRefreshing];
        [weakSelf showNetFailWithFrame:weakSelf.tableview.frame];
    }];
    
}

- (void)netFailReload{
    [self requestData];
}





@end
